    public /* synthetic */ ComicListData(int i, ComicsData comicsData, fj5 fj5Var) {
        if (1 == (i & 1)) {
            this.comics = comicsData;
        } else {
            pr2.D(i, 1, ComicListData$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
    }