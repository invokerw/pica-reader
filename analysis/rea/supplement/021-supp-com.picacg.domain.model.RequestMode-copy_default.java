    public static /* synthetic */ RequestMode copy$default(RequestMode requestMode, String str, String str2, RouteTarget routeTarget, ResolveStrategy resolveStrategy, int i, Object obj) {
        if ((i & 1) != 0) {
            str = requestMode.id;
        }
        if ((i & 2) != 0) {
            str2 = requestMode.displayName;
        }
        if ((i & 4) != 0) {
            routeTarget = requestMode.target;
        }
        if ((i & 8) != 0) {
            resolveStrategy = requestMode.resolveStrategy;
        }
        return requestMode.copy(str, str2, routeTarget, resolveStrategy);
    }