    public /* synthetic */ AdvancedSearchBody(int i, String str, String str2, List list, fj5 fj5Var) {
        if (1 != (i & 1)) {
            pr2.D(i, 1, j8.a.getDescriptor());
            throw null;
        }
        this.keyword = str;
        if ((i & 2) == 0) {
            this.sort = "dd";
        } else {
            this.sort = str2;
        }
        if ((i & 4) == 0) {
            this.categories = null;
        } else {
            this.categories = list;
        }
    }