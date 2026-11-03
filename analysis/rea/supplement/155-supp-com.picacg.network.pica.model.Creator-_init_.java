    public /* synthetic */ Creator(int i, String str, String str2, String str3, String str4, boolean z, int i2, int i3, List list, String str5, String str6, ImageInfo imageInfo, fj5 fj5Var) {
        if (97 != (i & 97)) {
            pr2.D(i, 97, Creator$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        if ((i & 2) == 0) {
            this.gender = "";
        } else {
            this.gender = str2;
        }
        if ((i & 4) == 0) {
            this.name = "";
        } else {
            this.name = str3;
        }
        if ((i & 8) == 0) {
            this.title = null;
        } else {
            this.title = str4;
        }
        if ((i & 16) == 0) {
            this.verified = false;
        } else {
            this.verified = z;
        }
        this.exp = i2;
        this.level = i3;
        if ((i & 128) == 0) {
            this.characters = b42.i;
        } else {
            this.characters = list;
        }
        if ((i & 256) == 0) {
            this.role = null;
        } else {
            this.role = str5;
        }
        if ((i & 512) == 0) {
            this.slogan = null;
        } else {
            this.slogan = str6;
        }
        if ((i & 1024) == 0) {
            this.avatar = null;
        } else {
            this.avatar = imageInfo;
        }
    }