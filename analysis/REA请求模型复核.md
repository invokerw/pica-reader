# REA 请求模型复核

范围：仅静态读取已有 REA 的 descriptor 初始化、`childSerializers()`、构造器与 `write$Self$app`；未运行目标、联网或安装工具。这里的“必填”是客户端序列化模型的必需键，不等同于服务端额外业务校验。键名取 descriptor，按索引与 writer 对齐，不从原始字段名猜测。

## 1. Nullable、optional 与默认值是三件事

| 判据 | 含义 | 本次实例 |
|---|---|---|
| descriptor 的 `j(key, false)` / `j(key, true)` | 元素非 optional / optional，即缺键是否允许由模型默认值补足；不是 null 标志 | `sort` 为 optional，但其 String 不可 null |
| `childSerializers()[index]` | 元素类型及 null 包装；`ix5.a` 用于 String，`e53.a` 用于 Int；`uo3.M(serializer)` 是本次出现的 nullable 包装调用 | `error` 包装 String；`data` 包装传入的泛型 serializer |
| 序列化合成构造器的位掩码 | 实际缺键默认值与必需键检查 | AdvancedSearch 只要求 bit 0；缺 `sort` → `"dd"`，缺 `categories` → `null` |
| writer 的条件分支 | 默认值是否写入；optional 不表示永远省略 | 非默认 `sort` 写入；null `categories` 始终跳过 |

关键反例：nullable 不自动表示 optional；optional 也不自动表示 nullable。`PicaResponse.error/data` 恰好二者兼具，需要 descriptor、child wrapper 和默认构造器三方证据。

## 2. 六个请求根

下表“无”表示没有缺键默认值，不表示默认空字符串。所有 required String 的普通构造器均保存传入字符串；序列化构造器缺必需位即进入 `pr2.D(...)` 失败路径。

| 请求根 | descriptor 索引 → 精确 wire key | 模型类型 / null | optional | 缺键默认值 | writer 行为 |
|---|---|---|---|---|---|
| SignInRequest | 0 → `email`；1 → `password` | 两者 String，非 null | 均 false | 无（required mask `3`） | 两键直接以 `b0` 写原字段值 |
| RegisterRequest | 0 → `name`；1 → `email`；2 → `password`；3 → `question1`；4 → `answer1`；5 → `question2`；6 → `answer2`；7 → `question3`；8 → `answer3`；9 → `birthday`；10 → `gender` | 11 个 String，均非 null | 均 false | 无（required mask `2047` / `0x7ff`） | 11 键全部直接 `b0` 写入 |
| AdvancedSearchBody | 0 → `keyword` | String，非 null | false | 无（required mask `1`） | 必写 |
| AdvancedSearchBody | 1 → `sort` | String，非 null | true | `"dd"` | `tt3.e(descriptor)` 为 true 或值不等于 `"dd"` 时写入 |
| AdvancedSearchBody | 2 → `categories` | `List<String>?`；整个列表 nullable | true | `null` | **仅非 null 时写入**，null 分支没有 `tt3.e` 检查 |
| ContentBody | 0 → `content` | String，非 null | false | 无（required mask `1`） | 必写 |
| AvatarUpdateRequest | 0 → `avatar` | String，非 null | false | 无（required mask `1`） | 必写 |
| SloganUpdateRequest | 0 → `slogan` | String，非 null | false | 无（required mask `1`） | 必写 |

- **SignIn 密码**：普通构造器为 `this.password = str2`；writer 为 `b0(descriptor, 1, signInRequest.password)`，没有客户端密码 hash、加密、编码或额外派生字段步骤。准确范围是“这条模型/序列化链原样写字符串”；本次未审上游完整调用链，不能由此声称全客户端每个调用点都从未预处理输入，也不能把数据类的 `hashCode()` 当作密码 hash。
- `birthday`、`gender`、`avatar` 等只证明为 String；这些方法没有给出生日格式、性别枚举、头像字符串内容或空串合法性，不能补造限制。
- `List<String>?` 的声明来自普通构造器，child 的外层 `uo3.M(...)` 证明包装的是整个列表，不是每个元素。本次未读缓存列表 serializer 的 factory 实现，元素 serializer 的具体表达式未单独证实。

### 请求证据（D = descriptor；C = child；I = 构造器；W = writer）

