    @Override // defpackage.ca3
    public final CommentLikeResponse deserialize(dn1 dn1Var) {
        dn1Var.getClass();
        zi5 zi5Var = descriptor;
        t91 t91VarC = dn1Var.c(zi5Var);
        boolean z = true;
        int i = 0;
        String strM = null;
        while (z) {
            int iH = t91VarC.h(zi5Var);
            if (iH == -1) {
                z = false;
            } else {
                if (iH != 0) {
                    k.c(iH);
                    return null;
                }
                strM = t91VarC.m(zi5Var, 0);
                i = 1;
            }
        }
        t91VarC.a(zi5Var);
        return new CommentLikeResponse(i, strM, null);
    }