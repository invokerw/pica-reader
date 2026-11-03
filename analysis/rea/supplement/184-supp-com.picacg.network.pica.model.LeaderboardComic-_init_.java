    /* JADX WARN: Illegal instructions before constructor call */
    public /* synthetic */ LeaderboardComic(String str, String str2, String str3, int i, int i2, int i3, int i4, boolean z, List list, List list2, ImageInfo imageInfo, int i5, int i6, jo1 jo1Var) {
        int i7 = (i6 & 8) != 0 ? 0 : i;
        int i8 = (i6 & 16) != 0 ? 0 : i2;
        int i9 = (i6 & 32) != 0 ? 0 : i3;
        int i10 = (i6 & 64) != 0 ? 0 : i4;
        boolean z2 = (i6 & 128) != 0 ? false : z;
        int i11 = i6 & 256;
        b42 b42Var = b42.i;
        this(str, str2, str3, i7, i8, i9, i10, z2, i11 != 0 ? b42Var : list, (i6 & 512) != 0 ? b42Var : list2, imageInfo, (i6 & 2048) != 0 ? 0 : i5);
    }