    @Override // defpackage.ca3
    public final ChapterPagesData deserialize(dn1 dn1Var) {
        dn1Var.getClass();
        zi5 zi5Var = descriptor;
        t91 t91VarC = dn1Var.c(zi5Var);
        boolean z = true;
        int i = 0;
        PagesInfo pagesInfo = null;
        EpisodeInfo episodeInfo = null;
        while (z) {
            int iH = t91VarC.h(zi5Var);
            if (iH == -1) {
                z = false;
            } else if (iH == 0) {
                pagesInfo = (PagesInfo) t91VarC.q(zi5Var, 0, PagesInfo$$serializer.INSTANCE, pagesInfo);
                i |= 1;
            } else {
                if (iH != 1) {
                    k.c(iH);
                    return null;
                }
                episodeInfo = (EpisodeInfo) t91VarC.q(zi5Var, 1, EpisodeInfo$$serializer.INSTANCE, episodeInfo);
                i |= 2;
            }
        }
        t91VarC.a(zi5Var);
        return new ChapterPagesData(i, pagesInfo, episodeInfo, null);
    }