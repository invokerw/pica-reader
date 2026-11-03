.method public static final c(Leo3;Lvn3;Lpe1;)Ljava/lang/Object;
    .registers 23

    .line 1
    move-object/from16 v1, p0

    .line 2
    .line 3
    move-object/from16 v0, p1

    .line 4
    .line 5
    move-object/from16 v2, p2

    .line 6
    .line 7
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 8
    .line 9
    .line 10
    instance-of v3, v2, Ldo3;

    .line 11
    .line 12
    if-eqz v3, :cond_1d

    .line 13
    .line 14
    move-object v3, v2

    .line 15
    check-cast v3, Ldo3;

    .line 16
    .line 17
    iget v4, v3, Ldo3;->m:I

    .line 18
    .line 19
    const/high16 v5, -0x80000000

    .line 20
    .line 21
    and-int v6, v4, v5

    .line 22
    .line 23
    if-eqz v6, :cond_1d

    .line 24
    .line 25
    sub-int/2addr v4, v5

    .line 26
    iput v4, v3, Ldo3;->m:I

    .line 27
    .line 28
    :goto_1b
    move-object v6, v3

    .line 29
    goto :goto_23

    .line 30
    :cond_1d
    new-instance v3, Ldo3;

    .line 31
    .line 32
    invoke-direct {v3, v1, v2}, Ldo3;-><init>(Leo3;Lpe1;)V

    .line 33
    .line 34
    .line 35
    goto :goto_1b

    .line 36
    :goto_23
    iget-object v2, v6, Ldo3;->k:Ljava/lang/Object;

    .line 37
    .line 38
    iget v3, v6, Ldo3;->m:I

    .line 39
    .line 40
    const/4 v4, 0x1

    .line 41
    const/4 v5, 0x2

    .line 42
    const/4 v7, 0x0

    .line 43
    sget-object v8, Ljg1;->i:Ljg1;

    .line 44
    .line 45
    if-eqz v3, :cond_52

    .line 46
    .line 47
    if-eq v3, v4, :cond_40

    .line 48
    .line 49
    if-ne v3, v5, :cond_3a

    .line 50
    .line 51
    :try_start_32
    invoke-static {v2}, Lsl4;->N(Ljava/lang/Object;)V
    :try_end_35
    .catch Ljava/lang/Exception; {:try_start_32 .. :try_end_35} :catch_37

    .line 52
    .line 53
    .line 54
    goto/16 :goto_c2

    .line 55
    .line 56
    :catch_37
    move-exception v0

    .line 57
    goto/16 :goto_bf

    .line 58
    .line 59
    :cond_3a
    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    .line 60
    .line 61
    invoke-static {v0}, Lmz;->h(Ljava/lang/String;)V

    .line 62
    .line 63
    .line 64
    return-object v7

    .line 65
    :cond_40
    iget-object v0, v6, Ldo3;->j:Ljava/lang/String;

    .line 66
    .line 67
    iget-object v3, v6, Ldo3;->i:Lvn3;

    .line 68
    .line 69
    :try_start_44
    invoke-static {v2}, Lsl4;->N(Ljava/lang/Object;)V

    .line 70
    .line 71
    .line 72
    check-cast v2, Lz65;

    .line 73
    .line 74
    iget-object v2, v2, Lz65;->i:Ljava/lang/Object;
    :try_end_4b
    .catch Ljava/lang/Exception; {:try_start_44 .. :try_end_4b} :catch_37

    .line 75
    .line 76
    move-object/from16 v19, v2

    .line 77
    .line 78
    move-object v2, v0

    .line 79
    move-object v0, v3

    .line 80
    move-object/from16 v3, v19

    .line 81
    .line 82
    goto :goto_71

    .line 83
    :cond_52
    invoke-static {v2}, Lsl4;->N(Ljava/lang/Object;)V

    .line 84
    .line 85
    .line 86
    iget-object v2, v0, Lvn3;->a:Ljava/lang/String;

    .line 87
    .line 88
    const-string v3, ""

    .line 89
    .line 90
    const/4 v9, 0x0

    .line 91
    const-string v10, "@"

    .line 92
    .line 93
    invoke-static {v2, v10, v3, v9}, Lrx5;->d0(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Ljava/lang/String;

    .line 94
    .line 95
    .line 96
    move-result-object v2

    .line 97
    :try_start_60
    iget-object v3, v1, Leo3;->a:Lhi6;

    .line 98
    .line 99
    iget-object v9, v0, Lvn3;->b:Ljava/lang/String;

    .line 100
    .line 101
    iput-object v0, v6, Ldo3;->i:Lvn3;

    .line 102
    .line 103
    iput-object v2, v6, Ldo3;->j:Ljava/lang/String;

    .line 104
    .line 105
    iput v4, v6, Ldo3;->m:I

    .line 106
    .line 107
    invoke-virtual {v3, v2, v9, v6}, Lhi6;->c(Ljava/lang/String;Ljava/lang/String;Lpe1;)Ljava/lang/Object;

    .line 108
    .line 109
    .line 110
    move-result-object v3

    .line 111
    if-ne v3, v8, :cond_71

    .line 112
    .line 113
    goto :goto_ad

    .line 114
    :cond_71
    :goto_71
    instance-of v4, v3, Ly65;

    .line 115
    .line 116
    if-nez v4, :cond_ae

    .line 117
    .line 118
    iget-object v3, v1, Leo3;->f:Ljw5;

    .line 119
    .line 120
    :cond_77
    invoke-virtual {v3}, Ljw5;->getValue()Ljava/lang/Object;

    .line 121
    .line 122
    .line 123
    move-result-object v4

    .line 124
    move-object v9, v4

    .line 125
    check-cast v9, Lvn3;

    .line 126
    .line 127
    const/16 v17, 0x0

    .line 128
    .line 129
    const/16 v18, 0x7f

    .line 130
    .line 131
    const/4 v10, 0x0

    .line 132
    const/4 v11, 0x0

    .line 133
    const/4 v12, 0x0

    .line 134
    const/4 v13, 0x0

    .line 135
    const/4 v14, 0x0

    .line 136
    const/4 v15, 0x0

    .line 137
    const/16 v16, 0x0

    .line 138
    .line 139
    invoke-static/range {v9 .. v18}, Lvn3;->a(Lvn3;Ljava/lang/String;Ljava/lang/String;Lsf6;Lsf6;ZZZZI)Lvn3;

    .line 140
    .line 141
    .line 142
    move-result-object v9

    .line 143
    invoke-virtual {v3, v4, v9}, Ljw5;->j(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 144
    .line 145
    .line 146
    move-result v4

    .line 147
    if-eqz v4, :cond_77

    .line 148
    .line 149
    iget-object v3, v0, Lvn3;->b:Ljava/lang/String;

    .line 150
    .line 151
    iget-boolean v4, v0, Lvn3;->g:Z

    .line 152
    .line 153
    new-instance v0, Lsf6;

    .line 154
    .line 155
    const v9, 0x7f0f0472

    .line 156
    .line 157
    .line 158
    invoke-direct {v0, v9}, Lsf6;-><init>(I)V

    .line 159
    .line 160
    .line 161
    iput-object v7, v6, Ldo3;->i:Lvn3;

    .line 162
    .line 163
    iput-object v7, v6, Ldo3;->j:Ljava/lang/String;

    .line 164
    .line 165
    iput v5, v6, Ldo3;->m:I

    .line 166
    .line 167
    move-object v5, v0

    .line 168
    invoke-virtual/range {v1 .. v6}, Leo3;->f(Ljava/lang/String;Ljava/lang/String;ZLsf6;Lpe1;)Ljava/lang/Object;

    .line 169
    .line 170
    .line 171
    move-result-object v0

    .line 172
    if-ne v0, v8, :cond_c2

    .line 173
    .line 174
    :goto_ad
    return-object v8

    .line 175
    :cond_ae
    invoke-static {v3}, Lz65;->a(Ljava/lang/Object;)Ljava/lang/Throwable;

    .line 176
    .line 177
    .line 178
    move-result-object v0

    .line 179
    if-nez v0, :cond_bb

    .line 180
    .line 181
    new-instance v0, Ljava/lang/Exception;

    .line 182
    .line 183
    const-string v2, "Unknown error"

    .line 184
    .line 185
    invoke-direct {v0, v2}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    .line 186
    .line 187
    .line 188
    :cond_bb
    invoke-virtual {v1, v0}, Leo3;->e(Ljava/lang/Throwable;)V
    :try_end_be
    .catch Ljava/lang/Exception; {:try_start_60 .. :try_end_be} :catch_37

    .line 189
    .line 190
    .line 191
    goto :goto_c2

    .line 192
    :goto_bf
    invoke-virtual {v1, v0}, Leo3;->e(Ljava/lang/Throwable;)V

    .line 193
    .line 194
    .line 195
    :cond_c2
    :goto_c2
    sget-object v0, Ldg6;->a:Ldg6;

    .line 196
    .line 197
    return-object v0
.end method