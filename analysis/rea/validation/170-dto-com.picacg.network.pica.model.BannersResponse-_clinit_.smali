.method static constructor <clinit>()V
    .registers 3

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/BannersResponse$Companion;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    invoke-direct {v0, v1}, Lcom/picacg/network/pica/model/BannersResponse$Companion;-><init>(Ljo1;)V

    .line 5
    .line 6
    .line 7
    sput-object v0, Lcom/picacg/network/pica/model/BannersResponse;->Companion:Lcom/picacg/network/pica/model/BannersResponse$Companion;

    .line 8
    .line 9
    const/16 v0, 0x8

    .line 10
    .line 11
    sput v0, Lcom/picacg/network/pica/model/BannersResponse;->$stable:I

    .line 12
    .line 13
    new-instance v1, Ldw;

    .line 14
    .line 15
    invoke-direct {v1, v0}, Ldw;-><init>(I)V

    .line 16
    .line 17
    .line 18
    sget-object v0, Lsh3;->i:Lsh3;

    .line 19
    .line 20
    invoke-static {v0, v1}, Lgr2;->A(Lsh3;Lkm2;)Lkd3;

    .line 21
    .line 22
    .line 23
    move-result-object v0

    .line 24
    const/4 v1, 0x1

    .line 25
    new-array v1, v1, [Lkd3;

    .line 26
    .line 27
    const/4 v2, 0x0

    .line 28
    aput-object v0, v1, v2

    .line 29
    .line 30
    sput-object v1, Lcom/picacg/network/pica/model/BannersResponse;->$childSerializers:[Lkd3;

    .line 31
    .line 32
    return-void
.end method