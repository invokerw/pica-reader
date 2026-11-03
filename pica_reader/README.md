# pica_reader

基于本目录 APK 静态分析结果（`analysis/登录与协议分析.md`、`analysis/protocol_catalog.md`）实现的第三方哔咔漫画阅读器，Flutter 单代码库，目标平台 **Windows + Android**。

只做浏览、阅读与离线缓存：不登录可以看首页/排行/搜索，登录后才能看需要账号的内容。**没有**点赞、收藏、评论等写操作；下载只是把**你自己能看的章节**存成本地文件（见下文「离线下载」），不绕过鉴权、不绕过付费。

## 已实现

| 页面 | 内容 |
| --- | --- |
| 登录 | 账号密码登录，token 只在内存中持有并在本次会话内复用 |
| 首页 | 分类（按中文标题过滤）、排序 `dd/da/ld/vd`、无限滚动网格 |
| 排行 | 日榜 `H24`、周榜 `D7`、月榜 `D30` |
| 搜索 | 关键词搜索（`POST /comics/advanced-search`）+ 热门关键词 |
| 详情 | 漫画信息、章节网格、章节评论、继续阅读、单话/整部下载 |
| 阅读 | 横向/纵向翻页、点击唤出工具栏、页码跳转、自动记录进度；已下载章节自动离线读 |
| 离线 | 下载队列（暂停/继续/重试/删除）、体积统计、导出到系统「下载」、打开下载文件夹 |
| 我的 | 个人资料、历史记录、离线库入口、阅读设置（方向、画质、并发页数）、设备标识 |

## 离线下载（CBZ）

下载产物是漫画界的通用格式 **CBZ**（zip 容器，MIME `application/vnd.comicbook+zip`），每个文件里除了 `001.jpg`、`002.jpg`… 还写了 `ComicInfo.xml`（ComicInfo 2.0）和一份 `来源说明.txt`。因此：

- 直接丢给 **Mihon/Tachiyomi 本地源、Komga、Kavita、YACReader、Perfect Viewer、CDisplay 系**都能认，能按系列/话号分好，不用重命名；
- 图片以 store 模式（不压缩）入包，打包不解码重编码，画质与原图一致，也不会二次膨胀 CPU；
- 打包先写 `.cbz.tmp` 再改名，中断不会留下半个「看起来正常」的包。

落盘布局：

```
<下载根>\<漫画标题>\<漫画标题> 第003话 <章节标题>.cbz
<下载根>\index.json                     下载清单（重启后恢复队列状态）
<下载根>\.part\<comicId>\<话号>\001.jpg   下载中的临时页，打包完成即删除
```

默认下载根：

- Windows：`~\Documents\local.pica\pica_reader\downloads`（不放进 `%APPDATA%`：那是漫游目录，几 GB 漫画会被同步到域服务器）
- Android：应用私有目录 `files/downloads`，无需任何存储权限；「导出到系统下载」走 MediaStore（Android 10+）或应用外部目录（Android 7–9），同样不申请运行时权限

行为细节：

- 一话内并发抓图（默认 4，设置里可改 1/2/4/6/8），页间有轻微随机间隔，避免把 CDN 打爆；
- 超时/5xx/429 重试 3 次（400ms→1.2s→3s），已下好的页记录在 `.part` 里，暂停或重启后继续时跳过；
- 抓到的字节要过魔数校验（JPEG/PNG/GIF/WebP），被墙拦截返回的 HTML 会判定失败而不是打进包里；
- 下载固定拿**原图**（请求章节页时单独带 `image-quality: original`），不受阅读画质设置影响——画质设置只管屏幕上流式加载的那份；
- 抓图用的是**独立的裸 HTTP 客户端**，只带 `User-Agent`，不会把 token/signature 发到图片 CDN；
- 体积参考（实测 2026-11-03：一话 456 页的 AI 图集，原图共 456 个 JPEG → 113.6 MB，平均每页约 260 KB，4 并发约 2 分钟）：常见 20–40 页的连载一话约 5–10 MB，百话长篇按 10 MB/话 估算就是 1 GB 量级，下载前先看设置页的「保存位置」。

合规：只下载当前账号本来就能阅读的章节，导出的文件里保留了来源与版权说明，仅供个人离线阅读，不要再分发。

## 构建

工具链全部装在本目录，不写全局环境变量。所有命令都通过 `.tools\flutter.cmd`（它把 `APPDATA`/`TEMP`/`PUB_CACHE` 重定向到本目录，并注入 JDK、Android SDK、Gradle 缓存路径）：

```powershell
cmd /c '.tools\flutter.cmd pub get'
cmd /c '.tools\flutter.cmd analyze'
cmd /c '.tools\flutter.cmd test'                 # 离线：签名向量、URL 拼接、CBZ 打包、下载队列
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

下载的漫画**不在这里**：Windows 默认 `~\Documents\local.pica\pica_reader\downloads`，Android 在应用私有目录，可在「我的 → 保存位置」查看，`index.json` 记录清单。

全部不可写时应用仍能启动，只是设置与进度不落盘（启动后会有提示页），下载功能会直接报「无法创建下载目录」。

因为是纯 Dart 依赖，没有 `flutter_secure_storage`：**token 以明文 JSON 存在上述目录**的 `session.json` 里。共用电脑请退出登录，或直接删掉该文件。

## 已知限制

- 未实现：点赞、收藏、评论、多账号、代理设置、整部导出为单包、下载限速与存储配额。
- 不做时钟自动校正，只把服务端 `1023` 错误提示出来。
- `flutter_secure_storage`、`shared_preferences`、`cached_network_image`、`file_picker`、`path_provider` 都因需要插件而被排除，缓存只有 Flutter 自带的内存图片缓存。
- 没有文件选择器：Windows 的下载根要在设置里**手填**路径（留空用默认），Android 只能存应用私有目录再「导出到系统下载」。
- 未下载的章节仍然没有磁盘缓存，重进会重新请求；已下载的章节完全离线（从 CBZ 里懒加载单页，不整包读进内存）。
- 一部漫画的下载任务是串行的，同时只会跑一话；暂停/继续以「话」为单位。
- 下载不校验剩余磁盘空间，空间不足时会以文件写入错误的形式失败。
- Windows 未启用长路径支持时，超过 260 字符的完整路径会写入失败；标题过长时已截到 48 字符，仍撞上就把下载根放到更浅的目录（如 `D:\comics`）。
