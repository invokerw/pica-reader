    public /* synthetic */ EpisodesData(int i, EpisodesInfo episodesInfo, fj5 fj5Var) {
        if (1 == (i & 1)) {
            this.eps = episodesInfo;
        } else {
            pr2.D(i, 1, EpisodesData$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
    }