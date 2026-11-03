    public /* synthetic */ LeaderboardComic(int i, String str, String str2, String str3, int i2, int i3, int i4, int i5, boolean z, List list, List list2, ImageInfo imageInfo, int i6, fj5 fj5Var) {
        if (1031 != (i & AnalyticsListener.EVENT_AUDIO_TRACK_INITIALIZED)) {
            pr2.D(i, AnalyticsListener.EVENT_AUDIO_TRACK_INITIALIZED, LeaderboardComic$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.title = str2;
        this.author = str3;
        if ((i & 8) == 0) {
            this.totalViews = 0;
        } else {
            this.totalViews = i2;
        }
        if ((i & 16) == 0) {
            this.totalLikes = 0;
        } else {
            this.totalLikes = i3;
        }
        if ((i & 32) == 0) {
            this.pagesCount = 0;
        } else {
            this.pagesCount = i4;
        }
        if ((i & 64) == 0) {
            this.epsCount = 0;
        } else {
            this.epsCount = i5;
        }
        if ((i & 128) == 0) {
            this.finished = false;
        } else {
            this.finished = z;
        }
        int i7 = i & 256;
        b42 b42Var = b42.i;
        if (i7 == 0) {
            this.categories = b42Var;
        } else {
            this.categories = list;
        }
        if ((i & 512) == 0) {
            this.tags = b42Var;
        } else {
            this.tags = list2;
        }
        this.thumb = imageInfo;
        if ((i & 2048) == 0) {
            this.likesCount = 0;
        } else {
            this.likesCount = i6;
        }
    }