.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/Announcement$$serializer;

    .line 2
    .line 3
    invoke-direct {v0}, Lcom/picacg/network/pica/model/Announcement$$serializer;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/picacg/network/pica/model/Announcement$$serializer;->INSTANCE:Lcom/picacg/network/pica/model/Announcement$$serializer;

    .line 7
    .line 8
    const/16 v1, 0x8

    .line 9
    .line 10
    sput v1, Lcom/picacg/network/pica/model/Announcement$$serializer;->$stable:I

    .line 11
    .line 12
    new-instance v1, Lqj4;

    .line 13
    .line 14
    const-string v2, "com.picacg.network.pica.model.Announcement"

    .line 15
    .line 16
    const/4 v3, 0x4

    .line 17
    invoke-direct {v1, v2, v0, v3}, Lqj4;-><init>(Ljava/lang/String;Lep2;I)V

    .line 18
    .line 19
    .line 20
    const-string v0, "_id"

    .line 21
    .line 22
    const/4 v2, 0x0

    .line 23
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 24
    .line 25
    .line 26
    const-string v0, "title"

    .line 27
    .line 28
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 29
    .line 30
    .line 31
    const-string v0, "content"

    .line 32
    .line 33
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 34
    .line 35
    .line 36
    const-string v0, "thumb"

    .line 37
    .line 38
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 39
    .line 40
    .line 41
    sput-object v1, Lcom/picacg/network/pica/model/Announcement$$serializer;->descriptor:Lzi5;

    .line 42
    .line 43
    return-void
.end method