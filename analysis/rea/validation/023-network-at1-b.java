    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    public final Object b(pe1 pe1Var) {
        ws1 ws1Var;
        if (pe1Var instanceof ws1) {
            ws1Var = (ws1) pe1Var;
            int i = ws1Var.l;
            if ((i & Integer.MIN_VALUE) != 0) {
                ws1Var.l = i - Integer.MIN_VALUE;
            } else {
                ws1Var = new ws1(this, pe1Var);
            }
        } else {
            ws1Var = new ws1(this, pe1Var);
        }
        Object objC = ws1Var.j;
        jg1 jg1Var = jg1.i;
        int i2 = ws1Var.l;
        if (i2 == 0) {
            sl4.N(objC);
            if (this.c == null) {
                ws1Var.i = this;
                ws1Var.l = 1;
                objC = c(ws1Var);
                if (objC == jg1Var) {
                    return jg1Var;
                }
            }
            return dg6.a;
        }
        if (i2 != 1) {
            mz.h("call to 'resume' before 'invoke' with coroutine");
            return null;
        }
        this = ws1Var.i;
        sl4.N(objC);
        this.c = (String) objC;
        return dg6.a;
    }