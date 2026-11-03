    public /* synthetic */ ChapterPagesData(int i, PagesInfo pagesInfo, EpisodeInfo episodeInfo, fj5 fj5Var) {
        if (3 != (i & 3)) {
            pr2.D(i, 3, ChapterPagesData$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.pages = pagesInfo;
        this.ep = episodeInfo;
    }