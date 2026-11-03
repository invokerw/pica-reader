.method static constructor <clinit>()V
    .registers 3

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/RandomComicsResponse$Companion;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    invoke-direct {v0, v1}, Lcom/picacg/network/pica/model/RandomComicsResponse$Companion;-><init>(Ljo1;)V

    .line 5
    .line 6
    .line 7
    sput-object v0, Lcom/picacg/network/pica/model/RandomComicsResponse;->Companion:Lcom/picacg/network/pica/model/RandomComicsResponse$Companion;

    .line 8
    .line 9
    const/16 v0, 0x8

    .line 10
    .line 11
    sput v0, Lcom/picacg/network/pica/model/RandomComicsResponse;->$stable:I

    .line 12
    .line 13
    new-instance v0, Lx94;

    .line 14
    .line 15
    const/4 v1, 0x5

    .line 16
    invoke-direct {v0, v1}, Lx94;-><init>(I)V

    .line 17
    .line 18
    .line 19
    sget-object v1, Lsh3;->i:Lsh3;

    .line 20
    .line 21
    invoke-static {v1, v0}, Lgr2;->A(Lsh3;Lkm2;)Lkd3;

    .line 22
    .line 23
    .line 24
    move-result-object v0

    .line 25
    const/4 v1, 0x1

    .line 26
    new-array v1, v1, [Lkd3;

    .line 27
    .line 28
    const/4 v2, 0x0

    .line 29
    aput-object v0, v1, v2

    .line 30
    .line 31
    sput-object v1, Lcom/picacg/network/pica/model/RandomComicsResponse;->$childSerializers:[Lkd3;

    .line 32
    .line 33
    return-void
.end method