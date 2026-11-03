    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    public final Object b(pe1 pe1Var) throws Throwable {
        jh4 jh4Var;
        nh4 nh4Var;
        if (pe1Var instanceof jh4) {
            jh4Var = (jh4) pe1Var;
            int i = jh4Var.l;
            if ((i & Integer.MIN_VALUE) != 0) {
                jh4Var.l = i - Integer.MIN_VALUE;
            } else {
                jh4Var = new jh4(this, pe1Var);
            }
        } else {
            jh4Var = new jh4(this, pe1Var);
        }
        Object objY = jh4Var.j;
        jg1 jg1Var = jg1.i;
        int i2 = jh4Var.l;
        ne1 ne1Var = null;
        if (i2 == 0) {
            sl4.N(objY);
            if (this.c != null) {
                return this.c;
            }
            zp1 zp1Var = nu1.a;
            dp1 dp1Var = dp1.k;
            i6 i6Var = new i6(this, ne1Var, 11);
            jh4Var.i = this;
            jh4Var.l = 1;
            objY = k64.Y(i6Var, dp1Var, jh4Var);
            if (objY == jg1Var) {
                return jg1Var;
            }
            nh4Var = this;
        } else {
            if (i2 != 1) {
                mz.h("call to 'resume' before 'invoke' with coroutine");
                return null;
            }
            nh4Var = jh4Var.i;
            sl4.N(objY);
        }
        nh4Var.c = (String) objY;
        return this.c;
    }