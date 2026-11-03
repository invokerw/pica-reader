    public final boolean getUseCustomDns() {
        return !(this.resolveStrategy instanceof ResolveStrategy.SystemDns);
    }