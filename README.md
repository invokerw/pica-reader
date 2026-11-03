# picacg · 第三方哔咔漫画阅读器 + 协议逆向工程骨架

一个 Flutter（Windows + Android）客户端，以及支撑它的**可复现 APK 静态分析流水线**。

客户端除浏览与阅读外，还能把当前账号可读的章节下载成本地 **CBZ**（含 `ComicInfo.xml`），Mihon/Tachiyomi 本地源、Komga、Kavita 等本地漫画库可直接识别；格式、目录布局与限制见 `pica_reader/README.md`。

仓库里没有 APK、没有 SDK、没有构建产物：所有工具链由 `tools/versions.json` 钉版本、`tools/bootstrap.ps1` 重建，
所有分析结果由 `analysis/pipeline.py` 从 APK 重新推导。换台机器 clone 下来，两条命令就能继续干活。

## 目录

| 路径 | 作用 | 体积 |
| --- | --- | --- |
| `pica_reader/` | Flutter 应用（Windows + Android 单代码库） | 0.3 MB |
| `analysis/` | APK 静态分析脚本、协议证据、REA 反编译记录 | 20 MB |
| `tools/` | 工具链版本清单与安装脚本（`versions.json` 是唯一真源） | 数十 KB |
| `.github/workflows/` | CI：构建产物、APK 复分析 | — |

## 三条流水线

### 1. 本地构建

```powershell
# 首次：装 Flutter 3.47.9 + JDK21 + Android SDK/NDK 到 .tools、.rea-tools（约 12 GB，可断点重跑）
powershell -File tools\bootstrap.ps1 -Profile build

# 之后
cmd /c 'tools\flutter.cmd pub get'
cmd /c 'tools\flutter.cmd analyze'
cmd /c 'tools\flutter.cmd test'                        # 离线：签名向量、URL 拼接、CBZ 打包、下载队列
cmd /c 'tools\flutter.cmd build windows --release'
cmd /c 'tools\flutter.cmd build apk --release'
```

产物：`pica_reader/build/windows/x64/runner/Release/`（整个目录一起拷走）、`pica_reader/build/app/outputs/flutter-apk/app-release.apk`。

### 2. CI 构建

打 tag（`v*`）或手动触发 `build.yml` → Release 附带 `*-windows-x64.zip`、`*-android.apk` 与 `sha256sums.txt`。
签名私钥来自仓库 Secrets；**没有配置 Secrets 时 CI 会退回 debug 签名并告警——那种包无法覆盖安装已发布版本**。

### 3. 新 APK 复分析

详见 [`analysis/README.md`](analysis/README.md)。最常用的一条：

```powershell
python analysis/pipeline.py new --apk .cache\apk\picacg-v2.6.80.apk --version 2.6.80
```

产出 `analysis/versions/2.6.80/REPORT.md`，逐条告诉你：协议没变 / 只升了版本号 / 签名算法变了（附要改的 Dart 文件与行）。

## 原始样本

APK 是版权软件，**不随仓库分发**。分析脚本按顺序找样本：

1. `--apk <路径>` 参数
2. 环境变量 `PICA_APK`
3. `.cache/apk/picacg-v<version>.apk`

SHA256 记录在 `analysis/versions/<version>/sha256.txt`（基线 `analysis/baseline/protocol.json` 里也有同一份），拿到样本先核对，
避免"分析的其实不是同一版"。CI 只接受 `workflow_dispatch` 显式传入的下载地址或 Release 资产，不内置任何镜像。

## 几条硬约定

- **生成文件禁止手改**：`pica_reader/lib/src/api/api_config.g.dart`、`pica_reader/test/signature_vectors.g.dart`
  都是 `python analysis/pipeline.py gen` 的产物，CI 会校验漂移。要改协议常量，改 `analysis/baseline/protocol.json` 后重新生成。
- **签名身份不可变**：`android/pica-release.jks` 一旦更换，已安装的用户必须先卸载才能升级。私钥不入库，需自行离线备份。
- **编码**：本机 PowerShell 的 `Get-Content`/`Set-Content` 会把 UTF-8 当 GBK 读写，破坏中文。改文件请用编辑器或本仓库的工具，不要用 PS 管道改写。
- **换行**：`.gitattributes` 强制 LF（`*.cmd`/`*.ps1` 例外），跨平台 diff 才干净。

## 合规

本项目只做互通性研究，不执行、不发散、不修改原 App；仓库不含 APK。详见 [`LEGAL.md`](LEGAL.md)。
