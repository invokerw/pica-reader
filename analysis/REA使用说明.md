# 用 REA 继续分析此 APK（Windows 本地方案）

## 当前状态

已在本项目内安装并实际运行 REA 6.8.0 + Temurin JDK21.0.13 + JADX headless 0.7.1。七个批次共保存 **1,056 个成功操作、808 次方法读取**（含重复），带 APK/JAR/bridge 哈希的真实 Evidence；见[审计](<rea_audit.json>)、[核心索引](<rea/core/index.json>)与[实际签名方法](<rea/core/signer.java>)。已核对 33 个 PICA 方法、62 模型/299 字段。没有运行 APK、使用真实账户或请求目标服务。下列保留部署与复现步骤，安装下载需要联网，分析阶段仅处理本地 APK。

REA 是 CLI/MCP 分析工具编排层；Android Java/Kotlin 分析实际由 `jadx-headless-mcp` 提供。无需先装 Android SDK、模拟器、Frida 或 native 分析引擎。

## 1. 本机条件

- 系统 Node：26.12.1，满足 `rea-agents@6.8.0` 的 `^22.23.4 || ^24.22.1 || >=26.12.1`。
- 工具均为项目内隔离部署，不修改系统 PATH：JDK 位于 `.rea-tools/jdk/jdk-21.0.13+9`，REA 位于 `.rea-tools/node_modules/rea-agents`。
- REA Android 需要完整 JDK ≥17（包括 `jdk.compiler`），推荐 JDK 21；只有 JRE 不够。
- `jadx-headless-mcp-0.7.1-all.jar` 要单独取得，`REA_JADX_MCP_JAR` 指向它的绝对路径。
- npm 6.8.0 的 Windows x64 native control 已在本机完成真实 JVM 通信；模块 SHA-256 为 `6a015bfefee7fafb6cbafab659f040170848a45425bbcef6caf962fd39b6ff7b`。首次沙箱启动报 `spawn EPERM`，按原命令批准较宽权限后启动；随后 JADX 的系统临时目录写入失败，改用项目内临时目录。未修改系统文件权限或 REA 源码。

## 2. 下载和版本固定

不建议直接在这里跑最新版 `npx` 或改全局配置。固定 6.8.0，依赖放项目内。此步骤需要联网并执行下载的分析工具，**不能称为离线安装**。

```powershell
$root = 'C:\Users\weife\Desktop\work\picacg'
$tools = Join-Path $root '.rea-tools'
& 'C:\Program Files\nodejs\node.exe' `
  'C:\Program Files\nodejs\node_modules\npm\bin\npm-cli.js' `
  install --prefix $tools --cache (Join-Path $tools 'npm-cache') `
  --no-save --package-lock=false --omit=optional --ignore-scripts `
  --no-audit --no-fund rea-agents@6.8.0
```

`--ignore-scripts` 避免安装时运行生命周期脚本；`--omit=optional` 省掉静态分析无需的可选依赖。仍需下载完整依赖，只有一个 npm tarball 不足以完全离线安装。

建议把 JDK 解压到 `.rea-tools\jdk`，JAR 放 `.rea-tools\jadx-headless-mcp-0.7.1-all.jar`。JDK 的实际 `JAVA_HOME` 必须是含 `bin\java.exe` 的那层目录，不要把 ZIP 的外层父目录当成 JAVA_HOME。

JAR 官方下载：
https://github.com/1013503897/jadx-headless-mcp/releases/download/v0.7.1/jadx-headless-mcp-0.7.1-all.jar

官方 REA 文档记录的 JAR SHA-256：
`6e5eacf500b64292bfb73c49797c1958f6ee44646e43e868039ae7feb573ff75`

本次查询到的 Temurin JDK21 Windows x64 ZIP：21.0.13+9，205421281 bytes（约 196 MiB，解压另需空间）。
https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.13%2B9/OpenJDK21U-jdk_x64_windows_hotspot_21.0.13_9.zip

该 JDK ZIP SHA-256：
`a4dbaa05fca4bd89d84584e58c459bd732efebb1722af80ab13c6516832004f9`

上述 JDK/JAR 已下载并通过 SHA-256 校验；记录见[部署清单](../.rea-tools/download-manifest.json)。下载脚本使用安全 ZIP 路径检查且不覆盖原 APK。已有可用的完整 JDK21 时不必重新下载。

## 3. 先用 CLI，确认可用后再配 MCP

以下设定仅影响当前 PowerShell 进程；不使用 `setx`，不修改系统 PATH。`$jdk` 需要替换为实际解压目录。

