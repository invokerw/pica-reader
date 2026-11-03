    @Override // defpackage.ca3
    public final GameCommentResponseData deserialize(dn1 dn1Var) {
        dn1Var.getClass();
        zi5 zi5Var = descriptor;
        t91 t91VarC = dn1Var.c(zi5Var);
        kd3[] kd3VarArr = GameCommentResponseData.$childSerializers;
        boolean z = true;
        int i = 0;
        GameCommentsPageData gameCommentsPageData = null;
        List list = null;
        while (z) {
            int iH = t91VarC.h(zi5Var);
            if (iH == -1) {
                z = false;
            } else if (iH == 0) {
                gameCommentsPageData = (GameCommentsPageData) t91VarC.q(zi5Var, 0, GameCommentsPageData$$serializer.INSTANCE, gameCommentsPageData);
                i |= 1;
            } else {
                if (iH != 1) {
                    k.c(iH);
                    return null;
                }
                list = (List) t91VarC.q(zi5Var, 1, (ca3) kd3VarArr[1].getValue(), list);
                i |= 2;
            }
        }
        t91VarC.a(zi5Var);
        return new GameCommentResponseData(i, gameCommentsPageData, list, (fj5) null);
    }