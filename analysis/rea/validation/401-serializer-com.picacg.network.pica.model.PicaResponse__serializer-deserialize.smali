.method public final deserialize(Ldn1;)Lcom/picacg/network/pica/model/PicaResponse;
    .registers 14
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ldn1;",
            ")",
            "Lcom/picacg/network/pica/model/PicaResponse<",
            "TT;>;"
        }
    .end annotation

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    iget-object v0, p0, Lcom/picacg/network/pica/model/PicaResponse$$serializer;->descriptor:Lzi5;

    .line 5
    .line 6
    invoke-interface {p1, v0}, Ldn1;->c(Lzi5;)Lt91;

    .line 7
    .line 8
    .line 9
    move-result-object p1

    .line 10
    const/4 v1, 0x1

    .line 11
    const/4 v2, 0x0

    .line 12
    const/4 v3, 0x0

    .line 13
    move v4, v1

    .line 14
    move v6, v2

    .line 15
    move v7, v6

    .line 16
    move-object v8, v3

    .line 17
    move-object v9, v8

    .line 18
    move-object v10, v9

    .line 19
    :goto_12
    if-eqz v4, :cond_50

    .line 20
    .line 21
    invoke-interface {p1, v0}, Lt91;->h(Lzi5;)I

    .line 22
    .line 23
    .line 24
    move-result v5

    .line 25
    const/4 v11, -0x1

    .line 26
    if-eq v5, v11, :cond_4e

    .line 27
    .line 28
    if-eqz v5, :cond_47

    .line 29
    .line 30
    if-eq v5, v1, :cond_40

    .line 31
    .line 32
    const/4 v11, 0x2

    .line 33
    if-eq v5, v11, :cond_34

    .line 34
    .line 35
    const/4 v11, 0x3

    .line 36
    if-ne v5, v11, :cond_30

    .line 37
    .line 38
    iget-object v5, p0, Lcom/picacg/network/pica/model/PicaResponse$$serializer;->typeSerial0:Lca3;

    .line 39
    .line 40
    check-cast v5, Lca3;

    .line 41
    .line 42
    invoke-interface {p1, v0, v11, v5, v10}, Lt91;->w(Lzi5;ILca3;Ljava/lang/Object;)Ljava/lang/Object;

    .line 43
    .line 44
    .line 45
    move-result-object v10

    .line 46
    or-int/lit8 v6, v6, 0x8

    .line 47
    .line 48
    goto :goto_12

    .line 49
    :cond_30
    invoke-static {v5}, Lk;->c(I)V

    .line 50
    .line 51
    .line 52
    return-object v3

    .line 53
    :cond_34
    sget-object v5, Lix5;->a:Lix5;

    .line 54
    .line 55
    invoke-interface {p1, v0, v11, v5, v9}, Lt91;->w(Lzi5;ILca3;Ljava/lang/Object;)Ljava/lang/Object;

    .line 56
    .line 57
    .line 58
    move-result-object v5

    .line 59
    move-object v9, v5

    .line 60
    check-cast v9, Ljava/lang/String;

    .line 61
    .line 62
    or-int/lit8 v6, v6, 0x4

    .line 63
    .line 64
    goto :goto_12

    .line 65
    :cond_40
    invoke-interface {p1, v0, v1}, Lt91;->m(Lzi5;I)Ljava/lang/String;

    .line 66
    .line 67
    .line 68
    move-result-object v8

    .line 69
    or-int/lit8 v6, v6, 0x2

    .line 70
    .line 71
    goto :goto_12

    .line 72
    :cond_47
    invoke-interface {p1, v0, v2}, Lt91;->r(Lzi5;I)I

    .line 73
    .line 74
    .line 75
    move-result v7

    .line 76
    or-int/lit8 v6, v6, 0x1

    .line 77
    .line 78
    goto :goto_12

    .line 79
    :cond_4e
    move v4, v2

    .line 80
    goto :goto_12

    .line 81
    :cond_50
    invoke-interface {p1, v0}, Lt91;->a(Lzi5;)V

    .line 82
    .line 83
    .line 84
    new-instance v5, Lcom/picacg/network/pica/model/PicaResponse;

    .line 85
    .line 86
    const/4 v11, 0x0

    .line 87
    invoke-direct/range {v5 .. v11}, Lcom/picacg/network/pica/model/PicaResponse;-><init>(IILjava/lang/String;Ljava/lang/String;Ljava/lang/Object;Lfj5;)V

    .line 88
    .line 89
    .line 90
    return-object v5
.end method