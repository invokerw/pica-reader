.method static constructor <clinit>()V
    .registers 8

    .line 1
    new-instance v0, Lcom/picacg/domain/model/RequestMode$Companion;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    invoke-direct {v0, v1}, Lcom/picacg/domain/model/RequestMode$Companion;-><init>(Ljo1;)V

    .line 5
    .line 6
    .line 7
    sput-object v0, Lcom/picacg/domain/model/RequestMode;->Companion:Lcom/picacg/domain/model/RequestMode$Companion;

    .line 8
    .line 9
    new-instance v0, Lcom/picacg/domain/model/RequestMode;

    .line 10
    .line 11
    sget-object v1, Lcom/picacg/domain/model/RouteTarget;->OFFICIAL:Lcom/picacg/domain/model/RouteTarget;

    .line 12
    .line 13
    sget-object v2, Lcom/picacg/domain/model/ResolveStrategy$SystemDns;->INSTANCE:Lcom/picacg/domain/model/ResolveStrategy$SystemDns;

    .line 14
    .line 15
    const-string v3, "official_direct"

    .line 16
    .line 17
    const-string v4, "\u5b98\u65b9\u76f4\u8fde"

    .line 18
    .line 19
    invoke-direct {v0, v3, v4, v1, v2}, Lcom/picacg/domain/model/RequestMode;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/picacg/domain/model/RouteTarget;Lcom/picacg/domain/model/ResolveStrategy;)V

    .line 20
    .line 21
    .line 22
    sput-object v0, Lcom/picacg/domain/model/RequestMode;->OFFICIAL_DIRECT:Lcom/picacg/domain/model/RequestMode;

    .line 23
    .line 24
    new-instance v3, Lcom/picacg/domain/model/RequestMode;

    .line 25
    .line 26
    const-string v4, "\u5b98\u65b9\u589e\u5f3a"

    .line 27
    .line 28
    sget-object v5, Lcom/picacg/domain/model/ResolveStrategy$FixedIps;->INSTANCE:Lcom/picacg/domain/model/ResolveStrategy$FixedIps;

    .line 29
    .line 30
    const-string v6, "official_enhanced"

    .line 31
    .line 32
    invoke-direct {v3, v6, v4, v1, v5}, Lcom/picacg/domain/model/RequestMode;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/picacg/domain/model/RouteTarget;Lcom/picacg/domain/model/ResolveStrategy;)V

    .line 33
    .line 34
    .line 35
    sput-object v3, Lcom/picacg/domain/model/RequestMode;->OFFICIAL_ENHANCED:Lcom/picacg/domain/model/RequestMode;

    .line 36
    .line 37
    new-instance v4, Lcom/picacg/domain/model/RequestMode;

    .line 38
    .line 39
    const-string v5, "\u5206\u6d411"

    .line 40
    .line 41
    sget-object v6, Lcom/picacg/domain/model/RouteTarget;->PROXY_1:Lcom/picacg/domain/model/RouteTarget;

    .line 42
    .line 43
    const-string v7, "proxy1_direct"

    .line 44
    .line 45
    invoke-direct {v4, v7, v5, v6, v2}, Lcom/picacg/domain/model/RequestMode;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/picacg/domain/model/RouteTarget;Lcom/picacg/domain/model/ResolveStrategy;)V

    .line 46
    .line 47
    .line 48
    sput-object v4, Lcom/picacg/domain/model/RequestMode;->PROXY_1_DIRECT:Lcom/picacg/domain/model/RequestMode;

    .line 49
    .line 50
    new-instance v2, Lcom/picacg/domain/model/RequestMode;

    .line 51
    .line 52
    const-string v5, "\u667a\u80fd\u4f18\u9009"

    .line 53
    .line 54
    sget-object v6, Lcom/picacg/domain/model/ResolveStrategy$MeasuredPool;->INSTANCE:Lcom/picacg/domain/model/ResolveStrategy$MeasuredPool;

    .line 55
    .line 56
    const-string v7, "smart_pool"

    .line 57
    .line 58
    invoke-direct {v2, v7, v5, v1, v6}, Lcom/picacg/domain/model/RequestMode;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/picacg/domain/model/RouteTarget;Lcom/picacg/domain/model/ResolveStrategy;)V

    .line 59
    .line 60
    .line 61
    sput-object v2, Lcom/picacg/domain/model/RequestMode;->SMART_POOL:Lcom/picacg/domain/model/RequestMode;

    .line 62
    .line 63
    filled-new-array {v0, v3, v4, v2}, [Lcom/picacg/domain/model/RequestMode;

    .line 64
    .line 65
    .line 66
    move-result-object v0

    .line 67
    invoke-static {v0}, Lpl0;->M([Ljava/lang/Object;)Ljava/util/List;

    .line 68
    .line 69
    .line 70
    move-result-object v0

    .line 71
    sput-object v0, Lcom/picacg/domain/model/RequestMode;->ALL:Ljava/util/List;

    .line 72
    .line 73
    new-instance v1, Ljava/util/ArrayList;

    .line 74
    .line 75
    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 76
    .line 77
    .line 78
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    .line 79
    .line 80
    .line 81
    move-result-object v0

    .line 82
    :cond_51
    :goto_51
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    .line 83
    .line 84
    .line 85
    move-result v2

    .line 86
    if-eqz v2, :cond_68

    .line 87
    .line 88
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 89
    .line 90
    .line 91
    move-result-object v2

    .line 92
    move-object v3, v2

    .line 93
    check-cast v3, Lcom/picacg/domain/model/RequestMode;

    .line 94
    .line 95
    invoke-virtual {v3}, Lcom/picacg/domain/model/RequestMode;->getUsesPool()Z

    .line 96
    .line 97
    .line 98
    move-result v3

    .line 99
    if-nez v3, :cond_51

    .line 100
    .line 101
    invoke-interface {v1, v2}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    .line 102
    .line 103
    .line 104
    goto :goto_51

    .line 105
    :cond_68
    sput-object v1, Lcom/picacg/domain/model/RequestMode;->SPEED_TESTED:Ljava/util/List;

    .line 106
    .line 107
    sget-object v0, Lcom/picacg/domain/model/RequestMode;->OFFICIAL_DIRECT:Lcom/picacg/domain/model/RequestMode;

    .line 108
    .line 109
    sput-object v0, Lcom/picacg/domain/model/RequestMode;->DEFAULT:Lcom/picacg/domain/model/RequestMode;

    .line 110
    .line 111
    return-void
.end method