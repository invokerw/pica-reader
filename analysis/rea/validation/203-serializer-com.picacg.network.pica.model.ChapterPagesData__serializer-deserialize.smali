.method public final deserialize(Ldn1;)Lcom/picacg/network/pica/model/ChapterPagesData;
    .registers 11

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    sget-object p0, Lcom/picacg/network/pica/model/ChapterPagesData$$serializer;->descriptor:Lzi5;

    .line 5
    .line 6
    invoke-interface {p1, p0}, Ldn1;->c(Lzi5;)Lt91;

    .line 7
    .line 8
    .line 9
    move-result-object p1

    .line 10
    const/4 v0, 0x1

    .line 11
    const/4 v1, 0x0

    .line 12
    const/4 v2, 0x0

    .line 13
    move v3, v0

    .line 14
    move v4, v1

    .line 15
    move-object v5, v2

    .line 16
    move-object v6, v5

    .line 17
    :goto_10
    if-eqz v3, :cond_39

    .line 18
    .line 19
    invoke-interface {p1, p0}, Lt91;->h(Lzi5;)I

    .line 20
    .line 21
    .line 22
    move-result v7

    .line 23
    const/4 v8, -0x1

    .line 24
    if-eq v7, v8, :cond_37

    .line 25
    .line 26
    if-eqz v7, :cond_2c

    .line 27
    .line 28
    if-ne v7, v0, :cond_28

    .line 29
    .line 30
    sget-object v7, Lcom/picacg/network/pica/model/EpisodeInfo$$serializer;->INSTANCE:Lcom/picacg/network/pica/model/EpisodeInfo$$serializer;

    .line 31
    .line 32
    invoke-interface {p1, p0, v0, v7, v6}, Lt91;->q(Lzi5;ILca3;Ljava/lang/Object;)Ljava/lang/Object;

    .line 33
    .line 34
    .line 35
    move-result-object v6

    .line 36
    check-cast v6, Lcom/picacg/network/pica/model/EpisodeInfo;

    .line 37
    .line 38
    or-int/lit8 v4, v4, 0x2

    .line 39
    .line 40
    goto :goto_10

    .line 41
    :cond_28
    invoke-static {v7}, Lk;->c(I)V

    .line 42
    .line 43
    .line 44
    return-object v2

    .line 45
    :cond_2c
    sget-object v7, Lcom/picacg/network/pica/model/PagesInfo$$serializer;->INSTANCE:Lcom/picacg/network/pica/model/PagesInfo$$serializer;

    .line 46
    .line 47
    invoke-interface {p1, p0, v1, v7, v5}, Lt91;->q(Lzi5;ILca3;Ljava/lang/Object;)Ljava/lang/Object;

    .line 48
    .line 49
    .line 50
    move-result-object v5

    .line 51
    check-cast v5, Lcom/picacg/network/pica/model/PagesInfo;

    .line 52
    .line 53
    or-int/lit8 v4, v4, 0x1

    .line 54
    .line 55
    goto :goto_10

    .line 56
    :cond_37
    move v3, v1

    .line 57
    goto :goto_10

    .line 58
    :cond_39
    invoke-interface {p1, p0}, Lt91;->a(Lzi5;)V

    .line 59
    .line 60
    .line 61
    new-instance p0, Lcom/picacg/network/pica/model/ChapterPagesData;

    .line 62
    .line 63
    invoke-direct {p0, v4, v5, v6, v2}, Lcom/picacg/network/pica/model/ChapterPagesData;-><init>(ILcom/picacg/network/pica/model/PagesInfo;Lcom/picacg/network/pica/model/EpisodeInfo;Lfj5;)V

    .line 64
    .line 65
    .line 66
    return-object p0
.end method