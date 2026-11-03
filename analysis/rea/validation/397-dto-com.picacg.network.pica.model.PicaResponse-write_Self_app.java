    public static final /* synthetic */ void write$Self$app(PicaResponse picaResponse, u91 u91Var, zi5 zi5Var, ca3 ca3Var) {
        tt3 tt3Var = (tt3) u91Var;
        tt3Var.Y(0, picaResponse.code, zi5Var);
        tt3Var.b0(zi5Var, 1, picaResponse.message);
        if (tt3Var.e(zi5Var) || picaResponse.error != null) {
            tt3Var.p(zi5Var, 2, ix5.a, picaResponse.error);
        }
        if (!tt3Var.e(zi5Var) && picaResponse.data == null) {
            return;
        }
        tt3Var.p(zi5Var, 3, ca3Var, picaResponse.data);
    }