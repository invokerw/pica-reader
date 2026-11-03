    public final m54 b(RequestMode requestMode) {
        requestMode.getClass();
        int i = 1;
        Object objComputeIfAbsent = this.l.computeIfAbsent(requestMode, new o54(i, new n54(this, requestMode, i)));
        objComputeIfAbsent.getClass();
        return (m54) objComputeIfAbsent;
    }