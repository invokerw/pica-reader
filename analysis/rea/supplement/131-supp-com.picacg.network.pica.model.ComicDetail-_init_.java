    public /* synthetic */ ComicDetail(int i, String str, Creator creator, String str2, String str3, ImageInfo imageInfo, String str4, String str5, List list, List list2, int i2, int i3, boolean z, String str6, String str7, boolean z2, boolean z3, Integer num, Integer num2, Integer num3, Integer num4, Integer num5, Integer num6, boolean z4, boolean z5, fj5 fj5Var) {
        if (19 != (i & 19)) {
            pr2.D(i, 19, ComicDetail$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.creator = creator;
        if ((i & 4) == 0) {
            this.title = "";
        } else {
            this.title = str2;
        }
        if ((i & 8) == 0) {
            this.description = "";
        } else {
            this.description = str3;
        }
        this.thumb = imageInfo;
        if ((i & 32) == 0) {
            this.author = "";
        } else {
            this.author = str4;
        }
        if ((i & 64) == 0) {
            this.chineseTeam = null;
        } else {
            this.chineseTeam = str5;
        }
        int i4 = i & 128;
        b42 b42Var = b42.i;
        if (i4 == 0) {
            this.categories = b42Var;
        } else {
            this.categories = list;
        }
        if ((i & 256) == 0) {
            this.tags = b42Var;
        } else {
            this.tags = list2;
        }
        if ((i & 512) == 0) {
            this.pagesCount = 0;
        } else {
            this.pagesCount = i2;
        }
        if ((i & 1024) == 0) {
            this.epsCount = 0;
        } else {
            this.epsCount = i3;
        }
        if ((i & 2048) == 0) {
            this.finished = false;
        } else {
            this.finished = z;
        }
        if ((i & 4096) == 0) {
            this.updatedAt = "";
        } else {
            this.updatedAt = str6;
        }
        if ((i & 8192) == 0) {
            this.createdAt = "";
        } else {
            this.createdAt = str7;
        }
        if ((i & 16384) == 0) {
            this.allowDownload = true;
        } else {
            this.allowDownload = z2;
        }
        if ((32768 & i) == 0) {
            this.allowComment = true;
        } else {
            this.allowComment = z3;
        }
        if ((65536 & i) == 0) {
            this.totalLikes = 0;
        } else {
            this.totalLikes = num;
        }
        if ((131072 & i) == 0) {
            this.totalViews = 0;
        } else {
            this.totalViews = num2;
        }
        if ((262144 & i) == 0) {
            this.totalComments = 0;
        } else {
            this.totalComments = num3;
        }
        if ((524288 & i) == 0) {
            this.viewsCount = 0;
        } else {
            this.viewsCount = num4;
        }
        if ((1048576 & i) == 0) {
            this.likesCount = 0;
        } else {
            this.likesCount = num5;
        }
        if ((2097152 & i) == 0) {
            this.commentsCount = 0;
        } else {
            this.commentsCount = num6;
        }
        if ((4194304 & i) == 0) {
            this.isFavourite = false;
        } else {
            this.isFavourite = z4;
        }
        if ((i & 8388608) == 0) {
            this.isLiked = false;
        } else {
            this.isLiked = z5;
        }
    }