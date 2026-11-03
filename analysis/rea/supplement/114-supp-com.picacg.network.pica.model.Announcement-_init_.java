    public /* synthetic */ Announcement(int i, String str, String str2, String str3, ImageInfo imageInfo, fj5 fj5Var) {
        if (15 != (i & 15)) {
            pr2.D(i, 15, Announcement$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this._id = str;
        this.title = str2;
        this.content = str3;
        this.thumb = imageInfo;
    }