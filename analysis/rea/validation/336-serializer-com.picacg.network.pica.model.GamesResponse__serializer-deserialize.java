    @Override // defpackage.ca3
    public final GamesResponse deserialize(dn1 dn1Var) {
        dn1Var.getClass();
        zi5 zi5Var = descriptor;
        t91 t91VarC = dn1Var.c(zi5Var);
        boolean z = true;
        int i = 0;
        GamesPageData gamesPageData = null;
        while (z) {
            int iH = t91VarC.h(zi5Var);
            if (iH == -1) {
                z = false;
            } else {
                if (iH != 0) {
                    k.c(iH);
                    return null;
                }
                gamesPageData = (GamesPageData) t91VarC.q(zi5Var, 0, GamesPageData$$serializer.INSTANCE, gamesPageData);
                i = 1;
            }
        }
        t91VarC.a(zi5Var);
        return new GamesResponse(i, gamesPageData, null);
    }