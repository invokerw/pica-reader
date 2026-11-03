    public /* synthetic */ PageItem(int i, String str, ImageInfo imageInfo, fj5 fj5Var) {
        if (3 != (i & 3)) {
            pr2.D(i, 3, PageItem$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.media = imageInfo;
    }