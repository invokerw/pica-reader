.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/CollectionComicItem$$serializer;

    .line 2
    .line 3
    invoke-direct {v0}, Lcom/picacg/network/pica/model/CollectionComicItem$$serializer;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/picacg/network/pica/model/CollectionComicItem$$serializer;->INSTANCE:Lcom/picacg/network/pica/model/CollectionComicItem$$serializer;

    .line 7
    .line 8
    const/16 v1, 0x8

    .line 9
    .line 10
    sput v1, Lcom/picacg/network/pica/model/CollectionComicItem$$serializer;->$stable:I

    .line 11
    .line 12
    new-instance v1, Lqj4;

    .line 13
    .line 14
    const-string v2, "com.picacg.network.pica.model.CollectionComicItem"

    .line 15
    .line 16
    const/16 v3, 0xb

    .line 17
    .line 18
    invoke-direct {v1, v2, v0, v3}, Lqj4;-><init>(Ljava/lang/String;Lep2;I)V

    .line 19
    .line 20
    .line 21
    const-string v0, "_id"

    .line 22
    .line 23
    const/4 v2, 0x0

    .line 24
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 25
    .line 26
    .line 27
    const-string v0, "title"

    .line 28
    .line 29
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 30
    .line 31
    .line 32
    const-string v0, "author"

    .line 33
    .line 34
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 35
    .line 36
    .line 37
    const-string v0, "thumb"

    .line 38
    .line 39
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 40
    .line 41
    .line 42
    const-string v0, "categories"

    .line 43
    .line 44
    const/4 v2, 0x1

    .line 45
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 46
    .line 47
    .line 48
    const-string v0, "tags"

    .line 49
    .line 50
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 51
    .line 52
    .line 53
    const-string v0, "finished"

    .line 54
    .line 55
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 56
    .line 57
    .line 58
    const-string v0, "epsCount"

    .line 59
    .line 60
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 61
    .line 62
    .line 63
    const-string v0, "pagesCount"

    .line 64
    .line 65
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 66
    .line 67
    .line 68
    const-string v0, "totalViews"

    .line 69
    .line 70
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 71
    .line 72
    .line 73
    const-string v0, "totalLikes"

    .line 74
    .line 75
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 76
    .line 77
    .line 78
    sput-object v1, Lcom/picacg/network/pica/model/CollectionComicItem$$serializer;->descriptor:Lzi5;

    .line 79
    .line 80
    return-void
.end method