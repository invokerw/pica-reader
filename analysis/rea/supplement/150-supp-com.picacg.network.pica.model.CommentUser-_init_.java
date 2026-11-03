    public /* synthetic */ CommentUser(int i, String str, String str2, String str3, String str4, boolean z, int i2, int i3, List list, String str5, ImageInfo imageInfo, String str6, String str7, fj5 fj5Var) {
        if (7 != (i & 7)) {
            pr2.D(i, 7, CommentUser$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.gender = str2;
        this.name = str3;
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
        if ((i & 32) == 0) {
            this.exp = 0;
        } else {
            this.exp = i2;
        }
        if ((i & 64) == 0) {
            this.level = 0;
        } else {
            this.level = i3;
        }
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
            this.avatar = null;
        } else {
            this.avatar = imageInfo;
        }
        if ((i & 1024) == 0) {
            this.slogan = null;
        } else {
            this.slogan = str6;
        }
        if ((i & 2048) == 0) {
            this.character = null;
        } else {
            this.character = str7;
        }
    }