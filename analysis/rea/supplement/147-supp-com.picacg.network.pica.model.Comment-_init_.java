    public /* synthetic */ Comment(int i, String str, String str2, CommentUser commentUser, String str3, int i2, boolean z, boolean z2, String str4, int i3, int i4, boolean z3, fj5 fj5Var) {
        if (131 != (i & 131)) {
            pr2.D(i, 131, Comment$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.content = str2;
        if ((i & 4) == 0) {
            this.user = null;
        } else {
            this.user = commentUser;
        }
        if ((i & 8) == 0) {
            this.comicId = "";
        } else {
            this.comicId = str3;
        }
        if ((i & 16) == 0) {
            this.totalComments = 0;
        } else {
            this.totalComments = i2;
        }
        if ((i & 32) == 0) {
            this.isTop = false;
        } else {
            this.isTop = z;
        }
        if ((i & 64) == 0) {
            this.hide = false;
        } else {
            this.hide = z2;
        }
        this.createdAt = str4;
        if ((i & 256) == 0) {
            this.likesCount = 0;
        } else {
            this.likesCount = i3;
        }
        if ((i & 512) == 0) {
            this.commentsCount = 0;
        } else {
            this.commentsCount = i4;
        }
        if ((i & 1024) == 0) {
            this.isLiked = false;
        } else {
            this.isLiked = z3;
        }
    }