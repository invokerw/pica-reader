# 在当前 PowerShell 会话里激活仓库内的工具链（构建用）。
# 用法：. .\tools\env.ps1
#      flutter analyze; flutter build apk --release

$root = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
if (-not (Test-Path (Join-Path $root '.tools/flutter/bin/flutter.bat'))) {
    Write-Warning '工具链还没装：powershell -ExecutionPolicy Bypass -File tools\bootstrap.ps1 -Profile build'
    return
}

$env:FLUTTER_ROOT = Join-Path $root '.tools/flutter'
$env:APPDATA = Join-Path $root '.tools/appdata'
$env:LOCALAPPDATA = Join-Path $root '.tools/appdata-local'
$env:TMP = Join-Path $root '.tools/tmp'
$env:TEMP = $env:TMP
$env:PUB_CACHE = Join-Path $root '.tools/pub-cache'
if (-not $env:PUB_HOSTED_URL) { $env:PUB_HOSTED_URL = 'https://pub.flutter-io.cn' }
if (-not $env:FLUTTER_STORAGE_BASE_URL) { $env:FLUTTER_STORAGE_BASE_URL = 'https://storage.flutter-io.cn' }

$env:JAVA_HOME = Join-Path $root '.rea-tools/jdk/jdk-21.0.13+9'
$env:ANDROID_HOME = Join-Path $root '.tools/android-sdk'
$env:ANDROID_SDK_ROOT = $env:ANDROID_HOME
$env:GRADLE_USER_HOME = Join-Path $root '.tools/gradle'

$env:PATH = @(
    (Join-Path $env:FLUTTER_ROOT 'bin')
    (Join-Path $env:JAVA_HOME 'bin')
    (Join-Path $env:ANDROID_HOME 'platform-tools')
    $env:PATH
) -join [IO.Path]::PathSeparator

Write-Host "已激活：Flutter $(& (Join-Path $env:FLUTTER_ROOT 'bin/flutter.bat') --version 2>$null | Select-Object -First 1)"
Write-Host "JAVA_HOME=$env:JAVA_HOME"
Write-Host "ANDROID_HOME=$env:ANDROID_HOME"
