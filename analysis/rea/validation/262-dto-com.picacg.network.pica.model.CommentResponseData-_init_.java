    public /* synthetic */ CommentResponseData(int i, CommentsPageData commentsPageData, List list, fj5 fj5Var) {
        if (1 != (i & 1)) {
            pr2.D(i, 1, CommentResponseData$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.comments = commentsPageData;
        if ((i & 2) == 0) {
            this.topComments = b42.i;
        } else {
            this.topComments = list;
        }
    }