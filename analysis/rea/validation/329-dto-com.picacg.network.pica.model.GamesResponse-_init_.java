    public /* synthetic */ GamesResponse(int i, GamesPageData gamesPageData, fj5 fj5Var) {
        if (1 == (i & 1)) {
            this.games = gamesPageData;
        } else {
            pr2.D(i, 1, GamesResponse$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
    }