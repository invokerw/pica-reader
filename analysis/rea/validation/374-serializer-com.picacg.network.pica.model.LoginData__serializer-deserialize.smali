.method public final deserialize(Ldn1;)Lcom/picacg/network/pica/model/LoginData;
    .registers 10

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    sget-object p0, Lcom/picacg/network/pica/model/LoginData$$serializer;->descriptor:Lzi5;

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
    if-eqz v3, :cond_26

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
    if-eq v6, v7, :cond_24

    .line 24
    .line 25
    if-nez v6, :cond_20

    .line 26
    .line 27
    invoke-interface {p1, p0, v1}, Lt91;->m(Lzi5;I)Ljava/lang/String;

    .line 28
    .line 29
    .line 30
    move-result-object v5

    .line 31
    move v4, v0

    .line 32
    goto :goto_f

    .line 33
    :cond_20
    invoke-static {v6}, Lk;->c(I)V

    .line 34
    .line 35
    .line 36
    return-object v2

    .line 37
    :cond_24
    move v3, v1

    .line 38
    goto :goto_f

    .line 39
    :cond_26
    invoke-interface {p1, p0}, Lt91;->a(Lzi5;)V

    .line 40
    .line 41
    .line 42
    new-instance p0, Lcom/picacg/network/pica/model/LoginData;

    .line 43
    .line 44
    invoke-direct {p0, v4, v5, v2}, Lcom/picacg/network/pica/model/LoginData;-><init>(ILjava/lang/String;Lfj5;)V

    .line 45
    .line 46
    .line 47
    return-object p0
.end method