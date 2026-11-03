.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/PicaResponse$Companion;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    invoke-direct {v0, v1}, Lcom/picacg/network/pica/model/PicaResponse$Companion;-><init>(Ljo1;)V

    .line 5
    .line 6
    .line 7
    sput-object v0, Lcom/picacg/network/pica/model/PicaResponse;->Companion:Lcom/picacg/network/pica/model/PicaResponse$Companion;

    .line 8
    .line 9
    new-instance v0, Lqj4;

    .line 10
    .line 11
    const-string v2, "com.picacg.network.pica.model.PicaResponse"

    .line 12
    .line 13
    const/4 v3, 0x4

    .line 14
    invoke-direct {v0, v2, v1, v3}, Lqj4;-><init>(Ljava/lang/String;Lep2;I)V

    .line 15
    .line 16
    .line 17
    const-string v1, "code"

    .line 18
    .line 19
    const/4 v2, 0x0

    .line 20
    invoke-virtual {v0, v1, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 21
    .line 22
    .line 23
    const-string v1, "message"

    .line 24
    .line 25
    invoke-virtual {v0, v1, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 26
    .line 27
    .line 28
    const-string v1, "error"

    .line 29
    .line 30
    const/4 v2, 0x1

    .line 31
    invoke-virtual {v0, v1, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 32
    .line 33
    .line 34
    const-string v1, "data"

    .line 35
    .line 36
    invoke-virtual {v0, v1, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 37
    .line 38
    .line 39
    sput-object v0, Lcom/picacg/network/pica/model/PicaResponse;->$cachedDescriptor:Lzi5;

    .line 40
    .line 41
    return-void
.end method