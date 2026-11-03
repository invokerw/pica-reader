.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lu83;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lu83;->a:Lu83;

    .line 7
    .line 8
    sget-object v0, Lkk4;->l:Lkk4;

    .line 9
    .line 10
    const/4 v1, 0x0

    .line 11
    new-array v1, v1, [Lzi5;

    .line 12
    .line 13
    new-instance v2, Ll43;

    .line 14
    .line 15
    const/4 v3, 0x6

    .line 16
    invoke-direct {v2, v3}, Ll43;-><init>(I)V

    .line 17
    .line 18
    .line 19
    const-string v3, "kotlinx.serialization.json.JsonElement"

    .line 20
    .line 21
    invoke-static {v3, v0, v1, v2}, Ltl4;->t(Ljava/lang/String;Lul4;[Lzi5;Llm2;)Lbj5;

    .line 22
    .line 23
    .line 24
    move-result-object v0

    .line 25
    sput-object v0, Lu83;->b:Lbj5;

    .line 26
    .line 27
    return-void
.end method