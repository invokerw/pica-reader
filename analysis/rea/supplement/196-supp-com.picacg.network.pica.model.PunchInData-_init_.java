    public /* synthetic */ PunchInData(int i, String str, String str2, fj5 fj5Var) {
        if (1 != (i & 1)) {
            pr2.D(i, 1, PunchInData$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
        this.status = str;
        if ((i & 2) == 0) {
            this.lastDay = null;
        } else {
            this.lastDay = str2;
        }
    }