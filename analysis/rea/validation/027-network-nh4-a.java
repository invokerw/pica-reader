    /* JADX WARN: Code duplicated, block: B:7:0x0015  */
    public final Object a(pe1 pe1Var) {
        ih4 ih4Var;
        dg6 dg6Var = dg6.a;
        if (pe1Var instanceof ih4) {
            ih4Var = (ih4) pe1Var;
            int i = ih4Var.k;
            if ((i & Integer.MIN_VALUE) != 0) {
                ih4Var.k = i - Integer.MIN_VALUE;
            } else {
                ih4Var = new ih4(this, pe1Var);
            }
        } else {
            ih4Var = new ih4(this, pe1Var);
        }
        Object obj = ih4Var.i;
        jg1 jg1Var = jg1.i;
        int i2 = ih4Var.k;
        if (i2 == 0) {
            sl4.N(obj);
            s42 s42Var = this.b;
            ih4Var.k = 1;
            s42Var.c.edit().remove("auth_token").remove("refresh_token").apply();
            if (dg6Var == jg1Var) {
                return jg1Var;
            }
        } else {
            if (i2 != 1) {
                mz.h("call to 'resume' before 'invoke' with coroutine");
                return null;
            }
            sl4.N(obj);
        }
        this.c = null;
        return dg6Var;
    }