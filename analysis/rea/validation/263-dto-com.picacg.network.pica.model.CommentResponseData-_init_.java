    public CommentResponseData(CommentsPageData commentsPageData, List<Comment> list) {
        commentsPageData.getClass();
        list.getClass();
        this.comments = commentsPageData;
        this.topComments = list;
    }