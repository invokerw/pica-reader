    public /* synthetic */ Episode(int i, String str, String str2, int i2, String str3, fj5 fj5Var) {
        if (15 != (i & 15)) {
            pr2.D(i, 15, Episode$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.id = str;
        this.title = str2;
        this.order = i2;
        this.updatedAt = str3;
    }