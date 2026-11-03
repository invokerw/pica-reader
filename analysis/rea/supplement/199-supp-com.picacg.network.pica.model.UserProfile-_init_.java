    public /* synthetic */ UserProfile(int i, String str, String str2, String str3, String str4, String str5, ImageInfo imageInfo, int i2, int i3, String str6, boolean z, boolean z2, List list, String str7, String str8, fj5 fj5Var) {
        if (7 != (i & 7)) {
            pr2.D(i, 7, UserProfile$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.email = str2;
        this.name = str3;
        if ((i & 8) == 0) {
            this.title = null;
        } else {
            this.title = str4;
        }
        if ((i & 16) == 0) {
            this.slogan = null;
        } else {
            this.slogan = str5;
        }
        if ((i & 32) == 0) {
            this.avatar = null;
        } else {
            this.avatar = imageInfo;
        }
        if ((i & 64) == 0) {
            this.exp = 0;
        } else {
            this.exp = i2;
        }
        if ((i & 128) == 0) {
            this.level = 1;
        } else {
            this.level = i3;
        }
        if ((i & 256) == 0) {
            this.gender = "bot";
        } else {
            this.gender = str6;
        }
        if ((i & 512) == 0) {
            this.verified = false;
        } else {
            this.verified = z;
        }
        if ((i & 1024) == 0) {
            this.isPunched = false;
        } else {
            this.isPunched = z2;
        }
        this.characters = (i & 2048) == 0 ? b42.i : list;
        if ((i & 4096) == 0) {
            this.birthday = null;
        } else {
            this.birthday = str7;
        }
        if ((i & 8192) == 0) {
            this.createdAt = null;
        } else {
            this.createdAt = str8;
        }
    }