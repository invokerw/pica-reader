.method static constructor <clinit>()V
    .registers 2

    new-instance v0, Lcom/picacg/network/pica/model/ComicsListResponse$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/picacg/network/pica/model/ComicsListResponse$Companion;-><init>(Ljo1;)V

    sput-object v0, Lcom/picacg/network/pica/model/ComicsListResponse;->Companion:Lcom/picacg/network/pica/model/ComicsListResponse$Companion;

    const/16 v0, 0x8

    sput v0, Lcom/picacg/network/pica/model/ComicsListResponse;->$stable:I

    return-void
.end method