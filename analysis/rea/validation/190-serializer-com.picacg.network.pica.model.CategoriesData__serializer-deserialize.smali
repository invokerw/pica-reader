.method public final deserialize(Ldn1;)Lcom/picacg/network/pica/model/CategoriesData;
    .registers 11

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    sget-object p0, Lcom/picacg/network/pica/model/CategoriesData$$serializer;->descriptor:Lzi5;

    .line 5
    .line 6
    invoke-interface {p1, p0}, Ldn1;->c(Lzi5;)Lt91;

    .line 7
    .line 8
    .line 9
    move-result-object p1

    .line 10
    invoke-static {}, Lcom/picacg/network/pica/model/CategoriesData;->access$get$childSerializers$cp()[Lkd3;

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
    :goto_13
    if-eqz v4, :cond_35

    .line 21
    .line 22
    invoke-interface {p1, p0}, Lt91;->h(Lzi5;)I

    .line 23
    .line 24
    .line 25
    move-result v7

    .line 26
    const/4 v8, -0x1

    .line 27
    if-eq v7, v8, :cond_33

    .line 28
    .line 29
    if-nez v7, :cond_2f

    .line 30
    .line 31
    aget-object v5, v0, v2

    .line 32
    .line 33
    invoke-interface {v5}, Lkd3;->getValue()Ljava/lang/Object;

    .line 34
    .line 35
    .line 36
    move-result-object v5

    .line 37
    check-cast v5, Lca3;

    .line 38
    .line 39
    invoke-interface {p1, p0, v2, v5, v6}, Lt91;->q(Lzi5;ILca3;Ljava/lang/Object;)Ljava/lang/Object;

    .line 40
    .line 41
    .line 42
    move-result-object v5

    .line 43
    move-object v6, v5

    .line 44
    check-cast v6, Ljava/util/List;

    .line 45
    .line 46
    move v5, v1

    .line 47
    goto :goto_13

    .line 48
    :cond_2f
    invoke-static {v7}, Lk;->c(I)V

    .line 49
    .line 50
    .line 51
    return-object v3

    .line 52
    :cond_33
    move v4, v2

    .line 53
    goto :goto_13

    .line 54
    :cond_35
    invoke-interface {p1, p0}, Lt91;->a(Lzi5;)V

    .line 55
    .line 56
    .line 57
    new-instance p0, Lcom/picacg/network/pica/model/CategoriesData;

    .line 58
    .line 59
    invoke-direct {p0, v5, v6, v3}, Lcom/picacg/network/pica/model/CategoriesData;-><init>(ILjava/util/List;Lfj5;)V

    .line 60
    .line 61
    .line 62
    return-object p0
.end method