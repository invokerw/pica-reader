.method static constructor <clinit>()V
    .registers 5

    .line 1
    new-instance v0, Lcom/picacg/domain/model/ComicSortType;

    .line 2
    .line 3
    const-string v1, "dd"

    .line 4
    .line 5
    const v2, 0x7f0f020c

    .line 6
    .line 7
    .line 8
    const-string v3, "DEFAULT"

    .line 9
    .line 10
    const/4 v4, 0x0

    .line 11
    invoke-direct {v0, v3, v4, v1, v2}, Lcom/picacg/domain/model/ComicSortType;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    .line 12
    .line 13
    .line 14
    sput-object v0, Lcom/picacg/domain/model/ComicSortType;->DEFAULT:Lcom/picacg/domain/model/ComicSortType;

    .line 15
    .line 16
    new-instance v0, Lcom/picacg/domain/model/ComicSortType;

    .line 17
    .line 18
    const-string v1, "da"

    .line 19
    .line 20
    const v2, 0x7f0f020e

    .line 21
    .line 22
    .line 23
    const-string v3, "TIME_ASC"

    .line 24
    .line 25
    const/4 v4, 0x1

    .line 26
    invoke-direct {v0, v3, v4, v1, v2}, Lcom/picacg/domain/model/ComicSortType;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    .line 27
    .line 28
    .line 29
    sput-object v0, Lcom/picacg/domain/model/ComicSortType;->TIME_ASC:Lcom/picacg/domain/model/ComicSortType;

    .line 30
    .line 31
    new-instance v0, Lcom/picacg/domain/model/ComicSortType;

    .line 32
    .line 33
    const-string v1, "ld"

    .line 34
    .line 35
    const v2, 0x7f0f020d

    .line 36
    .line 37
    .line 38
    const-string v3, "LIKES_DESC"

    .line 39
    .line 40
    const/4 v4, 0x2

    .line 41
    invoke-direct {v0, v3, v4, v1, v2}, Lcom/picacg/domain/model/ComicSortType;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    .line 42
    .line 43
    .line 44
    sput-object v0, Lcom/picacg/domain/model/ComicSortType;->LIKES_DESC:Lcom/picacg/domain/model/ComicSortType;

    .line 45
    .line 46
    new-instance v0, Lcom/picacg/domain/model/ComicSortType;

    .line 47
    .line 48
    const-string v1, "vd"

    .line 49
    .line 50
    const v2, 0x7f0f020f

    .line 51
    .line 52
    .line 53
    const-string v3, "VIEWS_DESC"

    .line 54
    .line 55
    const/4 v4, 0x3

    .line 56
    invoke-direct {v0, v3, v4, v1, v2}, Lcom/picacg/domain/model/ComicSortType;-><init>(Ljava/lang/String;ILjava/lang/String;I)V

    .line 57
    .line 58
    .line 59
    sput-object v0, Lcom/picacg/domain/model/ComicSortType;->VIEWS_DESC:Lcom/picacg/domain/model/ComicSortType;

    .line 60
    .line 61
    invoke-static {}, Lcom/picacg/domain/model/ComicSortType;->$values()[Lcom/picacg/domain/model/ComicSortType;

    .line 62
    .line 63
    .line 64
    move-result-object v0

    .line 65
    sput-object v0, Lcom/picacg/domain/model/ComicSortType;->$VALUES:[Lcom/picacg/domain/model/ComicSortType;

    .line 66
    .line 67
    invoke-static {v0}, Lim0;->w([Ljava/lang/Enum;)Lv52;

    .line 68
    .line 69
    .line 70
    move-result-object v0

    .line 71
    sput-object v0, Lcom/picacg/domain/model/ComicSortType;->$ENTRIES:Lu52;

    .line 72
    .line 73
    new-instance v0, Lcom/picacg/domain/model/ComicSortType$Companion;

    .line 74
    .line 75
    const/4 v1, 0x0

    .line 76
    invoke-direct {v0, v1}, Lcom/picacg/domain/model/ComicSortType$Companion;-><init>(Ljo1;)V

    .line 77
    .line 78
    .line 79
    sput-object v0, Lcom/picacg/domain/model/ComicSortType;->Companion:Lcom/picacg/domain/model/ComicSortType$Companion;

    .line 80
    .line 81
    return-void
.end method