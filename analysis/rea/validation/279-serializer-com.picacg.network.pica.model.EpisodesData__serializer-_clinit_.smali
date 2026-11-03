.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/EpisodesData$$serializer;

    .line 2
    .line 3
    invoke-direct {v0}, Lcom/picacg/network/pica/model/EpisodesData$$serializer;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/picacg/network/pica/model/EpisodesData$$serializer;->INSTANCE:Lcom/picacg/network/pica/model/EpisodesData$$serializer;

    .line 7
    .line 8
    const/16 v1, 0x8

    .line 9
    .line 10
    sput v1, Lcom/picacg/network/pica/model/EpisodesData$$serializer;->$stable:I

    .line 11
    .line 12
    new-instance v1, Lqj4;

    .line 13
    .line 14
    const-string v2, "com.picacg.network.pica.model.EpisodesData"

    .line 15
    .line 16
    const/4 v3, 0x1

    .line 17
    invoke-direct {v1, v2, v0, v3}, Lqj4;-><init>(Ljava/lang/String;Lep2;I)V

    .line 18
    .line 19
    .line 20
    const-string v0, "eps"

    .line 21
    .line 22
    const/4 v2, 0x0

    .line 23
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 24
    .line 25
    .line 26
    sput-object v1, Lcom/picacg/network/pica/model/EpisodesData$$serializer;->descriptor:Lzi5;

    .line 27
    .line 28
    return-void
.end method