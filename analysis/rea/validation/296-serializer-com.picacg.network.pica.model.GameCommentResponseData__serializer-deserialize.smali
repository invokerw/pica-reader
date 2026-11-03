.method public final deserialize(Ldn1;)Lcom/picacg/network/pica/model/GameCommentResponseData;
    .registers 12

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    sget-object p0, Lcom/picacg/network/pica/model/GameCommentResponseData$$serializer;->descriptor:Lzi5;

    .line 5
    .line 6
    invoke-interface {p1, p0}, Ldn1;->c(Lzi5;)Lt91;

    .line 7
    .line 8
    .line 9
    move-result-object p1

    .line 10
    invoke-static {}, Lcom/picacg/network/pica/model/GameCommentResponseData;->access$get$childSerializers$cp()[Lkd3;

    .line 11
    .line 12
    .line 13
    move-result-object v0

    .line 14
    const/4 v1, 0x1

    .line 15
    const/4 v2, 0x0

    .line 16
    const/4 v3, 0x0

    .line 17
    move v4, v1

    .line 18
    move v5, v2

    .line 19
    move-object v6, v3

    .line 20
    move-object v7, v6

    .line 21
    :goto_14
    if-eqz v4, :cond_43

    .line 22
    .line 23
    invoke-interface {p1, p0}, Lt91;->h(Lzi5;)I

    .line 24
    .line 25
    .line 26
    move-result v8

    .line 27
    const/4 v9, -0x1

    .line 28
    if-eq v8, v9, :cond_41

    .line 29
    .line 30
    if-eqz v8, :cond_36

    .line 31
    .line 32
    if-ne v8, v1, :cond_32

    .line 33
    .line 34
    aget-object v8, v0, v1

    .line 35
    .line 36
    invoke-interface {v8}, Lkd3;->getValue()Ljava/lang/Object;

    .line 37
    .line 38
    .line 39
    move-result-object v8

    .line 40
    check-cast v8, Lca3;

    .line 41
    .line 42
    invoke-interface {p1, p0, v1, v8, v7}, Lt91;->q(Lzi5;ILca3;Ljava/lang/Object;)Ljava/lang/Object;

    .line 43
    .line 44
    .line 45
    move-result-object v7

    .line 46
    check-cast v7, Ljava/util/List;

    .line 47
    .line 48
    or-int/lit8 v5, v5, 0x2

    .line 49
    .line 50
    goto :goto_14

    .line 51
    :cond_32
    invoke-static {v8}, Lk;->c(I)V

    .line 52
    .line 53
    .line 54
    return-object v3

    .line 55
    :cond_36
    sget-object v8, Lcom/picacg/network/pica/model/GameCommentsPageData$$serializer;->INSTANCE:Lcom/picacg/network/pica/model/GameCommentsPageData$$serializer;

    .line 56
    .line 57
    invoke-interface {p1, p0, v2, v8, v6}, Lt91;->q(Lzi5;ILca3;Ljava/lang/Object;)Ljava/lang/Object;

    .line 58
    .line 59
    .line 60
    move-result-object v6

    .line 61
    check-cast v6, Lcom/picacg/network/pica/model/GameCommentsPageData;

    .line 62
    .line 63
    or-int/lit8 v5, v5, 0x1

    .line 64
    .line 65
    goto :goto_14

    .line 66
    :cond_41
    move v4, v2

    .line 67
    goto :goto_14

    .line 68
    :cond_43
    invoke-interface {p1, p0}, Lt91;->a(Lzi5;)V

    .line 69
    .line 70
    .line 71
    new-instance p0, Lcom/picacg/network/pica/model/GameCommentResponseData;

    .line 72
    .line 73
    invoke-direct {p0, v5, v6, v7, v3}, Lcom/picacg/network/pica/model/GameCommentResponseData;-><init>(ILcom/picacg/network/pica/model/GameCommentsPageData;Ljava/util/List;Lfj5;)V

    .line 74
    .line 75
    .line 76
    return-object p0
.end method