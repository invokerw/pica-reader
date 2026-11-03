    public static final /* synthetic */ void write$Self$app(GameCommentResponseData gameCommentResponseData, u91 u91Var, zi5 zi5Var) {
        kd3[] kd3VarArr = $childSerializers;
        tt3 tt3Var = (tt3) u91Var;
        tt3Var.a0(zi5Var, 0, GameCommentsPageData$$serializer.INSTANCE, gameCommentResponseData.comments);
        if (!tt3Var.e(zi5Var) && j63.u(gameCommentResponseData.topComments, b42.i)) {
            return;
        }
        tt3Var.a0(zi5Var, 1, (ca3) kd3VarArr[1].getValue(), gameCommentResponseData.topComments);
    }