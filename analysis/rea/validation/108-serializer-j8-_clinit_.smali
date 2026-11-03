.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lj8;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lj8;->a:Lj8;

    .line 7
    .line 8
    new-instance v1, Lqj4;

    .line 9
    .line 10
    const-string v2, "com.picacg.network.pica.api.AdvancedSearchBody"

    .line 11
    .line 12
    const/4 v3, 0x3

    .line 13
    invoke-direct {v1, v2, v0, v3}, Lqj4;-><init>(Ljava/lang/String;Lep2;I)V

    .line 14
    .line 15
    .line 16
    const-string v0, "keyword"

    .line 17
    .line 18
    const/4 v2, 0x0

    .line 19
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 20
    .line 21
    .line 22
    const-string v0, "sort"

    .line 23
    .line 24
    const/4 v2, 0x1

    .line 25
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 26
    .line 27
    .line 28
    const-string v0, "categories"

    .line 29
    .line 30
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 31
    .line 32
    .line 33
    sput-object v1, Lj8;->descriptor:Lzi5;

    .line 34
    .line 35
    return-void
.end method