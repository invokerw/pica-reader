# REA 序列化模型清单

已对照 **62 个模型、299 个字段注册**：REA Java/smali 的 descriptor key/optional 与原 APK DEX 一致。

这是客户端接受/写出的静态结构，不保证服务器实际返回。`必填`仅指缺字段校验；`可省略`不等于可为 null。默认值应以链接的构造器为准。泛型/懒加载子模型保留真实 serializer 表达式，不猜类型。

[机器可读完整清单](rea_model_schema.json)；[接口清单](protocol_catalog.md)。

## AdvancedSearchBody

Serializer：`Lj8;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `keyword` | 必填 | `(ix5.a)` | [descriptor](rea/validation/108-serializer-j8-_clinit_.smali#L41) |
| `sort` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/108-serializer-j8-_clinit_.smali#L53) |
| `categories` | 可省略 | `(uo3.M((ca3) AdvancedSearchBody.$childSerializers[2].getValue()))` | [descriptor](rea/validation/108-serializer-j8-_clinit_.smali#L62) |

[childSerializers](rea/validation/109-serializer-j8-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/105-dto-com.picacg.network.pica.api.AdvancedSearchBody-_init_.java)、[证据 2](rea/validation/106-dto-com.picacg.network.pica.api.AdvancedSearchBody-_init_.java)。

## ContentBody

Serializer：`Lac1;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `content` | 必填 | `ix5.a` | [descriptor](rea/validation/118-serializer-ac1-_clinit_.smali#L41) |

[childSerializers](rea/validation/119-serializer-ac1-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/115-dto-com.picacg.network.pica.api.ContentBody-_init_.java)、[证据 2](rea/validation/116-dto-com.picacg.network.pica.api.ContentBody-_init_.java)。

## RegisterRequest

Serializer：`Lq35;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `name` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L42) |
| `email` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L51) |
| `password` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L60) |
| `question1` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L69) |
| `answer1` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L78) |
| `question2` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L87) |
| `answer2` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L96) |
| `question3` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L105) |
| `answer3` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L114) |
| `birthday` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L123) |
| `gender` | 必填 | `(ix5.a)` | [descriptor](rea/validation/128-serializer-q35-_clinit_.smali#L132) |

[childSerializers](rea/validation/129-serializer-q35-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/125-dto-com.picacg.network.pica.api.RegisterRequest-_init_.java)、[证据 2](rea/validation/126-dto-com.picacg.network.pica.api.RegisterRequest-_init_.java)。

## SignInRequest

Serializer：`Lto5;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `email` | 必填 | `(ix5.a)` | [descriptor](rea/validation/138-serializer-to5-_clinit_.smali#L41) |
| `password` | 必填 | `(ix5.a)` | [descriptor](rea/validation/138-serializer-to5-_clinit_.smali#L50) |

[childSerializers](rea/validation/139-serializer-to5-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/135-dto-com.picacg.network.pica.api.SignInRequest-_init_.java)、[证据 2](rea/validation/136-dto-com.picacg.network.pica.api.SignInRequest-_init_.java)。

## Announcement

Serializer：`Lcom/picacg/network/pica/model/Announcement$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/465-nested-com.picacg.network.pica.model.Announcement__serializer-_clinit_.smali#L49) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/465-nested-com.picacg.network.pica.model.Announcement__serializer-_clinit_.smali#L58) |
| `content` | 必填 | `(ix5.a)` | [descriptor](rea/validation/465-nested-com.picacg.network.pica.model.Announcement__serializer-_clinit_.smali#L67) |
| `thumb` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/465-nested-com.picacg.network.pica.model.Announcement__serializer-_clinit_.smali#L76) |

[childSerializers](rea/validation/466-nested-com.picacg.network.pica.model.Announcement__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/114-supp-com.picacg.network.pica.model.Announcement-_init_.java)、[证据 2](rea/supplement/115-supp-com.picacg.network.pica.model.Announcement-_init_.java)。

## AnnouncementsData

Serializer：`Lcom/picacg/network/pica/model/AnnouncementsData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `docs` | 必填 | `AnnouncementsData.$childSerializers[0].getValue()` | [descriptor](rea/validation/467-nested-com.picacg.network.pica.model.AnnouncementsData__serializer-_clinit_.smali#L49) |
| `total` | 必填 | `(e53.a)` | [descriptor](rea/validation/467-nested-com.picacg.network.pica.model.AnnouncementsData__serializer-_clinit_.smali#L58) |
| `limit` | 必填 | `(e53.a)` | [descriptor](rea/validation/467-nested-com.picacg.network.pica.model.AnnouncementsData__serializer-_clinit_.smali#L67) |
| `page` | 必填 | `ix5.a` | [descriptor](rea/validation/467-nested-com.picacg.network.pica.model.AnnouncementsData__serializer-_clinit_.smali#L76) |
| `pages` | 必填 | `(e53.a)` | [descriptor](rea/validation/467-nested-com.picacg.network.pica.model.AnnouncementsData__serializer-_clinit_.smali#L85) |

[childSerializers](rea/validation/468-nested-com.picacg.network.pica.model.AnnouncementsData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/116-supp-com.picacg.network.pica.model.AnnouncementsData-_init_.java)、[证据 2](rea/supplement/117-supp-com.picacg.network.pica.model.AnnouncementsData-_init_.java)。

## AnnouncementsResponse

Serializer：`Lcom/picacg/network/pica/model/AnnouncementsResponse$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `announcements` | 必填 | `AnnouncementsData$$serializer.INSTANCE` | [descriptor](rea/validation/148-serializer-com.picacg.network.pica.model.AnnouncementsResponse__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/150-serializer-com.picacg.network.pica.model.AnnouncementsResponse__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/145-dto-com.picacg.network.pica.model.AnnouncementsResponse-_init_.java)、[证据 2](rea/validation/146-dto-com.picacg.network.pica.model.AnnouncementsResponse-_init_.java)。

## AvatarUpdateData

Serializer：`Lcom/picacg/network/pica/model/AvatarUpdateData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `avatar` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/469-nested-com.picacg.network.pica.model.AvatarUpdateData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/470-nested-com.picacg.network.pica.model.AvatarUpdateData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/118-supp-com.picacg.network.pica.model.AvatarUpdateData-_init_.java)、[证据 2](rea/supplement/119-supp-com.picacg.network.pica.model.AvatarUpdateData-_init_.java)。

## AvatarUpdateRequest

Serializer：`Lcom/picacg/network/pica/model/AvatarUpdateRequest$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `avatar` | 必填 | `ix5.a` | [descriptor](rea/validation/161-serializer-com.picacg.network.pica.model.AvatarUpdateRequest__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/163-serializer-com.picacg.network.pica.model.AvatarUpdateRequest__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/158-dto-com.picacg.network.pica.model.AvatarUpdateRequest-_init_.java)、[证据 2](rea/validation/159-dto-com.picacg.network.pica.model.AvatarUpdateRequest-_init_.java)。

## BannerData

Serializer：`Lcom/picacg/network/pica/model/BannerData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/471-nested-com.picacg.network.pica.model.BannerData__serializer-_clinit_.smali#L49) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/471-nested-com.picacg.network.pica.model.BannerData__serializer-_clinit_.smali#L58) |
| `shortDescription` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/471-nested-com.picacg.network.pica.model.BannerData__serializer-_clinit_.smali#L70) |
| `link` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/471-nested-com.picacg.network.pica.model.BannerData__serializer-_clinit_.smali#L79) |
| `type` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/471-nested-com.picacg.network.pica.model.BannerData__serializer-_clinit_.smali#L88) |
| `thumb` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/471-nested-com.picacg.network.pica.model.BannerData__serializer-_clinit_.smali#L97) |

[childSerializers](rea/validation/472-nested-com.picacg.network.pica.model.BannerData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/120-supp-com.picacg.network.pica.model.BannerData-_init_.java)、[证据 2](rea/supplement/121-supp-com.picacg.network.pica.model.BannerData-_init_.java)、[证据 3](rea/supplement/122-supp-com.picacg.network.pica.model.BannerData-_init_.java)。

## BannersResponse

Serializer：`Lcom/picacg/network/pica/model/BannersResponse$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `banners` | 必填 | `BannersResponse.$childSerializers[0].getValue()` | [descriptor](rea/validation/174-serializer-com.picacg.network.pica.model.BannersResponse__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/176-serializer-com.picacg.network.pica.model.BannersResponse__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/171-dto-com.picacg.network.pica.model.BannersResponse-_init_.java)、[证据 2](rea/validation/172-dto-com.picacg.network.pica.model.BannersResponse-_init_.java)。

## CategoriesData

Serializer：`Lcom/picacg/network/pica/model/CategoriesData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `categories` | 必填 | `CategoriesData.$childSerializers[0].getValue()` | [descriptor](rea/validation/187-serializer-com.picacg.network.pica.model.CategoriesData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/189-serializer-com.picacg.network.pica.model.CategoriesData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/184-dto-com.picacg.network.pica.model.CategoriesData-_init_.java)、[证据 2](rea/validation/185-dto-com.picacg.network.pica.model.CategoriesData-_init_.java)。

## CategoryItem

Serializer：`Lcom/picacg/network/pica/model/CategoryItem$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 可省略 | `(uo3.M((ix5.a)))` | [descriptor](rea/validation/473-nested-com.picacg.network.pica.model.CategoryItem__serializer-_clinit_.smali#L49) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/473-nested-com.picacg.network.pica.model.CategoryItem__serializer-_clinit_.smali#L61) |
| `description` | 可省略 | `(uo3.M((ix5.a)))` | [descriptor](rea/validation/473-nested-com.picacg.network.pica.model.CategoryItem__serializer-_clinit_.smali#L70) |
| `thumb` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/473-nested-com.picacg.network.pica.model.CategoryItem__serializer-_clinit_.smali#L79) |
| `isWeb` | 可省略 | `(od0.a)` | [descriptor](rea/validation/473-nested-com.picacg.network.pica.model.CategoryItem__serializer-_clinit_.smali#L88) |
| `active` | 可省略 | `(od0.a)` | [descriptor](rea/validation/473-nested-com.picacg.network.pica.model.CategoryItem__serializer-_clinit_.smali#L97) |
| `link` | 可省略 | `(uo3.M((ix5.a)))` | [descriptor](rea/validation/473-nested-com.picacg.network.pica.model.CategoryItem__serializer-_clinit_.smali#L106) |

[childSerializers](rea/validation/474-nested-com.picacg.network.pica.model.CategoryItem__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/123-supp-com.picacg.network.pica.model.CategoryItem-_init_.java)、[证据 2](rea/supplement/124-supp-com.picacg.network.pica.model.CategoryItem-_init_.java)、[证据 3](rea/supplement/125-supp-com.picacg.network.pica.model.CategoryItem-_init_.java)。

## ChapterPagesData

Serializer：`Lcom/picacg/network/pica/model/ChapterPagesData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `pages` | 必填 | `PagesInfo$$serializer.INSTANCE` | [descriptor](rea/validation/200-serializer-com.picacg.network.pica.model.ChapterPagesData__serializer-_clinit_.smali#L49) |
| `ep` | 必填 | `EpisodeInfo$$serializer.INSTANCE` | [descriptor](rea/validation/200-serializer-com.picacg.network.pica.model.ChapterPagesData__serializer-_clinit_.smali#L58) |

[childSerializers](rea/validation/202-serializer-com.picacg.network.pica.model.ChapterPagesData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/197-dto-com.picacg.network.pica.model.ChapterPagesData-_init_.java)、[证据 2](rea/validation/198-dto-com.picacg.network.pica.model.ChapterPagesData-_init_.java)。

## CollectionComicItem

Serializer：`Lcom/picacg/network/pica/model/CollectionComicItem$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L50) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L59) |
| `author` | 必填 | `(ix5.a)` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L68) |
| `thumb` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L77) |
| `categories` | 可省略 | `kd3VarArr[4].getValue()` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L89) |
| `tags` | 可省略 | `kd3VarArr[5].getValue()` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L98) |
| `finished` | 可省略 | `od0.a` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L107) |
| `epsCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L116) |
| `pagesCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L125) |
| `totalViews` | 可省略 | `(e53.a)` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L134) |
| `totalLikes` | 可省略 | `(e53.a)` | [descriptor](rea/validation/475-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-_clinit_.smali#L143) |

[childSerializers](rea/validation/476-nested-com.picacg.network.pica.model.CollectionComicItem__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/126-supp-com.picacg.network.pica.model.CollectionComicItem-_init_.java)、[证据 2](rea/supplement/127-supp-com.picacg.network.pica.model.CollectionComicItem-_init_.java)、[证据 3](rea/supplement/128-supp-com.picacg.network.pica.model.CollectionComicItem-_init_.java)。

## CollectionGroup

Serializer：`Lcom/picacg/network/pica/model/CollectionGroup$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `title` | 必填 | `ix5.a` | [descriptor](rea/validation/477-nested-com.picacg.network.pica.model.CollectionGroup__serializer-_clinit_.smali#L49) |
| `comics` | 必填 | `CollectionGroup.$childSerializers[1].getValue()` | [descriptor](rea/validation/477-nested-com.picacg.network.pica.model.CollectionGroup__serializer-_clinit_.smali#L58) |

[childSerializers](rea/validation/478-nested-com.picacg.network.pica.model.CollectionGroup__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/129-supp-com.picacg.network.pica.model.CollectionGroup-_init_.java)、[证据 2](rea/supplement/130-supp-com.picacg.network.pica.model.CollectionGroup-_init_.java)。

## CollectionsResponseData

Serializer：`Lcom/picacg/network/pica/model/CollectionsResponseData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `collections` | 必填 | `CollectionsResponseData.$childSerializers[0].getValue()` | [descriptor](rea/validation/213-serializer-com.picacg.network.pica.model.CollectionsResponseData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/215-serializer-com.picacg.network.pica.model.CollectionsResponseData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/210-dto-com.picacg.network.pica.model.CollectionsResponseData-_init_.java)、[证据 2](rea/validation/211-dto-com.picacg.network.pica.model.CollectionsResponseData-_init_.java)。

## ComicDetail

Serializer：`Lcom/picacg/network/pica/model/ComicDetail$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L50) |
| `_creator` | 必填 | `Creator$$serializer.INSTANCE` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L59) |
| `title` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L71) |
| `description` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L80) |
| `thumb` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L89) |
| `author` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L98) |
| `chineseTeam` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L107) |
| `categories` | 可省略 | `kd3VarArr[7].getValue()` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L116) |
| `tags` | 可省略 | `kd3VarArr[8].getValue()` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L125) |
| `pagesCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L134) |
| `epsCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L143) |
| `finished` | 可省略 | `(od0.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L152) |
| `updated_at` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L161) |
| `created_at` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L170) |
| `allowDownload` | 可省略 | `(od0.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L179) |
| `allowComment` | 可省略 | `(od0.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L188) |
| `totalLikes` | 可省略 | `uo3.M((e53.a))` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L197) |
| `totalViews` | 可省略 | `uo3.M((e53.a))` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L206) |
| `totalComments` | 可省略 | `uo3.M((e53.a))` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L215) |
| `viewsCount` | 可省略 | `uo3.M((e53.a))` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L224) |
| `likesCount` | 可省略 | `uo3.M((e53.a))` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L233) |
| `commentsCount` | 可省略 | `uo3.M((e53.a))` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L242) |
| `isFavourite` | 可省略 | `(od0.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L251) |
| `isLiked` | 可省略 | `(od0.a)` | [descriptor](rea/validation/479-nested-com.picacg.network.pica.model.ComicDetail__serializer-_clinit_.smali#L260) |

[childSerializers](rea/validation/480-nested-com.picacg.network.pica.model.ComicDetail__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/131-supp-com.picacg.network.pica.model.ComicDetail-_init_.java)、[证据 2](rea/supplement/132-supp-com.picacg.network.pica.model.ComicDetail-_init_.java)、[证据 3](rea/supplement/133-supp-com.picacg.network.pica.model.ComicDetail-_init_.java)。

## ComicDetailData

Serializer：`Lcom/picacg/network/pica/model/ComicDetailData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `comic` | 必填 | `ComicDetail$$serializer.INSTANCE` | [descriptor](rea/validation/226-serializer-com.picacg.network.pica.model.ComicDetailData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/228-serializer-com.picacg.network.pica.model.ComicDetailData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/223-dto-com.picacg.network.pica.model.ComicDetailData-_init_.java)、[证据 2](rea/validation/224-dto-com.picacg.network.pica.model.ComicDetailData-_init_.java)。

## ComicItem

Serializer：`Lcom/picacg/network/pica/model/ComicItem$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/481-nested-com.picacg.network.pica.model.ComicItem__serializer-_clinit_.smali#L49) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/481-nested-com.picacg.network.pica.model.ComicItem__serializer-_clinit_.smali#L58) |
| `author` | 必填 | `(ix5.a)` | [descriptor](rea/validation/481-nested-com.picacg.network.pica.model.ComicItem__serializer-_clinit_.smali#L67) |
| `totalViews` | 可省略 | `uo3.M((e53.a))` | [descriptor](rea/validation/481-nested-com.picacg.network.pica.model.ComicItem__serializer-_clinit_.smali#L79) |
| `totalLikes` | 可省略 | `uo3.M((e53.a))` | [descriptor](rea/validation/481-nested-com.picacg.network.pica.model.ComicItem__serializer-_clinit_.smali#L88) |
| `thumb` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/481-nested-com.picacg.network.pica.model.ComicItem__serializer-_clinit_.smali#L97) |
| `categories` | 必填 | `kd3VarArr[6].getValue()` | [descriptor](rea/validation/481-nested-com.picacg.network.pica.model.ComicItem__serializer-_clinit_.smali#L106) |

[childSerializers](rea/validation/482-nested-com.picacg.network.pica.model.ComicItem__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/134-supp-com.picacg.network.pica.model.ComicItem-_init_.java)、[证据 2](rea/supplement/135-supp-com.picacg.network.pica.model.ComicItem-_init_.java)、[证据 3](rea/supplement/136-supp-com.picacg.network.pica.model.ComicItem-_init_.java)。

## ComicItemData

Serializer：`Lcom/picacg/network/pica/model/ComicItemData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L50) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L59) |
| `author` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L71) |
| `totalViews` | 可省略 | `(e53.a)` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L80) |
| `totalLikes` | 可省略 | `(e53.a)` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L89) |
| `pagesCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L98) |
| `epsCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L107) |
| `finished` | 可省略 | `od0.a` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L116) |
| `categories` | 可省略 | `kd3VarArr[8].getValue()` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L125) |
| `tags` | 可省略 | `kd3VarArr[9].getValue()` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L134) |
| `thumb` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L143) |
| `likesCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/483-nested-com.picacg.network.pica.model.ComicItemData__serializer-_clinit_.smali#L152) |

[childSerializers](rea/validation/484-nested-com.picacg.network.pica.model.ComicItemData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/137-supp-com.picacg.network.pica.model.ComicItemData-_init_.java)、[证据 2](rea/supplement/138-supp-com.picacg.network.pica.model.ComicItemData-_init_.java)、[证据 3](rea/supplement/139-supp-com.picacg.network.pica.model.ComicItemData-_init_.java)。

## ComicListData

Serializer：`Lcom/picacg/network/pica/model/ComicListData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `comics` | 必填 | `ComicsData$$serializer.INSTANCE` | [descriptor](rea/validation/485-nested-com.picacg.network.pica.model.ComicListData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/486-nested-com.picacg.network.pica.model.ComicListData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/140-supp-com.picacg.network.pica.model.ComicListData-_init_.java)、[证据 2](rea/supplement/141-supp-com.picacg.network.pica.model.ComicListData-_init_.java)。

## ComicsData

Serializer：`Lcom/picacg/network/pica/model/ComicsData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `docs` | 必填 | `ComicsData.$childSerializers[0].getValue()` | [descriptor](rea/validation/487-nested-com.picacg.network.pica.model.ComicsData__serializer-_clinit_.smali#L49) |
| `total` | 必填 | `(e53.a)` | [descriptor](rea/validation/487-nested-com.picacg.network.pica.model.ComicsData__serializer-_clinit_.smali#L58) |
| `page` | 必填 | `(e53.a)` | [descriptor](rea/validation/487-nested-com.picacg.network.pica.model.ComicsData__serializer-_clinit_.smali#L67) |
| `pages` | 必填 | `(e53.a)` | [descriptor](rea/validation/487-nested-com.picacg.network.pica.model.ComicsData__serializer-_clinit_.smali#L76) |

[childSerializers](rea/validation/488-nested-com.picacg.network.pica.model.ComicsData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/142-supp-com.picacg.network.pica.model.ComicsData-_init_.java)、[证据 2](rea/supplement/143-supp-com.picacg.network.pica.model.ComicsData-_init_.java)。

## ComicsListResponse

Serializer：`Lcom/picacg/network/pica/model/ComicsListResponse$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `comics` | 必填 | `ComicsPageData$$serializer.INSTANCE` | [descriptor](rea/validation/239-serializer-com.picacg.network.pica.model.ComicsListResponse__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/241-serializer-com.picacg.network.pica.model.ComicsListResponse__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/236-dto-com.picacg.network.pica.model.ComicsListResponse-_init_.java)、[证据 2](rea/validation/237-dto-com.picacg.network.pica.model.ComicsListResponse-_init_.java)。

## ComicsPageData

Serializer：`Lcom/picacg/network/pica/model/ComicsPageData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `docs` | 必填 | `ComicsPageData.$childSerializers[0].getValue()` | [descriptor](rea/validation/489-nested-com.picacg.network.pica.model.ComicsPageData__serializer-_clinit_.smali#L49) |
| `total` | 必填 | `(e53.a)` | [descriptor](rea/validation/489-nested-com.picacg.network.pica.model.ComicsPageData__serializer-_clinit_.smali#L58) |
| `page` | 必填 | `(e53.a)` | [descriptor](rea/validation/489-nested-com.picacg.network.pica.model.ComicsPageData__serializer-_clinit_.smali#L67) |
| `pages` | 必填 | `(e53.a)` | [descriptor](rea/validation/489-nested-com.picacg.network.pica.model.ComicsPageData__serializer-_clinit_.smali#L76) |
| `limit` | 可省略 | `(e53.a)` | [descriptor](rea/validation/489-nested-com.picacg.network.pica.model.ComicsPageData__serializer-_clinit_.smali#L88) |

[childSerializers](rea/validation/490-nested-com.picacg.network.pica.model.ComicsPageData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/144-supp-com.picacg.network.pica.model.ComicsPageData-_init_.java)、[证据 2](rea/supplement/145-supp-com.picacg.network.pica.model.ComicsPageData-_init_.java)、[证据 3](rea/supplement/146-supp-com.picacg.network.pica.model.ComicsPageData-_init_.java)。

## Comment

Serializer：`Lcom/picacg/network/pica/model/Comment$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L50) |
| `content` | 必填 | `(ix5.a)` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L59) |
| `_user` | 可省略 | `(uo3.M(CommentUser$$serializer.INSTANCE))` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L71) |
| `_comic` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L80) |
| `totalComments` | 可省略 | `(e53.a)` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L89) |
| `isTop` | 可省略 | `(od0.a)` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L98) |
| `hide` | 可省略 | `(od0.a)` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L107) |
| `created_at` | 必填 | `(ix5.a)` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L116) |
| `likesCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L125) |
| `commentsCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L134) |
| `isLiked` | 可省略 | `(od0.a)` | [descriptor](rea/validation/491-nested-com.picacg.network.pica.model.Comment__serializer-_clinit_.smali#L143) |

[childSerializers](rea/validation/492-nested-com.picacg.network.pica.model.Comment__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/147-supp-com.picacg.network.pica.model.Comment-_init_.java)、[证据 2](rea/supplement/148-supp-com.picacg.network.pica.model.Comment-_init_.java)、[证据 3](rea/supplement/149-supp-com.picacg.network.pica.model.Comment-_init_.java)。

## CommentLikeResponse

Serializer：`Lcom/picacg/network/pica/model/CommentLikeResponse$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `action` | 必填 | `ix5.a` | [descriptor](rea/validation/252-serializer-com.picacg.network.pica.model.CommentLikeResponse__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/254-serializer-com.picacg.network.pica.model.CommentLikeResponse__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/249-dto-com.picacg.network.pica.model.CommentLikeResponse-_init_.java)、[证据 2](rea/validation/250-dto-com.picacg.network.pica.model.CommentLikeResponse-_init_.java)。

## CommentResponseData

Serializer：`Lcom/picacg/network/pica/model/CommentResponseData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `comments` | 必填 | `CommentsPageData$$serializer.INSTANCE` | [descriptor](rea/validation/266-serializer-com.picacg.network.pica.model.CommentResponseData__serializer-_clinit_.smali#L49) |
| `topComments` | 可省略 | `CommentResponseData.$childSerializers[1].getValue()` | [descriptor](rea/validation/266-serializer-com.picacg.network.pica.model.CommentResponseData__serializer-_clinit_.smali#L61) |

[childSerializers](rea/validation/268-serializer-com.picacg.network.pica.model.CommentResponseData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/262-dto-com.picacg.network.pica.model.CommentResponseData-_init_.java)、[证据 2](rea/validation/263-dto-com.picacg.network.pica.model.CommentResponseData-_init_.java)、[证据 3](rea/validation/264-dto-com.picacg.network.pica.model.CommentResponseData-_init_.java)。

## CommentUser

Serializer：`Lcom/picacg/network/pica/model/CommentUser$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L50) |
| `gender` | 必填 | `(ix5.a)` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L59) |
| `name` | 必填 | `(ix5.a)` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L68) |
| `title` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L80) |
| `verified` | 可省略 | `od0.a` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L89) |
| `exp` | 可省略 | `(e53.a)` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L98) |
| `level` | 可省略 | `(e53.a)` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L107) |
| `characters` | 可省略 | `kd3VarArr[7].getValue()` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L116) |
| `role` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L125) |
| `avatar` | 可省略 | `uo3.M(ImageInfo$$serializer.INSTANCE)` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L134) |
| `slogan` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L143) |
| `character` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/493-nested-com.picacg.network.pica.model.CommentUser__serializer-_clinit_.smali#L152) |

[childSerializers](rea/validation/494-nested-com.picacg.network.pica.model.CommentUser__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/150-supp-com.picacg.network.pica.model.CommentUser-_init_.java)、[证据 2](rea/supplement/151-supp-com.picacg.network.pica.model.CommentUser-_init_.java)、[证据 3](rea/supplement/152-supp-com.picacg.network.pica.model.CommentUser-_init_.java)。

## CommentsPageData

Serializer：`Lcom/picacg/network/pica/model/CommentsPageData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `docs` | 必填 | `CommentsPageData.$childSerializers[0].getValue()` | [descriptor](rea/validation/495-nested-com.picacg.network.pica.model.CommentsPageData__serializer-_clinit_.smali#L49) |
| `total` | 必填 | `(e53.a)` | [descriptor](rea/validation/495-nested-com.picacg.network.pica.model.CommentsPageData__serializer-_clinit_.smali#L58) |
| `limit` | 必填 | `(e53.a)` | [descriptor](rea/validation/495-nested-com.picacg.network.pica.model.CommentsPageData__serializer-_clinit_.smali#L67) |
| `page` | 必填 | `(e53.a)` | [descriptor](rea/validation/495-nested-com.picacg.network.pica.model.CommentsPageData__serializer-_clinit_.smali#L76) |
| `pages` | 必填 | `(e53.a)` | [descriptor](rea/validation/495-nested-com.picacg.network.pica.model.CommentsPageData__serializer-_clinit_.smali#L85) |

[childSerializers](rea/validation/496-nested-com.picacg.network.pica.model.CommentsPageData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/153-supp-com.picacg.network.pica.model.CommentsPageData-_init_.java)、[证据 2](rea/supplement/154-supp-com.picacg.network.pica.model.CommentsPageData-_init_.java)。

## Creator

Serializer：`Lcom/picacg/network/pica/model/Creator$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L50) |
| `gender` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L62) |
| `name` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L71) |
| `title` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L80) |
| `verified` | 可省略 | `od0.a` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L89) |
| `exp` | 必填 | `(e53.a)` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L98) |
| `level` | 必填 | `(e53.a)` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L107) |
| `characters` | 可省略 | `kd3VarArr[7].getValue()` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L116) |
| `role` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L125) |
| `slogan` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L134) |
| `avatar` | 可省略 | `uo3.M(ImageInfo$$serializer.INSTANCE)` | [descriptor](rea/validation/497-nested-com.picacg.network.pica.model.Creator__serializer-_clinit_.smali#L143) |

[childSerializers](rea/validation/498-nested-com.picacg.network.pica.model.Creator__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/155-supp-com.picacg.network.pica.model.Creator-_init_.java)、[证据 2](rea/supplement/156-supp-com.picacg.network.pica.model.Creator-_init_.java)、[证据 3](rea/supplement/157-supp-com.picacg.network.pica.model.Creator-_init_.java)。

## Episode

Serializer：`Lcom/picacg/network/pica/model/Episode$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/499-nested-com.picacg.network.pica.model.Episode__serializer-_clinit_.smali#L49) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/499-nested-com.picacg.network.pica.model.Episode__serializer-_clinit_.smali#L58) |
| `order` | 必填 | `e53.a` | [descriptor](rea/validation/499-nested-com.picacg.network.pica.model.Episode__serializer-_clinit_.smali#L67) |
| `updated_at` | 必填 | `(ix5.a)` | [descriptor](rea/validation/499-nested-com.picacg.network.pica.model.Episode__serializer-_clinit_.smali#L76) |

[childSerializers](rea/validation/500-nested-com.picacg.network.pica.model.Episode__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/158-supp-com.picacg.network.pica.model.Episode-_init_.java)、[证据 2](rea/supplement/159-supp-com.picacg.network.pica.model.Episode-_init_.java)。

## EpisodeInfo

Serializer：`Lcom/picacg/network/pica/model/EpisodeInfo$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/501-nested-com.picacg.network.pica.model.EpisodeInfo__serializer-_clinit_.smali#L49) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/501-nested-com.picacg.network.pica.model.EpisodeInfo__serializer-_clinit_.smali#L58) |
| `order` | 可省略 | `uo3.M(e53.a)` | [descriptor](rea/validation/501-nested-com.picacg.network.pica.model.EpisodeInfo__serializer-_clinit_.smali#L70) |
| `updated_at` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/501-nested-com.picacg.network.pica.model.EpisodeInfo__serializer-_clinit_.smali#L79) |

[childSerializers](rea/validation/502-nested-com.picacg.network.pica.model.EpisodeInfo__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/160-supp-com.picacg.network.pica.model.EpisodeInfo-_init_.java)、[证据 2](rea/supplement/161-supp-com.picacg.network.pica.model.EpisodeInfo-_init_.java)、[证据 3](rea/supplement/162-supp-com.picacg.network.pica.model.EpisodeInfo-_init_.java)。

## EpisodesData

Serializer：`Lcom/picacg/network/pica/model/EpisodesData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `eps` | 必填 | `EpisodesInfo$$serializer.INSTANCE` | [descriptor](rea/validation/279-serializer-com.picacg.network.pica.model.EpisodesData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/281-serializer-com.picacg.network.pica.model.EpisodesData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/276-dto-com.picacg.network.pica.model.EpisodesData-_init_.java)、[证据 2](rea/validation/277-dto-com.picacg.network.pica.model.EpisodesData-_init_.java)。

## EpisodesInfo

Serializer：`Lcom/picacg/network/pica/model/EpisodesInfo$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `docs` | 必填 | `EpisodesInfo.$childSerializers[0].getValue()` | [descriptor](rea/validation/503-nested-com.picacg.network.pica.model.EpisodesInfo__serializer-_clinit_.smali#L49) |
| `total` | 必填 | `(e53.a)` | [descriptor](rea/validation/503-nested-com.picacg.network.pica.model.EpisodesInfo__serializer-_clinit_.smali#L58) |
| `limit` | 必填 | `(e53.a)` | [descriptor](rea/validation/503-nested-com.picacg.network.pica.model.EpisodesInfo__serializer-_clinit_.smali#L67) |
| `page` | 必填 | `(e53.a)` | [descriptor](rea/validation/503-nested-com.picacg.network.pica.model.EpisodesInfo__serializer-_clinit_.smali#L76) |
| `pages` | 必填 | `(e53.a)` | [descriptor](rea/validation/503-nested-com.picacg.network.pica.model.EpisodesInfo__serializer-_clinit_.smali#L85) |

[childSerializers](rea/validation/504-nested-com.picacg.network.pica.model.EpisodesInfo__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/163-supp-com.picacg.network.pica.model.EpisodesInfo-_init_.java)、[证据 2](rea/supplement/164-supp-com.picacg.network.pica.model.EpisodesInfo-_init_.java)。

## GameComment

Serializer：`Lcom/picacg/network/pica/model/GameComment$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L50) |
| `content` | 必填 | `(ix5.a)` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L59) |
| `_user` | 可省略 | `(uo3.M(CommentUser$$serializer.INSTANCE))` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L71) |
| `_game` | 必填 | `(ix5.a)` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L80) |
| `totalComments` | 可省略 | `(e53.a)` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L89) |
| `isTop` | 可省略 | `(od0.a)` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L98) |
| `hide` | 可省略 | `(od0.a)` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L107) |
| `created_at` | 必填 | `(ix5.a)` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L116) |
| `likesCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L125) |
| `commentsCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L134) |
| `isLiked` | 可省略 | `(od0.a)` | [descriptor](rea/validation/505-nested-com.picacg.network.pica.model.GameComment__serializer-_clinit_.smali#L143) |

[childSerializers](rea/validation/506-nested-com.picacg.network.pica.model.GameComment__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/165-supp-com.picacg.network.pica.model.GameComment-_init_.java)、[证据 2](rea/supplement/166-supp-com.picacg.network.pica.model.GameComment-_init_.java)、[证据 3](rea/supplement/167-supp-com.picacg.network.pica.model.GameComment-_init_.java)。

## GameCommentResponseData

Serializer：`Lcom/picacg/network/pica/model/GameCommentResponseData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `comments` | 必填 | `GameCommentsPageData$$serializer.INSTANCE` | [descriptor](rea/validation/293-serializer-com.picacg.network.pica.model.GameCommentResponseData__serializer-_clinit_.smali#L49) |
| `topComments` | 可省略 | `GameCommentResponseData.$childSerializers[1].getValue()` | [descriptor](rea/validation/293-serializer-com.picacg.network.pica.model.GameCommentResponseData__serializer-_clinit_.smali#L61) |

[childSerializers](rea/validation/295-serializer-com.picacg.network.pica.model.GameCommentResponseData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/289-dto-com.picacg.network.pica.model.GameCommentResponseData-_init_.java)、[证据 2](rea/validation/290-dto-com.picacg.network.pica.model.GameCommentResponseData-_init_.java)、[证据 3](rea/validation/291-dto-com.picacg.network.pica.model.GameCommentResponseData-_init_.java)。

## GameCommentsPageData

Serializer：`Lcom/picacg/network/pica/model/GameCommentsPageData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `docs` | 必填 | `GameCommentsPageData.$childSerializers[0].getValue()` | [descriptor](rea/validation/507-nested-com.picacg.network.pica.model.GameCommentsPageData__serializer-_clinit_.smali#L49) |
| `total` | 必填 | `(e53.a)` | [descriptor](rea/validation/507-nested-com.picacg.network.pica.model.GameCommentsPageData__serializer-_clinit_.smali#L58) |
| `limit` | 必填 | `(e53.a)` | [descriptor](rea/validation/507-nested-com.picacg.network.pica.model.GameCommentsPageData__serializer-_clinit_.smali#L67) |
| `page` | 必填 | `ix5.a` | [descriptor](rea/validation/507-nested-com.picacg.network.pica.model.GameCommentsPageData__serializer-_clinit_.smali#L76) |
| `pages` | 必填 | `(e53.a)` | [descriptor](rea/validation/507-nested-com.picacg.network.pica.model.GameCommentsPageData__serializer-_clinit_.smali#L85) |

[childSerializers](rea/validation/508-nested-com.picacg.network.pica.model.GameCommentsPageData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/168-supp-com.picacg.network.pica.model.GameCommentsPageData-_init_.java)、[证据 2](rea/supplement/169-supp-com.picacg.network.pica.model.GameCommentsPageData-_init_.java)。

## GameDetail

Serializer：`Lcom/picacg/network/pica/model/GameDetail$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L50) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L59) |
| `version` | 必填 | `(ix5.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L68) |
| `publisher` | 必填 | `(ix5.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L77) |
| `description` | 必填 | `(ix5.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L86) |
| `icon` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L95) |
| `ios` | 可省略 | `(od0.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L107) |
| `android` | 可省略 | `(od0.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L116) |
| `iosLinks` | 可省略 | `kd3VarArr[8].getValue()` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L125) |
| `androidLinks` | 可省略 | `kd3VarArr[9].getValue()` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L134) |
| `picaLink` | 可省略 | `(od0.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L143) |
| `adult` | 可省略 | `(od0.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L152) |
| `suggest` | 可省略 | `(od0.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L161) |
| `downloadsCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L170) |
| `likesCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L179) |
| `commentsCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L188) |
| `isLiked` | 可省略 | `(od0.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L197) |
| `screenshots` | 可省略 | `kd3VarArr[17].getValue()` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L206) |
| `androidSize` | 可省略 | `uo3.M((tv1.a))` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L215) |
| `iosSize` | 可省略 | `uo3.M((tv1.a))` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L224) |
| `updateContent` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L233) |
| `videoLink` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L242) |
| `created_at` | 必填 | `(ix5.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L251) |
| `updated_at` | 必填 | `(ix5.a)` | [descriptor](rea/validation/509-nested-com.picacg.network.pica.model.GameDetail__serializer-_clinit_.smali#L260) |

[childSerializers](rea/validation/510-nested-com.picacg.network.pica.model.GameDetail__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/170-supp-com.picacg.network.pica.model.GameDetail-_init_.java)、[证据 2](rea/supplement/171-supp-com.picacg.network.pica.model.GameDetail-_init_.java)、[证据 3](rea/supplement/172-supp-com.picacg.network.pica.model.GameDetail-_init_.java)。

## GameDetailResponse

Serializer：`Lcom/picacg/network/pica/model/GameDetailResponse$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `game` | 必填 | `GameDetail$$serializer.INSTANCE` | [descriptor](rea/validation/306-serializer-com.picacg.network.pica.model.GameDetailResponse__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/308-serializer-com.picacg.network.pica.model.GameDetailResponse__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/303-dto-com.picacg.network.pica.model.GameDetailResponse-_init_.java)、[证据 2](rea/validation/304-dto-com.picacg.network.pica.model.GameDetailResponse-_init_.java)。

