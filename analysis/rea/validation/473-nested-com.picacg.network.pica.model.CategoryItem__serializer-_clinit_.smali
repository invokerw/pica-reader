.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/CategoryItem$$serializer;

    .line 2
    .line 3
    invoke-direct {v0}, Lcom/picacg/network/pica/model/CategoryItem$$serializer;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/picacg/network/pica/model/CategoryItem$$serializer;->INSTANCE:Lcom/picacg/network/pica/model/CategoryItem$$serializer;

    .line 7
    .line 8
    const/16 v1, 0x8

    .line 9
    .line 10
    sput v1, Lcom/picacg/network/pica/model/CategoryItem$$serializer;->$stable:I

    .line 11
    .line 12
    new-instance v1, Lqj4;

    .line 13
    .line 14
    const-string v2, "com.picacg.network.pica.model.CategoryItem"

    .line 15
    .line 16
    const/4 v3, 0x7

    .line 17
    invoke-direct {v1, v2, v0, v3}, Lqj4;-><init>(Ljava/lang/String;Lep2;I)V

    .line 18
    .line 19
    .line 20
    const-string v0, "_id"

    .line 21
    .line 22
    const/4 v2, 0x1

    .line 23
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 24
    .line 25
    .line 26
    const-string v0, "title"

    .line 27
    .line 28
    const/4 v3, 0x0

    .line 29
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 30
    .line 31
    .line 32
    const-string v0, "description"

    .line 33
    .line 34
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 35
    .line 36
    .line 37
    const-string v0, "thumb"

    .line 38
    .line 39
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 40
    .line 41
    .line 42
    const-string v0, "isWeb"

    .line 43
    .line 44
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 45
    .line 46
    .line 47
    const-string v0, "active"

    .line 48
    .line 49
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 50
    .line 51
    .line 52
    const-string v0, "link"

    .line 53
    .line 54
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 55
    .line 56
    .line 57
    sput-object v1, Lcom/picacg/network/pica/model/CategoryItem$$serializer;->descriptor:Lzi5;

    .line 58
    .line 59
    return-void
.end method