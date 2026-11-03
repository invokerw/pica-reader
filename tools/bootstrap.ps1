#Requires -Version 5.1
<#
.SYNOPSIS
  按 tools/versions.json 把工具链装到仓库内的 .tools / .rea-tools。

.DESCRIPTION
  幂等：已装且 stamp 对得上的组件会跳过；SHA256 不符会直接报错，不会悄悄换版本。
  所有下载先落在 .tools/dl，可以中断后重跑、也可以手动把文件放进去。

.PARAMETER Profile
  build   Flutter + JDK + Android SDK/NDK（能构建 APK 与 Windows 产物）
  analyze JDK + jadx + rea-agents（能跑 APK 静态分析）
  all     两者

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File tools\bootstrap.ps1 -Profile build
#>
[CmdletBinding()]
param(
    [ValidateSet('build', 'analyze', 'all')]
    [string]$Profile = 'build',
    [string]$Root,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

if (-not $Root) {
    $Root = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
}
$Root = (Resolve-Path -LiteralPath $Root).Path

$manifestPath = Join-Path $Root 'tools/versions.json'
if (-not (Test-Path -LiteralPath $manifestPath)) {
    throw "找不到 $manifestPath"
}
$manifest = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json

$toolsDir = Join-Path $Root '.tools'
$reaDir = Join-Path $Root '.rea-tools'
$dlDir = Join-Path $toolsDir 'dl'
$tmpDir = Join-Path $toolsDir 'tmp'

foreach ($dir in @(
        $toolsDir, $reaDir, $dlDir, $tmpDir,
        (Join-Path $toolsDir 'appdata'),
        (Join-Path $toolsDir 'appdata-local'),
        (Join-Path $toolsDir 'gradle'),
        (Join-Path $toolsDir 'pub-cache'))) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
}

function Write-Utf8([string]$Path, [string]$Text) {
    $encoding = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($Path, $Text, $encoding)
}

$stampPath = Join-Path $toolsDir 'stamp.json'
$stamp = @{}
if (Test-Path -LiteralPath $stampPath) {
    try {
        $saved = Get-Content -LiteralPath $stampPath -Raw -Encoding UTF8 | ConvertFrom-Json
        foreach ($property in $saved.PSObject.Properties) { $stamp[$property.Name] = $property.Value }
    } catch {
        Write-Warning "stamp.json 读不了，按全新安装处理：$($_.Exception.Message)"
    }
}