## GameItem

Serializer：`Lcom/picacg/network/pica/model/GameItem$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L50) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L59) |
| `version` | 必填 | `(ix5.a)` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L68) |
| `publisher` | 必填 | `(ix5.a)` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L77) |
| `icon` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L86) |
| `ios` | 可省略 | `(od0.a)` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L98) |
| `android` | 可省略 | `(od0.a)` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L107) |
| `iosLinks` | 可省略 | `kd3VarArr[7].getValue()` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L116) |
| `androidLinks` | 可省略 | `kd3VarArr[8].getValue()` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L125) |
| `picaLink` | 可省略 | `(od0.a)` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L134) |
| `adult` | 可省略 | `(od0.a)` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L143) |
| `suggest` | 可省略 | `(od0.a)` | [descriptor](rea/validation/511-nested-com.picacg.network.pica.model.GameItem__serializer-_clinit_.smali#L152) |

[childSerializers](rea/validation/512-nested-com.picacg.network.pica.model.GameItem__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/173-supp-com.picacg.network.pica.model.GameItem-_init_.java)、[证据 2](rea/supplement/174-supp-com.picacg.network.pica.model.GameItem-_init_.java)、[证据 3](rea/supplement/175-supp-com.picacg.network.pica.model.GameItem-_init_.java)。

## GameLikeResponse

Serializer：`Lcom/picacg/network/pica/model/GameLikeResponse$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `action` | 必填 | `ix5.a` | [descriptor](rea/validation/319-serializer-com.picacg.network.pica.model.GameLikeResponse__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/321-serializer-com.picacg.network.pica.model.GameLikeResponse__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/316-dto-com.picacg.network.pica.model.GameLikeResponse-_init_.java)、[证据 2](rea/validation/317-dto-com.picacg.network.pica.model.GameLikeResponse-_init_.java)。

