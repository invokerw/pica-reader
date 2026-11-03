# analysis · APK 静态分析记录

本目录回答一个问题：**这个 App 到底怎么跟服务器说话**——用的是什么密钥、签名怎么算、有哪些接口、请求带什么头、
响应长什么样。所有结论都来自对原始 APK 的**静态**分析（不运行 App、不发真实请求、不碰账号），每条结论都能追到具体的
DEX 类/方法/指令偏移或 REA 反编译行号。

> 分析时间：2026-11-02 · 样本：`picacg-v2.6.73.apk` · SHA256 见 [`versions/2.6.73/sha256.txt`](versions/2.6.73/sha256.txt)

## 1. 结论在哪

按"读起来最省力"的顺序：

| 文档 | 它回答什么 | 对应的机器证据 |
| --- | --- | --- |
| [`protocol_catalog.md`](protocol_catalog.md) | **协议总表**：42 个接口的 HTTP 方法/路径/参数、6 个请求体的 wire key、返回模型边界 | `remaining_targets.json`、`rea_model_schema.json`、`rea/validation/` |
| [`登录与协议分析.md`](登录与协议分析.md) | 登录链路、签名公式、请求头全表、错误码语义 | `dex_protocol_evidence.json` |
| [`signature_helper_evidence.md`](signature_helper_evidence.md) | 签名 helper（`Lc31;->n` 等）怎么拼接、`?` 与 query 的边界 | `focused_dex.json` |
| [`REA请求模型复核.md`](REA请求模型复核.md) | 哪些字段可省略、省略后默认值是什么 | `rea_model_schema.json` |
| [`REA模型清单.md`](REA模型清单.md) | 62 个模型 / 299 个字段的声明与 wire key 对照 | `rea_model_schema.json` |
| [`REA网络复核.md`](REA网络复核.md) | 网络层（Retrofit 注解、拦截器、图片域名）复核记录 | `rea/` |
| [`接口实测结果.md`](接口实测结果.md) / [`漫画接口实测结果.md`](漫画接口实测结果.md) | 按上述结论**真机联调**的结果（有账号、有请求） | `api-*.json` |
| [`dex_protocol_evidence.md`](dex_protocol_evidence.md) | 原 DEX 里的注解、方法 ID、关键指令序列（长篇） | 同名 `.json` |
| [`focused_dex.md`](focused_dex.md) | 定向导出的 20 余个关键方法的指令级 dump | 同名 `.json` |
| [`http_endpoints.md`](http_endpoints.md) | 从字符串池里捞出的 URL 清单 | `classes*.dex.strings.txt` |
| [`REA使用说明.md`](REA使用说明.md) | 这套 REA 环境怎么装、怎么跑、失败怎么查 | `.rea-tools/` 清单 |

**边界**：静态分析只能证明"代码里写了什么"，不能证明"服务端一定接受"。凡是标了"实测"的才是有请求佐证的；
`protocol_catalog.md` 也明确列了未覆盖面（raw socket / WebView / 运行时生成的请求、非 PICA 接口的返回模型）。

## 2. 脚本与执行顺序

```text
paths.py                     统一解析 PICA_APK / PICA_OUT / PICA_VERSION 与仓库相对路径
apk_probe.py                 解包：清单、DEX 类/方法/原生方法、字符串池、SO 提取
   └─> dex_evidence.py       注解 + 方法 ID + 关键方法指令（协议证据的源头）
         └─> focused_dex.py  定向 dump → focused_dex.json（含 42 个 Retrofit 端点）
               └─> build_protocol_catalog.py   依赖 REA 结果，生成 protocol_catalog.md
extract_protocol.py          从任意 APK 提取协议基线（靠常量定位，不依赖混淆名）→ protocol.json
diff_protocol.py             与基线比较 → REPORT.md，BREAKING 时退出码 2
gen_dart.py                  从 protocol.json 生成 api_config.g.dart 与签名向量
pipeline.py                  上面这些的统一入口（见下）
setup_rea_dependencies.py    JDK21 + jadx-headless-mcp 下载与校验（旧入口；现在优先 tools/bootstrap.ps1 -Profile analyze）
prepare_rea_*.py             生成各阶段 REA 批次任务（core/supplement/validation/closure/config/defaults/final）
rea_batch.mjs                批次执行器（REA 6.8.0 的 AndroidAnalysisService）
audit_rea_results.py         批次结果审计：证据 ID、类身份、方法与原 DEX 是否一致
pica_signature_offline.py    离线复算签名向量（从证据里取常量，不重打）
pica_*_probe.py / *_test.py  联机探针与冒烟测试（需要账号，会发真实请求）
```

