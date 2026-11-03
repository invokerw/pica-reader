.method public final b(Lom2;Lne1;)Ljava/lang/Object;
    .registers 9

    .line 1
    instance-of v0, p2, Lbg4;

    .line 2
    .line 3
    if-eqz v0, :cond_13

    .line 4
    .line 5
    move-object v0, p2

    .line 6
    check-cast v0, Lbg4;

    .line 7
    .line 8
    iget v1, v0, Lbg4;->l:I

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
    iput v1, v0, Lbg4;->l:I

    .line 18
    .line 19
    goto :goto_18

    .line 20
    :cond_13
    new-instance v0, Lbg4;

    .line 21
    .line 22
    invoke-direct {v0, p0, p2}, Lbg4;-><init>(Ldg4;Lne1;)V

    .line 23
    .line 24
    .line 25
    :goto_18
    iget-object p2, v0, Lbg4;->j:Ljava/lang/Object;

    .line 26
    .line 27
    iget v1, v0, Lbg4;->l:I

    .line 28
    .line 29
    const/4 v2, 0x0

    .line 30
    const/4 v3, 0x2

    .line 31
    const/4 v4, 0x1

    .line 32
    sget-object v5, Ljg1;->i:Ljg1;

    .line 33
    .line 34
    if-eqz v1, :cond_39

    .line 35
    .line 36
    if-eq v1, v4, :cond_31

    .line 37
    .line 38
    if-ne v1, v3, :cond_2b

    .line 39
    .line 40
    invoke-static {p2}, Lsl4;->N(Ljava/lang/Object;)V

    .line 41
    .line 42
    .line 43
    goto :goto_5c

    .line 44
    :cond_2b
    const-string p0, "call to \'resume\' before \'invoke\' with coroutine"

    .line 45
    .line 46
    invoke-static {p0}, Lmz;->h(Ljava/lang/String;)V

    .line 47
    .line 48
    .line 49
    return-object v2

    .line 50
    :cond_31
    iget-object p1, v0, Lbg4;->i:Lyz5;

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
    iput-object p2, v0, Lbg4;->i:Lyz5;

    .line 65
    .line 66
    iput v4, v0, Lbg4;->l:I

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
    goto :goto_5b

    .line 77
    :cond_4c
    :goto_4c
    new-instance p2, Lag4;

    .line 78
    .line 79
    invoke-direct {p2, p1, p0, v2, v4}, Lag4;-><init>(Lom2;Ldg4;Lne1;I)V

    .line 80
    .line 81
    .line 82
    iput-object v2, v0, Lbg4;->i:Lyz5;

    .line 83
    .line 84
    iput v3, v0, Lbg4;->l:I

    .line 85
    .line 86
    invoke-virtual {p0, p2, v0}, Ldg4;->d(Llm2;Lpe1;)Ljava/lang/Object;

    .line 87
    .line 88
    .line 89
    move-result-object p2

    .line 90
    if-ne p2, v5, :cond_5c

    .line 91
    .line 92
    :goto_5b
    return-object v5

    .line 93
    :cond_5c
    :goto_5c
    check-cast p2, Lcom/picacg/network/pica/model/PicaResponse;

    .line 94
    .line 95
    invoke-static {p2}, Ldg4;->c(Lcom/picacg/network/pica/model/PicaResponse;)V

    .line 96
    .line 97
    .line 98
    sget-object p0, Ldg6;->a:Ldg6;

    .line 99
    .line 100
    return-object p0
.end method