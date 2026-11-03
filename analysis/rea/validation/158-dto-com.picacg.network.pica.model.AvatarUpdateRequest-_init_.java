    public /* synthetic */ AvatarUpdateRequest(int i, String str, fj5 fj5Var) {
        if (1 == (i & 1)) {
            this.avatar = str;
        } else {
            pr2.D(i, 1, AvatarUpdateRequest$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
    }