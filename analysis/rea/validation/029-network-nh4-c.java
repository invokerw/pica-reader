    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    public final Object c(pe1 pe1Var) throws Throwable {
        kh4 kh4Var;
        if (pe1Var instanceof kh4) {
            kh4Var = (kh4) pe1Var;
            int i = kh4Var.k;
            if ((i & Integer.MIN_VALUE) != 0) {
                kh4Var.k = i - Integer.MIN_VALUE;
            } else {
                kh4Var = new kh4(this, pe1Var);
            }
        } else {
            kh4Var = new kh4(this, pe1Var);
        }
        Object objB = kh4Var.i;
        int i2 = kh4Var.k;
        if (i2 == 0) {
            sl4.N(objB);
            kh4Var.k = 1;
            objB = b(kh4Var);
            Object obj = jg1.i;
            if (objB == obj) {
                return obj;
            }
        } else {
            if (i2 != 1) {
                mz.h("call to 'resume' before 'invoke' with coroutine");
                return null;
            }
            sl4.N(objB);
        }
        return Boolean.valueOf(objB != null);
    }