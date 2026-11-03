# REA 网络复核（有界静态结论）

## 1. 范围与证据等级

本复核仅阅读已经完成的 REA 6.8 / JADX 0.7.1 导出及原始 DEX 指令证据；未运行 REA、APK、目标运行时，未安装软件，未发起网络请求或调用目标 API。仅新增本报告，不修改其他文件。

源文件名从 [validation 索引](<rea/validation/index.json>)、[supplement 索引](<rea/supplement/index.json>)、[closure 索引](<rea/closure/index.json>) 与定向 glob 定位。`complete` 表示导出完成，不表示 Java 反编译控制流正确。优先级：**原始 DEX 分支 > smali > 可读 Java**；损坏的 Java 不作为 APK 缺陷证据。

结论只覆盖客户端构造、调度、解析策略、TLS、拦截器、缓存/超时及标识符生成链。**当前服务端是否在线、DNS/IP/证书是否仍有效、登录是否成功、签名是否被现行后端接受、线路是否实际可达，均未动态验证，继续保留未决。**

## 2. PICA HTTP 客户端与调度

### 2.1 `n54` selector 0 是 PICA 客户端，不是图片客户端

[客户端工厂](<rea/validation/002-priority-n54-invoke.java#L10-L38>) 的 selector 0 明确配置：

| 项目 | 静态配置 |
|---|---|
| 连接池 | `p54.h` |
| 磁盘缓存对象 | `p54.i.getValue()`，转换为 `mh0` |
| 应用拦截器（顺序） | `wi0(3)` → `wi0(2)` → `fg4` |
| 网络拦截器（顺序） | `ue0(p54.f, 2)` → `qy2` |
| 事件监听工厂 | `dh4.e` |
| 三个超时 setter | `l54.a(30L)` / `c(30L)` / `d(30L)` |
| DNS | `p54.a(requestMode)` 非空时覆盖默认 DNS |

selector 1 使用另一连接池 `p54.j`、相同缓存、`wi0(3)` 与 `hz2`，且置 `l54.i=false`；它不挂 PICA `fg4`。因此不能把图片请求的行为直接移植为登录 API 行为。[selector 1 与默认分支](<rea/validation/002-priority-n54-invoke.java#L39-L78>)；默认分支三个 setter 是 `10L`，不是 PICA 的 `30L`。

[依赖容器构造](<rea/validation/012-network-p54-_init_.java#L9-L16>) 为 API、图片分别创建 `up2(8, 30L, TimeUnit.SECONDS)`，建立并发客户端映射，缓存通过 lazy 对象取得。这证明有连接池/磁盘缓存接入；本次未跟踪缓存 lazy 工厂的目录和容量，**不填入猜测的缓存大小**。

### 2.2 `j12.a` 按当前 RequestMode 重写 authority，保留请求业务路径

[调度器](<rea/validation/001-priority-j12-a.java#L5-L29>)：

1. 读取 `v55.d` 的当前 `RequestMode`。
2. 用 `Subdomain.API` 与 `requestMode.getDomain()` 构造 `https://<prefix>.<domain>/`；API prefix 为 `picaapi`，见 [Subdomain 初始化](<rea/supplement/108-supp-com.picacg.domain.model.Subdomain-_clinit_.smali#L5-L35>)。
3. 在 `p54.k` 中按 RequestMode `computeIfAbsent`，构造 `n54(..., 0)`；不是每个请求都重建客户端。
4. 对原 URL 只调用 scheme/host/port setter，即 `oa1.k(...)`、`h(...)`、`j(...)`，不替换原 path/query。
5. 写入 `accept: application/vnd.picacomic.com.v1+json`。

[Retrofit 注入](<rea/validation/000-priority-wj1-get.java#L151-L162>) 的基址为 `https://picaapi.picacomic.com/`、CallFactory 为 `j12`，挂载 `pr2.m(b83, application/json; charset=UTF-8)`；[pr2.m](<rea/closure/000-closure-pr2-m.java#L1-L3>) 将传入 JSON 实例与媒体类型封装成 converter。基址常量并不证明所有模式始终使用该 authority；最终路由由上述调度器决定。

## 3. RequestMode、DNS 与启动状态

### 3.1 四种模式和默认值

[RequestMode 初始化 smali](<rea/supplement/012-supp-com.picacg.domain.model.RequestMode-_clinit_.smali#L29-L220>) 确认：

| id | RouteTarget | ResolveStrategy |
|---|---|---|
| `official_direct` | `OFFICIAL` | `SystemDns` |
| `official_enhanced` | `OFFICIAL` | `FixedIps` |
| `proxy1_direct` | `PROXY_1` | `SystemDns` |
| `smart_pool` | `OFFICIAL` | `MeasuredPool` |

`ALL` 收录上述四种；`SPEED_TESTED` 按 `!getUsesPool()` 筛选；`DEFAULT=OFFICIAL_DIRECT`。[getDomain](<rea/supplement/029-supp-com.picacg.domain.model.RequestMode-getDomain.java#L1-L3>) 委托 `target.getDomain()`，本次没有完整 RouteTarget 域名导出，故不凭模式名称猜代理根域名。`dh4` 中的四个诊断后缀也不等于四种模式的域名映射。

[DNS 选择器](<rea/validation/013-network-p54-a.java#L1-L14>)：`SystemDns→null`（保留 builder 默认 DNS），`FixedIps→p54.e/if2`，`MeasuredPool→p54.d/dj1`。[builder 默认](<rea/supplement/211-supp-l54-_init_.java#L4-L24>) 设 `m=fv1.e`；并非 SystemDns 分支设置了一个“空 DNS 实现”。

[固定 IP 解析](<rea/validation/052-network-if2-g.java>) 显示：没有配置列表时回到 `InetAddress.getAllByName(host)`；存在列表时坏 IP 被排后而非全部剔除；用 `InetAddress.getByAddress(host, address)` 保留原 hostname；全部无效才抛 `固定 IP 全部无效: ...`。[池候选转换](<rea/validation/044-network-dj1-a.java>) 同样保留 hostname，跳过无效候选，全部无效抛 `没有有效的 IP 地址: ...`。**定向 IP 解析不等于把 HTTPS URL 改成 IP，也不等于取消 TLS hostname 验证。**

本次不穷举测速、池更新和全部 SmartDNS 算法，不能据此认定某个池当下必有可用 IP。[SmartDNS Retrofit 注入](<rea/validation/000-priority-wj1-get.java#L81-L100>) 可确认独立 `5L` 三超时与 `ip3` 拦截器，但不能替代线路实测。

### 3.2 `v55` 先默认，后异步初始化，并存在 readiness

[构造器](<rea/validation/015-network-v55-_init_.java#L1-L10>) 先以 DEFAULT 初始化 `d`，创建 `f`，再 launch `mx4(this, null, 6)`；[getter](<rea/validation/016-network-v55-b.java#L1-L3>) 直接读当前 `d`。

不能依巨大协程反编译的相邻 case 猜 selector。其 [switch 表](<rea/validation/005-priority-mx4-invokeSuspend.smali#L5398-L5407>) 明确 `6→:pswitch_6f2`；该分支 [读取 DataStore](<rea/validation/005-priority-mx4-invokeSuspend.smali#L3911-L3989>)，经 `bs4(..., 28)` / `kl0.I` 得到值并更新 `v55.d`，随后 [完成 `v55.f`，再调用 `p95.a`](<rea/validation/005-priority-mx4-invokeSuspend.smali#L3994-L4014>)。这闭合了“默认状态→持久化流读取→状态更新→readiness 完成”的调用顺序。

有界限制：本次未拿到 `bs4` selector 28 的转换细节，不能确定旧模式值损坏/缺失时的完整 fallback；[p95.a](<rea/validation/019-network-p95-a.java#L17-L37>) 只确认执行 DataStore edit 并吞掉异常，不能猜其编辑键。`j12.a` 内未显示 await readiness；不据此断言所有登录入口都等待完成或存在初始化竞态。

## 4. TLS、重定向、超时与缓存的边界

### 4.1 此构造路径不是 trust-all

[PICA 工厂](<rea/validation/002-priority-n54-invoke.java#L14-L38>) 未设置自定义 SSLSocketFactory / TrustManager / HostnameVerifier；[默认 builder](<rea/supplement/211-supp-l54-_init_.java#L4-L24>) 配置 `u=h54.a`、`v=sl0.c`。

[默认 TLS 建立](<rea/validation/009-priority-m54-_init_.java#L74-L95>) 调用 `TrustManagerFactory.getDefaultAlgorithm()`，`init((KeyStore)null)`，取系统 `X509TrustManager`，将其传给 `SSLContext.init` 并建立 chain cleaner。不是 `checkServerTrusted` 空实现或信任任意证书。

[h54.verify](<rea/closure/014-closure-h54-verify.java#L2-L14>) 取 `SSLSession.getPeerCertificates()[0]`，执行 `c(host, X509Certificate)`；异常/不符合条件返回 false。[h54.c](<rea/closure/013-closure-h54-c.java#L6-L59>) 对 IP 匹配 SAN type 7，对域名匹配 SAN type 2，并限制 `*.` 通配符仅匹配一层；不是恒真 verifier。[默认 pinner 初始化](<rea/supplement/225-supp-sl0-_clinit_.smali#L5-L34>) 从空集合建立 `sl0.c`，即此默认路径未配置固定证书 pin；**无 pin ≠ 无 CA 验证/主机名验证**。

[传输层接入](<rea/validation/041-network-ue0-a.java#L760-L785>) 将 hostname、DNS、SSLSocketFactory、verifier、pinner 交给地址/连接对象。本次未进行真实握手，也未检查设备信任库、证书有效期或远端证书链。

### 4.2 三超时、默认重定向与缓存策略

[三个 setter](<rea/supplement/212-supp-l54-a.java#L1-L4>) / [c](<rea/supplement/214-supp-l54-c.java#L1-L4>) / [d](<rea/supplement/215-supp-l54-d.java#L1-L4>) 均使用 `TimeUnit.SECONDS` 并调用 `bs6.b(j)`；PICA 均传 `30L`。可读代码确定为三项秒制 30 配置，通常对应 connect/read/write；本次未单独展开 `bs6.b` 校验/毫秒转换实现，不冒充已动态测出 30 秒断连。builder 初值三字段均 `10000`，而 PICA 显式覆盖；不能拿库默认 10 秒代替该客户端配置。[m54 字段复制](<rea/validation/009-priority-m54-_init_.java#L24-L30>)。

[默认 builder](<rea/supplement/211-supp-l54-_init_.java#L4-L24>) 的两个重定向字段 `i/j=true`，PICA selector 0 未覆盖，图片分支改 `i=false`；本次不从单个混淆字段反推出所有跨协议重定向细则。

[wi0 selector 2](<rea/validation/037-network-wi0-a.java#L502-L533>) 对带 `q14` tag 的请求写 `Cache-Control: no-cache`，其响应改为 `no-cache, no-store, must-revalidate, max-age=0` 并移除 `Pragma`；无 tag 且 `s65.y` 为真则不改响应，否则同样加上述禁缓存头。这里只报告观察到的 tag/分支，**不将共享磁盘缓存的存在解读为所有 API 都可离线命中缓存**，也不将 `s65.y` 未闭合的语义擅自解释为某个状态码。

## 5. 签名、请求头与拦截器职责

### 5.1 `fg4` 签名链保持已确认结论

[fg4.a](<rea/validation/025-network-fg4-a.java#L5-L47>) 获取秒级时间 `int(currentTimeMillis()/1000)`、`nh4.d()` nonce、`at1.c()` UUID；签名输入为：

```text
去掉开头 / 的 encoded path
+（encoded query 非空时：? + encoded query）
+ time + nonce + HTTP method + API key
```

然后对**整个拼接结果** `toLowerCase(Locale.ROOT)`，使用代码中的 UTF-8 key 和 `HmacSHA256`，输出 hex。此输入路径未包含 URL hostname 或 JSON 请求体；不是对整个原 URL/JSON body 做 HMAC。key 字面量的唯一定位见 [fg4 第 33 行](<rea/validation/025-network-fg4-a.java#L33>)，不在报告重复扩散。

[固定及条件请求头](<rea/validation/025-network-fg4-a.java#L50-L66>)：

- `accept: application/vnd.picacomic.com.v1+json`
- `time`、`nonce`、`signature`、`api-key`
- `app-channel: 1`
- `app-version: 2.3.1.20241111`
- `app-uuid`、`app-platform: android`
- `app-build-version: 20250144`
- **`User-Agent: okhttp/3.8.1`**
- `image-quality` 来自注入配置；token **非 null** 才直接写 `authorization`（空字符串并未被此条件排除，不加 Bearer 前缀）。

[401 分支](<rea/validation/025-network-fg4-a.java#L69-L73>) 同时删除 `auth_token` 与 `refresh_token` 并清掉 nonce/auth 容器中的 token 缓存 `nh4.c`；不能缩写成“只清 access token”。此行为静态成立，但未触发 401 实测。

### 5.2 重要纠正：3.8.1 是显式 UA，5.3.2 是库 Bridge 的缺省 UA

[ue0 selector 0](<rea/validation/041-network-ue0-a.java#L70-L123>) 是库 Bridge 分支，仅当原请求没有 User-Agent 时写 `okhttp/5.3.2`（[条件与字面量](<rea/validation/041-network-ue0-a.java#L106-L108>)），也补 Host/Connection、条件 gzip，并处理透明解压。

PICA 工厂自定义网络拦截器实例为 `ue0(..., 2)`，**不是 selector 0**；同时 `fg4` 已显式写 `okhttp/3.8.1`，所以缺省 UA 不应覆盖该 PICA 头。**不能从 PICA 的 3.8.1 UA 推断 APK 实际依赖 OkHttp 3.8.1，也不能把库缺省 5.3.2 写成登录请求的最终 UA。** 这两条只是对应分支的请求头字面量证据。

### 5.3 边缘 IP 防护与诊断不是签名器

[ue0 selector 2](<rea/validation/041-network-ue0-a.java#L666-L725>) 只在 HTTP 403 且正文包含 `error code: 1034` 时处理；仅直接连接可识别边缘 IP 并记录黑名单，经代理则跳过 IP 拉黑。它配合 `s12` tag 与 `X-Pica-Bad-Edge-Ip` 响应头；[wi0 selector 3](<rea/validation/037-network-wi0-a.java#L534-L569>) 显示 GET/HEAD 的重试预算最多 2，非幂等方法不自动重试。该段 Java 的尾部/`break` 结构存在反编译疑点，故仅保留上述条件/预算/非幂等保护结论，不宣称已精确重建所有失败循环路径。

[qy2](<rea/validation/042-network-qy2-a.java#L35-L49>) 记录 accept、API key 前 8 字符，authorization 打码为 `***[present]`；另有状态/耗时/peer/cache/location/错误诊断。它不是 HMAC signer。`dh4` [诊断后缀](<rea/supplement/203-supp-dh4-_clinit_.smali#L5-L37>) 包括 `picacomic.com`、`manhuabika.com`、`diwodiwo.xyz`、`go2778.com`；不把该列表当成路由目标映射或可达性证明。

## 6. Nonce 与 UUID：必须区分持久化标识与每请求随机数

### 6.1 `nh4` nonce

[nh4.e](<rea/validation/031-network-nh4-e.java>) 从 SharedPreferences `pica_nonce_prefs` 读取 `pica_nonce`；已有值直接返回，否则从 `0–9/a–z` 字符集中随机选 32 字符并 `apply()` 持久化。`fg4` 对该值还有内存缓存；**这是可复用的持久化 nonce，不是每次请求重新生成的 nonce**。

### 6.2 `at1.c` 原始 DEX 分支纠正损坏 Java

[Java 导出](<rea/validation/003-priority-at1-c.java#L61-L65>) 出现非法的 `for (0; i < length; i + 1)` 和字符变量恢复错误，不能据此报告“APK 校验死循环/每次丢弃 UUID”。本次以 [原始 DEX 方法记录](<supplement_original_dex.json#L11176-L11186>) 为准：`Lat1;->c(Lpe1;)Ljava/lang/Object;`，位于 `classes3.dex`，`code_offset=775552`。

[原始检查分支](<supplement_original_dex.json#L11615-L11875>) 的关键 PC：

- `pc96`：持久化值为 null → 生成分支 `pc154`。
- `pc111`：长度不是 32 → `pc154`。
- `pc118`：扫描完成 → `pc153`，**原样返回已保存值**。
- `pc124/128`、`pc133/137`、`pc142/146`：接受 `0–9`、`a–f`、`A–F`；其他字符 → `pc154`。
- `pc150` 确实自增；`pc152` 回到 `pc114`，不是 Java 导出表面的不变循环变量。

因此，合法 32 位大小写十六进制 UUID 可直接复用，**不会因为使用大写 A–F 而重建**。

在 `pc154` 后，读取 `Settings.Secure.android_id`：非空且不等于特殊值 `9774d56d682e549c` 时生成其 MD5 hex；缺失/空/该特殊值或异常时退回随机 UUID。随机 helper [at1.a](<rea/validation/022-network-at1-a.java#L1-L4>) 是 `UUID.randomUUID()` 去连字符。[原始生成与分支](<supplement_original_dex.json#L11875-L12224>)、[DataStore edit 持久化](<supplement_original_dex.json#L12225-L12326>) 显示生成后经 `zs1` / `PreferencesKt.edit` 写回，再返回结果或挂起。

**可确认：UUID 校验、稳定复用、MD5 Android ID / random fallback 和持久化链均存在。不可确认：任何具体设备最终取到的 UUID、Android ID 值或持久化权限/异常表现。**

## 7. JSON 配置闭环与最终未决

父代理补充的真实 REA 导出已经闭合配置语义，不再依混淆字段猜测：

1. [hj5 初始化](<rea/final/003-final-hj5-_clinit_.smali>) 选择 `dc5(10)`，经 `fs2.d` 构造 `hj5.a`。
2. [dc5 case 10](<rea/final/002-final-dc5-invoke.java#L50-L56>) 设置 g83 的 a/b/c=true；[构建器](<rea/config/000-config-fs2-d.java#L5-L22>) 把它们送入 i83。
3. [i83 构造器](<rea/config/001-config-i83-_init_.java#L5-L12>) 与[语义标签](<rea/config/002-config-i83-toString.java#L2>) 对应 a=encodeDefaults、b=ignoreUnknownKeys、c=isLenient、d=explicitNulls。
4. [基础配置初始化](<rea/defaults/000-defaults-b83-_clinit_.smali#L20-L40>) 的 d=true，由 fs2.d 保留。

因此，注入 PICA converter 的 JSON 实例静态配置为 **encodeDefaults=true、ignoreUnknownKeys=true、isLenient=true、explicitNulls=true**。不能将 isLenient 泛化为“接受任意非法 JSON”：该配置仍明确 allowTrailingComma=false、allowComments=false、coerceInputValues=false。这不是动态 JSON 往返测试。

[默认写出判据](<rea/defaults/002-defaults-dx5-e.java#L2-L4>) 返回配置 a；[null 输出](<rea/defaults/001-defaults-dx5-d.java#L2-L5>) 写文本 null。不过 writer 可自行跳过字段，例如 AdvancedSearchBody.categories=null 时仍省略，不能把 explicitNulls=true 解释成所有 nullable 字段必有 null 键。详见[请求模型复核](<REA请求模型复核.md#4-json-encoder-配置与-helper-闭环>)。

### 汇总

- 静态闭合：PICA selector 0、authority 调度、四种 RequestMode/DNS 映射、默认 CA/SAN 验证、签名/UA 区分、nonce、UUID、异步 readiness 次序、JSON 配置字段语义。
- 有界未闭合：具体代理 RouteTarget 域名、缓存目录/容量、saved-mode 损坏值转换 fallback、部分 JADX 损坏的边缘重试完整控制流；不把它们写成 APK bug。
- 动态未决：登录/令牌过期或刷新实效、目标 API、线路/DNS/IP/证书可用性、服务器签名兼容性。未执行目标或业务请求，不能给出“已能登录/已可直连”。
