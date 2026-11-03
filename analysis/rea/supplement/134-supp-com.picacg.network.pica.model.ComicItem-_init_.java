    public /* synthetic */ ComicItem(int i, String str, String str2, String str3, Integer num, Integer num2, ImageInfo imageInfo, List list, fj5 fj5Var) {
        if (103 != (i & 103)) {
            pr2.D(i, 103, ComicItem$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.title = str2;
        this.author = str3;
        if ((i & 8) == 0) {
            this.totalViews = null;
        } else {
            this.totalViews = num;
        }
        if ((i & 16) == 0) {
            this.totalLikes = null;
        } else {
            this.totalLikes = num2;
        }
        this.thumb = imageInfo;
        this.categories = list;
    }