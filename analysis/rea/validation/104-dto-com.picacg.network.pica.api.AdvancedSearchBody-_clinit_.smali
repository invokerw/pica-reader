.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lk8;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/picacg/network/pica/api/AdvancedSearchBody;->Companion:Lk8;

    .line 7
    .line 8
    new-instance v0, Lt5;

    .line 9
    .line 10
    const/4 v1, 0x4

    .line 11
    invoke-direct {v0, v1}, Lt5;-><init>(I)V

    .line 12
    .line 13
    .line 14
    sget-object v1, Lsh3;->i:Lsh3;

    .line 15
    .line 16
    invoke-static {v1, v0}, Lgr2;->A(Lsh3;Lkm2;)Lkd3;

    .line 17
    .line 18
    .line 19
    move-result-object v0

    .line 20
    const/4 v1, 0x3

    .line 21
    new-array v1, v1, [Lkd3;

    .line 22
    .line 23
    const/4 v2, 0x0

    .line 24
    const/4 v3, 0x0

    .line 25
    aput-object v3, v1, v2

    .line 26
    .line 27
    const/4 v2, 0x1

    .line 28
    aput-object v3, v1, v2

    .line 29
    .line 30
    const/4 v2, 0x2

    .line 31
    aput-object v0, v1, v2

    .line 32
    .line 33
    sput-object v1, Lcom/picacg/network/pica/api/AdvancedSearchBody;->$childSerializers:[Lkd3;

    .line 34
    .line 35
    return-void
.end method