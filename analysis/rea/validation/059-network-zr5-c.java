    public static final cs5 c(zr5 zr5Var, String str) {
        ConcurrentHashMap concurrentHashMap = zr5Var.b;
        qb4 qb4Var = (qb4) concurrentHashMap.get(str);
        if (qb4Var == null) {
            return null;
        }
        if (System.currentTimeMillis() > ((Number) qb4Var.j).longValue()) {
            concurrentHashMap.remove(str);
            return null;
        }
        Object obj = qb4Var.i;
        return (cs5) (((cs5) obj).b.isEmpty() ? null : obj);
    }