# 2.6.73 —— 首版基线

这是流水线的起点，没有"上一版"可比，所以这份记录写的是**基线本身包含什么**，而不是差异。

| 项 | 值 |
| --- | --- |
| 样本 | `picacg-v2.6.73.apk` |
| SHA256 | `68b1a02d634f791a673bd58935208cde8c896a6ea0912fcbf1b946d9a229c06e` |
| 签名器 | `Lfg4;->a(Lhe3;)Ls65;`（classes3.dex，code_off `0x111120`） |
| 接口 | 42 个：GET 27 / POST 13 / PUT 2 |
| base_url | `https://picaapi.picacomic.com` |
| 协议文档 | [`protocol_catalog.md`](../../protocol_catalog.md)、[`登录与协议分析.md`](../../登录与协议分析.md) |

## 怎么复现

```powershell
python analysis/pipeline.py verify
```

它会从样本 APK 重新提取协议、与 `analysis/baseline/protocol.json` 比较、再检查
`api_config.g.dart` 与 `signature_vectors.g.dart` 有没有漂移。三项都过 = 基线可信。

## 下一版怎么看

```powershell
python analysis/pipeline.py new --apk <新 APK> --version <新版本>
```

报告在 `analysis/runs/<新版本>/REPORT.md`；没有 BREAKING 差异就 `pipeline.py gen` +
`pipeline.py accept` 把基线前移，并在这里（以及 `analysis/CHANGELOG.md`）补一条记录。
