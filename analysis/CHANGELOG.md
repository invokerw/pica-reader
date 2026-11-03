# 协议基线变更记录

每一版 APK 的分析结论都记在这里。记录规则：

- **每个版本一节**，按 APK 版本号排序（新的在上）。
- 只记**会改变客户端行为**的事：常量、签名算法、接口、请求头、要改的 Dart 文件。
- 每节必须写清楚"证据在哪"（文档名 + 证据文件）和"影响了什么代码"。
- `protocol.json` 是机器可读版本，本文件是人读摘要；两者不一致时以 `protocol.json` 为准，并回头修本文件。

---

## 2.6.73 · 2026-11-02 · 基线

样本 `picacg-v2.6.73.apk`，SHA256 见 [`versions/2.6.73/sha256.txt`](versions/2.6.73/sha256.txt)。

**协议常量**

| 项 | 值 |
| --- | --- |
| baseUrl | `https://picaapi.picacomic.com` |
| api-key | `C69BAF41DA5ABD1FFEDC6D2FEA56B` |
| api-secret | 反编译所得 HMAC 密钥，见 `pica_reader/lib/src/api/api_config.g.dart` |
| accept | `application/vnd.picacomic.com.v1+json` |
| app-version | `2.3.1.20241111` |
| app-build-version | `20250144` |
| app-channel | `1` |
| app-platform | `android` |
| User-Agent | `okhttp/3.8.1` |

注意 `app-version` 与 APK 的 market version（2.6.73）**不是一回事**：前者是协议版本号，后者是发版号。前者通常数月才变一次。

**签名算法**

`signature = hex(HMAC-SHA256(secret, lower(encodedPath + ('?' + encodedQuery) + t + nonce + method + apiKey)))`

- `encodedPath` 去掉一个前导 `/`（有 query 时以 `/` 结尾）；`encodedQuery` 为空时**整段 `?` 都不拼**。
- 参与签名的字符串整体转小写**再**计算 HMAC（不是拼完再小写），`t` 为 int32 秒级时间戳。
- 证据：`classes3.dex` 的 `Lfg4;->a(Lhe3;)Ls65;`（code_off `0x111120`）指令序列，见
  [`signature_helper_evidence.md`](signature_helper_evidence.md) 与 [`focused_dex.md`](focused_dex.md)。
- 离线复算：`python analysis/pica_signature_offline.py`，向量固化在 `pica_reader/test/signature_vectors.g.dart`。

**接口**

42 个（GET 27 / POST 13 / PUT 2），全表见 [`protocol_catalog.md`](protocol_catalog.md)。
派生出的 Dart 客户端方法全部手写在 `pica_reader/lib/src/api/api_client.dart`，只消费常量、不生成方法体。

**影响**

初版，无迁移成本。

---

<!--
新版本模板：

## 2.6.80 · YYYY-MM-DD · <一句话结论>

样本 SHA256：`...`

**变化**（来自 `python analysis/pipeline.py diff`）
- BREAKING：…
- ADDITIVE：…
- COSMETIC：…

**影响**（要改的代码）
- `pica_reader/lib/src/api/signer.dart:NN`

**证据**
- [`versions/2.6.80/REPORT.md`](versions/2.6.80/REPORT.md)
-->
