.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lcom/picacg/domain/model/Subdomain;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    const-string v2, "picaapi"

    .line 5
    .line 6
    const-string v3, "API"

    .line 7
    .line 8
    invoke-direct {v0, v3, v1, v2}, Lcom/picacg/domain/model/Subdomain;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .line 9
    .line 10
    .line 11
    sput-object v0, Lcom/picacg/domain/model/Subdomain;->API:Lcom/picacg/domain/model/Subdomain;

    .line 12
    .line 13
    new-instance v0, Lcom/picacg/domain/model/Subdomain;

    .line 14
    .line 15
    const/4 v1, 0x1

    .line 16
    const-string v2, "img"

    .line 17
    .line 18
    const-string v3, "IMG"

    .line 19
    .line 20
    invoke-direct {v0, v3, v1, v2}, Lcom/picacg/domain/model/Subdomain;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .line 21
    .line 22
    .line 23
    sput-object v0, Lcom/picacg/domain/model/Subdomain;->IMG:Lcom/picacg/domain/model/Subdomain;

    .line 24
    .line 25
    new-instance v0, Lcom/picacg/domain/model/Subdomain;

    .line 26
    .line 27
    const/4 v1, 0x2

    .line 28
    const-string v2, "s1"

    .line 29
    .line 30
    const-string v3, "STORAGE_1"

    .line 31
    .line 32
    invoke-direct {v0, v3, v1, v2}, Lcom/picacg/domain/model/Subdomain;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .line 33
    .line 34
    .line 35
    sput-object v0, Lcom/picacg/domain/model/Subdomain;->STORAGE_1:Lcom/picacg/domain/model/Subdomain;

    .line 36
    .line 37
    new-instance v0, Lcom/picacg/domain/model/Subdomain;

    .line 38
    .line 39
    const/4 v1, 0x3

    .line 40
    const-string v2, "s2"

    .line 41
    .line 42
    const-string v3, "STORAGE_2"

    .line 43
    .line 44
    invoke-direct {v0, v3, v1, v2}, Lcom/picacg/domain/model/Subdomain;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .line 45
    .line 46
    .line 47
    sput-object v0, Lcom/picacg/domain/model/Subdomain;->STORAGE_2:Lcom/picacg/domain/model/Subdomain;

    .line 48
    .line 49
    new-instance v0, Lcom/picacg/domain/model/Subdomain;

    .line 50
    .line 51
    const/4 v1, 0x4

    .line 52
    const-string v2, "s3"

    .line 53
    .line 54
    const-string v3, "STORAGE_3"

    .line 55
    .line 56
    invoke-direct {v0, v3, v1, v2}, Lcom/picacg/domain/model/Subdomain;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .line 57
    .line 58
    .line 59
    sput-object v0, Lcom/picacg/domain/model/Subdomain;->STORAGE_3:Lcom/picacg/domain/model/Subdomain;

    .line 60
    .line 61
    new-instance v0, Lcom/picacg/domain/model/Subdomain;

    .line 62
    .line 63
    const/4 v1, 0x5

    .line 64
    const-string v2, "strong"

    .line 65
    .line 66
    const-string v3, "STRONG"

    .line 67
    .line 68
    invoke-direct {v0, v3, v1, v2}, Lcom/picacg/domain/model/Subdomain;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .line 69
    .line 70
    .line 71
    sput-object v0, Lcom/picacg/domain/model/Subdomain;->STRONG:Lcom/picacg/domain/model/Subdomain;

    .line 72
    .line 73
    new-instance v0, Lcom/picacg/domain/model/Subdomain;

    .line 74
    .line 75
    const/4 v1, 0x6

    .line 76
    const-string v2, "data"

    .line 77
    .line 78
    const-string v3, "DATA"

    .line 79
    .line 80
    invoke-direct {v0, v3, v1, v2}, Lcom/picacg/domain/model/Subdomain;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    .line 81
    .line 82
    .line 83
    sput-object v0, Lcom/picacg/domain/model/Subdomain;->DATA:Lcom/picacg/domain/model/Subdomain;

    .line 84
    .line 85
    invoke-static {}, Lcom/picacg/domain/model/Subdomain;->$values()[Lcom/picacg/domain/model/Subdomain;

    .line 86
    .line 87
    .line 88
    move-result-object v0

    .line 89
    sput-object v0, Lcom/picacg/domain/model/Subdomain;->$VALUES:[Lcom/picacg/domain/model/Subdomain;

    .line 90
    .line 91
    invoke-static {v0}, Lim0;->w([Ljava/lang/Enum;)Lv52;

    .line 92
    .line 93
    .line 94
    move-result-object v0

    .line 95
    sput-object v0, Lcom/picacg/domain/model/Subdomain;->$ENTRIES:Lu52;

    .line 96
    .line 97
    return-void
.end method