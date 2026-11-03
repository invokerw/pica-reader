    public static String c(s65 s65Var) {
        String strP;
        try {
            long jH = s65Var.o.h();
            if (1 > jH || jH >= 4097) {
                jH = 4096;
            }
            t65 t65VarN = s65Var.n(jH);
            if (rx5.Z(s65.h(s65Var, "content-encoding"), "gzip", true)) {
                sf0 sf0Var = new sf0();
                try {
                    sr2 sr2Var = new sr2(t65VarN.l);
                    try {
                        sr2Var.L(sf0Var, 512L);
                        sr2Var.close();
                        strP = sf0Var.Z();
                    } catch (Throwable th) {
                        try {
                            throw th;
                        } catch (Throwable th2) {
                            ql0.H(sr2Var, th);
                            throw th2;
                        }
                    }
                } catch (Throwable unused) {
                }
            } else {
                strP = t65VarN.p();
            }
            if (kx5.t0(strP)) {
                return "（空）";
            }
            Pattern patternCompile = Pattern.compile("\\s+");
            patternCompile.getClass();
            String strReplaceAll = patternCompile.matcher(strP).replaceAll(" ");
            strReplaceAll.getClass();
            return kx5.L0(512, kx5.N0(strReplaceAll).toString());
        } catch (Exception e) {
            return c31.j("（读取失败：", e.getClass().getSimpleName(), "）");
        }
    }