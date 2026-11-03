.method static constructor <clinit>()V
    .registers 10

    .line 1
    new-instance v0, La83;

    .line 2
    .line 3
    new-instance v1, Li83;

    .line 4
    .line 5
    const/4 v8, 0x1

    .line 6
    sget-object v9, Lzp0;->k:Lzp0;

    .line 7
    .line 8
    const/4 v2, 0x0

    .line 9
    const/4 v3, 0x0

    .line 10
    const/4 v4, 0x0

    .line 11
    const/4 v5, 0x1

    .line 12
    const-string v6, "    "

    .line 13
    .line 14
    const-string v7, "type"

    .line 15
    .line 16
    invoke-direct/range {v1 .. v9}, Li83;-><init>(ZZZZLjava/lang/String;Ljava/lang/String;ZLzp0;)V

    .line 17
    .line 18
    .line 19
    sget-object v2, Lx34;->n:Lmv2;

    .line 20
    .line 21
    invoke-direct {v0, v1, v2}, Lb83;-><init>(Li83;Lmv2;)V

    .line 22
    .line 23
    .line 24
    sput-object v0, Lb83;->d:La83;

    .line 25
    .line 26
    return-void
.end method