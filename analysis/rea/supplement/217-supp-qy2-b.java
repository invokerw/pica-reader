    public static String b(s65 s65Var) {
        dl3 dl3VarZ = pl0.z();
        String strH = s65.h(s65Var, "cf-ray");
        if (strH != null) {
            dl3VarZ.add("cf-ray=".concat(strH));
        }
        String strH2 = s65.h(s65Var, "server");
        if (strH2 != null) {
            dl3VarZ.add("server=".concat(strH2));
        }
        String strH3 = s65.h(s65Var, "cf-cache-status");
        if (strH3 != null) {
            dl3VarZ.add("cf-cache=".concat(strH3));
        }
        String strH4 = s65.h(s65Var, "cf-mitigated");
        if (strH4 != null) {
            dl3VarZ.add("cf-mitigated=".concat(strH4));
        }
        dl3 dl3VarW = pl0.w(dl3VarZ);
        if (dl3VarW.isEmpty()) {
            return null;
        }
        return nr0.C0(dl3VarW, " ", null, null, null, 62);
    }