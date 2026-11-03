    public /* synthetic */ PunchInResponse(int i, PunchInData punchInData, fj5 fj5Var) {
        if (1 == (i & 1)) {
            this.res = punchInData;
        } else {
            pr2.D(i, 1, PunchInResponse$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
    }