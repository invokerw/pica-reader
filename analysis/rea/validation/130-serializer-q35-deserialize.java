    @Override // defpackage.ca3
    public final Object deserialize(dn1 dn1Var) {
        zi5 zi5Var = descriptor;
        t91 t91VarC = dn1Var.c(zi5Var);
        boolean z = true;
        int i = 0;
        String strM = null;
        String strM2 = null;
        String strM3 = null;
        String strM4 = null;
        String strM5 = null;
        String strM6 = null;
        String strM7 = null;
        String strM8 = null;
        String strM9 = null;
        String strM10 = null;
        String strM11 = null;
        while (z) {
            int iH = t91VarC.h(zi5Var);
            switch (iH) {
                case -1:
                    z = false;
                    break;
                case 0:
                    strM = t91VarC.m(zi5Var, 0);
                    i |= 1;
                    break;
                case 1:
                    strM2 = t91VarC.m(zi5Var, 1);
                    i |= 2;
                    break;
                case 2:
                    strM3 = t91VarC.m(zi5Var, 2);
                    i |= 4;
                    break;
                case 3:
                    strM4 = t91VarC.m(zi5Var, 3);
                    i |= 8;
                    break;
                case 4:
                    strM5 = t91VarC.m(zi5Var, 4);
                    i |= 16;
                    break;
                case 5:
                    strM6 = t91VarC.m(zi5Var, 5);
                    i |= 32;
                    break;
                case 6:
                    strM7 = t91VarC.m(zi5Var, 6);
                    i |= 64;
                    break;
                case 7:
                    strM8 = t91VarC.m(zi5Var, 7);
                    i |= 128;
                    break;
                case 8:
                    strM9 = t91VarC.m(zi5Var, 8);
                    i |= 256;
                    break;
                case 9:
                    strM10 = t91VarC.m(zi5Var, 9);
                    i |= 512;
                    break;
                case 10:
                    strM11 = t91VarC.m(zi5Var, 10);
                    i |= 1024;
                    break;
                default:
                    k.c(iH);
                    return null;
            }
        }
        t91VarC.a(zi5Var);
        return new RegisterRequest(i, strM, strM2, strM3, strM4, strM5, strM6, strM7, strM8, strM9, strM10, strM11, null);
    }