function Assert-Hash([string]$Path, [object]$Artifact) {
    $hash = (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($hash -ne $Artifact.sha256) {
        throw "SHA256 不匹配：$($Artifact.id)`n  期望 $($Artifact.sha256)`n  实际 $hash"
    }
}

function Save-Download([object]$Artifact) {
    $name = Split-Path -Leaf ([string]$Artifact.urls[0])
    $target = Join-Path $dlDir $name
    if ((Test-Path -LiteralPath $target) -and -not $Force) {
        try {
            Assert-Hash $target $Artifact
            Write-Host "  用缓存 $name"
            return $target
        } catch {
            Write-Warning "  缓存校验失败，重新下载：$name"
            Remove-Item -LiteralPath $target -Force
        }
    }

    $partial = "$target.part"
    foreach ($url in $Artifact.urls) {
        try {
            Write-Host "  下载 $url"
            & curl.exe -L --fail --connect-timeout 30 --retry 2 -o $partial $url
            if ($LASTEXITCODE -ne 0) { throw "curl 退出码 $LASTEXITCODE" }
            Assert-Hash $partial $Artifact
            Move-Item -LiteralPath $partial -Destination $target -Force
            return $target
        } catch {
            Write-Warning "  来源失败：$($_.Exception.Message)"
            if (Test-Path -LiteralPath $partial) { Remove-Item -LiteralPath $partial -Force }
        }
    }
    throw "所有下载地址都失败：$($Artifact.id)"
}

function Expand-Zip([string]$Zip, [string]$Destination) {
    $staging = Join-Path $tmpDir ("extract-" + [guid]::NewGuid().ToString('N').Substring(0, 8))
    New-Item -ItemType Directory -Force -Path $staging | Out-Null
    try {
        & tar.exe -xf $Zip -C $staging
        if ($LASTEXITCODE -ne 0) { throw "tar 解压失败（退出码 $LASTEXITCODE）" }
        $entries = @(Get-ChildItem -LiteralPath $staging)
        $source = $staging
        if ($entries.Count -eq 1 -and $entries[0].PSIsContainer) { $source = $entries[0].FullName }

        if (Test-Path -LiteralPath $Destination) { Remove-Item -LiteralPath $Destination -Recurse -Force }
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Destination) | Out-Null
        Move-Item -LiteralPath $source -Destination $Destination
    } finally {
        if (Test-Path -LiteralPath $staging) {
            Remove-Item -LiteralPath $staging -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

Write-Host "仓库：$Root"
Write-Host "组件：profile=$Profile"
Write-Host ''

$wanted = @($manifest.artifacts | Where-Object {
        $Profile -eq 'all' -or (@($_.profiles) -contains $Profile)
    })

foreach ($artifact in $wanted) {
    $verify = Join-Path $Root $artifact.verify
    if (-not $Force -and $stamp[$artifact.id] -eq $artifact.sha256 -and (Test-Path -LiteralPath $verify)) {
        Write-Host "  [跳过] $($artifact.id) 已就绪"
        continue
    }

    Write-Host "== $($artifact.id)"
    $file = Save-Download $artifact
    if ($artifact.kind -eq 'zip') {
        Expand-Zip $file (Join-Path $Root $artifact.dest)
    } else {
        $destination = Join-Path $Root $artifact.dest
        New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destination) | Out-Null
        Copy-Item -LiteralPath $file -Destination $destination -Force
    }

    if (-not (Test-Path -LiteralPath $verify)) {
        throw "$($artifact.id) 安装后校验失败：缺 $($artifact.verify)"
    }
    $stamp[$artifact.id] = $artifact.sha256
}

if ($Profile -in @('build', 'all')) {
    # 直接用 zip 装 SDK 时没有 sdkmanager 生成的 license 文件，Gradle 会拒绝编译；
    # 这几个是 Android SDK 的标准接受记录。
    $licenseDir = Join-Path $toolsDir 'android-sdk/licenses'
    New-Item -ItemType Directory -Force -Path $licenseDir | Out-Null
    $license = "8933bad161af4178b1185d1a37fbf41ea5269c55`nd56f5187479451eabf01fb78af6dfcb131a6481e`n24333f8a63b6825ea9c5514f83c2829b004d1fee`n"
    foreach ($name in @('android-sdk-license', 'android-sdk-preview-license')) {
        $path = Join-Path $licenseDir $name
        if (-not (Test-Path -LiteralPath $path)) { Write-Utf8 $path $license }
    }
}

if (($Profile -in @('analyze', 'all')) -and $manifest.npm) {
    Write-Host '== npm'
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        Write-Warning '没有 npm：REA 反编译需要 Node.js，请先安装后重跑 -Profile analyze'
    } else {
        $packagePath = Join-Path $reaDir 'package.json'
        if (-not (Test-Path -LiteralPath $packagePath)) {
            Write-Utf8 $packagePath "{`n  `"name`": `"pica-rea-tools`",`n  `"private`": true`n}`n"
        }
        $packages = @($manifest.npm.packages)
        Push-Location $reaDir
        try {
            Write-Host "  安装 $($packages -join ', ')"
            & npm install --no-audit --no-fund @packages
            if ($LASTEXITCODE -ne 0) { throw "npm install 失败（退出码 $LASTEXITCODE）" }
        } finally {
            Pop-Location
        }
    }
}

$ordered = [ordered]@{}
foreach ($key in ($stamp.Keys | Sort-Object)) { $ordered[$key] = $stamp[$key] }
Write-Utf8 $stampPath (($ordered | ConvertTo-Json -Depth 4) + "`n")

Write-Host ''
Write-Host '完成。下一步：'
if ($Profile -in @('build', 'all')) {
    Write-Host '  cmd /c tools\flutter.cmd --version'
    Write-Host '  cmd /c tools\flutter.cmd build apk --release'
}
if ($Profile -in @('analyze', 'all')) {
    Write-Host '  python analysis\pipeline.py verify'
}
