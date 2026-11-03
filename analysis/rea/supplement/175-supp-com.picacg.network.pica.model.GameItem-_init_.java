    /* JADX WARN: Illegal instructions before constructor call */
    public /* synthetic */ GameItem(String str, String str2, String str3, String str4, ImageInfo imageInfo, boolean z, boolean z2, List list, List list2, boolean z3, boolean z4, boolean z5, int i, jo1 jo1Var) {
        boolean z6 = (i & 32) != 0 ? false : z;
        boolean z7 = (i & 64) != 0 ? false : z2;
        int i2 = i & 128;
        b42 b42Var = b42.i;
        this(str, str2, str3, str4, imageInfo, z6, z7, i2 != 0 ? b42Var : list, (i & 256) != 0 ? b42Var : list2, (i & 512) != 0 ? false : z3, (i & 1024) != 0 ? false : z4, (i & 2048) != 0 ? false : z5);
    }