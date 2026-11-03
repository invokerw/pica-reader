    public /* synthetic */ CategoryItem(int i, String str, String str2, String str3, ImageInfo imageInfo, boolean z, boolean z2, String str4, fj5 fj5Var) {
        if (10 != (i & 10)) {
            pr2.D(i, 10, CategoryItem$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        if ((i & 1) == 0) {
            this.id = null;
        } else {
            this.id = str;
        }
        this.title = str2;
        if ((i & 4) == 0) {
            this.description = null;
        } else {
            this.description = str3;
        }
        this.thumb = imageInfo;
        if ((i & 16) == 0) {
            this.isWeb = false;
        } else {
            this.isWeb = z;
        }
        if ((i & 32) == 0) {
            this.active = true;
        } else {
            this.active = z2;
        }
        if ((i & 64) == 0) {
            this.link = null;
        } else {
            this.link = str4;
        }
    }