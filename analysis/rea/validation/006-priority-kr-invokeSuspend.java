    /* JADX WARN: Code duplicated, block: B:115:0x020e A[Catch: Exception -> 0x017c, TryCatch #0 {Exception -> 0x017c, blocks: (B:84:0x0177, B:110:0x01f6, B:112:0x01fe, B:89:0x0185, B:102:0x01c3, B:104:0x01cb, B:106:0x01d5, B:113:0x0204, B:115:0x020e, B:117:0x021d, B:116:0x0214, B:90:0x018a, B:96:0x019c, B:98:0x01a0, B:99:0x01a7, B:93:0x0192), top: B:125:0x016b }] */
    /* JADX WARN: Code duplicated, block: B:116:0x0214 A[Catch: Exception -> 0x017c, TryCatch #0 {Exception -> 0x017c, blocks: (B:84:0x0177, B:110:0x01f6, B:112:0x01fe, B:89:0x0185, B:102:0x01c3, B:104:0x01cb, B:106:0x01d5, B:113:0x0204, B:115:0x020e, B:117:0x021d, B:116:0x0214, B:90:0x018a, B:96:0x019c, B:98:0x01a0, B:99:0x01a7, B:93:0x0192), top: B:125:0x016b }] */
    /* JADX WARN: Code duplicated, block: B:57:0x0108  */
    /* JADX WARN: Code duplicated, block: B:59:0x010e  */
    /* JADX WARN: Code duplicated, block: B:60:0x0113  */
    @Override // defpackage.c50
    public final Object invokeSuspend(Object obj) throws Exception {
        Object y65Var;
        Object objC;
        Object objE;
        MacCmsResponse macCmsResponse;
        a54 snVar;
        lk lkVar;
        String category;
        Object objA;
        Object objA2;
        Object objA3;
        Object objA4;
        int i = this.i;
        int i2 = 0;
        int i3 = 3;
        int i4 = 5;
        Object obj2 = this.m;
        int i5 = this.k;
        jg1 jg1Var = jg1.i;
        ne1 ne1Var = null;
        switch (i) {
            case 0:
                qr qrVar = (qr) obj2;
                uq uqVar = qrVar.b;
                int i6 = this.j;
                try {
                    if (i6 != 0) {
                        if (i6 == 1) {
                            sl4.N(obj);
                            objC = obj;
                        } else {
                            if (i6 == 2) {
                                sl4.N(obj);
                                objE = obj;
                                macCmsResponse = (MacCmsResponse) objE;
                                if (macCmsResponse.getCode() == 1 || macCmsResponse.getList().isEmpty()) {
                                    if (macCmsResponse.getList().isEmpty()) {
                                        snVar = new tn(i5);
                                    } else {
                                        snVar = new sn(macCmsResponse.getMsg());
                                    }
                                    Log.e("AnimeRepository", "❌ API返回失败: " + macCmsResponse.getMsg());
                                    new Exception(macCmsResponse.getMsg());
                                    y65Var = new y65(new bo(snVar));
                                } else {
                                    lk lkVarO = u04.O(macCmsResponse.getList().get(0));
                                    int i7 = this.k;
                                    this.l = lkVarO;
                                    this.j = 3;
                                    if (uqVar.e(i7, lkVarO, 300000L, this) == jg1Var) {
                                        return jg1Var;
                                    }
                                    lkVar = lkVarO;
                                }
                                return new z65(y65Var);
                            }
                            if (i6 != 3) {
                                mz.h("call to 'resume' before 'invoke' with coroutine");
                                return null;
                            }
                            lk lkVar2 = (lk) this.l;
                            sl4.N(obj);
                            lkVar = lkVar2;
                        }
                        boolean zIsEmpty = lkVar.m.isEmpty();
                        y65Var = lkVar;
                        if (zIsEmpty) {
                            Log.w("AnimeRepository", "⚠️ 警告: 剧集列表为空！");
                            y65Var = lkVar;
                        }
                        return new z65(y65Var);
                    }
                    sl4.N(obj);
                    this.j = 1;
                    objC = uqVar.c(i5, this);
                    if (objC == jg1Var) {
                        return jg1Var;
                    }
                    lk lkVar3 = (lk) objC;
                    if (lkVar3 != null) {
                        return new z65(lkVar3);
                    }
                    Collections.singletonMap("animeId", new Integer(i5)).getClass();
                    jp3 jp3Var = qrVar.a;
                    this.j = 2;
                    objE = jp3Var.e("videolist", i5, this);
                    if (objE == jg1Var) {
                        return jg1Var;
                    }
                    macCmsResponse = (MacCmsResponse) objE;
                    if (macCmsResponse.getCode() == 1) {
                    }
                    if (macCmsResponse.getList().isEmpty()) {
                        snVar = new tn(i5);
                    } else {
                        snVar = new sn(macCmsResponse.getMsg());
                    }
                    Log.e("AnimeRepository", "❌ API返回失败: " + macCmsResponse.getMsg());
                    new Exception(macCmsResponse.getMsg());
                    y65Var = new y65(new bo(snVar));
                    return new z65(y65Var);
                } catch (Exception e) {
                    if (e instanceof CancellationException) {
                        throw e;
                    }
                    a54 a54VarA = qr.a(qrVar, e);
                    Log.e("AnimeRepository", "❌ 请求异常: " + e.getMessage(), e);
                    y65Var = new y65(new bo(a54VarA));
                }
                break;
            case 1:
                int i8 = this.j;
                if (i8 != 0) {
                    if (i8 == 1) {
                        sl4.N(obj);
                        return obj;
                    }
                    mz.h("call to 'resume' before 'invoke' with coroutine");
                    return null;
                }
                sl4.N(obj);
                dg4 dg4Var = ((n21) this.l).c;
                f21 f21Var = new f21((String) obj2, i5, ne1Var, i2);
                this.j = 1;
                Object objA5 = dg4Var.a(f21Var, this);
                return objA5 == jg1Var ? jg1Var : objA5;
            case 2:
                dg4 dg4Var2 = ((n21) obj2).c;
                ComicListParams comicListParams = (ComicListParams) this.l;
                int i9 = this.j;
                if (i9 != 0) {
                    if (i9 == 1) {
                        sl4.N(obj);
                        objA = obj;
                        return (ComicsListResponse) objA;
                    }
                    if (i9 != 2) {
                        mz.h("call to 'resume' before 'invoke' with coroutine");
                        return null;
                    }
                    sl4.N(obj);
                    objA2 = obj;
                    return (ComicsListResponse) objA2;
                }
                sl4.N(obj);
                if (comicListParams.getKeyword() == null && comicListParams.getCategories() == null) {
                    LinkedHashMap linkedHashMapR = tq3.R(comicListParams.toQueryMap());
                    linkedHashMapR.put("page", String.valueOf(i5));
                    zw0 zw0Var = new zw0(linkedHashMapR, ne1Var, 7);
                    this.j = 2;
                    objA2 = dg4Var2.a(zw0Var, this);
                    if (objA2 == jg1Var) {
                        return jg1Var;
                    }
                    return (ComicsListResponse) objA2;
                }
                List<String> categories = comicListParams.getCategories();
                if (categories == null) {
                    category = comicListParams.getCategory();
                    if (category != null) {
                        categories = pl0.L(category);
                    } else {
                        categories = null;
                    }
                } else {
                    if (categories.isEmpty()) {
                        categories = null;
                    }
                    if (categories == null) {
                        category = comicListParams.getCategory();
                        if (category != null) {
                            categories = pl0.L(category);
                        } else {
                            categories = null;
                        }
                    }
                }
                String keyword = comicListParams.getKeyword();
                if (keyword == null) {
                    keyword = "";
                }
                zk zkVar = new zk(i5, new AdvancedSearchBody(keyword, comicListParams.getSort(), categories), ne1Var, i4);
                this.j = 1;
                objA = dg4Var2.a(zkVar, this);
                if (objA == jg1Var) {
                    return jg1Var;
                }
                return (ComicsListResponse) objA;
            case 3:
                int i10 = this.j;
                if (i10 != 0) {
                    if (i10 == 1) {
                        sl4.N(obj);
                        return obj;
                    }
                    mz.h("call to 'resume' before 'invoke' with coroutine");
                    return null;
                }
                sl4.N(obj);
                dg4 dg4Var3 = ((pb2) this.l).b;
                f21 f21Var2 = new f21(i5, (String) obj2, ne1Var, i3);
                this.j = 1;
                Object objA6 = dg4Var3.a(f21Var2, this);
                return objA6 == jg1Var ? jg1Var : objA6;
            case 4:
                int i11 = this.j;
                if (i11 == 0) {
                    sl4.N(obj);
                    dg4 dg4Var4 = ((mo2) this.l).a;
                    f21 f21Var3 = new f21((String) obj2, i5, ne1Var, 4);
                    this.j = 1;
                    objA3 = dg4Var4.a(f21Var3, this);
                    if (objA3 == jg1Var) {
                        return jg1Var;
                    }
                } else {
                    if (i11 != 1) {
                        mz.h("call to 'resume' before 'invoke' with coroutine");
                        return null;
                    }
                    sl4.N(obj);
                    objA3 = obj;
                }
                return j02.i(GameCommentResponseKt.toCommentResponseData((GameCommentResponseData) objA3));
            default:
                int i12 = this.j;
                if (i12 == 0) {
                    sl4.N(obj);
                    dg4 dg4Var5 = ((gu2) this.l).a;
                    f21 f21Var4 = new f21(i5, (String) obj2, ne1Var, i4);
                    this.j = 1;
                    objA4 = dg4Var5.a(f21Var4, this);
                    if (objA4 == jg1Var) {
                        return jg1Var;
                    }
                } else {
                    if (i12 != 1) {
                        mz.h("call to 'resume' before 'invoke' with coroutine");
                        return null;
                    }
                    sl4.N(obj);
                    objA4 = obj;
                }
                return ((AnnouncementsResponse) objA4).getAnnouncements();
        }
    }