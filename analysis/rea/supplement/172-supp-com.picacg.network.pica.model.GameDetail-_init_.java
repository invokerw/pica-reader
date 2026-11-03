    /* JADX WARN: Illegal instructions before constructor call */
    public /* synthetic */ GameDetail(String str, String str2, String str3, String str4, String str5, ImageInfo imageInfo, boolean z, boolean z2, List list, List list2, boolean z3, boolean z4, boolean z5, int i, int i2, int i3, boolean z6, List list3, Double d, Double d2, String str6, String str7, String str8, String str9, int i4, jo1 jo1Var) {
        boolean z7 = (i4 & 64) != 0 ? false : z;
        boolean z8 = (i4 & 128) != 0 ? false : z2;
        int i5 = i4 & 256;
        b42 b42Var = b42.i;
        this(str, str2, str3, str4, str5, imageInfo, z7, z8, i5 != 0 ? b42Var : list, (i4 & 512) != 0 ? b42Var : list2, (i4 & 1024) != 0 ? false : z3, (i4 & 2048) != 0 ? false : z4, (i4 & 4096) != 0 ? false : z5, (i4 & 8192) != 0 ? 0 : i, (i4 & 16384) != 0 ? 0 : i2, (32768 & i4) != 0 ? 0 : i3, (65536 & i4) != 0 ? false : z6, (131072 & i4) != 0 ? b42Var : list3, (262144 & i4) != 0 ? null : d, (524288 & i4) != 0 ? null : d2, (1048576 & i4) != 0 ? null : str6, (i4 & 2097152) != 0 ? null : str7, str8, str9);
    }