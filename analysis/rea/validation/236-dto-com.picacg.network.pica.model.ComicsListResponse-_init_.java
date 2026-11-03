    public /* synthetic */ ComicsListResponse(int i, ComicsPageData comicsPageData, fj5 fj5Var) {
        if (1 == (i & 1)) {
            this.comics = comicsPageData;
        } else {
            pr2.D(i, 1, ComicsListResponse$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
    }