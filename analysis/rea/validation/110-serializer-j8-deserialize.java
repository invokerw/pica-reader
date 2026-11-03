    @Override // defpackage.ca3
    public final Object deserialize(dn1 dn1Var) {
        zi5 zi5Var = descriptor;
        t91 t91VarC = dn1Var.c(zi5Var);
        kd3[] kd3VarArr = AdvancedSearchBody.$childSerializers;
        boolean z = true;
        int i = 0;
        String strM = null;
        String strM2 = null;
        List list = null;
        while (z) {
            int iH = t91VarC.h(zi5Var);
            if (iH == -1) {
                z = false;
            } else if (iH == 0) {
                strM = t91VarC.m(zi5Var, 0);
                i |= 1;
            } else if (iH == 1) {
                strM2 = t91VarC.m(zi5Var, 1);
                i |= 2;
            } else {
                if (iH != 2) {
                    k.c(iH);
                    return null;
                }
                list = (List) t91VarC.w(zi5Var, 2, (ca3) kd3VarArr[2].getValue(), list);
                i |= 4;
            }
        }
        t91VarC.a(zi5Var);
        return new AdvancedSearchBody(i, strM, strM2, list, null);
    }