    @Override // defpackage.o53
    public final s65 a(he3 he3Var) throws NoSuchAlgorithmException, InvalidKeyException {
        zx zxVar = (zx) he3Var.i;
        int iCurrentTimeMillis = (int) (System.currentTimeMillis() / 1000);
        nh4 nh4Var = this.a;
        if (nh4Var.d == null) {
            nh4Var.d = nh4Var.e();
        }
        String str = nh4Var.d;
        str.getClass();
        at1 at1Var = this.b;
        ne1 ne1Var = null;
        if (at1Var.c == null) {
            at1Var.c = (String) k64.P(y32.i, new fk(at1Var, ne1Var, 15));
        }
        String str2 = at1Var.c;
        str2.getClass();
        String strA0 = kx5.A0(((lx2) zxVar.b).b(), "/");
        String strD = ((lx2) zxVar.b).d();
        if (strD != null && strD.length() != 0) {
            strA0 = c31.x(strA0, "?", strD);
        }
        String str3 = (String) zxVar.g;
        str3.getClass();
        StringBuilder sb = new StringBuilder();
        sb.append(strA0);
        sb.append(iCurrentTimeMillis);
        sb.append(str);
        String lowerCase = c31.n(sb, str3, "C69BAF41DA5ABD1FFEDC6D2FEA56B").toLowerCase(Locale.ROOT);
        lowerCase.getClass();
        Mac mac = Mac.getInstance("HmacSHA256");
        Charset charset = do0.a;
        byte[] bytes = "~d}$Q7$eIni=V)9\\RK/P.RM4;9[7|@/CA}b~OW!3?EV`:<>M7pddUBL5n|0/*Cn".getBytes(charset);
        bytes.getClass();
        mac.init(new SecretKeySpec(bytes, "HmacSHA256"));
        byte[] bytes2 = lowerCase.getBytes(charset);
        bytes2.getClass();
        byte[] bArrDoFinal = mac.doFinal(bytes2);
        bArrDoFinal.getClass();
        String strI0 = sx.i0(bArrDoFinal, "", new kx3(28), 30);
        nh4 nh4Var2 = this.a;
        if (nh4Var2.c == null) {
            s42 s42Var = nh4Var2.b;
            String string = s42Var.c.getString("auth_token", null);
            nh4Var2.c = string == null ? null : s42Var.a(string);
        }
        String str4 = nh4Var2.c;
        String str5 = this.c.b;
        k30 k30VarK = zxVar.k();
        k30VarK.q("accept", "application/vnd.picacomic.com.v1+json");
        String strValueOf = String.valueOf(iCurrentTimeMillis);
        strValueOf.getClass();
        ((ys2) k30VarK.c).a("time", strValueOf);
        ((ys2) k30VarK.c).a("nonce", str);
        ((ys2) k30VarK.c).a("signature", strI0);
        ((ys2) k30VarK.c).a("api-key", "C69BAF41DA5ABD1FFEDC6D2FEA56B");
        ((ys2) k30VarK.c).a("app-channel", IcyHeaders.REQUEST_HEADER_ENABLE_METADATA_VALUE);
        ((ys2) k30VarK.c).a("app-version", "2.3.1.20241111");
        ((ys2) k30VarK.c).a("app-uuid", str2);
        ((ys2) k30VarK.c).a("app-platform", "android");
        ((ys2) k30VarK.c).a("app-build-version", "20250144");
        ((ys2) k30VarK.c).a("User-Agent", "okhttp/3.8.1");
        str5.getClass();
        ((ys2) k30VarK.c).a("image-quality", str5);
        if (str4 != null) {
            ((ys2) k30VarK.c).a("authorization", str4);
        }
        s65 s65VarF = he3Var.f(new zx(k30VarK));
        if (s65VarF.l == 401) {
            Log.w("PicaAuthInterceptor", "intercept: 收到401响应，清除Token");
            nh4 nh4Var3 = this.a;
            nh4Var3.b.c.edit().remove("auth_token").remove("refresh_token").commit();
            nh4Var3.c = null;
        }
        return s65VarF;
    }