`_oneoff/` 里是两个一次性脚本（按会话记录恢复被写坏的文件、查看某次 REA 失败原因），
只为留档，不参与流水线。

编排入口是 [`pipeline.py`](pipeline.py)，它把上面这些串成一条可重复的流水线：

```powershell
python analysis/pipeline.py verify                          # 自检：从 APK 复现基线、生成文件无漂移
python analysis/pipeline.py static --apk <apk> --out <dir>  # 纯 Python，约 30 秒，产出 protocol.json
python analysis/pipeline.py diff   --protocol <dir>         # 与基线对比，退出码 0=兼容 / 2=破坏性
python analysis/pipeline.py gen                             # 重新生成 api_config.g.dart 与签名向量
python analysis/pipeline.py accept --version <ver>          # 人工审核后把结果固化为新基线
python analysis/pipeline.py rea    --batch <batch.json>     # 需要 JVM+Node，10-40 分钟，产出反编译证据
```

所有脚本都认这两个环境变量，默认值保持向后兼容，因此老命令照跑：

| 变量 | 默认 | 作用 |
| --- | --- | --- |
| `PICA_APK` | `<repo>/picacg-v2.6.73.apk` | 分析哪个样本 |
| `PICA_OUT` | `<repo>/analysis` | 证据写到哪里（新版本建议 `analysis/runs/<ver>`） |

## 3. 目录约定

| 路径 | 是否入库 | 说明 |
| --- | --- | --- |
| `analysis/*.md`、`*.py`、`*.json` | ✅ | 2.6.73 这一版的**存档证据**，文档里的相对链接依赖当前布局，不要重排 |
| `analysis/rea/` | ✅ | REA 反编译产物（13 MB），文档里 100+ 条 `#L行号` 链接指向这里 |
| `analysis/baseline/protocol.json` | ✅ | **机器可读协议基线**，`api_config.g.dart` 与签名向量的唯一真源 |
| `analysis/versions/<ver>/` | ✅ | 每版的协议快照：`sha256.txt`（样本指纹与签名器指纹）+ `REPORT.md`（与上一版的差异） |
| `analysis/runs/<ver>/` | ❌ | 复分析的全量中间产物，CI 以 artifact 形式保留 90 天 |

## 4. 出了新 APK 怎么办

先核对样本：SHA256 记在 `analysis/versions/<ver>/sha256.txt`，基线里也有同一份（`apk.sha256`）。
对不上就说明拿到的不是同一版，先别往下走。然后跑：

```powershell
python analysis/pipeline.py new --apk .cache\apk\picacg-v2.6.80.apk --version 2.6.80
```

`REPORT.md` 会把差异分成三档，并直接指出要改哪里：

| 档 | 触发条件 | 要做什么 |
| --- | --- | --- |
| **BREAKING** | `api_key` / `api_secret` / `base_url` / 签名方法指纹变了，或接口被删 | 看 REPORT 的 `action` 列改 `signer.dart` / `api_client.dart`，然后 `pipeline.py gen` |
| **ADDITIVE** | 只多了接口 | 按需在 `api_client.dart` 增加方法，不改现有代码也能继续用 |
| **COSMETIC** | 只升了 `app-version` / `app-build-version` | 跑 `pipeline.py gen` 即可，行为不变 |

"签名方法指纹"是对签名函数**指令序列 + 字符串常量**取的哈希：拼接顺序、大小写处理、query 边界只要有一处变了，
指纹就会变。它不解释变了什么（那需要人读反编译），但能保证**不会静默漏掉**。

### 混淆名漂移

REA 批次 JSON 里用的是 R8 混淆后的类名（签名器 `Lfg4;`、Retrofit 接口 `Leg4;`），**每次发版都会重排**。
所以 `rea` 阶段不能直接复用旧批次：

1. `pipeline.py rea` 先用语义指纹重新定位锚点——"含 `HmacSHA256` 且带 `api-key` 常量的方法"= 签名器，
   "带 `@GET/@POST/@PUT` 注解的接口类"= Retrofit 接口——写出 `anchors-<ver>.json`；
2. 找不到**唯一**候选就停下并打印候选列表，不猜；
3. 用锚点替换批次 JSON 里的类名后再执行。

`static` 阶段不依赖这一步，所以即使 REA 定位失败，协议基线仍能更新。

## 5. 一次性脚本

`_oneoff/` 放与管线无关的救火脚本（例如从 DSH 会话记录里恢复被 PowerShell 写坏的 Dart 源码）。
它们依赖仓库外的路径，只作历史记录保留。