## GamesPageData

Serializer：`Lcom/picacg/network/pica/model/GamesPageData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `docs` | 必填 | `GamesPageData.$childSerializers[0].getValue()` | [descriptor](rea/validation/513-nested-com.picacg.network.pica.model.GamesPageData__serializer-_clinit_.smali#L49) |
| `total` | 必填 | `(e53.a)` | [descriptor](rea/validation/513-nested-com.picacg.network.pica.model.GamesPageData__serializer-_clinit_.smali#L58) |
| `limit` | 必填 | `(e53.a)` | [descriptor](rea/validation/513-nested-com.picacg.network.pica.model.GamesPageData__serializer-_clinit_.smali#L67) |
| `page` | 必填 | `(e53.a)` | [descriptor](rea/validation/513-nested-com.picacg.network.pica.model.GamesPageData__serializer-_clinit_.smali#L76) |
| `pages` | 必填 | `(e53.a)` | [descriptor](rea/validation/513-nested-com.picacg.network.pica.model.GamesPageData__serializer-_clinit_.smali#L85) |

[childSerializers](rea/validation/514-nested-com.picacg.network.pica.model.GamesPageData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/176-supp-com.picacg.network.pica.model.GamesPageData-_init_.java)、[证据 2](rea/supplement/177-supp-com.picacg.network.pica.model.GamesPageData-_init_.java)。

## GamesResponse

Serializer：`Lcom/picacg/network/pica/model/GamesResponse$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `games` | 必填 | `GamesPageData$$serializer.INSTANCE` | [descriptor](rea/validation/332-serializer-com.picacg.network.pica.model.GamesResponse__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/334-serializer-com.picacg.network.pica.model.GamesResponse__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/329-dto-com.picacg.network.pica.model.GamesResponse-_init_.java)、[证据 2](rea/validation/330-dto-com.picacg.network.pica.model.GamesResponse-_init_.java)。

