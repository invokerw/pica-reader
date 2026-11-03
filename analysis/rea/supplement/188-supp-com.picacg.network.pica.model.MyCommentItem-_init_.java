    public MyCommentItem(String str, String str2, MyCommentComicRef myCommentComicRef, int i, boolean z, String str3, int i2, int i3, boolean z2) {
        zv3.v(str, str2, str3);
        this.id = str;
        this.content = str2;
        this.comic = myCommentComicRef;
        this.totalComments = i;
        this.hide = z;
        this.createdAt = str3;
        this.likesCount = i2;
        this.commentsCount = i3;
        this.isLiked = z2;
    }