| 根 / 混淆后的 serializer | 可核对来源 |
|---|---|
| SignInRequest / `to5` | [D](<rea/validation/138-serializer-to5-_clinit_.smali#L22-L50>) · [C](<rea/validation/139-serializer-to5-childSerializers.java#L2-L4>) · [I 必需位](<rea/validation/135-dto-com.picacg.network.pica.api.SignInRequest-_init_.java#L1-L7>) · [I 原样保存](<rea/validation/136-dto-com.picacg.network.pica.api.SignInRequest-_init_.java#L1-L5>) · [W](<rea/validation/137-dto-com.picacg.network.pica.api.SignInRequest-write_Self_app.java#L1-L4>) |
| RegisterRequest / `q35` | [D](<rea/validation/128-serializer-q35-_clinit_.smali#L35-L132>) · [C](<rea/validation/129-serializer-q35-childSerializers.java#L2-L4>) · [I 必需位](<rea/validation/125-dto-com.picacg.network.pica.api.RegisterRequest-_init_.java#L1-L16>) · [I 普通](<rea/validation/126-dto-com.picacg.network.pica.api.RegisterRequest-_init_.java#L1-L15>) · [W](<rea/validation/127-dto-com.picacg.network.pica.api.RegisterRequest-write_Self_app.java#L1-L13>) |
| AdvancedSearchBody / `j8` | [D](<rea/validation/108-serializer-j8-_clinit_.smali#L34-L62>) · [C](<rea/validation/109-serializer-j8-childSerializers.java#L2-L5>) · [I 默认值](<rea/validation/105-dto-com.picacg.network.pica.api.AdvancedSearchBody-_init_.java#L1-L16>) · [I List 声明](<rea/validation/106-dto-com.picacg.network.pica.api.AdvancedSearchBody-_init_.java#L1-L6>) · [W](<rea/validation/107-dto-com.picacg.network.pica.api.AdvancedSearchBody-write_Self_app.java#L1-L10>) |
| ContentBody / `ac1` | [D](<rea/validation/118-serializer-ac1-_clinit_.smali#L34-L41>) · [C](<rea/validation/119-serializer-ac1-childSerializers.java#L2-L3>) · [I 必需位](<rea/validation/115-dto-com.picacg.network.pica.api.ContentBody-_init_.java#L1-L7>) · [I 非 null](<rea/validation/116-dto-com.picacg.network.pica.api.ContentBody-_init_.java#L1-L3>) · [W](<rea/validation/117-dto-com.picacg.network.pica.api.ContentBody-write_Self_app.smali#L5-L16>) |
| AvatarUpdateRequest / `AvatarUpdateRequest$$serializer` | [D](<rea/validation/161-serializer-com.picacg.network.pica.model.AvatarUpdateRequest__serializer-_clinit_.smali#L42-L49>) · [C](<rea/validation/163-serializer-com.picacg.network.pica.model.AvatarUpdateRequest__serializer-childSerializers.java#L2-L3>) · [I 必需位](<rea/validation/158-dto-com.picacg.network.pica.model.AvatarUpdateRequest-_init_.java#L1-L7>) · [I 非 null](<rea/validation/159-dto-com.picacg.network.pica.model.AvatarUpdateRequest-_init_.java#L1-L3>) · [W](<rea/validation/160-dto-com.picacg.network.pica.model.AvatarUpdateRequest-write_Self_app.smali#L5-L16>) |
| SloganUpdateRequest / `SloganUpdateRequest$$serializer` | [D](<rea/validation/437-serializer-com.picacg.network.pica.model.SloganUpdateRequest__serializer-_clinit_.smali#L42-L49>) · [C](<rea/validation/439-serializer-com.picacg.network.pica.model.SloganUpdateRequest__serializer-childSerializers.java#L2-L3>) · [I 必需位](<rea/validation/434-dto-com.picacg.network.pica.model.SloganUpdateRequest-_init_.java#L1-L7>) · [I 非 null](<rea/validation/435-dto-com.picacg.network.pica.model.SloganUpdateRequest-_init_.java#L1-L3>) · [W](<rea/validation/436-dto-com.picacg.network.pica.model.SloganUpdateRequest-write_Self_app.smali#L5-L16>) |

## 3. LoginData 与 PicaResponse

| 根 | descriptor 索引 → wire key | child serializer / 模型类型 | optional | 缺键默认值 | writer 行为 |
|---|---|---|---|---|---|
| LoginData | 0 → `token` | `ix5.a` / String，非 null | false | 无（required mask `1`） | 必写 |
| PicaResponse<T> | 0 → `code` | `e53.a` / Int，非 null | false | 无（与 message 合计 required mask `3`） | `Y(0, code, descriptor)` 必写 |
| PicaResponse<T> | 1 → `message` | `ix5.a` / String，非 null | false | 无 | `b0(descriptor, 1, message)` 必写 |
| PicaResponse<T> | 2 → `error` | **`uo3.M(ix5.a)`** / String? | true | `null` | `tt3.e(descriptor)` 为 true 或非 null 时，调用 `p(..., ix5.a, error)` |
| PicaResponse<T> | 3 → `data` | **`uo3.M(typeSerial0)`** / T? | true | `null` | `tt3.e(descriptor)` 为 false 且 null 时省略；否则调用 `p(..., typeSerial0, data)` |

`data` 不是固定对象或固定 LoginData：泛型 serializer 构造器保存传入的 `ca3` 为 `typeSerial0`，其外层才施加 nullable 包装。若具体使用 `PicaResponse<LoginData>`，data 有值时内部 `token` 仍是必需键；外层 data 缺失或为 null 与内部 token 缺失是不同情况。

### 响应证据

| 根 | 可核对来源 |
|---|---|
| LoginData | [D](<rea/validation/371-serializer-com.picacg.network.pica.model.LoginData__serializer-_clinit_.smali#L42-L49>) · [C](<rea/validation/373-serializer-com.picacg.network.pica.model.LoginData__serializer-childSerializers.java#L2-L3>) · [I 必需位](<rea/validation/368-dto-com.picacg.network.pica.model.LoginData-_init_.java#L1-L7>) · [I 非 null](<rea/validation/369-dto-com.picacg.network.pica.model.LoginData-_init_.java#L1-L3>) · [W](<rea/validation/370-dto-com.picacg.network.pica.model.LoginData-write_Self_app.smali#L5-L16>) |
| PicaResponse<T> | [D](<rea/validation/398-serializer-com.picacg.network.pica.model.PicaResponse__serializer-_init_.java#L1-L7>) · [C：两个 null wrapper](<rea/validation/400-serializer-com.picacg.network.pica.model.PicaResponse__serializer-childSerializers.java#L2-L4>) · [泛型 serializer](<rea/validation/399-serializer-com.picacg.network.pica.model.PicaResponse__serializer-_init_.java#L2-L5>) · [I 必需位与缺键 null](<rea/validation/394-dto-com.picacg.network.pica.model.PicaResponse-_init_.java#L2-L17>) · [I 普通](<rea/validation/395-dto-com.picacg.network.pica.model.PicaResponse-_init_.java#L1-L6>) · [I 调用侧默认 null](<rea/validation/396-dto-com.picacg.network.pica.model.PicaResponse-_init_.java#L1-L2>) · [W](<rea/validation/397-dto-com.picacg.network.pica.model.PicaResponse-write_Self_app.java#L1-L11>) |

## 4. JSON encoder 配置与 helper 闭环

后续真实 REA 补充批次已经把原报告保留的 helper 问题闭合：

- [qj4.j](<rea/closure/004-closure-qj4-j.java#L3-L8>) 按索引登记 key 和 optional bool，证实 descriptor 索引含义；不是 null 标记。
- [uo3.M](<rea/closure/003-closure-uo3-M.java>) 保留已 nullable 的 serializer，否则包成 b44；[b44 解码](<rea/closure/006-closure-b44-deserialize.java>) / [编码](<rea/closure/008-closure-b44-serialize.java>) 分别允许 null 或委托底层，证实包装语义。
- [tt3.p](<rea/final/000-final-tt3-p.java#L4-L10>) 先登记字段，再按底层 nullable/值是否 null 选择 serializer 或 d()；[实际 JSON d()](<rea/defaults/001-defaults-dx5-d.java#L2-L5>) 写 `null`。
- [dx5.e](<rea/defaults/002-defaults-dx5-e.java#L2-L4>) 返回配置 a。此 a 的语义是 encodeDefaults，不是任意常量：[i83 字段标签](<rea/config/002-config-i83-toString.java#L2>) 与[构造器](<rea/config/001-config-i83-_init_.java#L5-L12>)。
- [hj5 初始化](<rea/final/003-final-hj5-_clinit_.smali>) → [dc5 case 10](<rea/final/002-final-dc5-invoke.java#L50-L56>) → [fs2.d](<rea/config/000-config-fs2-d.java#L5-L22>)，再结合[基础配置](<rea/defaults/000-defaults-b83-_clinit_.smali#L20-L40>)，闭合 PICA JSON 实例为 **encodeDefaults=true、ignoreUnknownKeys=true、isLenient=true、explicitNulls=true**。

对本表的具体影响：

1. `AdvancedSearchBody.sort` 即使为默认 `dd`，在该 JSON 实例的实际 writer 条件下也写出；而 **categories=null 仍省略**，因为其 writer 自行用非 null 条件跳过整个字段。[writer](<rea/validation/107-dto-com.picacg.network.pica.api.AdvancedSearchBody-write_Self_app.java#L4-L10>)。
2. `PicaResponse.error/data` 的 writer 检查 encodeDefaults；在本配置下 null 也调用 p()，由 JSON encoder 输出 null。该输出语义与响应“允许缺失/允许 null”的解码契约是两回事。
3. 必需 String 无缺键默认值；宽松解析/未知键忽略不等于放弃缺键检查，也不证明服务端业务容许空串。isLenient 不等于接受任意 JSON，配置仍禁 trailing comma/comments/coercion。

这些是静态源码闭环，没有执行 APK 或进行服务端、设备运行时的 JSON 往返测试。更多根/嵌套模型见[62 模型清单](<REA模型清单.md>)与[机器清单](<rea_model_schema.json>)；懒加载/泛型 child 保留原表达式，未解析者不猜类型。
