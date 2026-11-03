    public /* synthetic */ GameDetail(int i, String str, String str2, String str3, String str4, String str5, ImageInfo imageInfo, boolean z, boolean z2, List list, List list2, boolean z3, boolean z4, boolean z5, int i2, int i3, int i4, boolean z6, List list3, Double d, Double d2, String str6, String str7, String str8, String str9, fj5 fj5Var) {
        if (12582975 != (i & 12582975)) {
            pr2.D(i, 12582975, GameDetail$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.title = str2;
        this.version = str3;
        this.publisher = str4;
        this.description = str5;
        this.icon = imageInfo;
        if ((i & 64) == 0) {
            this.ios = false;
        } else {
            this.ios = z;
        }
        if ((i & 128) == 0) {
            this.f2android = false;
        } else {
            this.f2android = z2;
        }
        int i5 = i & 256;
        b42 b42Var = b42.i;
        if (i5 == 0) {
            this.iosLinks = b42Var;
        } else {
            this.iosLinks = list;
        }
        if ((i & 512) == 0) {
            this.androidLinks = b42Var;
        } else {
            this.androidLinks = list2;
        }
        if ((i & 1024) == 0) {
            this.picaLink = false;
        } else {
            this.picaLink = z3;
        }
        if ((i & 2048) == 0) {
            this.adult = false;
        } else {
            this.adult = z4;
        }
        if ((i & 4096) == 0) {
            this.suggest = false;
        } else {
            this.suggest = z5;
        }
        if ((i & 8192) == 0) {
            this.downloadsCount = 0;
        } else {
            this.downloadsCount = i2;
        }
        if ((i & 16384) == 0) {
            this.likesCount = 0;
        } else {
            this.likesCount = i3;
        }
        if ((32768 & i) == 0) {
            this.commentsCount = 0;
        } else {
            this.commentsCount = i4;
        }
        if ((65536 & i) == 0) {
            this.isLiked = false;
        } else {
            this.isLiked = z6;
        }
        if ((131072 & i) == 0) {
            this.screenshots = b42Var;
        } else {
            this.screenshots = list3;
        }
        if ((262144 & i) == 0) {
            this.androidSize = null;
        } else {
            this.androidSize = d;
        }
        if ((524288 & i) == 0) {
            this.iosSize = null;
        } else {
            this.iosSize = d2;
        }
        if ((1048576 & i) == 0) {
            this.updateContent = null;
        } else {
            this.updateContent = str6;
        }
        if ((i & 2097152) == 0) {
            this.videoLink = null;
        } else {
            this.videoLink = str7;
        }
        this.createdAt = str8;
        this.updatedAt = str9;
    }