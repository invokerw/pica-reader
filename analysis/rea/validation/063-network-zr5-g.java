    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:26:0x0067 -> B:19:0x003e). Please report as a decompilation issue!!! */
    public final Object g(List list, pe1 pe1Var) throws Throwable {
        yr5 yr5Var;
        Iterator it;
        int i;
        String str;
        if (pe1Var instanceof yr5) {
            yr5Var = (yr5) pe1Var;
            int i2 = yr5Var.n;
            if ((i2 & Integer.MIN_VALUE) != 0) {
                yr5Var.n = i2 - Integer.MIN_VALUE;
            } else {
                yr5Var = new yr5(this, pe1Var);
            }
        } else {
            yr5Var = new yr5(this, pe1Var);
        }
        Object obj = yr5Var.l;
        int i3 = yr5Var.n;
        ne1 ne1Var = null;
        if (i3 == 0) {
            sl4.N(obj);
            it = list.iterator();
            i = 0;
        } else {
            if (i3 != 1) {
                mz.h("call to 'resume' before 'invoke' with coroutine");
                return null;
            }
            i = yr5Var.k;
            str = yr5Var.j;
            it = yr5Var.i;
            try {
                sl4.N(obj);
            } catch (Exception e) {
                Log.w("SmartDnsRepository", "预热失败: " + str, e);
            }
        }
        while (it.hasNext()) {
            str = (String) it.next();
            yr5Var.i = it;
            yr5Var.j = str;
            yr5Var.k = i;
            yr5Var.n = 1;
            zp1 zp1Var = nu1.a;
            Object objY = k64.Y(new mx4(this, str, ne1Var, 22), dp1.k, yr5Var);
            jg1 jg1Var = jg1.i;
            if (objY == jg1Var) {
                return jg1Var;
            }
        }
        return dg6.a;
    }