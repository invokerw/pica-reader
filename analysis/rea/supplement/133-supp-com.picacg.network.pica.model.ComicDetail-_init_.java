    /* JADX WARN: Illegal instructions before constructor call */
    public /* synthetic */ ComicDetail(String str, Creator creator, String str2, String str3, ImageInfo imageInfo, String str4, String str5, List list, List list2, int i, int i2, boolean z, String str6, String str7, boolean z2, boolean z3, Integer num, Integer num2, Integer num3, Integer num4, Integer num5, Integer num6, boolean z4, boolean z5, int i3, jo1 jo1Var) {
        String str8 = (i3 & 4) != 0 ? "" : str2;
        String str9 = (i3 & 8) != 0 ? "" : str3;
        String str10 = (i3 & 32) != 0 ? "" : str4;
        String str11 = (i3 & 64) != 0 ? null : str5;
        int i4 = i3 & 128;
        b42 b42Var = b42.i;
        this(str, creator, str8, str9, imageInfo, str10, str11, i4 != 0 ? b42Var : list, (i3 & 256) != 0 ? b42Var : list2, (i3 & 512) != 0 ? 0 : i, (i3 & 1024) != 0 ? 0 : i2, (i3 & 2048) != 0 ? false : z, (i3 & 4096) != 0 ? "" : str6, (i3 & 8192) != 0 ? "" : str7, (i3 & 16384) != 0 ? true : z2, (32768 & i3) != 0 ? true : z3, (65536 & i3) != 0 ? 0 : num, (131072 & i3) != 0 ? 0 : num2, (262144 & i3) != 0 ? 0 : num3, (524288 & i3) != 0 ? 0 : num4, (1048576 & i3) != 0 ? 0 : num5, (2097152 & i3) != 0 ? 0 : num6, (4194304 & i3) != 0 ? false : z4, (i3 & 8388608) != 0 ? false : z5);
    }