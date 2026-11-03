    @Override // defpackage.c50
    public final Object invokeSuspend(Object obj) throws Throwable {
        ix3 ix3Var;
        List<String> list;
        int i = this.i;
        int i2 = 4;
        Object obj2 = this.n;
        jg1 jg1Var = jg1.i;
        int i3 = 2;
        ne1 ne1Var = null;
        switch (i) {
            case 0:
                cb3 cb3Var = (cb3) obj2;
                int i4 = this.j;
                if (i4 != 0) {
                    if (i4 == 1) {
                        sl4.N(obj);
                    } else {
                        if (i4 != 2) {
                            mz.h("call to 'resume' before 'invoke' with coroutine");
                            return null;
                        }
                        cb3Var = (cb3) this.m;
                        ix3Var = (ix3) this.l;
                        List<String> list2 = (List) this.k;
                        sl4.N(obj);
                        list = list2;
                    }
                    try {
                        cb3Var.d = list;
                        cb3Var.e = System.currentTimeMillis();
                        return list;
                    } finally {
                        ix3Var.l(null);
                    }
                }
                sl4.N(obj);
                dg4 dg4Var = cb3Var.a;
                uk0 uk0Var = new uk0(i3, ne1Var, i2);
                this.j = 1;
                obj = dg4Var.a(uk0Var, this);
                if (obj == jg1Var) {
                    return jg1Var;
                }
                List<String> keywords = ((KeywordsData) obj).getKeywords();
                keywords.size();
                ix3Var = cb3Var.c;
                this.k = keywords;
                this.l = ix3Var;
                this.m = cb3Var;
                this.j = 2;
                if (ix3Var.g(this) == jg1Var) {
                    return jg1Var;
                }
                list = keywords;
                cb3Var.d = list;
                cb3Var.e = System.currentTimeMillis();
                return list;
            default:
                hi6 hi6Var = (hi6) this.l;
                int i5 = this.j;
                if (i5 == 0) {
                    sl4.N(obj);
                    dg4 dg4Var2 = hi6Var.a;
                    l31 l31Var = new l31((String) this.m, (String) obj2, 4, null);
                    this.j = 1;
                    obj = dg4Var2.a(l31Var, this);
                    if (obj == jg1Var) {
                        return jg1Var;
                    }
                } else {
                    if (i5 != 1) {
                        if (i5 != 2) {
                            mz.h("call to 'resume' before 'invoke' with coroutine");
                            return null;
                        }
                        LoginData loginData = (LoginData) this.k;
                        sl4.N(obj);
                        return loginData;
                    }
                    sl4.N(obj);
                }
                LoginData loginData2 = (LoginData) obj;
                nh4 nh4Var = hi6Var.b;
                String token = loginData2.getToken();
                this.k = loginData2;
                this.j = 2;
                return nh4Var.f(token, this) == jg1Var ? jg1Var : loginData2;
        }
    }