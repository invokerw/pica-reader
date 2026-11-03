    public /* synthetic */ ComicsPageData(int i, List list, int i2, int i3, int i4, int i5, fj5 fj5Var) {
        if (15 != (i & 15)) {
            pr2.D(i, 15, ComicsPageData$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.docs = list;
        this.total = i2;
        this.page = i3;
        this.pages = i4;
        if ((i & 16) == 0) {
            this.limit = 40;
        } else {
            this.limit = i5;
        }
    }