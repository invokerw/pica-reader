.method static constructor <clinit>()V
    .registers 4

    .line 1
    const-string v0, "diwodiwo.xyz"

    .line 2
    .line 3
    const-string v1, "go2778.com"

    .line 4
    .line 5
    const-string v2, "picacomic.com"

    .line 6
    .line 7
    const-string v3, "manhuabika.com"

    .line 8
    .line 9
    filled-new-array {v2, v3, v0, v1}, [Ljava/lang/String;

    .line 10
    .line 11
    .line 12
    move-result-object v0

    .line 13
    invoke-static {v0}, Lpl0;->M([Ljava/lang/Object;)Ljava/util/List;

    .line 14
    .line 15
    .line 16
    move-result-object v0

    .line 17
    sput-object v0, Lqy2;->a:Ljava/util/List;

    .line 18
    .line 19
    const-string v0, "/comics/"

    .line 20
    .line 21
    const-string v1, "/users/"

    .line 22
    .line 23
    const-string v2, "/api/"

    .line 24
    .line 25
    const-string v3, "/auth/"

    .line 26
    .line 27
    filled-new-array {v2, v3, v0, v1}, [Ljava/lang/String;

    .line 28
    .line 29
    .line 30
    move-result-object v0

    .line 31
    invoke-static {v0}, Lpl0;->M([Ljava/lang/Object;)Ljava/util/List;

    .line 32
    .line 33
    .line 34
    move-result-object v0

    .line 35
    sput-object v0, Lqy2;->b:Ljava/util/List;

    .line 36
    .line 37
    return-void
.end method