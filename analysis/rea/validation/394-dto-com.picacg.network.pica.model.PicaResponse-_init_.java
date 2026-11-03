    /* JADX WARN: Multi-variable type inference failed */
    public /* synthetic */ PicaResponse(int i, int i2, String str, String str2, Object obj, fj5 fj5Var) {
        if (3 != (i & 3)) {
            pr2.D(i, 3, $cachedDescriptor);
            throw null;
        }
        this.code = i2;
        this.message = str;
        if ((i & 4) == 0) {
            this.error = null;
        } else {
            this.error = str2;
        }
        if ((i & 8) == 0) {
            this.data = null;
        } else {
            this.data = obj;
        }
    }