.method public final deserialize(Ldn1;)Lcom/picacg/network/pica/model/MyCommentsResponseData;
    .registers 10

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    sget-object p0, Lcom/picacg/network/pica/model/MyCommentsResponseData$$serializer;->descriptor:Lzi5;

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
    :goto_f
    if-eqz v3, :cond_2b

    .line 17
    .line 18
    invoke-interface {p1, p0}, Lt91;->h(Lzi5;)I

    .line 19
    .line 20
    .line 21
    move-result v6

    .line 22
    const/4 v7, -0x1

    .line 23
    if-eq v6, v7, :cond_29

    .line 24
    .line 25
    if-nez v6, :cond_25

    .line 26
    .line 27
    sget-object v4, Lcom/picacg/network/pica/model/MyCommentsPageData$$serializer;->INSTANCE:Lcom/picacg/network/pica/model/MyCommentsPageData$$serializer;

    .line 28
    .line 29
    invoke-interface {p1, p0, v1, v4, v5}, Lt91;->q(Lzi5;ILca3;Ljava/lang/Object;)Ljava/lang/Object;

    .line 30
    .line 31
    .line 32
    move-result-object v4

    .line 33
    move-object v5, v4

    .line 34
    check-cast v5, Lcom/picacg/network/pica/model/MyCommentsPageData;

    .line 35
    .line 36
    move v4, v0

    .line 37
    goto :goto_f

    .line 38
    :cond_25
    invoke-static {v6}, Lk;->c(I)V

    .line 39
    .line 40
    .line 41
    return-object v2

    .line 42
    :cond_29
    move v3, v1

    .line 43
    goto :goto_f

    .line 44
    :cond_2b
    invoke-interface {p1, p0}, Lt91;->a(Lzi5;)V

    .line 45
    .line 46
    .line 47
    new-instance p0, Lcom/picacg/network/pica/model/MyCommentsResponseData;

    .line 48
    .line 49
    invoke-direct {p0, v4, v5, v2}, Lcom/picacg/network/pica/model/MyCommentsResponseData;-><init>(ILcom/picacg/network/pica/model/MyCommentsPageData;Lfj5;)V

    .line 50
    .line 51
    .line 52
    return-object p0
.end method