```powershell
$root = 'C:\Users\weife\Desktop\work\picacg'
$node = 'C:\Program Files\nodejs\node.exe'
$rea = Join-Path $root '.rea-tools\node_modules\rea-agents\scripts\rea.mjs'
$apk = Join-Path $root 'picacg-v2.6.73.apk'
$jdk = Join-Path $root '.rea-tools\jdk\jdk-21.0.13+9'
$env:JAVA_HOME = $jdk
$env:REA_JADX_MCP_JAR = Join-Path $root '.rea-tools\jadx-headless-mcp-0.7.1-all.jar'
$tmp = Join-Path $root '.rea-tools\runtime-temp'
New-Item -ItemType Directory -Path $tmp -Force | Out-Null
$env:TEMP = $tmp
$env:TMP = $tmp
$env:JAVA_TOOL_OPTIONS = "-Djava.io.tmpdir=$tmp"
$env:REA_JADX_HEAP_MIB = '2048'
$env:REA_JADX_ACTIVE_PROCESSOR_COUNT = '2'

& (Join-Path $jdk 'bin\java.exe') --list-modules
# 输出应包括 jdk.compiler。
& $node $rea inspect-android-package $apk --json
& $node $rea search-android-classes $apk 'SignInRequest' --json
& $node $rea search-android-classes $apk 'fg4' --json
```

之后使用搜索结果中的精确类名。原 DEX 的 `Lfg4;` 对应预期的默认包类名 `fg4`；如 JADX 返回别名，以它返回的类名为准。

```powershell
& $node $rea inspect-android-class $apk 'fg4' --json
& $node $rea inspect-android-method $apk 'fg4' 'a' --json
& $node $rea trace-android-references $apk 'fg4' --method-name 'a' --json
& $node $rea inspect-android-class $apk 'nh4' --json
& $node $rea inspect-android-class $apk 's42' --json
& $node $rea inspect-android-class $apk 'eg4' --json
```

- `inspect-android-class` 返回成员清单，不是整类 Java 源码。
- `inspect-android-method` 才用于读取具体方法 Java，无法生成时可返回 smali。
- 同名重载必须先看成员清单，按返回的索引指定 `--overload-index N`，不要猜。
- `trace-android-references` 是静态 incoming using nodes，不是已经发生的运行调用链。
- CLI 每次启动/结束 JVM；交互追踪很多方法时 MCP 能重用同一个会话，效率更好。

### 已执行的批量服务适配器

[rea_batch.mjs](rea_batch.mjs)调用安装版 REA 的 `AndroidAnalysisService`（与 CLI/MCP 相同服务层），重用一次 JADX 会话，按成员清单选择重载，保存完整 Evidence JSON 与 Java/smali 文本；不是用自写 DEX parser 冒充 REA。复现核心批次：

```powershell
& 'C:\Program Files\nodejs\node.exe' `
  'C:\Users\weife\Desktop\work\picacg\analysis\rea_batch.mjs' `
  'C:\Users\weife\Desktop\work\picacg\analysis\rea_core_batch.json'
```

REA 6.8.0 **Android CLI 不支持 `--evidence-output` / `--evidence_output`**；不能套用其他命令或 main 文档的选项。CLI 可输出 `--json`，本项目适配器直接保存服务层 Evidence。Windows PowerShell 的 `>` 可能输出 UTF-16，适配器固定 UTF-8。

`source_status=complete` 仅表示返回文本未截断，不代表反编译控制流正确。R8/协程方法必须对照 smali/原 DEX；abstract 接口无 body 是正常结果。JADX 顶层类数与原始 DEX class_def 计数口径不同。

| 批次 | 实际 Evidence 索引 | 重点 |
|---|---|---|
| core | [索引](<rea/core/index.json>) | 登录、签名、Token、xref |
| validation | [索引](<rea/validation/index.json>) | 33 接口、网络、根/嵌套 serializer |
| supplement | [索引](<rea/supplement/index.json>) | 字符串/headers、构造器、RequestMode |
| closure | [索引](<rea/closure/index.json>) | nullable/descriptor/TLS helpers |
| final | [索引](<rea/final/index.json>) | JSON 实例入口、encoder |
| config | [索引](<rea/config/index.json>) | 配置字段语义 |
| defaults | [索引](<rea/defaults/index.json>) | 默认 explicitNulls 与实际写出钩子 |

对应任务文件用 `rea_<批次>_batch.json` 命名；[完整验证任务](<rea_validation_batch.json>)可替换上例的核心任务参数。适配器会覆写该批次的导出文件，**复跑前复制任务并改 `output_directory` 为新目录**，避免覆盖本次审计证据。适配器依赖固定 6.8.0 内部服务层，不保证未来版本可直接复用。

