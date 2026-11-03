.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lto5;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lto5;->a:Lto5;

    .line 7
    .line 8
    new-instance v1, Lqj4;

    .line 9
    .line 10
    const-string v2, "com.picacg.network.pica.api.SignInRequest"

    .line 11
    .line 12
    const/4 v3, 0x2

    .line 13
    invoke-direct {v1, v2, v0, v3}, Lqj4;-><init>(Ljava/lang/String;Lep2;I)V

    .line 14
    .line 15
    .line 16
    const-string v0, "email"

    .line 17
    .line 18
    const/4 v2, 0x0

    .line 19
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 20
    .line 21
    .line 22
    const-string v0, "password"

    .line 23
    .line 24
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 25
    .line 26
    .line 27
    sput-object v1, Lto5;->descriptor:Lzi5;

    .line 28
    .line 29
    return-void
.end method