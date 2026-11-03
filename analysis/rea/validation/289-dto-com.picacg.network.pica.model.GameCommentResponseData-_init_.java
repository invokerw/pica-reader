    public /* synthetic */ GameCommentResponseData(int i, GameCommentsPageData gameCommentsPageData, List list, fj5 fj5Var) {
        if (1 != (i & 1)) {
            pr2.D(i, 1, GameCommentResponseData$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.comments = gameCommentsPageData;
        if ((i & 2) == 0) {
            this.topComments = b42.i;
        } else {
            this.topComments = list;
        }
    }