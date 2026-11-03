    /* JADX WARN: Illegal instructions before constructor call */
    public /* synthetic */ CollectionComicItem(String str, String str2, String str3, ImageInfo imageInfo, List list, List list2, boolean z, int i, int i2, int i3, int i4, int i5, jo1 jo1Var) {
        int i6 = i5 & 16;
        b42 b42Var = b42.i;
        this(str, str2, str3, imageInfo, i6 != 0 ? b42Var : list, (i5 & 32) != 0 ? b42Var : list2, (i5 & 64) != 0 ? false : z, (i5 & 128) != 0 ? 0 : i, (i5 & 256) != 0 ? 0 : i2, (i5 & 512) != 0 ? 0 : i3, (i5 & 1024) != 0 ? 0 : i4);
    }