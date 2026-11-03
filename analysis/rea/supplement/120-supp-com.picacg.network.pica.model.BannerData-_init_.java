    public /* synthetic */ BannerData(int i, String str, String str2, String str3, String str4, String str5, ImageInfo imageInfo, fj5 fj5Var) {
        if (35 != (i & 35)) {
            pr2.D(i, 35, BannerData$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this._id = str;
        this.title = str2;
        if ((i & 4) == 0) {
            this.shortDescription = "";
        } else {
            this.shortDescription = str3;
        }
        if ((i & 8) == 0) {
            this.link = "";
        } else {
            this.link = str4;
        }
        if ((i & 16) == 0) {
            this.type = "web";
        } else {
            this.type = str5;
        }
        this.thumb = imageInfo;
    }