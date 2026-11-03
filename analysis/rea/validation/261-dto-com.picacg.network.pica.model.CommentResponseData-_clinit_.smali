.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/CommentResponseData$Companion;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    invoke-direct {v0, v1}, Lcom/picacg/network/pica/model/CommentResponseData$Companion;-><init>(Ljo1;)V

    .line 5
    .line 6
    .line 7
    sput-object v0, Lcom/picacg/network/pica/model/CommentResponseData;->Companion:Lcom/picacg/network/pica/model/CommentResponseData$Companion;

    .line 8
    .line 9
    new-instance v0, Llw0;

    .line 10
    .line 11
    const/16 v2, 0xb

    .line 12
    .line 13
    invoke-direct {v0, v2}, Llw0;-><init>(I)V

    .line 14
    .line 15
    .line 16
    sget-object v2, Lsh3;->i:Lsh3;

    .line 17
    .line 18
    invoke-static {v2, v0}, Lgr2;->A(Lsh3;Lkm2;)Lkd3;

    .line 19
    .line 20
    .line 21
    move-result-object v0

    .line 22
    const/4 v2, 0x2

    .line 23
    new-array v2, v2, [Lkd3;

    .line 24
    .line 25
    const/4 v3, 0x0

    .line 26
    aput-object v1, v2, v3

    .line 27
    .line 28
    const/4 v1, 0x1

    .line 29
    aput-object v0, v2, v1

    .line 30
    .line 31
    sput-object v2, Lcom/picacg/network/pica/model/CommentResponseData;->$childSerializers:[Lkd3;

    .line 32
    .line 33
    return-void
.end method