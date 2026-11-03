    @Override // defpackage.ca3
    public final BannersResponse deserialize(dn1 dn1Var) {
        dn1Var.getClass();
        zi5 zi5Var = descriptor;
        t91 t91VarC = dn1Var.c(zi5Var);
        kd3[] kd3VarArr = BannersResponse.$childSerializers;
        boolean z = true;
        int i = 0;
        List list = null;
        while (z) {
            int iH = t91VarC.h(zi5Var);
            if (iH == -1) {
                z = false;
            } else {
                if (iH != 0) {
                    k.c(iH);
                    return null;
                }
                list = (List) t91VarC.q(zi5Var, 0, (ca3) kd3VarArr[0].getValue(), list);
                i = 1;
            }
        }
        t91VarC.a(zi5Var);
        return new BannersResponse(i, list, null);
    }