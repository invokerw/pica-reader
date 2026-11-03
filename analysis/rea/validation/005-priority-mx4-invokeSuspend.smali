.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 19

    .line 1
    move-object/from16 v4, p0

    .line 2
    .line 3
    iget v0, v4, Lmx4;->i:I

    .line 4
    .line 5
    const-string v1, "ReadingHistoryVM"

    .line 6
    .line 7
    const/4 v2, 0x4

    .line 8
    const-string v3, ". Must be one of: "

    .line 9
    .line 10
    const/4 v5, 0x2

    .line 11
    const/4 v6, 0x0

    .line 12
    const-string v7, "call to \'resume\' before \'invoke\' with coroutine"

    .line 13
    .line 14
    const/4 v8, 0x1

    .line 15
    const/4 v9, 0x0

    .line 16
    packed-switch v0, :pswitch_data_9c0

    .line 17
    .line 18
    .line 19
    sget-object v0, Ljg1;->i:Ljg1;

    .line 20
    .line 21
    iget v1, v4, Lmx4;->j:I

    .line 22
    .line 23
    if-eqz v1, :cond_22

    .line 24
    .line 25
    if-ne v1, v8, :cond_1e

    .line 26
    .line 27
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 28
    .line 29
    .line 30
    goto :goto_35

    .line 31
    :cond_1e
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 32
    .line 33
    .line 34
    goto :goto_37

    .line 35
    :cond_22
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 36
    .line 37
    .line 38
    iget-object v1, v4, Lmx4;->k:Ljava/lang/Object;

    .line 39
    .line 40
    iget-object v2, v4, Lmx4;->l:Ljava/lang/Object;

    .line 41
    .line 42
    check-cast v2, Ldg2;

    .line 43
    .line 44
    iput v8, v4, Lmx4;->j:I

    .line 45
    .line 46
    invoke-interface {v2, v1, v4}, Ldg2;->emit(Ljava/lang/Object;Lne1;)Ljava/lang/Object;

    .line 47
    .line 48
    .line 49
    move-result-object v1

    .line 50
    if-ne v1, v0, :cond_35

    .line 51
    .line 52
    move-object v9, v0

    .line 53
    goto :goto_37

    .line 54
    :cond_35
    :goto_35
    sget-object v9, Ldg6;->a:Ldg6;

    .line 55
    .line 56
    :goto_37
    return-object v9

    .line 57
    :pswitch_38
    invoke-direct/range {p0 .. p1}, Lmx4;->j(Ljava/lang/Object;)Ljava/lang/Object;

    .line 58
    .line 59
    .line 60
    move-result-object v0

    .line 61
    return-object v0

    .line 62
    :pswitch_3d
    invoke-direct/range {p0 .. p1}, Lmx4;->i(Ljava/lang/Object;)Ljava/lang/Object;

    .line 63
    .line 64
    .line 65
    move-result-object v0

    .line 66
    return-object v0

    .line 67
    :pswitch_42
    sget-object v6, Ljg1;->i:Ljg1;

    .line 68
    .line 69
    iget v0, v4, Lmx4;->j:I

    .line 70
    .line 71
    if-eqz v0, :cond_52

    .line 72
    .line 73
    if-ne v0, v8, :cond_4e

    .line 74
    .line 75
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 76
    .line 77
    .line 78
    goto :goto_74

    .line 79
    :cond_4e
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 80
    .line 81
    .line 82
    goto :goto_76

    .line 83
    :cond_52
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 84
    .line 85
    .line 86
    iget-object v0, v4, Lmx4;->k:Ljava/lang/Object;

    .line 87
    .line 88
    check-cast v0, Llh0;

    .line 89
    .line 90
    iget-object v0, v0, Llh0;->c:Ljava/lang/Object;

    .line 91
    .line 92
    check-cast v0, Lfi;

    .line 93
    .line 94
    new-instance v1, Ljava/lang/Float;

    .line 95
    .line 96
    const/4 v2, 0x0

    .line 97
    invoke-direct {v1, v2}, Ljava/lang/Float;-><init>(F)V

    .line 98
    .line 99
    .line 100
    iget-object v2, v4, Lmx4;->l:Ljava/lang/Object;

    .line 101
    .line 102
    check-cast v2, Ljj;

    .line 103
    .line 104
    iput v8, v4, Lmx4;->j:I

    .line 105
    .line 106
    const/4 v3, 0x0

    .line 107
    const/16 v5, 0xc

    .line 108
    .line 109
    invoke-static/range {v0 .. v5}, Lfi;->c(Lfi;Ljava/lang/Object;Ljj;Llm2;Lne1;I)Ljava/lang/Object;

    .line 110
    .line 111
    .line 112
    move-result-object v0

    .line 113
    if-ne v0, v6, :cond_74

    .line 114
    .line 115
    move-object v9, v6

    .line 116
    goto :goto_76

    .line 117
    :cond_74
    :goto_74
    sget-object v9, Ldg6;->a:Ldg6;

    .line 118
    .line 119
    :goto_76
    return-object v9

    .line 120
    :pswitch_77
    sget-object v0, Ljg1;->i:Ljg1;

    .line 121
    .line 122
    iget v1, v4, Lmx4;->j:I

    .line 123
    .line 124
    if-eqz v1, :cond_88

    .line 125
    .line 126
    if-eq v1, v8, :cond_83

    .line 127
    .line 128
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 129
    .line 130
    .line 131
    goto :goto_a3

    .line 132
    :cond_83
    invoke-static/range {p1 .. p1}, Lud2;->c(Ljava/lang/Object;)Lq51;

    .line 133
    .line 134
    .line 135
    move-result-object v0

    .line 136
    throw v0

    .line 137
    :cond_88
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 138
    .line 139
    .line 140
    iget-object v1, v4, Lmx4;->k:Ljava/lang/Object;

    .line 141
    .line 142
    check-cast v1, Ldg2;

    .line 143
    .line 144
    new-instance v2, Ly25;

    .line 145
    .line 146
    invoke-direct {v2}, Ljava/lang/Object;-><init>()V

    .line 147
    .line 148
    .line 149
    iget-object v3, v4, Lmx4;->l:Ljava/lang/Object;

    .line 150
    .line 151
    check-cast v3, Laz5;

    .line 152
    .line 153
    new-instance v5, Ld1;

    .line 154
    .line 155
    invoke-direct {v5, v2, v1}, Ld1;-><init>(Ly25;Ldg2;)V

    .line 156
    .line 157
    .line 158
    iput v8, v4, Lmx4;->j:I

    .line 159
    .line 160
    invoke-virtual {v3, v5, v4}, Ldm5;->collect(Ldg2;Lne1;)Ljava/lang/Object;

    .line 161
    .line 162
    .line 163
    move-object v9, v0

    .line 164
    :goto_a3
    return-object v9

    .line 165
    :pswitch_a4
    sget-object v6, Ljg1;->i:Ljg1;

    .line 166
    .line 167
    iget v0, v4, Lmx4;->j:I

    .line 168
    .line 169
    if-eqz v0, :cond_b4

    .line 170
    .line 171
    if-ne v0, v8, :cond_b0

    .line 172
    .line 173
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 174
    .line 175
    .line 176
    goto :goto_e1

    .line 177
    :cond_b0
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 178
    .line 179
    .line 180
    goto :goto_e3

    .line 181
    :cond_b4
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 182
    .line 183
    .line 184
    iget-object v0, v4, Lmx4;->k:Ljava/lang/Object;

    .line 185
    .line 186
    check-cast v0, Lfi;

    .line 187
    .line 188
    iget-object v1, v4, Lmx4;->l:Ljava/lang/Object;

    .line 189
    .line 190
    check-cast v1, Li95;

    .line 191
    .line 192
    iget-wide v1, v1, Li95;->c:J

    .line 193
    .line 194
    long-to-float v1, v1

    .line 195
    new-instance v2, Ljava/lang/Float;

    .line 196
    .line 197
    invoke-direct {v2, v1}, Ljava/lang/Float;-><init>(F)V

    .line 198
    .line 199
    .line 200
    const/16 v1, 0x190

    .line 201
    .line 202
    sget-object v3, Ln12;->a:Lph1;

    .line 203
    .line 204
    invoke-static {v1, v5, v3}, Lu04;->U(IILl12;)Lpd6;

    .line 205
    .line 206
    .line 207
    move-result-object v1

    .line 208
    iput v8, v4, Lmx4;->j:I

    .line 209
    .line 210
    const/4 v3, 0x0

    .line 211
    const/16 v5, 0xc

    .line 212
    .line 213
    move-object/from16 v16, v2

    .line 214
    .line 215
    move-object v2, v1

    .line 216
    move-object/from16 v1, v16

    .line 217
    .line 218
    invoke-static/range {v0 .. v5}, Lfi;->c(Lfi;Ljava/lang/Object;Ljj;Llm2;Lne1;I)Ljava/lang/Object;

    .line 219
    .line 220
    .line 221
    move-result-object v0

    .line 222
    if-ne v0, v6, :cond_e1

    .line 223
    .line 224
    move-object v9, v6

    .line 225
    goto :goto_e3

    .line 226
    :cond_e1
    :goto_e1
    sget-object v9, Ldg6;->a:Ldg6;

    .line 227
    .line 228
    :goto_e3
    return-object v9

    .line 229
    :pswitch_e4
    invoke-direct/range {p0 .. p1}, Lmx4;->h(Ljava/lang/Object;)Ljava/lang/Object;

    .line 230
    .line 231
    .line 232
    move-result-object v0

    .line 233
    return-object v0

    .line 234
    :pswitch_e9
    iget-object v0, v4, Lmx4;->l:Ljava/lang/Object;

    .line 235
    .line 236
    move-object v1, v0

    .line 237
    check-cast v1, Ljava/lang/String;

    .line 238
    .line 239
    iget-object v0, v4, Lmx4;->k:Ljava/lang/Object;

    .line 240
    .line 241
    move-object v2, v0

    .line 242
    check-cast v2, Lzr5;

    .line 243
    .line 244
    const-string v0, "\u667a\u80fdDNS\u54cd\u5e94\u5f02\u5e38: code="

    .line 245
    .line 246
    const-string v3, "\u667a\u80fdDNS\u65e0\u6709\u6548IP: "

    .line 247
    .line 248
    sget-object v5, Ljg1;->i:Ljg1;

    .line 249
    .line 250
    iget v10, v4, Lmx4;->j:I

    .line 251
    .line 252
    const-string v11, "SmartDnsRepository"

    .line 253
    .line 254
    if-eqz v10, :cond_10f

    .line 255
    .line 256
    if-ne v10, v8, :cond_10a

    .line 257
    .line 258
    :try_start_101
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V
    :try_end_104
    .catch Ljava/lang/Exception; {:try_start_101 .. :try_end_104} :catch_107

    .line 259
    .line 260
    .line 261
    move-object/from16 v4, p1

    .line 262
    .line 263
    goto :goto_166

    .line 264
    :catch_107
    move-exception v0

    .line 265
    goto/16 :goto_1d8

    .line 266
    .line 267
    :cond_10a
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 268
    .line 269
    .line 270
    goto/16 :goto_1ef

    .line 271
    .line 272
    :cond_10f
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 273
    .line 274
    .line 275
    invoke-virtual {v2}, Lzr5;->f()Z

    .line 276
    .line 277
    .line 278
    move-result v7

    .line 279
    if-eqz v7, :cond_11e

    .line 280
    .line 281
    invoke-static {v2, v1}, Lzr5;->c(Lzr5;Ljava/lang/String;)Lcs5;

    .line 282
    .line 283
    .line 284
    move-result-object v9

    .line 285
    goto/16 :goto_1ef

    .line 286
    .line 287
    :cond_11e
    invoke-static {v2, v1}, Lzr5;->c(Lzr5;Ljava/lang/String;)Lcs5;

    .line 288
    .line 289
    .line 290
    move-result-object v7

    .line 291
    if-eqz v7, :cond_12c

    .line 292
    .line 293
    iget-object v0, v7, Lcs5;->b:Ljava/util/List;

    .line 294
    .line 295
    invoke-interface {v0}, Ljava/util/List;->size()I

    .line 296
    .line 297
    .line 298
    move-object v9, v7

    .line 299
    goto/16 :goto_1ef

    .line 300
    .line 301
    :cond_12c
    iget-object v7, v2, Lzr5;->b:Ljava/util/concurrent/ConcurrentHashMap;

    .line 302
    .line 303
    invoke-virtual {v7, v1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    .line 304
    .line 305
    .line 306
    move-result-object v10

    .line 307
    check-cast v10, Lqb4;

    .line 308
    .line 309
    if-nez v10, :cond_137

    .line 310
    .line 311
    goto :goto_155

    .line 312
    :cond_137
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 313
    .line 314
    .line 315
    move-result-wide v12

    .line 316
    iget-object v14, v10, Lqb4;->j:Ljava/lang/Object;

    .line 317
    .line 318
    check-cast v14, Ljava/lang/Number;

    .line 319
    .line 320
    invoke-virtual {v14}, Ljava/lang/Number;->longValue()J

    .line 321
    .line 322
    .line 323
    move-result-wide v14

    .line 324
    cmp-long v12, v12, v14

    .line 325
    .line 326
    if-lez v12, :cond_14b

    .line 327
    .line 328
    invoke-virtual {v7, v1}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 329
    .line 330
    .line 331
    goto :goto_155

    .line 332
    :cond_14b
    iget-object v6, v10, Lqb4;->i:Ljava/lang/Object;

    .line 333
    .line 334
    check-cast v6, Lcs5;

    .line 335
    .line 336
    iget-object v6, v6, Lcs5;->b:Ljava/util/List;

    .line 337
    .line 338
    invoke-interface {v6}, Ljava/util/Collection;->isEmpty()Z

    .line 339
    .line 340
    .line 341
    move-result v6

    .line 342
    :goto_155
    if-eqz v6, :cond_159

    .line 343
    .line 344
    goto/16 :goto_1ef

    .line 345
    .line 346
    :cond_159
    :try_start_159
    iget-object v6, v2, Lzr5;->a:Ltr5;

    .line 347
    .line 348
    iput v8, v4, Lmx4;->j:I

    .line 349
    .line 350
    invoke-interface {v6, v1, v4}, Ltr5;->a(Ljava/lang/String;Lne1;)Ljava/lang/Object;

    .line 351
    .line 352
    .line 353
    move-result-object v4

    .line 354
    if-ne v4, v5, :cond_166

    .line 355
    .line 356
    move-object v9, v5

    .line 357
    goto/16 :goto_1ef

    .line 358
    .line 359
    :cond_166
    :goto_166
    check-cast v4, Lcom/picacg/network/dns/smartdns/SmartDnsResponse;

    .line 360
    .line 361
    invoke-virtual {v4}, Lcom/picacg/network/dns/smartdns/SmartDnsResponse;->getCode()I

    .line 362
    .line 363
    .line 364
    move-result v5

    .line 365
    const/16 v6, 0xc8

    .line 366
    .line 367
    if-ne v5, v6, :cond_1b2

    .line 368
    .line 369
    invoke-virtual {v4}, Lcom/picacg/network/dns/smartdns/SmartDnsResponse;->getData()Lcom/picacg/network/dns/smartdns/SmartDnsData;

    .line 370
    .line 371
    .line 372
    move-result-object v5

    .line 373
    if-nez v5, :cond_177

    .line 374
    .line 375
    goto :goto_1b2

    .line 376
    :cond_177
    invoke-virtual {v4}, Lcom/picacg/network/dns/smartdns/SmartDnsResponse;->getData()Lcom/picacg/network/dns/smartdns/SmartDnsData;

    .line 377
    .line 378
    .line 379
    move-result-object v0

    .line 380
    invoke-static {v2, v0}, Lzr5;->a(Lzr5;Lcom/picacg/network/dns/smartdns/SmartDnsData;)Lcs5;

    .line 381
    .line 382
    .line 383
    move-result-object v4

    .line 384
    iget-object v5, v4, Lcs5;->b:Ljava/util/List;

    .line 385
    .line 386
    invoke-interface {v5}, Ljava/util/Collection;->isEmpty()Z

    .line 387
    .line 388
    .line 389
    move-result v5

    .line 390
    if-nez v5, :cond_197

    .line 391
    .line 392
    const-wide/32 v5, 0x493e0

    .line 393
    .line 394
    .line 395
    invoke-static {v2, v1, v4, v5, v6}, Lzr5;->d(Lzr5;Ljava/lang/String;Lcs5;J)V

    .line 396
    .line 397
    .line 398
    invoke-static {v2, v0}, Lzr5;->e(Lzr5;Lcom/picacg/network/dns/smartdns/SmartDnsData;)V

    .line 399
    .line 400
    .line 401
    iget-object v0, v4, Lcs5;->b:Ljava/util/List;

    .line 402
    .line 403
    invoke-static {v0}, Ljava/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 404
    .line 405
    .line 406
    move-object v9, v4

    .line 407
    goto :goto_1ef

    .line 408
    :cond_197
    const-wide/32 v5, 0xea60

    .line 409
    .line 410
    .line 411
    invoke-static {v2, v1, v4, v5, v6}, Lzr5;->d(Lzr5;Ljava/lang/String;Lcs5;J)V

    .line 412
    .line 413
    .line 414
    new-instance v0, Ljava/lang/StringBuilder;

    .line 415
    .line 416
    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 417
    .line 418
    .line 419
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 420
    .line 421
    .line 422
    const-string v3, "\uff0c\u5df2\u8d1f\u7f13\u5b58"

    .line 423
    .line 424
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 425
    .line 426
    .line 427
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 428
    .line 429
    .line 430
    move-result-object v0

    .line 431
    invoke-static {v11, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 432
    .line 433
    .line 434
    goto :goto_1ef

    .line 435
    :cond_1b2
    :goto_1b2
    invoke-virtual {v4}, Lcom/picacg/network/dns/smartdns/SmartDnsResponse;->getCode()I

    .line 436
    .line 437
    .line 438
    move-result v3

    .line 439
    invoke-virtual {v4}, Lcom/picacg/network/dns/smartdns/SmartDnsResponse;->getMessage()Ljava/lang/String;

    .line 440
    .line 441
    .line 442
    move-result-object v4

    .line 443
    new-instance v5, Ljava/lang/StringBuilder;

    .line 444
    .line 445
    invoke-direct {v5, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 446
    .line 447
    .line 448
    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 449
    .line 450
    .line 451
    const-string v0, ", msg="

    .line 452
    .line 453
    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 454
    .line 455
    .line 456
    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 457
    .line 458
    .line 459
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 460
    .line 461
    .line 462
    move-result-object v0

    .line 463
    invoke-static {v11, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 464
    .line 465
    .line 466
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 467
    .line 468
    .line 469
    move-result-wide v3

    .line 470
    iput-wide v3, v2, Lzr5;->d:J
    :try_end_1d7
    .catch Ljava/lang/Exception; {:try_start_159 .. :try_end_1d7} :catch_107

    .line 471
    .line 472
    goto :goto_1ef

    .line 473
    :goto_1d8
    new-instance v3, Ljava/lang/StringBuilder;

    .line 474
    .line 475
    const-string v4, "\u667a\u80fdDNS\u8bf7\u6c42\u5931\u8d25: "

    .line 476
    .line 477
    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 478
    .line 479
    .line 480
    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 481
    .line 482
    .line 483
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 484
    .line 485
    .line 486
    move-result-object v1

    .line 487
    invoke-static {v11, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 488
    .line 489
    .line 490
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 491
    .line 492
    .line 493
    move-result-wide v0

    .line 494
    iput-wide v0, v2, Lzr5;->d:J

    .line 495
    .line 496
    :goto_1ef
    return-object v9

    .line 497
    :pswitch_1f0
    iget-object v0, v4, Lmx4;->k:Ljava/lang/Object;

    .line 498
    .line 499
    check-cast v0, Lkr5;

    .line 500
    .line 501
    iget-object v1, v0, Lkr5;->n:Lqc4;

    .line 502
    .line 503
    sget-object v2, Ljg1;->i:Ljg1;

    .line 504
    .line 505
    iget v3, v4, Lmx4;->j:I

    .line 506
    .line 507
    if-eqz v3, :cond_206

    .line 508
    .line 509
    if-ne v3, v8, :cond_202

    .line 510
    .line 511
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 512
    .line 513
    .line 514
    goto :goto_22c

    .line 515
    :cond_202
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 516
    .line 517
    .line 518
    goto :goto_233

    .line 519
    :cond_206
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 520
    .line 521
    .line 522
    sget-object v3, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    .line 523
    .line 524
    invoke-virtual {v1, v3}, Lqc4;->setValue(Ljava/lang/Object;)V

    .line 525
    .line 526
    .line 527
    iget-object v11, v0, Lkr5;->s:Lex3;

    .line 528
    .line 529
    iget-object v13, v0, Lkr5;->r:Lua;

    .line 530
    .line 531
    sget-object v10, Lyw3;->j:Lyw3;

    .line 532
    .line 533
    iget-object v0, v4, Lmx4;->l:Ljava/lang/Object;

    .line 534
    .line 535
    move-object v12, v0

    .line 536
    check-cast v12, Lb0;

    .line 537
    .line 538
    iput v8, v4, Lmx4;->j:I

    .line 539
    .line 540
    invoke-virtual {v11}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 541
    .line 542
    .line 543
    new-instance v9, Ldx3;

    .line 544
    .line 545
    const/4 v14, 0x0

    .line 546
    invoke-direct/range {v9 .. v14}, Ldx3;-><init>(Lyw3;Lex3;Lom2;Ljava/lang/Object;Lne1;)V

    .line 547
    .line 548
    .line 549
    invoke-static {v9, v4}, Lin0;->N(Lom2;Lne1;)Ljava/lang/Object;

    .line 550
    .line 551
    .line 552
    move-result-object v0

    .line 553
    if-ne v0, v2, :cond_22c

    .line 554
    .line 555
    move-object v9, v2

    .line 556
    goto :goto_233

    .line 557
    :cond_22c
    :goto_22c
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    .line 558
    .line 559
    invoke-virtual {v1, v0}, Lqc4;->setValue(Ljava/lang/Object;)V

    .line 560
    .line 561
    .line 562
    sget-object v9, Ldg6;->a:Ldg6;

    .line 563
    .line 564
    :goto_233
    return-object v9

    .line 565
    :pswitch_234
    sget-object v0, Ljg1;->i:Ljg1;

    .line 566
    .line 567
    iget v1, v4, Lmx4;->j:I

    .line 568
    .line 569
    if-eqz v1, :cond_246

    .line 570
    .line 571
    if-ne v1, v8, :cond_242

    .line 572
    .line 573
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 574
    .line 575
    .line 576
    sget-object v9, Ldg6;->a:Ldg6;

    .line 577
    .line 578
    goto :goto_25e

    .line 579
    :cond_242
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 580
    .line 581
    .line 582
    goto :goto_25e

    .line 583
    :cond_246
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 584
    .line 585
    .line 586
    iget-object v1, v4, Lmx4;->k:Ljava/lang/Object;

    .line 587
    .line 588
    check-cast v1, Lqv3;

    .line 589
    .line 590
    iget-object v1, v1, Lqv3;->a:Ldm5;

    .line 591
    .line 592
    new-instance v3, Lrg0;

    .line 593
    .line 594
    iget-object v5, v4, Lmx4;->l:Ljava/lang/Object;

    .line 595
    .line 596
    check-cast v5, Lzt5;

    .line 597
    .line 598
    invoke-direct {v3, v5, v2}, Lrg0;-><init>(Lzt5;I)V

    .line 599
    .line 600
    .line 601
    iput v8, v4, Lmx4;->j:I

    .line 602
    .line 603
    invoke-virtual {v1, v3, v4}, Ldm5;->collect(Ldg2;Lne1;)Ljava/lang/Object;

    .line 604
    .line 605
    .line 606
    move-object v9, v0

    .line 607
    :goto_25e
    return-object v9

    .line 608
    :pswitch_25f
    iget-object v0, v4, Lmx4;->k:Ljava/lang/Object;

    .line 609
    .line 610
    move-object v1, v0

    .line 611
    check-cast v1, Lun5;

    .line 612
    .line 613
    sget-object v0, Ljg1;->i:Ljg1;

    .line 614
    .line 615
    iget v2, v4, Lmx4;->j:I

    .line 616
    .line 617
    if-eqz v2, :cond_276

    .line 618
    .line 619
    if-ne v2, v8, :cond_272

    .line 620
    .line 621
    :try_start_26c
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V
    :try_end_26f
    .catch Ljava/util/concurrent/CancellationException; {:try_start_26c .. :try_end_26f} :catch_287
    .catch Ljava/lang/Exception; {:try_start_26c .. :try_end_26f} :catch_270

    .line 622
    .line 623
    .line 624
    goto :goto_29d

    .line 625
    :catch_270
    move-exception v0

    .line 626
    goto :goto_289

    .line 627
    :cond_272
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 628
    .line 629
    .line 630
    goto :goto_29f

    .line 631
    :cond_276
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 632
    .line 633
    .line 634
    :try_start_279
    iget-object v2, v4, Lmx4;->l:Ljava/lang/Object;

    .line 635
    .line 636
    check-cast v2, Lpo0;

    .line 637
    .line 638
    iput v8, v4, Lmx4;->j:I

    .line 639
    .line 640
    invoke-static {v1, v2, v4}, Lun5;->b(Lun5;Lpo0;Lpe1;)Ljava/lang/Object;

    .line 641
    .line 642
    .line 643
    move-result-object v1
    :try_end_283
    .catch Ljava/util/concurrent/CancellationException; {:try_start_279 .. :try_end_283} :catch_287
    .catch Ljava/lang/Exception; {:try_start_279 .. :try_end_283} :catch_270

    .line 644
    if-ne v1, v0, :cond_29d

    .line 645
    .line 646
    move-object v9, v0

    .line 647
    goto :goto_29f

    .line 648
    :catch_287
    move-exception v0

    .line 649
    goto :goto_2a0

    .line 650
    :goto_289
    const-string v2, "ShelfUpdateChecker"

    .line 651
    .line 652
    const-string v3, "\u68c0\u67e5\u8f6e\u6b21\u5f02\u5e38\u4e2d\u6b62"

    .line 653
    .line 654
    invoke-static {v2, v3, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 655
    .line 656
    .line 657
    iget-object v0, v1, Lun5;->e:Ljw5;

    .line 658
    .line 659
    new-instance v1, Ljo0;

    .line 660
    .line 661
    invoke-direct {v1, v6, v6, v6, v8}, Ljo0;-><init>(IIIZ)V

    .line 662
    .line 663
    .line 664
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 665
    .line 666
    .line 667
    invoke-virtual {v0, v9, v1}, Ljw5;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 668
    .line 669
    .line 670
    :cond_29d
    :goto_29d
    sget-object v9, Ldg6;->a:Ldg6;

    .line 671
    .line 672
    :goto_29f
    return-object v9

    .line 673
    :goto_2a0
    throw v0

    .line 674
    :pswitch_2a1
    iget-object v0, v4, Lmx4;->l:Ljava/lang/Object;

    .line 675
    .line 676
    move-object v1, v0

    .line 677
    check-cast v1, Lpj5;

    .line 678
    .line 679
    iget-object v0, v4, Lmx4;->k:Ljava/lang/Object;

    .line 680
    .line 681
    move-object v3, v0

    .line 682
    check-cast v3, Ljm5;

    .line 683
    .line 684
    sget-object v6, Ljg1;->i:Ljg1;

    .line 685
    .line 686
    iget v0, v4, Lmx4;->j:I

    .line 687
    .line 688
    if-eqz v0, :cond_2c3

    .line 689
    .line 690
    if-eq v0, v8, :cond_2bd

    .line 691
    .line 692
    if-ne v0, v5, :cond_2b9

    .line 693
    .line 694
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 695
    .line 696
    .line 697
    goto :goto_30c

    .line 698
    :cond_2b9
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 699
    .line 700
    .line 701
    goto :goto_30e

    .line 702
    :cond_2bd
    :try_start_2bd
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V
    :try_end_2c0
    .catch Ljava/lang/Exception; {:try_start_2bd .. :try_end_2c0} :catch_2c1

    .line 703
    .line 704
    .line 705
    goto :goto_30c

    .line 706
    :catch_2c1
    move-exception v0

    .line 707
    goto :goto_2d6

    .line 708
    :cond_2c3
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 709
    .line 710
    .line 711
    :try_start_2c6
    iget-object v0, v3, Ljm5;->e:Landroidx/datastore/core/DataStore;

    .line 712
    .line 713
    new-instance v7, Lhm5;

    .line 714
    .line 715
    invoke-direct {v7, v3, v9, v8}, Lhm5;-><init>(Ljm5;Lne1;I)V

    .line 716
    .line 717
    .line 718
    iput v8, v4, Lmx4;->j:I

    .line 719
    .line 720
    invoke-interface {v0, v7, v4}, Landroidx/datastore/core/DataStore;->updateData(Lom2;Lne1;)Ljava/lang/Object;

    .line 721
    .line 722
    .line 723
    move-result-object v0
    :try_end_2d3
    .catch Ljava/lang/Exception; {:try_start_2c6 .. :try_end_2d3} :catch_2c1

    .line 724
    if-ne v0, v6, :cond_30c

    .line 725
    .line 726
    goto :goto_30a

    .line 727
    :goto_2d6
    invoke-virtual {v0}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    .line 728
    .line 729
    .line 730
    invoke-virtual {v3, v1}, Ljm5;->d(Lpj5;)Z

    .line 731
    .line 732
    .line 733
    move-result v0

    .line 734
    if-eqz v0, :cond_30c

    .line 735
    .line 736
    iget-object v0, v3, Ljm5;->b:Lyj5;

    .line 737
    .line 738
    iget-object v7, v1, Lpj5;->a:Ltj5;

    .line 739
    .line 740
    invoke-virtual {v0, v7}, Lyj5;->a(Ltj5;)Ltj5;

    .line 741
    .line 742
    .line 743
    move-result-object v0

    .line 744
    invoke-static {v1, v0, v9, v9, v2}, Lpj5;->a(Lpj5;Ltj5;Lr86;Ljava/util/Map;I)Lpj5;

    .line 745
    .line 746
    .line 747
    move-result-object v1

    .line 748
    iput-object v1, v3, Ljm5;->h:Lpj5;

    .line 749
    .line 750
    iget-object v1, v3, Ljm5;->c:Lxj5;

    .line 751
    .line 752
    iget-object v2, v1, Lxj5;->e:Lxf1;

    .line 753
    .line 754
    invoke-static {v2}, Lin0;->j(Lxf1;)Lme1;

    .line 755
    .line 756
    .line 757
    move-result-object v2

    .line 758
    new-instance v7, Ll14;

    .line 759
    .line 760
    invoke-direct {v7, v1, v0, v9, v8}, Ll14;-><init>(Ljava/lang/Object;Ljava/lang/Object;Lne1;I)V

    .line 761
    .line 762
    .line 763
    const/4 v1, 0x3

    .line 764
    invoke-static {v2, v9, v9, v7, v1}, Lk64;->I(Lhg1;Lxf1;Llg1;Lom2;I)Lzv5;

    .line 765
    .line 766
    .line 767
    iget-object v0, v0, Ltj5;->a:Ljava/lang/String;

    .line 768
    .line 769
    sget-object v1, Lgm5;->j:Lgm5;

    .line 770
    .line 771
    iput v5, v4, Lmx4;->j:I

    .line 772
    .line 773
    invoke-static {v3, v0, v1, v4}, Ljm5;->a(Ljm5;Ljava/lang/String;Lgm5;Lne1;)Ljava/lang/Object;

    .line 774
    .line 775
    .line 776
    move-result-object v0

    .line 777
    if-ne v0, v6, :cond_30c

    .line 778
    .line 779
    :goto_30a
    move-object v9, v6

    .line 780
    goto :goto_30e

    .line 781
    :cond_30c
    :goto_30c
    sget-object v9, Ldg6;->a:Ldg6;

    .line 782
    .line 783
    :goto_30e
    return-object v9

    .line 784
    :pswitch_30f
    sget-object v0, Ldg6;->a:Ldg6;

    .line 785
    .line 786
    sget-object v1, Ljg1;->i:Ljg1;

    .line 787
    .line 788
    iget v2, v4, Lmx4;->j:I

    .line 789
    .line 790
    if-eqz v2, :cond_322

    .line 791
    .line 792
    if-ne v2, v8, :cond_31e

    .line 793
    .line 794
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 795
    .line 796
    .line 797
    :cond_31c
    move-object v9, v0

    .line 798
    goto :goto_366

    .line 799
    :cond_31e
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 800
    .line 801
    .line 802
    goto :goto_366

    .line 803
    :cond_322
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 804
    .line 805
    .line 806
    iget-object v2, v4, Lmx4;->k:Ljava/lang/Object;

    .line 807
    .line 808
    check-cast v2, Lll5;

    .line 809
    .line 810
    iget-object v2, v2, Lll5;->a:Lz76;

    .line 811
    .line 812
    iget-object v5, v4, Lmx4;->l:Ljava/lang/Object;

    .line 813
    .line 814
    check-cast v5, Lp76;

    .line 815
    .line 816
    invoke-virtual {v5}, Ljava/lang/Enum;->name()Ljava/lang/String;

    .line 817
    .line 818
    .line 819
    move-result-object v5

    .line 820
    iput v8, v4, Lmx4;->j:I

    .line 821
    .line 822
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 823
    .line 824
    .line 825
    sget-object v10, Lz76;->k:Ljava/util/List;

    .line 826
    .line 827
    invoke-interface {v10, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    .line 828
    .line 829
    .line 830
    move-result v6

    .line 831
    if-eqz v6, :cond_353

    .line 832
    .line 833
    iget-object v2, v2, Lz76;->a:Landroidx/datastore/core/DataStore;

    .line 834
    .line 835
    new-instance v3, Lt76;

    .line 836
    .line 837
    invoke-direct {v3, v5, v9}, Lt76;-><init>(Ljava/lang/String;Lne1;)V

    .line 838
    .line 839
    .line 840
    invoke-static {v2, v3, v4}, Landroidx/datastore/preferences/core/PreferencesKt;->edit(Landroidx/datastore/core/DataStore;Lom2;Lne1;)Ljava/lang/Object;

    .line 841
    .line 842
    .line 843
    move-result-object v2

    .line 844
    if-ne v2, v1, :cond_34e

    .line 845
    .line 846
    goto :goto_34f

    .line 847
    :cond_34e
    move-object v2, v0

    .line 848
    :goto_34f
    if-ne v2, v1, :cond_31c

    .line 849
    .line 850
    move-object v9, v1

    .line 851
    goto :goto_366

    .line 852
    :cond_353
    const/4 v14, 0x0

    .line 853
    const/16 v15, 0x3f

    .line 854
    .line 855
    const/4 v11, 0x0

    .line 856
    const/4 v12, 0x0

    .line 857
    const/4 v13, 0x0

    .line 858
    invoke-static/range {v10 .. v15}, Lnr0;->C0(Ljava/lang/Iterable;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Llm2;I)Ljava/lang/String;

    .line 859
    .line 860
    .line 861
    move-result-object v0

    .line 862
    const-string v1, "Invalid theme mode: "

    .line 863
    .line 864
    invoke-static {v1, v5, v3, v0}, Lud2;->j(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 865
    .line 866
    .line 867
    move-result-object v0

    .line 868
    invoke-static {v0}, Lmz;->e(Ljava/lang/Object;)V

    .line 869
    .line 870
    .line 871
    :goto_366
    return-object v9

    .line 872
    :pswitch_367
    sget-object v0, Ldg6;->a:Ldg6;

    .line 873
    .line 874
    sget-object v1, Ljg1;->i:Ljg1;

    .line 875
    .line 876
    iget v2, v4, Lmx4;->j:I

    .line 877
    .line 878
    if-eqz v2, :cond_37a

    .line 879
    .line 880
    if-ne v2, v8, :cond_376

    .line 881
    .line 882
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 883
    .line 884
    .line 885
    :cond_374
    move-object v9, v0

    .line 886
    goto :goto_3be

    .line 887
    :cond_376
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 888
    .line 889
    .line 890
    goto :goto_3be

    .line 891
    :cond_37a
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 892
    .line 893
    .line 894
    iget-object v2, v4, Lmx4;->k:Ljava/lang/Object;

    .line 895
    .line 896
    check-cast v2, Lll5;

    .line 897
    .line 898
    iget-object v2, v2, Lll5;->a:Lz76;

    .line 899
    .line 900
    iget-object v5, v4, Lmx4;->l:Ljava/lang/Object;

    .line 901
    .line 902
    check-cast v5, Lb76;

    .line 903
    .line 904
    invoke-virtual {v5}, Ljava/lang/Enum;->name()Ljava/lang/String;

    .line 905
    .line 906
    .line 907
    move-result-object v5

    .line 908
    iput v8, v4, Lmx4;->j:I

    .line 909
    .line 910
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 911
    .line 912
    .line 913
    sget-object v10, Lz76;->l:Ljava/util/List;

    .line 914
    .line 915
    invoke-interface {v10, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    .line 916
    .line 917
    .line 918
    move-result v6

    .line 919
    if-eqz v6, :cond_3ab

    .line 920
    .line 921
    iget-object v2, v2, Lz76;->a:Landroidx/datastore/core/DataStore;

    .line 922
    .line 923
    new-instance v3, Ls76;

    .line 924
    .line 925
    invoke-direct {v3, v5, v9}, Ls76;-><init>(Ljava/lang/String;Lne1;)V

    .line 926
    .line 927
    .line 928
    invoke-static {v2, v3, v4}, Landroidx/datastore/preferences/core/PreferencesKt;->edit(Landroidx/datastore/core/DataStore;Lom2;Lne1;)Ljava/lang/Object;

    .line 929
    .line 930
    .line 931
    move-result-object v2

    .line 932
    if-ne v2, v1, :cond_3a6

    .line 933
    .line 934
    goto :goto_3a7

    .line 935
    :cond_3a6
    move-object v2, v0

    .line 936
    :goto_3a7
    if-ne v2, v1, :cond_374

    .line 937
    .line 938
    move-object v9, v1

    .line 939
    goto :goto_3be

    .line 940
    :cond_3ab
    const/4 v14, 0x0

    .line 941
    const/16 v15, 0x3f

    .line 942
    .line 943
    const/4 v11, 0x0

    .line 944
    const/4 v12, 0x0

    .line 945
    const/4 v13, 0x0

    .line 946
    invoke-static/range {v10 .. v15}, Lnr0;->C0(Ljava/lang/Iterable;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Llm2;I)Ljava/lang/String;

    .line 947
    .line 948
    .line 949
    move-result-object v0

    .line 950
    const-string v1, "Invalid text scale: "

    .line 951
    .line 952
    invoke-static {v1, v5, v3, v0}, Lud2;->j(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 953
    .line 954
    .line 955
    move-result-object v0

    .line 956
    invoke-static {v0}, Lmz;->e(Ljava/lang/Object;)V

    .line 957
    .line 958
    .line 959
    :goto_3be
    return-object v9

    .line 960
    :pswitch_3bf
    sget-object v0, Ldg6;->a:Ldg6;

    .line 961
    .line 962
    sget-object v1, Ljg1;->i:Ljg1;

    .line 963
    .line 964
    iget v2, v4, Lmx4;->j:I

    .line 965
    .line 966
    if-eqz v2, :cond_3d2

    .line 967
    .line 968
    if-ne v2, v8, :cond_3ce

    .line 969
    .line 970
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 971
    .line 972
    .line 973
    :cond_3cc
    move-object v9, v0

    .line 974
    goto :goto_412

    .line 975
    :cond_3ce
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 976
    .line 977
    .line 978
    goto :goto_412

    .line 979
    :cond_3d2
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 980
    .line 981
    .line 982
    iget-object v2, v4, Lmx4;->k:Ljava/lang/Object;

    .line 983
    .line 984
    check-cast v2, Lll5;

    .line 985
    .line 986
    iget-object v2, v2, Lll5;->b:Ldd1;

    .line 987
    .line 988
    iget-object v5, v4, Lmx4;->l:Ljava/lang/Object;

    .line 989
    .line 990
    check-cast v5, Ljava/lang/String;

    .line 991
    .line 992
    iput v8, v4, Lmx4;->j:I

    .line 993
    .line 994
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 995
    .line 996
    .line 997
    sget-object v10, Ldd1;->x:Ljava/util/List;

    .line 998
    .line 999
    invoke-interface {v10, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    .line 1000
    .line 1001
    .line 1002
    move-result v6

    .line 1003
    if-eqz v6, :cond_3ff

    .line 1004
    .line 1005
    iget-object v2, v2, Ldd1;->a:Landroidx/datastore/core/DataStore;

    .line 1006
    .line 1007
    new-instance v3, Llc1;

    .line 1008
    .line 1009
    invoke-direct {v3, v5, v9}, Llc1;-><init>(Ljava/lang/String;Lne1;)V

    .line 1010
    .line 1011
    .line 1012
    invoke-static {v2, v3, v4}, Landroidx/datastore/preferences/core/PreferencesKt;->edit(Landroidx/datastore/core/DataStore;Lom2;Lne1;)Ljava/lang/Object;

    .line 1013
    .line 1014
    .line 1015
    move-result-object v2

    .line 1016
    if-ne v2, v1, :cond_3fa

    .line 1017
    .line 1018
    goto :goto_3fb

    .line 1019
    :cond_3fa
    move-object v2, v0

    .line 1020
    :goto_3fb
    if-ne v2, v1, :cond_3cc

    .line 1021
    .line 1022
    move-object v9, v1

    .line 1023
    goto :goto_412

    .line 1024
    :cond_3ff
    const/4 v14, 0x0

    .line 1025
    const/16 v15, 0x3f

    .line 1026
    .line 1027
    const/4 v11, 0x0

    .line 1028
    const/4 v12, 0x0

    .line 1029
    const/4 v13, 0x0

    .line 1030
    invoke-static/range {v10 .. v15}, Lnr0;->C0(Ljava/lang/Iterable;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Llm2;I)Ljava/lang/String;

    .line 1031
    .line 1032
    .line 1033
    move-result-object v0

    .line 1034
    const-string v1, "Invalid comic detail style: "

    .line 1035
    .line 1036
    invoke-static {v1, v5, v3, v0}, Lud2;->j(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 1037
    .line 1038
    .line 1039
    move-result-object v0

    .line 1040
    invoke-static {v0}, Lmz;->e(Ljava/lang/Object;)V

    .line 1041
    .line 1042
    .line 1043
    :goto_412
    return-object v9

    .line 1044
    :pswitch_413
    sget-object v0, Ldg6;->a:Ldg6;

    .line 1045
    .line 1046
    sget-object v1, Ljg1;->i:Ljg1;

    .line 1047
    .line 1048
    iget v2, v4, Lmx4;->j:I

    .line 1049
    .line 1050
    if-eqz v2, :cond_426

    .line 1051
    .line 1052
    if-ne v2, v8, :cond_422

    .line 1053
    .line 1054
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1055
    .line 1056
    .line 1057
    :cond_420
    move-object v9, v0

    .line 1058
    goto :goto_468

    .line 1059
    :cond_422
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1060
    .line 1061
    .line 1062
    goto :goto_468

    .line 1063
    :cond_426
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1064
    .line 1065
    .line 1066
    iget-object v2, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1067
    .line 1068
    check-cast v2, Lll5;

    .line 1069
    .line 1070
    iget-object v2, v2, Lll5;->a:Lz76;

    .line 1071
    .line 1072
    iget-object v5, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1073
    .line 1074
    check-cast v5, Lis0;

    .line 1075
    .line 1076
    iget-object v5, v5, Lis0;->i:Ljava/lang/String;

    .line 1077
    .line 1078
    iput v8, v4, Lmx4;->j:I

    .line 1079
    .line 1080
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 1081
    .line 1082
    .line 1083
    sget-object v10, Lz76;->j:Ljava/util/List;

    .line 1084
    .line 1085
    invoke-interface {v10, v5}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    .line 1086
    .line 1087
    .line 1088
    move-result v6

    .line 1089
    if-eqz v6, :cond_455

    .line 1090
    .line 1091
    iget-object v2, v2, Lz76;->a:Landroidx/datastore/core/DataStore;

    .line 1092
    .line 1093
    new-instance v3, Lr76;

    .line 1094
    .line 1095
    invoke-direct {v3, v5, v9}, Lr76;-><init>(Ljava/lang/String;Lne1;)V

    .line 1096
    .line 1097
    .line 1098
    invoke-static {v2, v3, v4}, Landroidx/datastore/preferences/core/PreferencesKt;->edit(Landroidx/datastore/core/DataStore;Lom2;Lne1;)Ljava/lang/Object;

    .line 1099
    .line 1100
    .line 1101
    move-result-object v2

    .line 1102
    if-ne v2, v1, :cond_450

    .line 1103
    .line 1104
    goto :goto_451

    .line 1105
    :cond_450
    move-object v2, v0

    .line 1106
    :goto_451
    if-ne v2, v1, :cond_420

    .line 1107
    .line 1108
    move-object v9, v1

    .line 1109
    goto :goto_468

    .line 1110
    :cond_455
    const/4 v14, 0x0

    .line 1111
    const/16 v15, 0x3f

    .line 1112
    .line 1113
    const/4 v11, 0x0

    .line 1114
    const/4 v12, 0x0

    .line 1115
    const/4 v13, 0x0

    .line 1116
    invoke-static/range {v10 .. v15}, Lnr0;->C0(Ljava/lang/Iterable;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Llm2;I)Ljava/lang/String;

    .line 1117
    .line 1118
    .line 1119
    move-result-object v0

    .line 1120
    const-string v1, "Invalid color theme: "

    .line 1121
    .line 1122
    invoke-static {v1, v5, v3, v0}, Lud2;->j(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    .line 1123
    .line 1124
    .line 1125
    move-result-object v0

    .line 1126
    invoke-static {v0}, Lmz;->e(Ljava/lang/Object;)V

    .line 1127
    .line 1128
    .line 1129
    :goto_468
    return-object v9

    .line 1130
    :pswitch_469
    sget-object v0, Ldg6;->a:Ldg6;

    .line 1131
    .line 1132
    sget-object v1, Ljg1;->i:Ljg1;

    .line 1133
    .line 1134
    iget v2, v4, Lmx4;->j:I

    .line 1135
    .line 1136
    if-eqz v2, :cond_47c

    .line 1137
    .line 1138
    if-ne v2, v8, :cond_478

    .line 1139
    .line 1140
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1141
    .line 1142
    .line 1143
    :cond_476
    move-object v9, v0

    .line 1144
    goto :goto_495

    .line 1145
    :cond_478
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1146
    .line 1147
    .line 1148
    goto :goto_495

    .line 1149
    :cond_47c
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1150
    .line 1151
    .line 1152
    iget-object v2, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1153
    .line 1154
    check-cast v2, Lxq0;

    .line 1155
    .line 1156
    iget-object v3, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1157
    .line 1158
    check-cast v3, Lrt;

    .line 1159
    .line 1160
    invoke-static {v3}, Lkl0;->j0(Lrt;)Lwq0;

    .line 1161
    .line 1162
    .line 1163
    move-result-object v3

    .line 1164
    iput v8, v4, Lmx4;->j:I

    .line 1165
    .line 1166
    check-cast v2, Lmb;

    .line 1167
    .line 1168
    invoke-virtual {v2, v3}, Lmb;->a(Lwq0;)V

    .line 1169
    .line 1170
    .line 1171
    if-ne v0, v1, :cond_476

    .line 1172
    .line 1173
    move-object v9, v1

    .line 1174
    :goto_495
    return-object v9

    .line 1175
    :pswitch_496
    sget-object v1, Lb42;->i:Lb42;

    .line 1176
    .line 1177
    iget-object v0, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1178
    .line 1179
    check-cast v0, Lgf5;

    .line 1180
    .line 1181
    iget-object v2, v0, Lgf5;->j:Ljw5;

    .line 1182
    .line 1183
    iget-object v3, v0, Lgf5;->a:Lqr;

    .line 1184
    .line 1185
    sget-object v10, Ljg1;->i:Ljg1;

    .line 1186
    .line 1187
    iget v11, v4, Lmx4;->j:I

    .line 1188
    .line 1189
    if-eqz v11, :cond_4cb

    .line 1190
    .line 1191
    if-eq v11, v8, :cond_4c1

    .line 1192
    .line 1193
    if-ne v11, v5, :cond_4bc

    .line 1194
    .line 1195
    iget-object v0, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1196
    .line 1197
    check-cast v0, Ljw5;

    .line 1198
    .line 1199
    :try_start_4ae
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1200
    .line 1201
    .line 1202
    move-object/from16 v3, p1

    .line 1203
    .line 1204
    check-cast v3, Lz65;

    .line 1205
    .line 1206
    iget-object v3, v3, Lz65;->i:Ljava/lang/Object;
    :try_end_4b7
    .catch Ljava/lang/Exception; {:try_start_4ae .. :try_end_4b7} :catch_4b9

    .line 1207
    .line 1208
    goto/16 :goto_54c

    .line 1209
    .line 1210
    :catch_4b9
    move-exception v0

    .line 1211
    goto/16 :goto_5a1

    .line 1212
    .line 1213
    :cond_4bc
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1214
    .line 1215
    .line 1216
    goto/16 :goto_5b1

    .line 1217
    .line 1218
    :cond_4c1
    :try_start_4c1
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1219
    .line 1220
    .line 1221
    move-object/from16 v7, p1

    .line 1222
    .line 1223
    check-cast v7, Lz65;

    .line 1224
    .line 1225
    iget-object v7, v7, Lz65;->i:Ljava/lang/Object;
    :try_end_4ca
    .catch Ljava/lang/Exception; {:try_start_4c1 .. :try_end_4ca} :catch_4b9

    .line 1226
    .line 1227
    goto :goto_4d8

    .line 1228
    :cond_4cb
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1229
    .line 1230
    .line 1231
    :try_start_4ce
    iput v8, v4, Lmx4;->j:I

    .line 1232
    .line 1233
    invoke-virtual {v3, v4}, Lqr;->e(Lpe1;)Ljava/lang/Object;

    .line 1234
    .line 1235
    .line 1236
    move-result-object v7

    .line 1237
    if-ne v7, v10, :cond_4d8

    .line 1238
    .line 1239
    goto/16 :goto_54a

    .line 1240
    .line 1241
    :cond_4d8
    :goto_4d8
    invoke-static {v7}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1242
    .line 1243
    .line 1244
    check-cast v7, Ljava/util/List;

    .line 1245
    .line 1246
    sget-object v11, Lek;->a:Ljava/util/List;

    .line 1247
    .line 1248
    new-instance v11, Ljava/util/ArrayList;

    .line 1249
    .line 1250
    invoke-direct {v11}, Ljava/util/ArrayList;-><init>()V

    .line 1251
    .line 1252
    .line 1253
    invoke-interface {v7}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    .line 1254
    .line 1255
    .line 1256
    move-result-object v7

    .line 1257
    :cond_4e8
    :goto_4e8
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    .line 1258
    .line 1259
    .line 1260
    move-result v12

    .line 1261
    if-eqz v12, :cond_4fd

    .line 1262
    .line 1263
    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 1264
    .line 1265
    .line 1266
    move-result-object v12

    .line 1267
    move-object v13, v12

    .line 1268
    check-cast v13, Ltj;

    .line 1269
    .line 1270
    iget v13, v13, Ltj;->c:I

    .line 1271
    .line 1272
    if-nez v13, :cond_4e8

    .line 1273
    .line 1274
    invoke-virtual {v11, v12}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1275
    .line 1276
    .line 1277
    goto :goto_4e8

    .line 1278
    :cond_4fd
    invoke-static {v11}, Lek;->a(Ljava/util/ArrayList;)Ljava/util/ArrayList;

    .line 1279
    .line 1280
    .line 1281
    move-result-object v7

    .line 1282
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 1283
    .line 1284
    .line 1285
    invoke-virtual {v2, v9, v7}, Ljw5;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 1286
    .line 1287
    .line 1288
    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    .line 1289
    .line 1290
    .line 1291
    move-result v11

    .line 1292
    move v12, v6

    .line 1293
    :goto_50c
    if-ge v12, v11, :cond_52e

    .line 1294
    .line 1295
    invoke-virtual {v7, v12}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 1296
    .line 1297
    .line 1298
    move-result-object v13

    .line 1299
    add-int/lit8 v12, v12, 0x1

    .line 1300
    .line 1301
    move-object v14, v13

    .line 1302
    check-cast v14, Ltj;

    .line 1303
    .line 1304
    iget-object v15, v14, Ltj;->b:Ljava/lang/String;

    .line 1305
    .line 1306
    const-string v9, "\u52a8\u6f2b"

    .line 1307
    .line 1308
    invoke-static {v15, v9, v6}, Lkx5;->i0(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    .line 1309
    .line 1310
    .line 1311
    move-result v9

    .line 1312
    if-nez v9, :cond_52f

    .line 1313
    .line 1314
    iget-object v9, v14, Ltj;->b:Ljava/lang/String;

    .line 1315
    .line 1316
    const-string v14, "\u52a8\u753b"

    .line 1317
    .line 1318
    invoke-static {v9, v14, v6}, Lkx5;->i0(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    .line 1319
    .line 1320
    .line 1321
    move-result v9

    .line 1322
    if-eqz v9, :cond_52c

    .line 1323
    .line 1324
    goto :goto_52f

    .line 1325
    :cond_52c
    const/4 v9, 0x0

    .line 1326
    goto :goto_50c

    .line 1327
    :cond_52e
    const/4 v13, 0x0

    .line 1328
    :cond_52f
    :goto_52f
    check-cast v13, Ltj;

    .line 1329
    .line 1330
    if-nez v13, :cond_53a

    .line 1331
    .line 1332
    invoke-static {v7}, Lnr0;->w0(Ljava/util/List;)Ljava/lang/Object;

    .line 1333
    .line 1334
    .line 1335
    move-result-object v7

    .line 1336
    move-object v13, v7

    .line 1337
    check-cast v13, Ltj;

    .line 1338
    .line 1339
    :cond_53a
    if-eqz v13, :cond_5af

    .line 1340
    .line 1341
    iget-object v0, v0, Lgf5;->l:Ljw5;

    .line 1342
    .line 1343
    iget v7, v13, Ltj;->a:I

    .line 1344
    .line 1345
    iput-object v0, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1346
    .line 1347
    iput v5, v4, Lmx4;->j:I

    .line 1348
    .line 1349
    invoke-virtual {v3, v7, v8, v4}, Lqr;->d(IILpe1;)Ljava/lang/Object;

    .line 1350
    .line 1351
    .line 1352
    move-result-object v3

    .line 1353
    if-ne v3, v10, :cond_54c

    .line 1354
    .line 1355
    :goto_54a
    move-object v9, v10

    .line 1356
    goto :goto_5b1

    .line 1357
    :cond_54c
    :goto_54c
    instance-of v4, v3, Ly65;

    .line 1358
    .line 1359
    if-eqz v4, :cond_551

    .line 1360
    .line 1361
    const/4 v3, 0x0

    .line 1362
    :cond_551
    check-cast v3, Ljava/util/List;

    .line 1363
    .line 1364
    if-nez v3, :cond_556

    .line 1365
    .line 1366
    move-object v3, v1

    .line 1367
    :cond_556
    new-instance v4, Ljava/util/ArrayList;

    .line 1368
    .line 1369
    const/16 v5, 0xa

    .line 1370
    .line 1371
    invoke-static {v3, v5}, Lor0;->f0(Ljava/lang/Iterable;I)I

    .line 1372
    .line 1373
    .line 1374
    move-result v7

    .line 1375
    invoke-direct {v4, v7}, Ljava/util/ArrayList;-><init>(I)V

    .line 1376
    .line 1377
    .line 1378
    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    .line 1379
    .line 1380
    .line 1381
    move-result-object v3

    .line 1382
    :goto_565
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    .line 1383
    .line 1384
    .line 1385
    move-result v7

    .line 1386
    if-eqz v7, :cond_577

    .line 1387
    .line 1388
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 1389
    .line 1390
    .line 1391
    move-result-object v7

    .line 1392
    check-cast v7, Leq;

    .line 1393
    .line 1394
    iget-object v7, v7, Leq;->b:Ljava/lang/String;

    .line 1395
    .line 1396
    invoke-virtual {v4, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1397
    .line 1398
    .line 1399
    goto :goto_565

    .line 1400
    :cond_577
    new-instance v3, Ljava/util/ArrayList;

    .line 1401
    .line 1402
    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 1403
    .line 1404
    .line 1405
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    .line 1406
    .line 1407
    .line 1408
    move-result v7

    .line 1409
    :cond_580
    :goto_580
    if-ge v6, v7, :cond_595

    .line 1410
    .line 1411
    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    .line 1412
    .line 1413
    .line 1414
    move-result-object v8

    .line 1415
    add-int/lit8 v6, v6, 0x1

    .line 1416
    .line 1417
    move-object v9, v8

    .line 1418
    check-cast v9, Ljava/lang/String;

    .line 1419
    .line 1420
    invoke-static {v9}, Lkx5;->t0(Ljava/lang/CharSequence;)Z

    .line 1421
    .line 1422
    .line 1423
    move-result v9

    .line 1424
    if-nez v9, :cond_580

    .line 1425
    .line 1426
    invoke-virtual {v3, v8}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1427
    .line 1428
    .line 1429
    goto :goto_580

    .line 1430
    :cond_595
    invoke-static {v3, v5}, Lnr0;->S0(Ljava/lang/Iterable;I)Ljava/util/List;

    .line 1431
    .line 1432
    .line 1433
    move-result-object v3

    .line 1434
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 1435
    .line 1436
    .line 1437
    const/4 v4, 0x0

    .line 1438
    invoke-virtual {v0, v4, v3}, Ljw5;->l(Ljava/lang/Object;Ljava/lang/Object;)Z
    :try_end_5a0
    .catch Ljava/lang/Exception; {:try_start_4ce .. :try_end_5a0} :catch_4b9

    .line 1439
    .line 1440
    .line 1441
    goto :goto_5af

    .line 1442
    :goto_5a1
    const-string v3, "SearchViewModel"

    .line 1443
    .line 1444
    const-string v4, "loadCategories: \u52a0\u8f7d\u5931\u8d25"

    .line 1445
    .line 1446
    invoke-static {v3, v4, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 1447
    .line 1448
    .line 1449
    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 1450
    .line 1451
    .line 1452
    const/4 v4, 0x0

    .line 1453
    invoke-virtual {v2, v4, v1}, Ljw5;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 1454
    .line 1455
    .line 1456
    :cond_5af
    :goto_5af
    sget-object v9, Ldg6;->a:Ldg6;

    .line 1457
    .line 1458
    :goto_5b1
    return-object v9

    .line 1459
    :pswitch_5b2
    sget-object v0, Ldg6;->a:Ldg6;

    .line 1460
    .line 1461
    sget-object v1, Ljg1;->i:Ljg1;

    .line 1462
    .line 1463
    iget v2, v4, Lmx4;->j:I

    .line 1464
    .line 1465
    if-eqz v2, :cond_5c6

    .line 1466
    .line 1467
    if-ne v2, v8, :cond_5c1

    .line 1468
    .line 1469
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1470
    .line 1471
    .line 1472
    :cond_5bf
    move-object v9, v0

    .line 1473
    goto :goto_5ec

    .line 1474
    :cond_5c1
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1475
    .line 1476
    .line 1477
    const/4 v9, 0x0

    .line 1478
    goto :goto_5ec

    .line 1479
    :cond_5c6
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1480
    .line 1481
    .line 1482
    iget-object v2, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1483
    .line 1484
    check-cast v2, Lff5;

    .line 1485
    .line 1486
    iget-object v2, v2, Lff5;->a:Loe5;

    .line 1487
    .line 1488
    iget-object v3, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1489
    .line 1490
    check-cast v3, Ljava/lang/String;

    .line 1491
    .line 1492
    iput v8, v4, Lmx4;->j:I

    .line 1493
    .line 1494
    iget-object v5, v2, Loe5;->a:Landroid/content/Context;

    .line 1495
    .line 1496
    invoke-static {v5}, Lpe5;->a(Landroid/content/Context;)Landroidx/datastore/core/DataStore;

    .line 1497
    .line 1498
    .line 1499
    move-result-object v5

    .line 1500
    new-instance v6, Lme5;

    .line 1501
    .line 1502
    const/4 v7, 0x0

    .line 1503
    invoke-direct {v6, v3, v2, v7}, Lme5;-><init>(Ljava/lang/String;Loe5;Lne1;)V

    .line 1504
    .line 1505
    .line 1506
    invoke-static {v5, v6, v4}, Landroidx/datastore/preferences/core/PreferencesKt;->edit(Landroidx/datastore/core/DataStore;Lom2;Lne1;)Ljava/lang/Object;

    .line 1507
    .line 1508
    .line 1509
    move-result-object v2

    .line 1510
    if-ne v2, v1, :cond_5e8

    .line 1511
    .line 1512
    goto :goto_5e9

    .line 1513
    :cond_5e8
    move-object v2, v0

    .line 1514
    :goto_5e9
    if-ne v2, v1, :cond_5bf

    .line 1515
    .line 1516
    move-object v9, v1

    .line 1517
    :goto_5ec
    return-object v9

    .line 1518
    :pswitch_5ed
    sget-object v0, Ljg1;->i:Ljg1;

    .line 1519
    .line 1520
    iget v1, v4, Lmx4;->j:I

    .line 1521
    .line 1522
    if-eqz v1, :cond_5fe

    .line 1523
    .line 1524
    if-ne v1, v8, :cond_5f9

    .line 1525
    .line 1526
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1527
    .line 1528
    .line 1529
    goto :goto_624

    .line 1530
    :cond_5f9
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1531
    .line 1532
    .line 1533
    const/4 v9, 0x0

    .line 1534
    goto :goto_626

    .line 1535
    :cond_5fe
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1536
    .line 1537
    .line 1538
    iget-object v1, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1539
    .line 1540
    check-cast v1, Ldy1;

    .line 1541
    .line 1542
    iget-boolean v2, v1, Ldy1;->b:Z

    .line 1543
    .line 1544
    if-eqz v2, :cond_60c

    .line 1545
    .line 1546
    const/high16 v2, -0x40800000    # -1.0f

    .line 1547
    .line 1548
    goto :goto_60e

    .line 1549
    :cond_60c
    const/high16 v2, 0x3f800000    # 1.0f

    .line 1550
    .line 1551
    :goto_60e
    iget-object v3, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1552
    .line 1553
    check-cast v3, Lwd5;

    .line 1554
    .line 1555
    iget-object v3, v3, Lwd5;->V:Lee5;

    .line 1556
    .line 1557
    iget-wide v9, v1, Ldy1;->a:J

    .line 1558
    .line 1559
    invoke-static {v9, v10, v2}, Lkj6;->f(JF)J

    .line 1560
    .line 1561
    .line 1562
    move-result-wide v1

    .line 1563
    iput v8, v4, Lmx4;->j:I

    .line 1564
    .line 1565
    invoke-virtual {v3, v1, v2, v6, v4}, Lee5;->b(JZLyz5;)Ljava/lang/Object;

    .line 1566
    .line 1567
    .line 1568
    move-result-object v1

    .line 1569
    if-ne v1, v0, :cond_624

    .line 1570
    .line 1571
    move-object v9, v0

    .line 1572
    goto :goto_626

    .line 1573
    :cond_624
    :goto_624
    sget-object v9, Ldg6;->a:Ldg6;

    .line 1574
    .line 1575
    :goto_626
    return-object v9

    .line 1576
    :pswitch_627
    iget-object v0, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1577
    .line 1578
    check-cast v0, Lgg;

    .line 1579
    .line 1580
    sget-object v1, Ljg1;->i:Ljg1;

    .line 1581
    .line 1582
    iget v2, v4, Lmx4;->j:I

    .line 1583
    .line 1584
    if-eqz v2, :cond_63c

    .line 1585
    .line 1586
    if-ne v2, v8, :cond_637

    .line 1587
    .line 1588
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1589
    .line 1590
    .line 1591
    goto :goto_65a

    .line 1592
    :cond_637
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1593
    .line 1594
    .line 1595
    const/4 v9, 0x0

    .line 1596
    goto :goto_65c

    .line 1597
    :cond_63c
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1598
    .line 1599
    .line 1600
    iget-object v2, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1601
    .line 1602
    check-cast v2, Lhg1;

    .line 1603
    .line 1604
    iget-object v3, v0, Lgg;->w:Lk53;

    .line 1605
    .line 1606
    invoke-interface {v3}, Lk53;->a()Lcg2;

    .line 1607
    .line 1608
    .line 1609
    move-result-object v3

    .line 1610
    new-instance v5, Ld1;

    .line 1611
    .line 1612
    const/16 v6, 0xf

    .line 1613
    .line 1614
    invoke-direct {v5, v6, v0, v2}, Ld1;-><init>(ILjava/lang/Object;Ljava/lang/Object;)V

    .line 1615
    .line 1616
    .line 1617
    iput v8, v4, Lmx4;->j:I

    .line 1618
    .line 1619
    invoke-interface {v3, v5, v4}, Lcg2;->collect(Ldg2;Lne1;)Ljava/lang/Object;

    .line 1620
    .line 1621
    .line 1622
    move-result-object v0

    .line 1623
    if-ne v0, v1, :cond_65a

    .line 1624
    .line 1625
    move-object v9, v1

    .line 1626
    goto :goto_65c

    .line 1627
    :cond_65a
    :goto_65a
    sget-object v9, Ldg6;->a:Ldg6;

    .line 1628
    .line 1629
    :goto_65c
    return-object v9

    .line 1630
    :pswitch_65d
    sget-object v0, Ljg1;->i:Ljg1;

    .line 1631
    .line 1632
    iget v1, v4, Lmx4;->j:I

    .line 1633
    .line 1634
    if-eqz v1, :cond_66e

    .line 1635
    .line 1636
    if-ne v1, v8, :cond_669

    .line 1637
    .line 1638
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1639
    .line 1640
    .line 1641
    goto :goto_68b

    .line 1642
    :cond_669
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1643
    .line 1644
    .line 1645
    const/4 v9, 0x0

    .line 1646
    goto :goto_68d

    .line 1647
    :cond_66e
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1648
    .line 1649
    .line 1650
    iget-object v1, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1651
    .line 1652
    check-cast v1, Lqb4;

    .line 1653
    .line 1654
    iget-object v2, v1, Lqb4;->i:Ljava/lang/Object;

    .line 1655
    .line 1656
    check-cast v2, Lpz2;

    .line 1657
    .line 1658
    iget-object v1, v1, Lqb4;->j:Ljava/lang/Object;

    .line 1659
    .line 1660
    check-cast v1, Lhz4;

    .line 1661
    .line 1662
    iget-object v3, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1663
    .line 1664
    check-cast v3, Li65;

    .line 1665
    .line 1666
    iput v8, v4, Lmx4;->j:I

    .line 1667
    .line 1668
    invoke-virtual {v3, v6, v4, v2, v1}, Li65;->e(ILpe1;Lpz2;Lhz4;)Ljava/lang/Object;

    .line 1669
    .line 1670
    .line 1671
    move-result-object v1

    .line 1672
    if-ne v1, v0, :cond_68b

    .line 1673
    .line 1674
    move-object v9, v0

    .line 1675
    goto :goto_68d

    .line 1676
    :cond_68b
    :goto_68b
    sget-object v9, Ldg6;->a:Ldg6;

    .line 1677
    .line 1678
    :goto_68d
    return-object v9

    .line 1679
    :pswitch_68e
    sget-object v0, Ldg6;->a:Ldg6;

    .line 1680
    .line 1681
    iget-object v1, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1682
    .line 1683
    check-cast v1, Lcom/picacg/domain/model/RequestMode;

    .line 1684
    .line 1685
    iget-object v2, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1686
    .line 1687
    check-cast v2, Lv55;

    .line 1688
    .line 1689
    sget-object v3, Ljg1;->i:Ljg1;

    .line 1690
    .line 1691
    iget v5, v4, Lmx4;->j:I

    .line 1692
    .line 1693
    if-eqz v5, :cond_6a9

    .line 1694
    .line 1695
    if-ne v5, v8, :cond_6a4

    .line 1696
    .line 1697
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1698
    .line 1699
    .line 1700
    goto :goto_6d5

    .line 1701
    :cond_6a4
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1702
    .line 1703
    .line 1704
    const/4 v9, 0x0

    .line 1705
    goto :goto_6f1

    .line 1706
    :cond_6a9
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1707
    .line 1708
    .line 1709
    iget-object v5, v2, Lv55;->d:Ljw5;

    .line 1710
    .line 1711
    invoke-virtual {v5, v1}, Ljw5;->k(Ljava/lang/Object;)V

    .line 1712
    .line 1713
    .line 1714
    iget-object v5, v2, Lv55;->a:Lp95;

    .line 1715
    .line 1716
    iput v8, v4, Lmx4;->j:I

    .line 1717
    .line 1718
    iget-object v7, v5, Lp95;->a:Landroid/content/Context;

    .line 1719
    .line 1720
    iget-object v5, v5, Lp95;->b:Lir4;

    .line 1721
    .line 1722
    sget-object v8, Lp95;->c:[Lba3;

    .line 1723
    .line 1724
    aget-object v6, v8, v6

    .line 1725
    .line 1726
    invoke-interface {v5, v7, v6}, Lir4;->getValue(Ljava/lang/Object;Lba3;)Ljava/lang/Object;

    .line 1727
    .line 1728
    .line 1729
    move-result-object v5

    .line 1730
    check-cast v5, Landroidx/datastore/core/DataStore;

    .line 1731
    .line 1732
    new-instance v6, Lo95;

    .line 1733
    .line 1734
    const/4 v7, 0x0

    .line 1735
    invoke-direct {v6, v1, v7}, Lo95;-><init>(Lcom/picacg/domain/model/RequestMode;Lne1;)V

    .line 1736
    .line 1737
    .line 1738
    invoke-static {v5, v6, v4}, Landroidx/datastore/preferences/core/PreferencesKt;->edit(Landroidx/datastore/core/DataStore;Lom2;Lne1;)Ljava/lang/Object;

    .line 1739
    .line 1740
    .line 1741
    move-result-object v1

    .line 1742
    if-ne v1, v3, :cond_6d0

    .line 1743
    .line 1744
    goto :goto_6d1

    .line 1745
    :cond_6d0
    move-object v1, v0

    .line 1746
    :goto_6d1
    if-ne v1, v3, :cond_6d5

    .line 1747
    .line 1748
    move-object v9, v3

    .line 1749
    goto :goto_6f1

    .line 1750
    :cond_6d5
    :goto_6d5
    iget-object v1, v2, Lv55;->b:Lp54;

    .line 1751
    .line 1752
    iget-object v2, v1, Lp54;->k:Ljava/util/concurrent/ConcurrentHashMap;

    .line 1753
    .line 1754
    invoke-virtual {v2}, Ljava/util/concurrent/ConcurrentHashMap;->clear()V

    .line 1755
    .line 1756
    .line 1757
    iget-object v2, v1, Lp54;->l:Ljava/util/concurrent/ConcurrentHashMap;

    .line 1758
    .line 1759
    invoke-virtual {v2}, Ljava/util/concurrent/ConcurrentHashMap;->clear()V

    .line 1760
    .line 1761
    .line 1762
    sget-object v2, Lhz2;->a:Landroid/util/LruCache;

    .line 1763
    .line 1764
    invoke-virtual {v2}, Landroid/util/LruCache;->evictAll()V

    .line 1765
    .line 1766
    .line 1767
    iget-object v2, v1, Lp54;->h:Lup2;

    .line 1768
    .line 1769
    invoke-virtual {v2}, Lup2;->p()V

    .line 1770
    .line 1771
    .line 1772
    iget-object v1, v1, Lp54;->j:Lup2;

    .line 1773
    .line 1774
    invoke-virtual {v1}, Lup2;->p()V

    .line 1775
    .line 1776
    .line 1777
    move-object v9, v0

    .line 1778
    :goto_6f1
    return-object v9

    .line 1779
    :pswitch_6f2
    sget-object v0, Ldg6;->a:Ldg6;

    .line 1780
    .line 1781
    iget-object v1, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1782
    .line 1783
    check-cast v1, Lv55;

    .line 1784
    .line 1785
    iget-object v2, v1, Lv55;->a:Lp95;

    .line 1786
    .line 1787
    sget-object v3, Ljg1;->i:Ljg1;

    .line 1788
    .line 1789
    iget v9, v4, Lmx4;->j:I

    .line 1790
    .line 1791
    if-eqz v9, :cond_719

    .line 1792
    .line 1793
    if-eq v9, v8, :cond_70e

    .line 1794
    .line 1795
    if-ne v9, v5, :cond_709

    .line 1796
    .line 1797
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1798
    .line 1799
    .line 1800
    :cond_707
    move-object v9, v0

    .line 1801
    goto :goto_756

    .line 1802
    :cond_709
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1803
    .line 1804
    .line 1805
    const/4 v9, 0x0

    .line 1806
    goto :goto_756

    .line 1807
    :cond_70e
    iget-object v6, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1808
    .line 1809
    check-cast v6, Ljw5;

    .line 1810
    .line 1811
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1812
    .line 1813
    .line 1814
    move-object v7, v6

    .line 1815
    move-object/from16 v6, p1

    .line 1816
    .line 1817
    goto :goto_742

    .line 1818
    :cond_719
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1819
    .line 1820
    .line 1821
    iget-object v7, v1, Lv55;->d:Ljw5;

    .line 1822
    .line 1823
    iput-object v7, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1824
    .line 1825
    iput v8, v4, Lmx4;->j:I

    .line 1826
    .line 1827
    iget-object v8, v2, Lp95;->a:Landroid/content/Context;

    .line 1828
    .line 1829
    iget-object v9, v2, Lp95;->b:Lir4;

    .line 1830
    .line 1831
    sget-object v10, Lp95;->c:[Lba3;

    .line 1832
    .line 1833
    aget-object v6, v10, v6

    .line 1834
    .line 1835
    invoke-interface {v9, v8, v6}, Lir4;->getValue(Ljava/lang/Object;Lba3;)Ljava/lang/Object;

    .line 1836
    .line 1837
    .line 1838
    move-result-object v6

    .line 1839
    check-cast v6, Landroidx/datastore/core/DataStore;

    .line 1840
    .line 1841
    invoke-interface {v6}, Landroidx/datastore/core/DataStore;->getData()Lcg2;

    .line 1842
    .line 1843
    .line 1844
    move-result-object v6

    .line 1845
    new-instance v8, Lbs4;

    .line 1846
    .line 1847
    const/16 v9, 0x1c

    .line 1848
    .line 1849
    invoke-direct {v8, v6, v9}, Lbs4;-><init>(Lcg2;I)V

    .line 1850
    .line 1851
    .line 1852
    invoke-static {v8, v4}, Lkl0;->I(Lcg2;Lne1;)Ljava/lang/Object;

    .line 1853
    .line 1854
    .line 1855
    move-result-object v6

    .line 1856
    if-ne v6, v3, :cond_742

    .line 1857
    .line 1858
    goto :goto_755

    .line 1859
    :cond_742
    :goto_742
    invoke-virtual {v7, v6}, Ljw5;->k(Ljava/lang/Object;)V

    .line 1860
    .line 1861
    .line 1862
    iget-object v1, v1, Lv55;->f:Lh51;

    .line 1863
    .line 1864
    invoke-virtual {v1, v0}, Lx73;->N(Ljava/lang/Object;)Z

    .line 1865
    .line 1866
    .line 1867
    const/4 v7, 0x0

    .line 1868
    iput-object v7, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1869
    .line 1870
    iput v5, v4, Lmx4;->j:I

    .line 1871
    .line 1872
    invoke-virtual {v2, v4}, Lp95;->a(Lpe1;)Ljava/lang/Object;

    .line 1873
    .line 1874
    .line 1875
    move-result-object v1

    .line 1876
    if-ne v1, v3, :cond_707

    .line 1877
    .line 1878
    :goto_755
    move-object v9, v3

    .line 1879
    :goto_756
    return-object v9

    .line 1880
    :pswitch_757
    sget-object v0, Ljg1;->i:Ljg1;

    .line 1881
    .line 1882
    iget v1, v4, Lmx4;->j:I

    .line 1883
    .line 1884
    if-eqz v1, :cond_768

    .line 1885
    .line 1886
    if-ne v1, v8, :cond_763

    .line 1887
    .line 1888
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1889
    .line 1890
    .line 1891
    goto :goto_77d

    .line 1892
    :cond_763
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1893
    .line 1894
    .line 1895
    const/4 v9, 0x0

    .line 1896
    goto :goto_77f

    .line 1897
    :cond_768
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1898
    .line 1899
    .line 1900
    iget-object v1, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1901
    .line 1902
    check-cast v1, Lhg1;

    .line 1903
    .line 1904
    iget-object v2, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1905
    .line 1906
    check-cast v2, Lom2;

    .line 1907
    .line 1908
    iput v8, v4, Lmx4;->j:I

    .line 1909
    .line 1910
    invoke-interface {v2, v1, v4}, Lom2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 1911
    .line 1912
    .line 1913
    move-result-object v1

    .line 1914
    if-ne v1, v0, :cond_77d

    .line 1915
    .line 1916
    move-object v9, v0

    .line 1917
    goto :goto_77f

    .line 1918
    :cond_77d
    :goto_77d
    sget-object v9, Ldg6;->a:Ldg6;

    .line 1919
    .line 1920
    :goto_77f
    return-object v9

    .line 1921
    :pswitch_780
    iget-object v0, v4, Lmx4;->l:Ljava/lang/Object;

    .line 1922
    .line 1923
    move-object v1, v0

    .line 1924
    check-cast v1, Lw45;

    .line 1925
    .line 1926
    const-string v0, "cache_duration"

    .line 1927
    .line 1928
    const-string v2, "session_timeout_seconds"

    .line 1929
    .line 1930
    const-string v3, "sampling_rate"

    .line 1931
    .line 1932
    const-string v5, "sessions_enabled"

    .line 1933
    .line 1934
    sget-object v6, Ljg1;->i:Ljg1;

    .line 1935
    .line 1936
    iget v9, v4, Lmx4;->j:I

    .line 1937
    .line 1938
    if-eqz v9, :cond_7a0

    .line 1939
    .line 1940
    if-ne v9, v8, :cond_79a

    .line 1941
    .line 1942
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1943
    .line 1944
    .line 1945
    goto/16 :goto_84b

    .line 1946
    .line 1947
    :cond_79a
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 1948
    .line 1949
    .line 1950
    const/4 v9, 0x0

    .line 1951
    goto/16 :goto_84d

    .line 1952
    .line 1953
    :cond_7a0
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 1954
    .line 1955
    .line 1956
    iget-object v7, v4, Lmx4;->k:Ljava/lang/Object;

    .line 1957
    .line 1958
    check-cast v7, Lorg/json/JSONObject;

    .line 1959
    .line 1960
    invoke-static {v7}, Ljava/util/Objects;->toString(Ljava/lang/Object;)Ljava/lang/String;

    .line 1961
    .line 1962
    .line 1963
    const-string v9, "app_quality"

    .line 1964
    .line 1965
    invoke-virtual {v7, v9}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    .line 1966
    .line 1967
    .line 1968
    move-result v10

    .line 1969
    if-eqz v10, :cond_816

    .line 1970
    .line 1971
    invoke-virtual {v7, v9}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    .line 1972
    .line 1973
    .line 1974
    move-result-object v7

    .line 1975
    invoke-virtual {v7}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 1976
    .line 1977
    .line 1978
    check-cast v7, Lorg/json/JSONObject;

    .line 1979
    .line 1980
    :try_start_7bb
    invoke-virtual {v7, v5}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    .line 1981
    .line 1982
    .line 1983
    move-result v9

    .line 1984
    if-eqz v9, :cond_7cd

    .line 1985
    .line 1986
    invoke-virtual {v7, v5}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    .line 1987
    .line 1988
    .line 1989
    move-result-object v5

    .line 1990
    check-cast v5, Ljava/lang/Boolean;
    :try_end_7c7
    .catch Lorg/json/JSONException; {:try_start_7bb .. :try_end_7c7} :catch_7c8

    .line 1991
    .line 1992
    goto :goto_7ce

    .line 1993
    :catch_7c8
    move-exception v0

    .line 1994
    const/4 v2, 0x0

    .line 1995
    const/4 v3, 0x0

    .line 1996
    const/4 v5, 0x0

    .line 1997
    goto :goto_806

    .line 1998
    :cond_7cd
    const/4 v5, 0x0

    .line 1999
    :goto_7ce
    :try_start_7ce
    invoke-virtual {v7, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    .line 2000
    .line 2001
    .line 2002
    move-result v9

    .line 2003
    if-eqz v9, :cond_7df

    .line 2004
    .line 2005
    invoke-virtual {v7, v3}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    .line 2006
    .line 2007
    .line 2008
    move-result-object v3

    .line 2009
    check-cast v3, Ljava/lang/Double;
    :try_end_7da
    .catch Lorg/json/JSONException; {:try_start_7ce .. :try_end_7da} :catch_7db

    .line 2010
    .line 2011
    goto :goto_7e0

    .line 2012
    :catch_7db
    move-exception v0

    .line 2013
    const/4 v2, 0x0

    .line 2014
    const/4 v3, 0x0

    .line 2015
    goto :goto_806

    .line 2016
    :cond_7df
    const/4 v3, 0x0

    .line 2017
    :goto_7e0
    :try_start_7e0
    invoke-virtual {v7, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    .line 2018
    .line 2019
    .line 2020
    move-result v9

    .line 2021
    if-eqz v9, :cond_7f0

    .line 2022
    .line 2023
    invoke-virtual {v7, v2}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    .line 2024
    .line 2025
    .line 2026
    move-result-object v2

    .line 2027
    check-cast v2, Ljava/lang/Integer;
    :try_end_7ec
    .catch Lorg/json/JSONException; {:try_start_7e0 .. :try_end_7ec} :catch_7ed

    .line 2028
    .line 2029
    goto :goto_7f1

    .line 2030
    :catch_7ed
    move-exception v0

    .line 2031
    const/4 v2, 0x0

    .line 2032
    goto :goto_806

    .line 2033
    :cond_7f0
    const/4 v2, 0x0

    .line 2034
    :goto_7f1
    :try_start_7f1
    invoke-virtual {v7, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    .line 2035
    .line 2036
    .line 2037
    move-result v9

    .line 2038
    if-eqz v9, :cond_801

    .line 2039
    .line 2040
    invoke-virtual {v7, v0}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    .line 2041
    .line 2042
    .line 2043
    move-result-object v0

    .line 2044
    check-cast v0, Ljava/lang/Integer;
    :try_end_7fd
    .catch Lorg/json/JSONException; {:try_start_7f1 .. :try_end_7fd} :catch_7ff

    .line 2045
    .line 2046
    move-object v9, v0

    .line 2047
    goto :goto_802

    .line 2048
    :catch_7ff
    move-exception v0

    .line 2049
    goto :goto_806

    .line 2050
    :cond_801
    const/4 v9, 0x0

    .line 2051
    :goto_802
    move-object v12, v2

    .line 2052
    move-object v11, v3

    .line 2053
    move-object v10, v5

    .line 2054
    goto :goto_81a

    .line 2055
    :goto_806
    const-string v7, "FirebaseSessions"

    .line 2056
    .line 2057
    const-string v9, "Error parsing the configs remotely fetched: "

    .line 2058
    .line 2059
    invoke-static {v7, v9, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2060
    .line 2061
    .line 2062
    move-result v0

    .line 2063
    invoke-static {v0}, Luo3;->G(I)Ljava/lang/Integer;

    .line 2064
    .line 2065
    .line 2066
    move-object v12, v2

    .line 2067
    move-object v11, v3

    .line 2068
    move-object v10, v5

    .line 2069
    const/4 v9, 0x0

    .line 2070
    goto :goto_81a

    .line 2071
    :cond_816
    const/4 v9, 0x0

    .line 2072
    const/4 v10, 0x0

    .line 2073
    const/4 v11, 0x0

    .line 2074
    const/4 v12, 0x0

    .line 2075
    :goto_81a
    iget-object v0, v1, Lw45;->e:Luk5;

    .line 2076
    .line 2077
    if-eqz v9, :cond_823

    .line 2078
    .line 2079
    invoke-virtual {v9}, Ljava/lang/Integer;->intValue()I

    .line 2080
    .line 2081
    .line 2082
    move-result v2

    .line 2083
    goto :goto_825

    .line 2084
    :cond_823
    sget v2, Lw45;->g:I

    .line 2085
    .line 2086
    :goto_825
    iget-object v1, v1, Lw45;->a:Lt86;

    .line 2087
    .line 2088
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2089
    .line 2090
    .line 2091
    invoke-static {}, Lt86;->a()Lr86;

    .line 2092
    .line 2093
    .line 2094
    move-result-object v1

    .line 2095
    iget-wide v13, v1, Lr86;->c:J

    .line 2096
    .line 2097
    new-instance v9, Lmj5;

    .line 2098
    .line 2099
    new-instance v1, Ljava/lang/Integer;

    .line 2100
    .line 2101
    invoke-direct {v1, v2}, Ljava/lang/Integer;-><init>(I)V

    .line 2102
    .line 2103
    .line 2104
    new-instance v2, Ljava/lang/Long;

    .line 2105
    .line 2106
    invoke-direct {v2, v13, v14}, Ljava/lang/Long;-><init>(J)V

    .line 2107
    .line 2108
    .line 2109
    move-object v13, v1

    .line 2110
    move-object v14, v2

    .line 2111
    invoke-direct/range {v9 .. v14}, Lmj5;-><init>(Ljava/lang/Boolean;Ljava/lang/Double;Ljava/lang/Integer;Ljava/lang/Integer;Ljava/lang/Long;)V

    .line 2112
    .line 2113
    .line 2114
    iput v8, v4, Lmx4;->j:I

    .line 2115
    .line 2116
    invoke-virtual {v0, v9, v4}, Luk5;->c(Lmj5;Lpe1;)Ljava/lang/Object;

    .line 2117
    .line 2118
    .line 2119
    move-result-object v0

    .line 2120
    if-ne v0, v6, :cond_84b

    .line 2121
    .line 2122
    move-object v9, v6

    .line 2123
    goto :goto_84d

    .line 2124
    :cond_84b
    :goto_84b
    sget-object v9, Ldg6;->a:Ldg6;

    .line 2125
    .line 2126
    :goto_84d
    return-object v9

    .line 2127
    :pswitch_84e
    iget-object v0, v4, Lmx4;->l:Ljava/lang/Object;

    .line 2128
    .line 2129
    move-object v1, v0

    .line 2130
    check-cast v1, Ljava/util/List;

    .line 2131
    .line 2132
    iget-object v0, v4, Lmx4;->k:Ljava/lang/Object;

    .line 2133
    .line 2134
    move-object v2, v0

    .line 2135
    check-cast v2, Lp10;

    .line 2136
    .line 2137
    sget-object v0, Ljg1;->i:Ljg1;

    .line 2138
    .line 2139
    iget v3, v4, Lmx4;->j:I

    .line 2140
    .line 2141
    if-eqz v3, :cond_871

    .line 2142
    .line 2143
    if-ne v3, v8, :cond_86b

    .line 2144
    .line 2145
    :try_start_860
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V
    :try_end_863
    .catch Ljava/lang/Exception; {:try_start_860 .. :try_end_863} :catch_869
    .catchall {:try_start_860 .. :try_end_863} :catchall_866

    .line 2146
    .line 2147
    .line 2148
    move-object/from16 v3, p1

    .line 2149
    .line 2150
    goto :goto_8a2

    .line 2151
    :catchall_866
    move-exception v0

    .line 2152
    goto/16 :goto_8ef

    .line 2153
    .line 2154
    :catch_869
    move-exception v0

    .line 2155
    goto :goto_8d0

    .line 2156
    :cond_86b
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 2157
    .line 2158
    .line 2159
    const/4 v9, 0x0

    .line 2160
    goto/16 :goto_8ee

    .line 2161
    .line 2162
    :cond_871
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 2163
    .line 2164
    .line 2165
    iget-object v3, v2, Lp10;->j:Ljava/lang/Object;

    .line 2166
    .line 2167
    check-cast v3, Ljw5;

    .line 2168
    .line 2169
    sget-object v5, Ljava/lang/Boolean;->TRUE:Ljava/lang/Boolean;

    .line 2170
    .line 2171
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2172
    .line 2173
    .line 2174
    const/4 v7, 0x0

    .line 2175
    invoke-virtual {v3, v7, v5}, Ljw5;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2176
    .line 2177
    .line 2178
    iget-object v3, v2, Lp10;->h:Ljava/lang/Object;

    .line 2179
    .line 2180
    check-cast v3, Ljw5;

    .line 2181
    .line 2182
    sget-object v5, Lb42;->i:Lb42;

    .line 2183
    .line 2184
    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2185
    .line 2186
    .line 2187
    invoke-virtual {v3, v7, v5}, Ljw5;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2188
    .line 2189
    .line 2190
    :try_start_88d
    iget-object v3, v2, Lp10;->b:Ljava/lang/Object;

    .line 2191
    .line 2192
    check-cast v3, Luv;

    .line 2193
    .line 2194
    iput v8, v4, Lmx4;->j:I

    .line 2195
    .line 2196
    new-instance v5, Lue;

    .line 2197
    .line 2198
    const/16 v6, 0x11

    .line 2199
    .line 2200
    invoke-direct {v5, v1, v3, v7, v6}, Lue;-><init>(Ljava/lang/Object;Ljava/lang/Object;Lne1;I)V

    .line 2201
    .line 2202
    .line 2203
    invoke-static {v5, v4}, Lin0;->N(Lom2;Lne1;)Ljava/lang/Object;

    .line 2204
    .line 2205
    .line 2206
    move-result-object v3

    .line 2207
    if-ne v3, v0, :cond_8a2

    .line 2208
    .line 2209
    move-object v9, v0

    .line 2210
    goto :goto_8ee

    .line 2211
    :cond_8a2
    :goto_8a2
    check-cast v3, Ljava/util/List;

    .line 2212
    .line 2213
    invoke-interface {v3}, Ljava/util/Collection;->isEmpty()Z

    .line 2214
    .line 2215
    .line 2216
    move-result v0

    .line 2217
    if-nez v0, :cond_8bf

    .line 2218
    .line 2219
    iget-object v0, v2, Lp10;->d:Ljava/lang/Object;

    .line 2220
    .line 2221
    check-cast v0, Ljw5;

    .line 2222
    .line 2223
    invoke-virtual {v0}, Ljw5;->getValue()Ljava/lang/Object;

    .line 2224
    .line 2225
    .line 2226
    move-result-object v4

    .line 2227
    check-cast v4, Ljava/util/Collection;

    .line 2228
    .line 2229
    invoke-static {v3, v4}, Lnr0;->H0(Ljava/lang/Iterable;Ljava/util/Collection;)Ljava/util/ArrayList;

    .line 2230
    .line 2231
    .line 2232
    move-result-object v4

    .line 2233
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2234
    .line 2235
    .line 2236
    const/4 v7, 0x0

    .line 2237
    invoke-virtual {v0, v7, v4}, Ljw5;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2238
    .line 2239
    .line 2240
    :cond_8bf
    invoke-interface {v3}, Ljava/util/List;->size()I
    :try_end_8c2
    .catch Ljava/lang/Exception; {:try_start_88d .. :try_end_8c2} :catch_869
    .catchall {:try_start_88d .. :try_end_8c2} :catchall_866

    .line 2241
    .line 2242
    .line 2243
    iget-object v0, v2, Lp10;->j:Ljava/lang/Object;

    .line 2244
    .line 2245
    check-cast v0, Ljw5;

    .line 2246
    .line 2247
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    .line 2248
    .line 2249
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2250
    .line 2251
    .line 2252
    const/4 v7, 0x0

    .line 2253
    :goto_8cc
    invoke-virtual {v0, v7, v1}, Ljw5;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2254
    .line 2255
    .line 2256
    goto :goto_8ec

    .line 2257
    :goto_8d0
    :try_start_8d0
    const-string v3, "RelatedComicsLoader"

    .line 2258
    .line 2259
    const-string v4, "loadMoreRelatedComics failed silently, restoring pending ids"

    .line 2260
    .line 2261
    invoke-static {v3, v4, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2262
    .line 2263
    .line 2264
    iget-object v0, v2, Lp10;->h:Ljava/lang/Object;

    .line 2265
    .line 2266
    check-cast v0, Ljw5;

    .line 2267
    .line 2268
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2269
    .line 2270
    .line 2271
    const/4 v7, 0x0

    .line 2272
    invoke-virtual {v0, v7, v1}, Ljw5;->l(Ljava/lang/Object;Ljava/lang/Object;)Z
    :try_end_8e2
    .catchall {:try_start_8d0 .. :try_end_8e2} :catchall_866

    .line 2273
    .line 2274
    .line 2275
    iget-object v0, v2, Lp10;->j:Ljava/lang/Object;

    .line 2276
    .line 2277
    check-cast v0, Ljw5;

    .line 2278
    .line 2279
    sget-object v1, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    .line 2280
    .line 2281
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2282
    .line 2283
    .line 2284
    goto :goto_8cc

    .line 2285
    :goto_8ec
    sget-object v9, Ldg6;->a:Ldg6;

    .line 2286
    .line 2287
    :goto_8ee
    return-object v9

    .line 2288
    :goto_8ef
    iget-object v1, v2, Lp10;->j:Ljava/lang/Object;

    .line 2289
    .line 2290
    check-cast v1, Ljw5;

    .line 2291
    .line 2292
    sget-object v2, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    .line 2293
    .line 2294
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2295
    .line 2296
    .line 2297
    const/4 v3, 0x0

    .line 2298
    invoke-virtual {v1, v3, v2}, Ljw5;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 2299
    .line 2300
    .line 2301
    throw v0

    .line 2302
    :pswitch_8fd
    move-object v3, v9

    .line 2303
    iget-object v0, v4, Lmx4;->l:Ljava/lang/Object;

    .line 2304
    .line 2305
    check-cast v0, Lcom/picacg/domain/model/HistoryRecord;

    .line 2306
    .line 2307
    sget-object v2, Ljg1;->i:Ljg1;

    .line 2308
    .line 2309
    iget v5, v4, Lmx4;->j:I

    .line 2310
    .line 2311
    if-eqz v5, :cond_919

    .line 2312
    .line 2313
    if-ne v5, v8, :cond_914

    .line 2314
    .line 2315
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 2316
    .line 2317
    .line 2318
    move-object/from16 v2, p1

    .line 2319
    .line 2320
    check-cast v2, Lz65;

    .line 2321
    .line 2322
    iget-object v2, v2, Lz65;->i:Ljava/lang/Object;

    .line 2323
    .line 2324
    goto :goto_92d

    .line 2325
    :cond_914
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 2326
    .line 2327
    .line 2328
    move-object v9, v3

    .line 2329
    goto :goto_94a

    .line 2330
    :cond_919
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 2331
    .line 2332
    .line 2333
    iget-object v3, v4, Lmx4;->k:Ljava/lang/Object;

    .line 2334
    .line 2335
    check-cast v3, Lsy4;

    .line 2336
    .line 2337
    iget-object v3, v3, Lsy4;->a:Liy4;

    .line 2338
    .line 2339
    iput v8, v4, Lmx4;->j:I

    .line 2340
    .line 2341
    invoke-virtual {v3, v0, v4}, Liy4;->g(Lcom/picacg/domain/model/HistoryRecord;Lpe1;)Ljava/lang/Object;

    .line 2342
    .line 2343
    .line 2344
    move-result-object v3

    .line 2345
    if-ne v3, v2, :cond_92c

    .line 2346
    .line 2347
    move-object v9, v2

    .line 2348
    goto :goto_94a

    .line 2349
    :cond_92c
    move-object v2, v3

    .line 2350
    :goto_92d
    invoke-static {v2}, Lz65;->a(Ljava/lang/Object;)Ljava/lang/Throwable;

    .line 2351
    .line 2352
    .line 2353
    move-result-object v2

    .line 2354
    if-eqz v2, :cond_948

    .line 2355
    .line 2356
    invoke-virtual {v0}, Lcom/picacg/domain/model/HistoryRecord;->getComicId()Ljava/lang/String;

    .line 2357
    .line 2358
    .line 2359
    move-result-object v0

    .line 2360
    new-instance v3, Ljava/lang/StringBuilder;

    .line 2361
    .line 2362
    const-string v4, "Failed to undo delete: "

    .line 2363
    .line 2364
    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    .line 2365
    .line 2366
    .line 2367
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 2368
    .line 2369
    .line 2370
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    .line 2371
    .line 2372
    .line 2373
    move-result-object v0

    .line 2374
    invoke-static {v1, v0, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2375
    .line 2376
    .line 2377
    :cond_948
    sget-object v9, Ldg6;->a:Ldg6;

    .line 2378
    .line 2379
    :goto_94a
    return-object v9

    .line 2380
    :pswitch_94b
    move-object v3, v9

    .line 2381
    iget-object v0, v4, Lmx4;->l:Ljava/lang/Object;

    .line 2382
    .line 2383
    check-cast v0, Ljava/lang/String;

    .line 2384
    .line 2385
    iget-object v2, v4, Lmx4;->k:Ljava/lang/Object;

    .line 2386
    .line 2387
    check-cast v2, Lsy4;

    .line 2388
    .line 2389
    sget-object v5, Ljg1;->i:Ljg1;

    .line 2390
    .line 2391
    iget v6, v4, Lmx4;->j:I

    .line 2392
    .line 2393
    if-eqz v6, :cond_96b

    .line 2394
    .line 2395
    if-ne v6, v8, :cond_966

    .line 2396
    .line 2397
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 2398
    .line 2399
    .line 2400
    move-object/from16 v3, p1

    .line 2401
    .line 2402
    check-cast v3, Lz65;

    .line 2403
    .line 2404
    iget-object v3, v3, Lz65;->i:Ljava/lang/Object;

    .line 2405
    .line 2406
    goto :goto_97a

    .line 2407
    :cond_966
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 2408
    .line 2409
    .line 2410
    move-object v9, v3

    .line 2411
    goto :goto_98e

    .line 2412
    :cond_96b
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 2413
    .line 2414
    .line 2415
    iget-object v3, v2, Lsy4;->a:Liy4;

    .line 2416
    .line 2417
    iput v8, v4, Lmx4;->j:I

    .line 2418
    .line 2419
    invoke-virtual {v3, v0, v4}, Liy4;->c(Ljava/lang/String;Lpe1;)Ljava/lang/Object;

    .line 2420
    .line 2421
    .line 2422
    move-result-object v3

    .line 2423
    if-ne v3, v5, :cond_97a

    .line 2424
    .line 2425
    move-object v9, v5

    .line 2426
    goto :goto_98e

    .line 2427
    :cond_97a
    :goto_97a
    invoke-static {v3}, Lz65;->a(Ljava/lang/Object;)Ljava/lang/Throwable;

    .line 2428
    .line 2429
    .line 2430
    move-result-object v3

    .line 2431
    if-eqz v3, :cond_989

    .line 2432
    .line 2433
    const-string v4, "Failed to delete history: "

    .line 2434
    .line 2435
    invoke-virtual {v4, v0}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    .line 2436
    .line 2437
    .line 2438
    move-result-object v0

    .line 2439
    invoke-static {v1, v0, v3}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 2440
    .line 2441
    .line 2442
    :cond_989
    invoke-virtual {v2}, Lsy4;->b()V

    .line 2443
    .line 2444
    .line 2445
    sget-object v9, Ldg6;->a:Ldg6;

    .line 2446
    .line 2447
    :goto_98e
    return-object v9

    .line 2448
    :pswitch_98f
    move-object v3, v9

    .line 2449
    sget-object v0, Ljg1;->i:Ljg1;

    .line 2450
    .line 2451
    iget v1, v4, Lmx4;->j:I

    .line 2452
    .line 2453
    if-eqz v1, :cond_9a1

    .line 2454
    .line 2455
    if-ne v1, v8, :cond_99c

    .line 2456
    .line 2457
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 2458
    .line 2459
    .line 2460
    goto :goto_9bc

    .line 2461
    :cond_99c
    invoke-static {v7}, Lmz;->h(Ljava/lang/String;)V

    .line 2462
    .line 2463
    .line 2464
    move-object v9, v3

    .line 2465
    goto :goto_9be

    .line 2466
    :cond_9a1
    invoke-static/range {p1 .. p1}, Lsl4;->N(Ljava/lang/Object;)V

    .line 2467
    .line 2468
    .line 2469
    iget-object v1, v4, Lmx4;->k:Ljava/lang/Object;

    .line 2470
    .line 2471
    check-cast v1, Lpx4;

    .line 2472
    .line 2473
    iget-object v1, v1, Lpx4;->b:Lhw4;

    .line 2474
    .line 2475
    iget-object v2, v4, Lmx4;->l:Ljava/lang/Object;

    .line 2476
    .line 2477
    check-cast v2, Ltu4;

    .line 2478
    .line 2479
    invoke-virtual {v2}, Ljava/lang/Enum;->name()Ljava/lang/String;

    .line 2480
    .line 2481
    .line 2482
    move-result-object v2

    .line 2483
    iput v8, v4, Lmx4;->j:I

    .line 2484
    .line 2485
    invoke-virtual {v1, v2, v4}, Lhw4;->c(Ljava/lang/String;Lyz5;)Ljava/lang/Object;

    .line 2486
    .line 2487
    .line 2488
    move-result-object v1

    .line 2489
    if-ne v1, v0, :cond_9bc

    .line 2490
    .line 2491
    move-object v9, v0

    .line 2492
    goto :goto_9be

    .line 2493
    :cond_9bc
    :goto_9bc
    sget-object v9, Ldg6;->a:Ldg6;

    .line 2494
    .line 2495
    :goto_9be
    return-object v9

    .line 2496
    nop

    .line 2497
    :pswitch_data_9c0
    .packed-switch 0x0
        :pswitch_98f
        :pswitch_94b
        :pswitch_8fd
        :pswitch_84e
        :pswitch_780
        :pswitch_757
        :pswitch_6f2
        :pswitch_68e
        :pswitch_65d
        :pswitch_627
        :pswitch_5ed
        :pswitch_5b2
        :pswitch_496
        :pswitch_469
        :pswitch_413
        :pswitch_3bf
        :pswitch_367
        :pswitch_30f
        :pswitch_2a1
        :pswitch_25f
        :pswitch_234
        :pswitch_1f0
        :pswitch_e9
        :pswitch_e4
        :pswitch_a4
        :pswitch_77
        :pswitch_42
        :pswitch_3d
        :pswitch_38
    .end packed-switch
.end method