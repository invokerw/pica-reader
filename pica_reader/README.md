# pica_reader

基于本目录 APK 静态分析结果（`analysis/登录与协议分析.md`、`analysis/protocol_catalog.md`）实现的第三方哔咔漫画阅读器，Flutter 单代码库，目标平台 **Windows + Android**。

只做浏览和阅读：不登录可以看首页/排行/搜索，登录后才能看需要账号的内容。**没有**点赞、收藏、评论、下载等写操作。

## 已实现

| 页面 | 内容 |
| --- | --- |
| 登录 | 账号密码登录，token 只在内存中持有并在本次会话内复用 |
| 首页 | 分类（按中文标题过滤）、排序 `dd/da/ld/vd`、无限滚动网格 |
| 排行 | 日榜 `H24`、周榜 `D7`、月榜 `D30` |
| 搜索 | 关键词搜索（`POST /comics/advanced-search`）+ 热门关键词 |
| 详情 | 漫画信息、章节网格、章节评论、继续阅读 |
| 阅读 | 横向/纵向翻页、点击唤出工具栏、页码跳转、自动记录进度 |
| 我的 | 个人资料、历史记录、阅读设置（方向、画质）、设备标识 |

## 构建

工具链全部装在本目录，不写全局环境变量。所有命令都通过 `.tools\flutter.cmd`（它把 `APPDATA`/`TEMP`/`PUB_CACHE` 重定向到本目录，并注入 JDK、Android SDK、Gradle 缓存路径）：

```powershell
cmd /c '.tools\flutter.cmd pub get'
cmd /c '.tools\flutter.cmd analyze'
cmd /c '.tools\flutter.cmd test'                 # 离线：签名向量、URL 拼接
cmd /c '.tools\flutter.cmd build windows --release'
cmd /c '.tools\flutter.cmd build apk --release'
```

产物：

- `build\windows\x64\runner\Release\`（整个目录一起拷走，exe 依赖同目录的 DLL 和 `data\`）
- `build\app\outputs\flutter-apk\app-release.apk`

环境注意事项（本机实测）：

- Flutter 3.47 的 Gradle 插件会注册一个合成的 `externalNativeBuild`，所以即使没有原生代码也**必须**有 NDK；已安装 `28.2.13676358`（r28c）到 `.tools\android-sdk\ndk\`，缺失时 `flutter build apk` 会报 `NDK not configured`。
- 模板默认用 `~/.android/debug.keystore` 签 release，本机该目录不可写（`AccessDeniedException: debug.keystore.lock`），因此改用项目内 keystore：`android/pica-release.jks` + `android/key.properties`（两者都已加入 `.gitignore`）。**换了 keystore 就无法覆盖安装**，请保留这两个文件。
- 本机无法创建符号链接（无 `SeCreateSymbolicLinkPrivilege`，也未开启开发者模式），所以 `pubspec.yaml` 里只允许纯 Dart 依赖，任何带原生插件的包都会让 `pub get` 失败。

## 联机自检

`test/live_api_test.dart` 用 App 自己的网络层打真实接口，默认跳过：

```powershell
$env:PICA_LIVE_ACCOUNT='账号'
$env:PICA_LIVE_PASSWORD='密码'
cmd /c '.tools\flutter.cmd test test/live_api_test.dart'
```

2026-11-02 实测通过：登录拿到 token、个人资料、`/comics` 首页 20 条 / 共 144912 条、第 2 页、`H24` 榜单 40 条、随机 20 条、47 个分类、关键词搜索、详情（44 话）、章节列表 40 条、章节图片 40 张、图片 URL 直接返回 `200 image/jpeg`、评论 20 条 / 共 77 条。

## 协议要点（来自 APK 静态分析）

- 签名：`lowercase(encodedPath + ('?' + encodedQuery 若存在) + t + nonce + method + apiKey)`，再做 `HMAC-SHA256(secret)` 取小写 hex；`t` 为 int32 秒级时间戳。
- 请求头：`accept: application/vnd.picacomic.com.v1+json`、`api-key`、`app-channel: 1`、`app-version`、`app-build-version`、`app-platform: android`、`app-uuid`（32 位 hex）、`image-quality`、`time`、`nonce`（32 位 `[0-9a-z]`，客户端持久化）、`signature`、`User-Agent: okhttp/3.8.1`；`authorization` 为**裸 token**，没有 `Bearer`。
- 业务判定：`code == 200 && message == 'success'`；`error == '1023'` 表示本机时钟与服务端偏差过大；HTTP 401 视为登录失效。
- 列表数据：`data.<集合名>.docs`（含 `total/limit/page/pages`），榜单与随机是裸数组。
- 图片：`fileServer` 若不含 `/static` 要补上，再拼 `/` + `path`；缺 `/static` 会被 CDN 拒绝。
- 封面 `thumb` 有两种形态：`/comics` 与漫画详情返回 `{fileServer, path}` 对象，榜单/随机/收藏返回字符串 URL；只按字符串解析会让首页封面全是空白。
- 分类过滤传**中文标题**（`c=全彩`），传 `_id` 会返回空。

## 数据存放

登录态、设置、阅读进度是 JSON 文件，按顺序尝试第一个可写目录：

1. `%APPDATA%\local.pica\pica_reader`
2. `%LOCALAPPDATA%\local.pica\pica_reader`
3. `~\Documents\local.pica\pica_reader`
4. 当前工作目录 / 系统临时目录下的 `local.pica\pica_reader`

全部不可写时应用仍能启动，只是设置与进度不落盘（启动后会有提示页）。

因为是纯 Dart 依赖，没有 `flutter_secure_storage`：**token 以明文 JSON 存在上述目录**的 `session.json` 里。共用电脑请退出登录，或直接删掉该文件。

## 已知限制

- 未实现：点赞、收藏、评论、下载离线、多账号、代理设置。
- 不做时钟自动校正，只把服务端 `1023` 错误提示出来。
- `flutter_secure_storage`、`shared_preferences`、`cached_network_image` 都因需要插件而被排除，缓存只有 Flutter 自带的内存图片缓存。
- 阅读器一次加载一话的图片地址，翻页时预取后 2 张；没有磁盘缓存，重进章节会重新请求。
