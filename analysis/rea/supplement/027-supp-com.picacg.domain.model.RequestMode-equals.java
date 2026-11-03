    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (!(obj instanceof RequestMode)) {
            return false;
        }
        RequestMode requestMode = (RequestMode) obj;
        return j63.u(this.id, requestMode.id) && j63.u(this.displayName, requestMode.displayName) && this.target == requestMode.target && j63.u(this.resolveStrategy, requestMode.resolveStrategy);
    }