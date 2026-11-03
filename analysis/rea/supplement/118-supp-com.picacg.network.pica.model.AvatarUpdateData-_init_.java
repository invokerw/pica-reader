    public /* synthetic */ AvatarUpdateData(int i, ImageInfo imageInfo, fj5 fj5Var) {
        if (1 == (i & 1)) {
            this.avatar = imageInfo;
        } else {
            pr2.D(i, 1, AvatarUpdateData$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
    }