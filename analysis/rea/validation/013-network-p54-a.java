    public final fv1 a(RequestMode requestMode) {
        ResolveStrategy resolveStrategy = requestMode.getResolveStrategy();
        if (resolveStrategy instanceof ResolveStrategy.SystemDns) {
            return null;
        }
        if (resolveStrategy instanceof ResolveStrategy.FixedIps) {
            return this.e;
        }
        if (resolveStrategy instanceof ResolveStrategy.MeasuredPool) {
            return this.d;
        }
        k.b();
        return null;
    }