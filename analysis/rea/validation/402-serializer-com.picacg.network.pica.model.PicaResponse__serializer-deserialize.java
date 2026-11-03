    @Override // defpackage.ca3
    public final PicaResponse<T> deserialize(dn1 dn1Var) {
        dn1Var.getClass();
        zi5 zi5Var = this.descriptor;
        t91 t91VarC = dn1Var.c(zi5Var);
        boolean z = true;
        int i = 0;
        int iR = 0;
        String strM = null;
        String str = null;
        Object objW = null;
        while (z) {
            int iH = t91VarC.h(zi5Var);
            if (iH == -1) {
                z = false;
            } else if (iH == 0) {
                iR = t91VarC.r(zi5Var, 0);
                i |= 1;
            } else if (iH == 1) {
                strM = t91VarC.m(zi5Var, 1);
                i |= 2;
            } else if (iH == 2) {
                str = (String) t91VarC.w(zi5Var, 2, ix5.a, str);
                i |= 4;
            } else {
                if (iH != 3) {
                    k.c(iH);
                    return null;
                }
                objW = t91VarC.w(zi5Var, 3, this.typeSerial0, objW);
                i |= 8;
            }
        }
        t91VarC.a(zi5Var);
        return new PicaResponse<>(i, iR, strM, str, objW, (fj5) null);
    }