[audit_rea_results.py](<audit_rea_results.py>)校验每个 Evidence 的 APK/JAR/bridge 哈希、任务 prototype、导出源码字节和报告链接；[build_rea_schema.py](<build_rea_schema.py>)将真实 REA descriptor 与原 DEX 对照，再生成模型清单。[原始修正证据](<rea_original_corrections.json>)用于保留已发现的 Java 控制流失真，不能拿错误 Java 当 APK bug。

## 4. 建议追踪顺序

| 原 DEX 类/方法 | 分析问题 |
|---|---|
| `eo3.c` | 登录 UI 如何处理用户名 |
| `hi6.c`、`bb3.invokeSuspend` | 仓库/协程派发与 Token 成功路径 |
| `l31.invokeSuspend` | 实际构造 SignInRequest 并调用登录接口 |
| `dg4.a/c/d` | 响应解包、非空 data、HTTP 错误处理 |
| `eg4.h`、`SignInRequest` 及序列化器 | POST auth/sign-in、email/password JSON |
| `fg4.a` | time/nonce/签名/HTTP headers/401 |
| `nh4.e/f/a` | nonce、Token 保存与注销 |
| `s42.a/b/c/f` | AndroidKeyStore/AES-GCM 本地存储 |
| `eg4` | 33 个 PICA 接口声明及请求/返回 DTO |
| `wj1.get` 对应分支 | API base URL、HTTP client、转换器绑定 |

obfuscated 类名和合并 Kotlin lambda 分支必须结合签名及字节码判断，不能只凭名字推断每个分支用途。

## 5. MCP 配置模板

这是通用服务器配置片段，**本次未写入 DSH 配置，也未验证客户端加载**。用宿主客户端支持的 MCP 配置方式添加，不要直接覆盖整个配置文件；新 MCP 工具可能需要重启会话才出现。

```json
{
  "mcpServers": {
    "rea": {
      "command": "C:\\Program Files\\nodejs\\node.exe",
      "args": [
        "C:\\Users\\weife\\Desktop\\work\\picacg\\.rea-tools\\node_modules\\rea-agents\\scripts\\rea.mjs",
        "mcp"
      ],
      "env": {
        "JAVA_HOME": "C:\\Users\\weife\\Desktop\\work\\picacg\\.rea-tools\\jdk\\jdk-21.0.13+9",
        "REA_JADX_MCP_JAR": "C:\\Users\\weife\\Desktop\\work\\picacg\\.rea-tools\\jadx-headless-mcp-0.7.1-all.jar",
        "TEMP": "C:\\Users\\weife\\Desktop\\work\\picacg\\.rea-tools\\runtime-temp",
        "TMP": "C:\\Users\\weife\\Desktop\\work\\picacg\\.rea-tools\\runtime-temp",
        "JAVA_TOOL_OPTIONS": "-Djava.io.tmpdir=C:\\Users\\weife\\Desktop\\work\\picacg\\.rea-tools\\runtime-temp",
        "REA_JADX_HEAP_MIB": "2048",
        "REA_JADX_ACTIVE_PROCESSOR_COUNT": "2"
      }
    }
  }
}
```

模板 TEMP/JVM 临时目录沿用本次已创建的项目目录；复制到别处时先创建相应目录，且不要盲目覆盖宿主已有 JAVA_TOOL_OPTIONS。只在宿主允许该分析工具启动子进程的权限下使用；遇 `spawn EPERM` 是运行环境边界，不应修改 REA/ACL 来绕过。

初始化后先检查 `tools/list` 和 Android `tool_availability`，再分析；每次 Android 调用都显式传 APK path，不用 `open_binary`。不要把 npm 6.8.0 当作 GitHub main：本次读到 release 的桥接协议是 `rea-jadx-bridge/7`，main 是 `/10`。main 新增 mapping/JNI 之类参数不一定在 6.8.0 可用。

## 6. 哪些事情不靠 REA 静态分析证明

在线 API 是否仍可用、账户是否能登录、TLS/证书实际行为、代理/线路真实切换、远端刷新 Token 机制、所有查询枚举的服务端含义，以及运行时生成的额外请求。静态协议梳理完成后，如确有需要，再在本人授权账户/设备上单独安排动态验证；本次没有发送认证、注册或其他目标站点请求。

## 参考

- [REA 项目](https://github.com/morluto/rea/tree/main)
- [固定发布版 Android 文档](https://github.com/morluto/rea/blob/rea-agents-6.8.0/docs/android-analysis.md)
- [固定发布版 CLI 实现](https://github.com/morluto/rea/blob/rea-agents-6.8.0/src/cli/androidCommands.ts)
- [npm 6.8.0 元数据](https://registry.npmjs.org/rea-agents/6.8.0)
