.method static constructor <clinit>()V
    .registers 2

    new-instance v0, Lcom/picacg/network/pica/model/GamesResponse$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/picacg/network/pica/model/GamesResponse$Companion;-><init>(Ljo1;)V

    sput-object v0, Lcom/picacg/network/pica/model/GamesResponse;->Companion:Lcom/picacg/network/pica/model/GamesResponse$Companion;

    const/16 v0, 0x8

    sput v0, Lcom/picacg/network/pica/model/GamesResponse;->$stable:I

    return-void
.end method