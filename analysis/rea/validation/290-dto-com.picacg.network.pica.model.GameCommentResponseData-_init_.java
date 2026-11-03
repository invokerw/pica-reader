    public GameCommentResponseData(GameCommentsPageData gameCommentsPageData, List<GameComment> list) {
        gameCommentsPageData.getClass();
        list.getClass();
        this.comments = gameCommentsPageData;
        this.topComments = list;
    }