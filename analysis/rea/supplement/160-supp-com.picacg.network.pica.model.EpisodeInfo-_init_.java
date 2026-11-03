    public /* synthetic */ EpisodeInfo(int i, String str, String str2, Integer num, String str3, fj5 fj5Var) {
        if (3 != (i & 3)) {
            pr2.D(i, 3, EpisodeInfo$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.title = str2;
        if ((i & 4) == 0) {
            this.order = null;
        } else {
            this.order = num;
        }
        if ((i & 8) == 0) {
            this.updatedAt = null;
        } else {
            this.updatedAt = str3;
        }
    }