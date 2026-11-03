    public static final jv1 b(zr5 zr5Var) {
        ConcurrentHashMap concurrentHashMap = zr5Var.c;
        qb4 qb4Var = (qb4) concurrentHashMap.get("picacomic.com");
        if (qb4Var == null) {
            return null;
        }
        if (System.currentTimeMillis() <= ((Number) qb4Var.j).longValue()) {
            return (jv1) qb4Var.i;
        }
        concurrentHashMap.remove("picacomic.com");
        return null;
    }