## ImageInfo

Serializer：`Lcom/picacg/network/pica/model/ImageInfo$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `originalName` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/515-nested-com.picacg.network.pica.model.ImageInfo__serializer-_clinit_.smali#L49) |
| `path` | 必填 | `(ix5.a)` | [descriptor](rea/validation/515-nested-com.picacg.network.pica.model.ImageInfo__serializer-_clinit_.smali#L61) |
| `fileServer` | 必填 | `(ix5.a)` | [descriptor](rea/validation/515-nested-com.picacg.network.pica.model.ImageInfo__serializer-_clinit_.smali#L70) |

[childSerializers](rea/validation/516-nested-com.picacg.network.pica.model.ImageInfo__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/178-supp-com.picacg.network.pica.model.ImageInfo-_init_.java)、[证据 2](rea/supplement/179-supp-com.picacg.network.pica.model.ImageInfo-_init_.java)、[证据 3](rea/supplement/180-supp-com.picacg.network.pica.model.ImageInfo-_init_.java)。

## KeywordsData

Serializer：`Lcom/picacg/network/pica/model/KeywordsData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `keywords` | 必填 | `KeywordsData.$childSerializers[0].getValue()` | [descriptor](rea/validation/345-serializer-com.picacg.network.pica.model.KeywordsData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/347-serializer-com.picacg.network.pica.model.KeywordsData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/342-dto-com.picacg.network.pica.model.KeywordsData-_init_.java)、[证据 2](rea/validation/343-dto-com.picacg.network.pica.model.KeywordsData-_init_.java)。

