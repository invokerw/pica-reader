    public static x83 d(lm2 lm2Var) {
        a83 a83Var = b83.d;
        a83Var.getClass();
        g83 g83Var = new g83();
        i83 i83Var = a83Var.a;
        g83Var.a = i83Var.a;
        boolean z = i83Var.d;
        g83Var.b = i83Var.b;
        g83Var.c = i83Var.c;
        String str = i83Var.e;
        String str2 = i83Var.f;
        zp0 zp0Var = i83Var.h;
        boolean z2 = i83Var.g;
        mv2 mv2Var = a83Var.b;
        lm2Var.invoke(g83Var);
        if (!j63.u(str, "    ")) {
            mz.f("Indent should not be specified when default printing mode is used");
            return null;
        }
        i83 i83Var2 = new i83(g83Var.a, g83Var.b, g83Var.c, z, str, str2, z2, zp0Var);
        mv2Var.getClass();
        return new x83(i83Var2, mv2Var);
    }