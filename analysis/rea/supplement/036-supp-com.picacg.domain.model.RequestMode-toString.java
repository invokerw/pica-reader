    public String toString() {
        String str = this.id;
        String str2 = this.displayName;
        RouteTarget routeTarget = this.target;
        ResolveStrategy resolveStrategy = this.resolveStrategy;
        StringBuilder sbQ = zv3.q("RequestMode(id=", str, ", displayName=", str2, ", target=");
        sbQ.append(routeTarget);
        sbQ.append(", resolveStrategy=");
        sbQ.append(resolveStrategy);
        sbQ.append(")");
        return sbQ.toString();
    }