## LeaderboardComic

Serializer：`Lcom/picacg/network/pica/model/LeaderboardComic$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L50) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L59) |
| `author` | 必填 | `(ix5.a)` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L68) |
| `totalViews` | 可省略 | `(e53.a)` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L80) |
| `totalLikes` | 可省略 | `(e53.a)` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L89) |
| `pagesCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L98) |
| `epsCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L107) |
| `finished` | 可省略 | `od0.a` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L116) |
| `categories` | 可省略 | `kd3VarArr[8].getValue()` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L125) |
| `tags` | 可省略 | `kd3VarArr[9].getValue()` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L134) |
| `thumb` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L143) |
| `likesCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/517-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-_clinit_.smali#L152) |

[childSerializers](rea/validation/518-nested-com.picacg.network.pica.model.LeaderboardComic__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/182-supp-com.picacg.network.pica.model.LeaderboardComic-_init_.java)、[证据 2](rea/supplement/183-supp-com.picacg.network.pica.model.LeaderboardComic-_init_.java)、[证据 3](rea/supplement/184-supp-com.picacg.network.pica.model.LeaderboardComic-_init_.java)。

## LeaderboardData

Serializer：`Lcom/picacg/network/pica/model/LeaderboardData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `comics` | 必填 | `LeaderboardData.$childSerializers[0].getValue()` | [descriptor](rea/validation/358-serializer-com.picacg.network.pica.model.LeaderboardData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/360-serializer-com.picacg.network.pica.model.LeaderboardData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/355-dto-com.picacg.network.pica.model.LeaderboardData-_init_.java)、[证据 2](rea/validation/356-dto-com.picacg.network.pica.model.LeaderboardData-_init_.java)。

## LoginData

Serializer：`Lcom/picacg/network/pica/model/LoginData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `token` | 必填 | `ix5.a` | [descriptor](rea/validation/371-serializer-com.picacg.network.pica.model.LoginData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/373-serializer-com.picacg.network.pica.model.LoginData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/368-dto-com.picacg.network.pica.model.LoginData-_init_.java)、[证据 2](rea/validation/369-dto-com.picacg.network.pica.model.LoginData-_init_.java)。

