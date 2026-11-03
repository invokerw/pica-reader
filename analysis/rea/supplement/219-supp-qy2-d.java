    public static String d(he3 he3Var) {
        lh0 lh0Var = (lh0) he3Var.h;
        cz4 cz4VarC = lh0Var != null ? lh0Var.c() : null;
        if (cz4VarC == null) {
            return "unknown（无连接信息）";
        }
        Set set = et1.a;
        return et1.a(cz4VarC.c) + " " + cz4VarC.g;
    }