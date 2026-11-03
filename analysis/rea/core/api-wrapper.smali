.method public final a(Lom2;Lne1;)Ljava/lang/Object;
    .registers 9

    .line 1
    instance-of v0, p2, Lzf4;

    .line 2
    .line 3
    if-eqz v0, :cond_13

    .line 4
    .line 5
    move-object v0, p2

    .line 6
    check-cast v0, Lzf4;

    .line 7
    .line 8
    iget v1, v0, Lzf4;->l:I

    .line 9
    .line 10
    const/high16 v2, -0x80000000

    .line 11
    .line 12
    and-int v3, v1, v2

    .line 13
    .line 14
    if-eqz v3, :cond_13

    .line 15
    .line 16
    sub-int/2addr v1, v2

    .line 17
    iput v1, v0, Lzf4;->l:I

    .line 18
    .line 19
    goto :goto_18

    .line 20
    :cond_13
    new-instance v0, Lzf4;

    .line 21
    .line 22
    invoke-direct {v0, p0, p2}, Lzf4;-><init>(Ldg4;Lne1;)V

    .line 23
    .line 24
    .line 25
    :goto_18
    iget-object p2, v0, Lzf4;->j:Ljava/lang/Object;

    .line 26
    .line 27
    iget v1, v0, Lzf4;->l:I

    .line 28
    .line 29
    const/4 v2, 0x2

    .line 30
    const/4 v3, 0x1

    .line 31
    const/4 v4, 0x0

    .line 32
    sget-object v5, Ljg1;->i:Ljg1;

    .line 33
    .line 34
    if-eqz v1, :cond_39

    .line 35
    .line 36
    if-eq v1, v3, :cond_31

    .line 37
    .line 38
    if-ne v1, v2, :cond_2b

    .line 39
    .line 40
    invoke-static {p2}, Lsl4;->N(Ljava/lang/Object;)V

    .line 41
    .line 42
    .line 43
    goto :goto_5d

    .line 44
    :cond_2b
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    .line 45
    .line 46
    invoke-static {p0}, Lmz;->h(Ljava/lang/String;)V

    .line 47
    .line 48
    .line 49
    return-object v4

    .line 50
    :cond_31
    iget-object p1, v0, Lzf4;->i:Lyz5;

    .line 51
    .line 52
    check-cast p1, Lom2;

    .line 53
    .line 54
    invoke-static {p2}, Lsl4;->N(Ljava/lang/Object;)V

    .line 55
    .line 56
    .line 57
    goto :goto_4c

    .line 58
    :cond_39
    invoke-static {p2}, Lsl4;->N(Ljava/lang/Object;)V

    .line 59
    .line 60
    .line 61
    move-object p2, p1

    .line 62
    check-cast p2, Lyz5;

    .line 63
    .line 64
    iput-object p2, v0, Lzf4;->i:Lyz5;

    .line 65
    .line 66
    iput v3, v0, Lzf4;->l:I

    .line 67
    .line 68
    iget-object p2, p0, Ldg4;->b:Lv55;

    .line 69
    .line 70
    invoke-virtual {p2, v0}, Lv55;->a(Lpe1;)Ljava/lang/Object;

    .line 71
    .line 72
    .line 73
    move-result-object p2

    .line 74
    if-ne p2, v5, :cond_4c

    .line 75
    .line 76
    goto :goto_5c

    .line 77
    :cond_4c
    :goto_4c
    new-instance p2, Lag4;

    .line 78
    .line 79
    const/4 v1, 0x0

    .line 80
    invoke-direct {p2, p1, p0, v4, v1}, Lag4;-><init>(Lom2;Ldg4;Lne1;I)V

    .line 81
    .line 82
    .line 83
    iput-object v4, v0, Lzf4;->i:Lyz5;

    .line 84
    .line 85
    iput v2, v0, Lzf4;->l:I

    .line 86
    .line 87
    invoke-virtual {p0, p2, v0}, Ldg4;->d(Llm2;Lpe1;)Ljava/lang/Object;

    .line 88
    .line 89
    .line 90
    move-result-object p2

    .line 91
    if-ne p2, v5, :cond_5d

    .line 92
    .line 93
    :goto_5c
    return-object v5

    .line 94
    :cond_5d
    :goto_5d
    check-cast p2, Lcom/picacg/network/pica/model/PicaResponse;

    .line 95
    .line 96
    invoke-static {p2}, Ldg4;->c(Lcom/picacg/network/pica/model/PicaResponse;)V

    .line 97
    .line 98
    .line 99
    invoke-virtual {p2}, Lcom/picacg/network/pica/model/PicaResponse;->getData()Ljava/lang/Object;

    .line 100
    .line 101
    .line 102
    move-result-object p0

    .line 103
    if-eqz p0, :cond_69

    .line 104
    .line 105
    return-object p0

    .line 106
    :cond_69
    new-instance p0, Lwg4;

    .line 107
    .line 108
    const-string p1, "\u54cd\u5e94 data \u4e3a null"

    .line 109
    .line 110
    invoke-direct {p0, p1, v4}, Ljava/lang/Exception;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 111
    .line 112
    .line 113
    throw p0
.end method