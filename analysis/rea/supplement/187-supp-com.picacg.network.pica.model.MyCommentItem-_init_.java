    public /* synthetic */ MyCommentItem(int i, String str, String str2, MyCommentComicRef myCommentComicRef, int i2, boolean z, String str3, int i3, int i4, boolean z2, fj5 fj5Var) {
        if (35 != (i & 35)) {
            pr2.D(i, 35, MyCommentItem$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.content = str2;
        if ((i & 4) == 0) {
            this.comic = null;
        } else {
            this.comic = myCommentComicRef;
        }
        if ((i & 8) == 0) {
            this.totalComments = 0;
        } else {
            this.totalComments = i2;
        }
        if ((i & 16) == 0) {
            this.hide = false;
        } else {
            this.hide = z;
        }
        this.createdAt = str3;
        if ((i & 64) == 0) {
            this.likesCount = 0;
        } else {
            this.likesCount = i3;
        }
        if ((i & 128) == 0) {
            this.commentsCount = 0;
        } else {
            this.commentsCount = i4;
        }
        if ((i & 256) == 0) {
            this.isLiked = false;
        } else {
            this.isLiked = z2;
        }
    }