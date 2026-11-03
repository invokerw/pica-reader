.method static constructor <clinit>()V
    .registers 3

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/LeaderboardData$Companion;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    invoke-direct {v0, v1}, Lcom/picacg/network/pica/model/LeaderboardData$Companion;-><init>(Ljo1;)V

    .line 5
    .line 6
    .line 7
    sput-object v0, Lcom/picacg/network/pica/model/LeaderboardData;->Companion:Lcom/picacg/network/pica/model/LeaderboardData$Companion;

    .line 8
    .line 9
    new-instance v0, Lt83;

    .line 10
    .line 11
    const/4 v1, 0x5

    .line 12
    invoke-direct {v0, v1}, Lt83;-><init>(I)V

    .line 13
    .line 14
    .line 15
    sget-object v1, Lsh3;->i:Lsh3;

    .line 16
    .line 17
    invoke-static {v1, v0}, Lgr2;->A(Lsh3;Lkm2;)Lkd3;

    .line 18
    .line 19
    .line 20
    move-result-object v0

    .line 21
    const/4 v1, 0x1

    .line 22
    new-array v1, v1, [Lkd3;

    .line 23
    .line 24
    const/4 v2, 0x0

    .line 25
    aput-object v0, v1, v2

    .line 26
    .line 27
    sput-object v1, Lcom/picacg/network/pica/model/LeaderboardData;->$childSerializers:[Lkd3;

    .line 28
    .line 29
    return-void
.end method