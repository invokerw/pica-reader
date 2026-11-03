.method static constructor <clinit>()V
    .registers 3

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/CategoriesData$Companion;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    invoke-direct {v0, v1}, Lcom/picacg/network/pica/model/CategoriesData$Companion;-><init>(Ljo1;)V

    .line 5
    .line 6
    .line 7
    sput-object v0, Lcom/picacg/network/pica/model/CategoriesData;->Companion:Lcom/picacg/network/pica/model/CategoriesData$Companion;

    .line 8
    .line 9
    const/16 v0, 0x8

    .line 10
    .line 11
    sput v0, Lcom/picacg/network/pica/model/CategoriesData;->$stable:I

    .line 12
    .line 13
    new-instance v0, Ldw;

    .line 14
    .line 15
    const/16 v1, 0xe

    .line 16
    .line 17
    invoke-direct {v0, v1}, Ldw;-><init>(I)V

    .line 18
    .line 19
    .line 20
    sget-object v1, Lsh3;->i:Lsh3;

    .line 21
    .line 22
    invoke-static {v1, v0}, Lgr2;->A(Lsh3;Lkm2;)Lkd3;

    .line 23
    .line 24
    .line 25
    move-result-object v0

    .line 26
    const/4 v1, 0x1

    .line 27
    new-array v1, v1, [Lkd3;

    .line 28
    .line 29
    const/4 v2, 0x0

    .line 30
    aput-object v0, v1, v2

    .line 31
    .line 32
    sput-object v1, Lcom/picacg/network/pica/model/CategoriesData;->$childSerializers:[Lkd3;

    .line 33
    .line 34
    return-void
.end method