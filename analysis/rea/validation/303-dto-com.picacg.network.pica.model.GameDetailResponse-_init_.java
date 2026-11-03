    public /* synthetic */ GameDetailResponse(int i, GameDetail gameDetail, fj5 fj5Var) {
        if (1 == (i & 1)) {
            this.game = gameDetail;
        } else {
            pr2.D(i, 1, GameDetailResponse$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
    }