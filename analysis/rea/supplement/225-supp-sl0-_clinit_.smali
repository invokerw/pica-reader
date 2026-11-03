.method static constructor <clinit>()V
    .registers 3

    .line 1
    new-instance v0, Ljava/util/ArrayList;

    .line 2
    .line 3
    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 4
    .line 5
    .line 6
    new-instance v1, Lsl0;

    .line 7
    .line 8
    invoke-static {v0}, Lnr0;->c1(Ljava/lang/Iterable;)Ljava/util/Set;

    .line 9
    .line 10
    .line 11
    move-result-object v0

    .line 12
    const/4 v2, 0x0

    .line 13
    invoke-direct {v1, v0, v2}, Lsl0;-><init>(Ljava/util/Set;Lrl0;)V

    .line 14
    .line 15
    .line 16
    sput-object v1, Lsl0;->c:Lsl0;

    .line 17
    .line 18
    return-void
.end method