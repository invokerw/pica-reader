    public /* synthetic */ MyCommentsResponseData(int i, MyCommentsPageData myCommentsPageData, fj5 fj5Var) {
        if (1 == (i & 1)) {
            this.comments = myCommentsPageData;
        } else {
            pr2.D(i, 1, MyCommentsResponseData$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
    }