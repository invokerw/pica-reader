    @Override // defpackage.c50
    public final Object invokeSuspend(Object obj) {
        int i = this.i;
        String str = this.m;
        String str2 = this.l;
        jg1 jg1Var = jg1.i;
        switch (i) {
            case 0:
                eg4 eg4Var = (eg4) this.k;
                int i2 = this.j;
                if (i2 != 0) {
                    if (i2 == 1) {
                        sl4.N(obj);
                        return obj;
                    }
                    mz.h("call to 'resume' before 'invoke' with coroutine");
                    return null;
                }
                sl4.N(obj);
                ContentBody contentBody = new ContentBody(str);
                this.k = null;
                this.j = 1;
                Object objN = eg4Var.n(str2, contentBody, this);
                return objN == jg1Var ? jg1Var : objN;
            case 1:
                eg4 eg4Var2 = (eg4) this.k;
                int i3 = this.j;
                if (i3 != 0) {
                    if (i3 == 1) {
                        sl4.N(obj);
                        return obj;
                    }
                    mz.h("call to 'resume' before 'invoke' with coroutine");
                    return null;
                }
                sl4.N(obj);
                ContentBody contentBody2 = new ContentBody(str);
                this.k = null;
                this.j = 1;
                Object objW = eg4Var2.w(str2, contentBody2, this);
                return objW == jg1Var ? jg1Var : objW;
            case 2:
                eg4 eg4Var3 = (eg4) this.k;
                int i4 = this.j;
                if (i4 != 0) {
                    if (i4 == 1) {
                        sl4.N(obj);
                        return obj;
                    }
                    mz.h("call to 'resume' before 'invoke' with coroutine");
                    return null;
                }
                sl4.N(obj);
                ContentBody contentBody3 = new ContentBody(str);
                this.k = null;
                this.j = 1;
                Object objG = eg4Var3.g(str2, contentBody3, this);
                return objG == jg1Var ? jg1Var : objG;
            case 3:
                eg4 eg4Var4 = (eg4) this.k;
                int i5 = this.j;
                if (i5 != 0) {
                    if (i5 == 1) {
                        sl4.N(obj);
                        return obj;
                    }
                    mz.h("call to 'resume' before 'invoke' with coroutine");
                    return null;
                }
                sl4.N(obj);
                ContentBody contentBody4 = new ContentBody(str);
                this.k = null;
                this.j = 1;
                Object objW2 = eg4Var4.w(str2, contentBody4, this);
                return objW2 == jg1Var ? jg1Var : objW2;
            default:
                eg4 eg4Var5 = (eg4) this.k;
                int i6 = this.j;
                if (i6 != 0) {
                    if (i6 == 1) {
                        sl4.N(obj);
                        return obj;
                    }
                    mz.h("call to 'resume' before 'invoke' with coroutine");
                    return null;
                }
                sl4.N(obj);
                SignInRequest signInRequest = new SignInRequest(str2, str);
                this.k = null;
                this.j = 1;
                Object objH = eg4Var5.h(signInRequest, this);
                return objH == jg1Var ? jg1Var : objH;
        }
    }