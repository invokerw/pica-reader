    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    public final Object d(pe1 pe1Var) {
        lh4 lh4Var;
        if (pe1Var instanceof lh4) {
            lh4Var = (lh4) pe1Var;
            int i = lh4Var.l;
            if ((i & Integer.MIN_VALUE) != 0) {
                lh4Var.l = i - Integer.MIN_VALUE;
            } else {
                lh4Var = new lh4(this, pe1Var);
            }
        } else {
            lh4Var = new lh4(this, pe1Var);
        }
        Object objE = lh4Var.j;
        Object obj = jg1.i;
        int i2 = lh4Var.l;
        if (i2 == 0) {
            sl4.N(objE);
            s42 s42Var = this.b;
            String string = s42Var.c.getString("auth_token", null);
            this.c = string != null ? s42Var.a(string) : null;
            if (this.d == null) {
                lh4Var.i = this;
                lh4Var.l = 1;
                objE = e();
                if (objE == obj) {
                    return obj;
                }
            }
            return dg6.a;
        }
        if (i2 != 1) {
            mz.h("call to 'resume' before 'invoke' with coroutine");
            return null;
        }
        this = lh4Var.i;
        sl4.N(objE);
        this.d = (String) objE;
        return dg6.a;
    }