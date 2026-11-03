    public /* synthetic */ CollectionComicItem(int i, String str, String str2, String str3, ImageInfo imageInfo, List list, List list2, boolean z, int i2, int i3, int i4, int i5, fj5 fj5Var) {
        if (15 != (i & 15)) {
            pr2.D(i, 15, CollectionComicItem$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.title = str2;
        this.author = str3;
        this.thumb = imageInfo;
        int i6 = i & 16;
        b42 b42Var = b42.i;
        if (i6 == 0) {
            this.categories = b42Var;
        } else {
            this.categories = list;
        }
        if ((i & 32) == 0) {
            this.tags = b42Var;
        } else {
            this.tags = list2;
        }
        if ((i & 64) == 0) {
            this.finished = false;
        } else {
            this.finished = z;
        }
        if ((i & 128) == 0) {
            this.epsCount = 0;
        } else {
            this.epsCount = i2;
        }
        if ((i & 256) == 0) {
            this.pagesCount = 0;
        } else {
            this.pagesCount = i3;
        }
        if ((i & 512) == 0) {
            this.totalViews = 0;
        } else {
            this.totalViews = i4;
        }
        if ((i & 1024) == 0) {
            this.totalLikes = 0;
        } else {
            this.totalLikes = i5;
        }
    }