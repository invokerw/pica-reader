    @Override // defpackage.c50
    public final Object invokeSuspend(Object obj) {
        int i = this.i;
        dg4 dg4Var = this.l;
        om2 om2Var = this.k;
        jg1 jg1Var = jg1.i;
        switch (i) {
            case 0:
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
                eg4 eg4Var = dg4Var.a;
                this.j = 1;
                Object objInvoke = om2Var.invoke(eg4Var, this);
                return objInvoke == jg1Var ? jg1Var : objInvoke;
            default:
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
                eg4 eg4Var2 = dg4Var.a;
                this.j = 1;
                Object objInvoke2 = om2Var.invoke(eg4Var2, this);
                return objInvoke2 == jg1Var ? jg1Var : objInvoke2;
        }
    }