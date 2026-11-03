.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/GameCommentResponseData$Companion;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    invoke-direct {v0, v1}, Lcom/picacg/network/pica/model/GameCommentResponseData$Companion;-><init>(Ljo1;)V

    .line 5
    .line 6
    .line 7
    sput-object v0, Lcom/picacg/network/pica/model/GameCommentResponseData;->Companion:Lcom/picacg/network/pica/model/GameCommentResponseData$Companion;

    .line 8
    .line 9
    new-instance v0, La02;

    .line 10
    .line 11
    const/4 v2, 0x7

    .line 12
    invoke-direct {v0, v2}, La02;-><init>(I)V

    .line 13
    .line 14
    .line 15
    sget-object v2, Lsh3;->i:Lsh3;

    .line 16
    .line 17
    invoke-static {v2, v0}, Lgr2;->A(Lsh3;Lkm2;)Lkd3;

    .line 18
    .line 19
    .line 20
    move-result-object v0

    .line 21
    const/4 v2, 0x2

    .line 22
    new-array v2, v2, [Lkd3;

    .line 23
    .line 24
    const/4 v3, 0x0

    .line 25
    aput-object v1, v2, v3

    .line 26
    .line 27
    const/4 v1, 0x1

    .line 28
    aput-object v0, v2, v1

    .line 29
    .line 30
    sput-object v2, Lcom/picacg/network/pica/model/GameCommentResponseData;->$childSerializers:[Lkd3;

    .line 31
    .line 32
    return-void
.end method