## MyCommentComicRef

Serializer：`Lcom/picacg/network/pica/model/MyCommentComicRef$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/519-nested-com.picacg.network.pica.model.MyCommentComicRef__serializer-_clinit_.smali#L49) |
| `title` | 必填 | `(ix5.a)` | [descriptor](rea/validation/519-nested-com.picacg.network.pica.model.MyCommentComicRef__serializer-_clinit_.smali#L58) |

[childSerializers](rea/validation/520-nested-com.picacg.network.pica.model.MyCommentComicRef__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/185-supp-com.picacg.network.pica.model.MyCommentComicRef-_init_.java)、[证据 2](rea/supplement/186-supp-com.picacg.network.pica.model.MyCommentComicRef-_init_.java)。

## MyCommentItem

Serializer：`Lcom/picacg/network/pica/model/MyCommentItem$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/521-nested-com.picacg.network.pica.model.MyCommentItem__serializer-_clinit_.smali#L50) |
| `content` | 必填 | `(ix5.a)` | [descriptor](rea/validation/521-nested-com.picacg.network.pica.model.MyCommentItem__serializer-_clinit_.smali#L59) |
| `_comic` | 可省略 | `(uo3.M(MyCommentComicRef$$serializer.INSTANCE))` | [descriptor](rea/validation/521-nested-com.picacg.network.pica.model.MyCommentItem__serializer-_clinit_.smali#L71) |
| `totalComments` | 可省略 | `(e53.a)` | [descriptor](rea/validation/521-nested-com.picacg.network.pica.model.MyCommentItem__serializer-_clinit_.smali#L80) |
| `hide` | 可省略 | `(od0.a)` | [descriptor](rea/validation/521-nested-com.picacg.network.pica.model.MyCommentItem__serializer-_clinit_.smali#L89) |
| `created_at` | 必填 | `(ix5.a)` | [descriptor](rea/validation/521-nested-com.picacg.network.pica.model.MyCommentItem__serializer-_clinit_.smali#L98) |
| `likesCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/521-nested-com.picacg.network.pica.model.MyCommentItem__serializer-_clinit_.smali#L107) |
| `commentsCount` | 可省略 | `(e53.a)` | [descriptor](rea/validation/521-nested-com.picacg.network.pica.model.MyCommentItem__serializer-_clinit_.smali#L116) |
| `isLiked` | 可省略 | `(od0.a)` | [descriptor](rea/validation/521-nested-com.picacg.network.pica.model.MyCommentItem__serializer-_clinit_.smali#L125) |

[childSerializers](rea/validation/522-nested-com.picacg.network.pica.model.MyCommentItem__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/187-supp-com.picacg.network.pica.model.MyCommentItem-_init_.java)、[证据 2](rea/supplement/188-supp-com.picacg.network.pica.model.MyCommentItem-_init_.java)、[证据 3](rea/supplement/189-supp-com.picacg.network.pica.model.MyCommentItem-_init_.java)。

## MyCommentsPageData

Serializer：`Lcom/picacg/network/pica/model/MyCommentsPageData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `docs` | 必填 | `MyCommentsPageData.$childSerializers[0].getValue()` | [descriptor](rea/validation/523-nested-com.picacg.network.pica.model.MyCommentsPageData__serializer-_clinit_.smali#L49) |
| `total` | 必填 | `(e53.a)` | [descriptor](rea/validation/523-nested-com.picacg.network.pica.model.MyCommentsPageData__serializer-_clinit_.smali#L58) |
| `limit` | 必填 | `(e53.a)` | [descriptor](rea/validation/523-nested-com.picacg.network.pica.model.MyCommentsPageData__serializer-_clinit_.smali#L67) |
| `page` | 必填 | `ix5.a` | [descriptor](rea/validation/523-nested-com.picacg.network.pica.model.MyCommentsPageData__serializer-_clinit_.smali#L76) |
| `pages` | 必填 | `(e53.a)` | [descriptor](rea/validation/523-nested-com.picacg.network.pica.model.MyCommentsPageData__serializer-_clinit_.smali#L85) |

[childSerializers](rea/validation/524-nested-com.picacg.network.pica.model.MyCommentsPageData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/190-supp-com.picacg.network.pica.model.MyCommentsPageData-_init_.java)、[证据 2](rea/supplement/191-supp-com.picacg.network.pica.model.MyCommentsPageData-_init_.java)。

## MyCommentsResponseData

Serializer：`Lcom/picacg/network/pica/model/MyCommentsResponseData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `comments` | 必填 | `MyCommentsPageData$$serializer.INSTANCE` | [descriptor](rea/validation/384-serializer-com.picacg.network.pica.model.MyCommentsResponseData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/386-serializer-com.picacg.network.pica.model.MyCommentsResponseData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/381-dto-com.picacg.network.pica.model.MyCommentsResponseData-_init_.java)、[证据 2](rea/validation/382-dto-com.picacg.network.pica.model.MyCommentsResponseData-_init_.java)。

## PageItem

Serializer：`Lcom/picacg/network/pica/model/PageItem$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `ix5.a` | [descriptor](rea/validation/525-nested-com.picacg.network.pica.model.PageItem__serializer-_clinit_.smali#L49) |
| `media` | 必填 | `ImageInfo$$serializer.INSTANCE` | [descriptor](rea/validation/525-nested-com.picacg.network.pica.model.PageItem__serializer-_clinit_.smali#L58) |

[childSerializers](rea/validation/526-nested-com.picacg.network.pica.model.PageItem__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/192-supp-com.picacg.network.pica.model.PageItem-_init_.java)、[证据 2](rea/supplement/193-supp-com.picacg.network.pica.model.PageItem-_init_.java)。

## PagesInfo

Serializer：`Lcom/picacg/network/pica/model/PagesInfo$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `docs` | 必填 | `PagesInfo.$childSerializers[0].getValue()` | [descriptor](rea/validation/527-nested-com.picacg.network.pica.model.PagesInfo__serializer-_clinit_.smali#L49) |
| `total` | 必填 | `(e53.a)` | [descriptor](rea/validation/527-nested-com.picacg.network.pica.model.PagesInfo__serializer-_clinit_.smali#L58) |
| `limit` | 必填 | `(e53.a)` | [descriptor](rea/validation/527-nested-com.picacg.network.pica.model.PagesInfo__serializer-_clinit_.smali#L67) |
| `page` | 必填 | `(e53.a)` | [descriptor](rea/validation/527-nested-com.picacg.network.pica.model.PagesInfo__serializer-_clinit_.smali#L76) |
| `pages` | 必填 | `(e53.a)` | [descriptor](rea/validation/527-nested-com.picacg.network.pica.model.PagesInfo__serializer-_clinit_.smali#L85) |

[childSerializers](rea/validation/528-nested-com.picacg.network.pica.model.PagesInfo__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/194-supp-com.picacg.network.pica.model.PagesInfo-_init_.java)、[证据 2](rea/supplement/195-supp-com.picacg.network.pica.model.PagesInfo-_init_.java)。

## PicaResponse

Serializer：`Lcom/picacg/network/pica/model/PicaResponse$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `code` | 必填 | `e53.a` | [descriptor](rea/validation/398-serializer-com.picacg.network.pica.model.PicaResponse__serializer-_init_.java#L3) |
| `message` | 必填 | `(ix5.a)` | [descriptor](rea/validation/398-serializer-com.picacg.network.pica.model.PicaResponse__serializer-_init_.java#L4) |
| `error` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/398-serializer-com.picacg.network.pica.model.PicaResponse__serializer-_init_.java#L5) |
| `data` | 可省略 | `uo3.M(this.typeSerial0)` | [descriptor](rea/validation/398-serializer-com.picacg.network.pica.model.PicaResponse__serializer-_init_.java#L6) |

[childSerializers](rea/validation/400-serializer-com.picacg.network.pica.model.PicaResponse__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/394-dto-com.picacg.network.pica.model.PicaResponse-_init_.java)、[证据 2](rea/validation/395-dto-com.picacg.network.pica.model.PicaResponse-_init_.java)、[证据 3](rea/validation/396-dto-com.picacg.network.pica.model.PicaResponse-_init_.java)。

## PunchInData

Serializer：`Lcom/picacg/network/pica/model/PunchInData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `status` | 必填 | `(ix5.a)` | [descriptor](rea/validation/529-nested-com.picacg.network.pica.model.PunchInData__serializer-_clinit_.smali#L49) |
| `punchInLastDay` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/529-nested-com.picacg.network.pica.model.PunchInData__serializer-_clinit_.smali#L61) |

[childSerializers](rea/validation/530-nested-com.picacg.network.pica.model.PunchInData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/196-supp-com.picacg.network.pica.model.PunchInData-_init_.java)、[证据 2](rea/supplement/197-supp-com.picacg.network.pica.model.PunchInData-_init_.java)、[证据 3](rea/supplement/198-supp-com.picacg.network.pica.model.PunchInData-_init_.java)。

## PunchInResponse

Serializer：`Lcom/picacg/network/pica/model/PunchInResponse$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `res` | 必填 | `PunchInData$$serializer.INSTANCE` | [descriptor](rea/validation/411-serializer-com.picacg.network.pica.model.PunchInResponse__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/413-serializer-com.picacg.network.pica.model.PunchInResponse__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/408-dto-com.picacg.network.pica.model.PunchInResponse-_init_.java)、[证据 2](rea/validation/409-dto-com.picacg.network.pica.model.PunchInResponse-_init_.java)。

## RandomComicsResponse

Serializer：`Lcom/picacg/network/pica/model/RandomComicsResponse$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `comics` | 必填 | `RandomComicsResponse.$childSerializers[0].getValue()` | [descriptor](rea/validation/424-serializer-com.picacg.network.pica.model.RandomComicsResponse__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/426-serializer-com.picacg.network.pica.model.RandomComicsResponse__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/421-dto-com.picacg.network.pica.model.RandomComicsResponse-_init_.java)、[证据 2](rea/validation/422-dto-com.picacg.network.pica.model.RandomComicsResponse-_init_.java)。

## SloganUpdateRequest

Serializer：`Lcom/picacg/network/pica/model/SloganUpdateRequest$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `slogan` | 必填 | `ix5.a` | [descriptor](rea/validation/437-serializer-com.picacg.network.pica.model.SloganUpdateRequest__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/439-serializer-com.picacg.network.pica.model.SloganUpdateRequest__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/434-dto-com.picacg.network.pica.model.SloganUpdateRequest-_init_.java)、[证据 2](rea/validation/435-dto-com.picacg.network.pica.model.SloganUpdateRequest-_init_.java)。

## UserProfile

Serializer：`Lcom/picacg/network/pica/model/UserProfile$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `_id` | 必填 | `(ix5.a)` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L50) |
| `email` | 必填 | `(ix5.a)` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L59) |
| `name` | 必填 | `(ix5.a)` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L68) |
| `title` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L80) |
| `slogan` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L89) |
| `avatar` | 可省略 | `uo3.M(ImageInfo$$serializer.INSTANCE)` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L98) |
| `exp` | 可省略 | `(e53.a)` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L107) |
| `level` | 可省略 | `(e53.a)` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L116) |
| `gender` | 可省略 | `(ix5.a)` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L125) |
| `verified` | 可省略 | `(od0.a)` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L134) |
| `isPunched` | 可省略 | `(od0.a)` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L143) |
| `characters` | 可省略 | `kd3VarArr[11].getValue()` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L152) |
| `birthday` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L161) |
| `created_at` | 可省略 | `uo3.M((ix5.a))` | [descriptor](rea/validation/531-nested-com.picacg.network.pica.model.UserProfile__serializer-_clinit_.smali#L170) |

[childSerializers](rea/validation/532-nested-com.picacg.network.pica.model.UserProfile__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/supplement/199-supp-com.picacg.network.pica.model.UserProfile-_init_.java)、[证据 2](rea/supplement/200-supp-com.picacg.network.pica.model.UserProfile-_init_.java)、[证据 3](rea/supplement/201-supp-com.picacg.network.pica.model.UserProfile-_init_.java)。

## UserProfileData

Serializer：`Lcom/picacg/network/pica/model/UserProfileData$$serializer;`。

| JSON key | 缺省约束 | 子 serializer（原表达式） | 证据 |
|---|---|---|---|
| `user` | 必填 | `UserProfile$$serializer.INSTANCE` | [descriptor](rea/validation/450-serializer-com.picacg.network.pica.model.UserProfileData__serializer-_clinit_.smali#L49) |

[childSerializers](rea/validation/452-serializer-com.picacg.network.pica.model.UserProfileData__serializer-childSerializers.java)。

构造器/defaults：[证据 1](rea/validation/447-dto-com.picacg.network.pica.model.UserProfileData-_init_.java)、[证据 2](rea/validation/448-dto-com.picacg.network.pica.model.UserProfileData-_init_.java)。
