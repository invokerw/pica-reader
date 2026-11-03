    /* JADX WARN: Code duplicated, block: B:7:0x0015  */
    public final Object f(String str, pe1 pe1Var) {
        mh4 mh4Var;
        dg6 dg6Var = dg6.a;
        if (pe1Var instanceof mh4) {
            mh4Var = (mh4) pe1Var;
            int i = mh4Var.l;
            if ((i & Integer.MIN_VALUE) != 0) {
                mh4Var.l = i - Integer.MIN_VALUE;
            } else {
                mh4Var = new mh4(this, pe1Var);
            }
        } else {
            mh4Var = new mh4(this, pe1Var);
        }
        Object obj = mh4Var.j;
        jg1 jg1Var = jg1.i;
        int i2 = mh4Var.l;
        if (i2 == 0) {
            sl4.N(obj);
            s42 s42Var = this.b;
            mh4Var.i = str;
            mh4Var.l = 1;
            String strB = s42Var.b(str);
            if (strB != null) {
                s42Var.c.edit().putString("auth_token", strB).apply();
            }
            if (dg6Var == jg1Var) {
                return jg1Var;
            }
        } else {
            if (i2 != 1) {
                mz.h("call to 'resume' before 'invoke' with coroutine");
                return null;
            }
            str = mh4Var.i;
            sl4.N(obj);
        }
        this.c = str;
        return dg6Var;
    }