    public /* synthetic */ GameItem(int i, String str, String str2, String str3, String str4, ImageInfo imageInfo, boolean z, boolean z2, List list, List list2, boolean z3, boolean z4, boolean z5, fj5 fj5Var) {
        if (31 != (i & 31)) {
            pr2.D(i, 31, GameItem$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.title = str2;
        this.version = str3;
        this.publisher = str4;
        this.icon = imageInfo;
        if ((i & 32) == 0) {
            this.ios = false;
        } else {
            this.ios = z;
        }
        if ((i & 64) == 0) {
            this.f3android = false;
        } else {
            this.f3android = z2;
        }
        int i2 = i & 128;
        b42 b42Var = b42.i;
        if (i2 == 0) {
            this.iosLinks = b42Var;
        } else {
            this.iosLinks = list;
        }
        if ((i & 256) == 0) {
            this.androidLinks = b42Var;
        } else {
            this.androidLinks = list2;
        }
        if ((i & 512) == 0) {
            this.picaLink = false;
        } else {
            this.picaLink = z3;
        }
        if ((i & 1024) == 0) {
            this.adult = false;
        } else {
            this.adult = z4;
        }
        if ((i & 2048) == 0) {
            this.suggest = false;
        } else {
            this.suggest = z5;
        }
    }