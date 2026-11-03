    public /* synthetic */ ImageInfo(int i, String str, String str2, String str3, fj5 fj5Var) {
        if (6 != (i & 6)) {
            pr2.D(i, 6, ImageInfo$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        if ((i & 1) == 0) {
            this.originalName = null;
        } else {
            this.originalName = str;
        }
        this.path = str2;
        this.fileServer = str3;
    }