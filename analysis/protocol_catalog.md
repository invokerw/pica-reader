# APK HTTP 协议声明与 REA 模型清单

HTTP method/path/参数来自原 APK DEX 注解；PICA 的 **33/33 方法完整签名** 已与实际 REA 成员清单对照一致。接口为 abstract，REA 方法体为空不抹除原注解。
已穷举此 APK 中 Retrofit parser 识别的 8 类 HTTP 注解：GET 27、POST 13、PUT 2，DELETE/HEAD/PATCH/OPTIONS/HTTP 各 0，共 **42 个接口方法**；不保证覆盖 raw socket/WebView/运行时生成的协议。
Continuation 不上网；Tag 是客户端元数据，不自动变成 query。非 PICA 接口不能默认套用 PICA HMAC。
[机器可读原注解/泛型签名](<remaining_targets.json>) · [62 模型/299 字段](<REA模型清单.md>) · [请求缺省值/省略规则](<REA请求模型复核.md>)。

| 接口方法 | HTTP | 路径 | 网络参数 | 请求 Body | PicaResponse 的 data 类型 |
|---|---|---|---|---|---|
| `jp3.a` | GET | `.` | arg0: Query(ac); arg1: Query(ids) | 无 | 非 PICA（未全面细审返回模型） |
| `jp3.b` | GET | `.` | arg0: Query(ac) | 无 | 非 PICA（未全面细审返回模型） |
| `jp3.c` | GET | `.` | arg0: Query(ac); arg1: Query(t); arg2: Query(pg); arg3: Query(wd); arg4: Query(h); arg5: Query(ids); arg6: Query(level); arg7: Query(area); arg8: Query(year); arg9: Query(lang); arg10: Query(letter); arg11: Query(by); arg12: Query(sort); arg13: Query(random) | 无 | 非 PICA（未全面细审返回模型） |
| `jp3.d` | GET | `.` | arg0: Query(ac); arg1: Query(t); arg2: Query(pg) | 无 | 非 PICA（未全面细审返回模型） |
| `jp3.e` | GET | `.` | arg0: Query(ac); arg1: Query(ids) | 无 | 非 PICA（未全面细审返回模型） |
| `o8.a` | GET | `api/gva/characterExternalMapping/checkMappingMulti` | arg0: Query(externalId) | 无 | 非 PICA（未全面细审返回模型） |
| `x05.a` | POST | `picacomic/rec/track` | arg0: Body | RecTrackRequest | 非 PICA（未全面细审返回模型） |
| `x05.b` | GET | `picacomic/rec/{comicId}` | arg0: Path(comicId); arg1: Query(limit) | 无 | 非 PICA（未全面细审返回模型） |
| [`eg4.A`](<rea/validation/071-api-eg4-A.json>) | GET | `games/{gameId}/comments` | arg0: Path(gameId); arg1: Query(page) | 无 | [GameCommentResponseData](<REA模型清单.md#gamecommentresponsedata>) |
| [`eg4.B`](<rea/validation/072-api-eg4-B.json>) | GET | `comments/{commentId}/childrens` | arg0: Path(commentId); arg1: Query(page) | 无 | [CommentResponseData](<REA模型清单.md#commentresponsedata>) |
| [`eg4.C`](<rea/validation/073-api-eg4-C.json>) | PUT | `users/profile` | arg0: Body | [SloganUpdateRequest](<REA模型清单.md#sloganupdaterequest>) | JsonElement（通用 JSON 树） |
| [`eg4.D`](<rea/validation/074-api-eg4-D.json>) | GET | `users/favourite` | arg0: Query(page); arg1: Query(s) | 无 | [ComicsListResponse](<REA模型清单.md#comicslistresponse>) |
| [`eg4.E`](<rea/validation/075-api-eg4-E.json>) | GET | `users/my-comments` | arg0: Query(page) | 无 | [MyCommentsResponseData](<REA模型清单.md#mycommentsresponsedata>) |
| [`eg4.F`](<rea/validation/076-api-eg4-F.json>) | POST | `comments/{commentId}/report` | arg0: Path(commentId); arg1: Body | Map | JsonElement（通用 JSON 树） |
| [`eg4.G`](<rea/validation/077-api-eg4-G.json>) | PUT | `users/avatar` | arg0: Body | [AvatarUpdateRequest](<REA模型清单.md#avatarupdaterequest>) | JsonElement（通用 JSON 树） |
| [`eg4.a`](<rea/validation/078-api-eg4-a.json>) | GET | `games/{gameId}` | arg0: Path(gameId) | 无 | [GameDetailResponse](<REA模型清单.md#gamedetailresponse>) |
| [`eg4.b`](<rea/validation/079-api-eg4-b.json>) | POST | `comments/{commentId}/like` | arg0: Path(commentId); arg1: Body | Map | [CommentLikeResponse](<REA模型清单.md#commentlikeresponse>) |
| [`eg4.c`](<rea/validation/080-api-eg4-c.json>) | GET | `categories` | 无 | 无 | [CategoriesData](<REA模型清单.md#categoriesdata>) |
| [`eg4.d`](<rea/validation/081-api-eg4-d.json>) | GET | `comics` | arg0: QueryMap | 无 | [ComicsListResponse](<REA模型清单.md#comicslistresponse>) |
| [`eg4.e`](<rea/validation/082-api-eg4-e.json>) | POST | `comics/advanced-search` | arg0: Query(page); arg1: Body | [AdvancedSearchBody](<REA模型清单.md#advancedsearchbody>) | [ComicsListResponse](<REA模型清单.md#comicslistresponse>) |
| [`eg4.f`](<rea/validation/083-api-eg4-f.json>) | GET | `users/profile` | 无 | 无 | [UserProfileData](<REA模型清单.md#userprofiledata>) |
| [`eg4.g`](<rea/validation/084-api-eg4-g.json>) | POST | `games/{gameId}/comments` | arg0: Path(gameId); arg1: Body | [ContentBody](<REA模型清单.md#contentbody>) | JsonElement（通用 JSON 树） |
| [`eg4.h`](<rea/validation/085-api-eg4-h.json>) | POST | `auth/sign-in` | arg0: Body | [SignInRequest](<REA模型清单.md#signinrequest>) | [LoginData](<REA模型清单.md#logindata>) |
| [`eg4.i`](<rea/validation/086-api-eg4-i.json>) | GET | `comics/random` | arg0: Tag | 无 | [RandomComicsResponse](<REA模型清单.md#randomcomicsresponse>) |
| [`eg4.j`](<rea/validation/087-api-eg4-j.json>) | GET | `announcements` | arg0: Query(page); arg1: Query(platform) | 无 | [AnnouncementsResponse](<REA模型清单.md#announcementsresponse>) |
| [`eg4.k`](<rea/validation/088-api-eg4-k.json>) | POST | `comics/{comicId}/favourite` | arg0: Path(comicId); arg1: Body | Map | JsonElement（通用 JSON 树） |
| [`eg4.l`](<rea/validation/089-api-eg4-l.json>) | POST | `comics/{comicId}/like` | arg0: Path(comicId); arg1: Body | Map | JsonElement（通用 JSON 树） |
| [`eg4.m`](<rea/validation/090-api-eg4-m.json>) | GET | `keywords` | 无 | 无 | [KeywordsData](<REA模型清单.md#keywordsdata>) |
| [`eg4.n`](<rea/validation/091-api-eg4-n.json>) | POST | `comics/{comicId}/comments` | arg0: Path(comicId); arg1: Body | [ContentBody](<REA模型清单.md#contentbody>) | JsonElement（通用 JSON 树） |
| [`eg4.o`](<rea/validation/092-api-eg4-o.json>) | GET | `comics/leaderboard` | arg0: Query(tt); arg1: Query(ct) | 无 | [LeaderboardData](<REA模型清单.md#leaderboarddata>) |
| [`eg4.p`](<rea/validation/093-api-eg4-p.json>) | POST | `auth/register` | arg0: Body | [RegisterRequest](<REA模型清单.md#registerrequest>) | JsonElement（通用 JSON 树） |
| [`eg4.q`](<rea/validation/094-api-eg4-q.json>) | POST | `games/{gameId}/like` | arg0: Path(gameId); arg1: Body | Map | [GameLikeResponse](<REA模型清单.md#gamelikeresponse>) |
| [`eg4.r`](<rea/validation/095-api-eg4-r.json>) | POST | `users/punch-in` | arg0: Body | Map | [PunchInResponse](<REA模型清单.md#punchinresponse>) |
| [`eg4.s`](<rea/validation/096-api-eg4-s.json>) | GET | `comics/{comicId}/comments` | arg0: Path(comicId); arg1: Query(page) | 无 | [CommentResponseData](<REA模型清单.md#commentresponsedata>) |
| [`eg4.t`](<rea/validation/097-api-eg4-t.json>) | GET | `comics/{comicId}` | arg0: Path(comicId) | 无 | [ComicDetailData](<REA模型清单.md#comicdetaildata>) |
| [`eg4.u`](<rea/validation/098-api-eg4-u.json>) | GET | `comics/{comicId}/eps` | arg0: Path(comicId); arg1: Query(page) | 无 | [EpisodesData](<REA模型清单.md#episodesdata>) |
| [`eg4.v`](<rea/validation/099-api-eg4-v.json>) | GET | `comics/{comicId}/order/{order}/pages` | arg0: Path(comicId); arg1: Path(order); arg2: Query(page) | 无 | [ChapterPagesData](<REA模型清单.md#chapterpagesdata>) |
| [`eg4.w`](<rea/validation/100-api-eg4-w.json>) | POST | `comments/{commentId}` | arg0: Path(commentId); arg1: Body | [ContentBody](<REA模型清单.md#contentbody>) | JsonElement（通用 JSON 树） |
| [`eg4.x`](<rea/validation/101-api-eg4-x.json>) | GET | `games` | arg0: Query(page) | 无 | [GamesResponse](<REA模型清单.md#gamesresponse>) |
| [`eg4.y`](<rea/validation/102-api-eg4-y.json>) | GET | `collections` | 无 | 无 | [CollectionsResponseData](<REA模型清单.md#collectionsresponsedata>) |
| [`eg4.z`](<rea/validation/103-api-eg4-z.json>) | GET | `banners` | 无 | 无 | [BannersResponse](<REA模型清单.md#bannersresponse>) |
| [`tr5.a`](<rea/validation/065-network-tr5-a.json>) | GET | `app/picacomic/dns/resolve` | arg0: Query(domain) | 无 | 非 PICA（未全面细审返回模型） |

## QueryMap / 搜索分支

`GET comics` 的已知映射：category→`c`、tag→`t`、author→`a`、creatorId→`ca`、chineseTeam→`ct`、sort→`s`。前五项非 null 才加，sort 总添加；随后 `customParams.putAll` 可覆盖这些键，调用方最后设置 `page`，覆盖自定义 page。
排序值：DEFAULT=`dd`，TIME_ASC=`da`，LIKES_DESC=`ld`，VIEWS_DESC=`vd`；名字是客户端枚举，不保证服务端含义。keyword 或 categories 非 null 时进入 `POST comics/advanced-search`，分页仍为 query，keyword/sort/categories 在 Body。
JADX 对 `toQueryMap` 丢失了前五个 put，不能照抄该 Java；[REA 原输出](<rea/validation/007-priority-com.picacg.domain.model.ComicListParams-toQueryMap.java>)应结合[原始字节码修正证据](<rea_original_corrections.json>)。调用分支见[REA kr](<rea/validation/006-priority-kr-invokeSuspend.java#L152-L190>)。

## 已验证的 PICA 请求 wire keys

### SignInRequest

| JSON key | 缺键 | serializer |
|---|---|---|
| [`email`](<rea/validation/138-serializer-to5-_clinit_.smali#L41>) | 不允许 | `(ix5.a)` |
| [`password`](<rea/validation/138-serializer-to5-_clinit_.smali#L50>) | 不允许 | `(ix5.a)` |

### RegisterRequest

| JSON key | 缺键 | serializer |
|---|---|---|
| [`name`](<rea/validation/128-serializer-q35-_clinit_.smali#L42>) | 不允许 | `(ix5.a)` |
| [`email`](<rea/validation/128-serializer-q35-_clinit_.smali#L51>) | 不允许 | `(ix5.a)` |
| [`password`](<rea/validation/128-serializer-q35-_clinit_.smali#L60>) | 不允许 | `(ix5.a)` |
| [`question1`](<rea/validation/128-serializer-q35-_clinit_.smali#L69>) | 不允许 | `(ix5.a)` |
| [`answer1`](<rea/validation/128-serializer-q35-_clinit_.smali#L78>) | 不允许 | `(ix5.a)` |
| [`question2`](<rea/validation/128-serializer-q35-_clinit_.smali#L87>) | 不允许 | `(ix5.a)` |
| [`answer2`](<rea/validation/128-serializer-q35-_clinit_.smali#L96>) | 不允许 | `(ix5.a)` |
| [`question3`](<rea/validation/128-serializer-q35-_clinit_.smali#L105>) | 不允许 | `(ix5.a)` |
| [`answer3`](<rea/validation/128-serializer-q35-_clinit_.smali#L114>) | 不允许 | `(ix5.a)` |
| [`birthday`](<rea/validation/128-serializer-q35-_clinit_.smali#L123>) | 不允许 | `(ix5.a)` |
| [`gender`](<rea/validation/128-serializer-q35-_clinit_.smali#L132>) | 不允许 | `(ix5.a)` |

### AdvancedSearchBody

| JSON key | 缺键 | serializer |
|---|---|---|
| [`keyword`](<rea/validation/108-serializer-j8-_clinit_.smali#L41>) | 不允许 | `(ix5.a)` |
| [`sort`](<rea/validation/108-serializer-j8-_clinit_.smali#L53>) | 允许（具体默认值见请求复核） | `(ix5.a)` |
| [`categories`](<rea/validation/108-serializer-j8-_clinit_.smali#L62>) | 允许（具体默认值见请求复核） | `(uo3.M((ca3) AdvancedSearchBody.$childSerializers[2].getValue()))` |

### ContentBody

| JSON key | 缺键 | serializer |
|---|---|---|
| [`content`](<rea/validation/118-serializer-ac1-_clinit_.smali#L41>) | 不允许 | `ix5.a` |

### AvatarUpdateRequest

| JSON key | 缺键 | serializer |
|---|---|---|
| [`avatar`](<rea/validation/161-serializer-com.picacg.network.pica.model.AvatarUpdateRequest__serializer-_clinit_.smali#L49>) | 不允许 | `ix5.a` |

### SloganUpdateRequest

| JSON key | 缺键 | serializer |
|---|---|---|
| [`slogan`](<rea/validation/437-serializer-com.picacg.network.pica.model.SloganUpdateRequest__serializer-_clinit_.smali#L49>) | 不允许 | `ix5.a` |

## 返回模型边界

PICA 返回外壳是 `PicaResponse<T>`：code/message 必需，error/data 可省略且 nullable；成功包装器另要求 data 非 null。`JsonElement` 是任意 JSON 树，不是 Unit，也不能伪造为固定字段对象。
全部声明的 PICA 具体根模型及发现的嵌套模型在[REA 模型清单](<REA模型清单.md>)（62 个模型，299 个字段注册）。key/optional 已逐个与原 DEX 对照；构造器/defaults、child serializer 原表达式与来源链接保留，未做服务端动态校验。
MacCMS / 推荐 / AIBIKA / DNS 的非 PICA 参数声明保留；其完整返回模型、运行时地址和验签不在本次全面细审范围。
