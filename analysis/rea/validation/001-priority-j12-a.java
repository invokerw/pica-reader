    @Override // defpackage.si0
    public final bz4 a(zx zxVar) {
        zxVar.getClass();
        v55 v55Var = this.a;
        RequestMode requestMode = (RequestMode) v55Var.d.getValue();
        requestMode.getClass();
        Subdomain subdomain = Subdomain.API;
        subdomain.getClass();
        int i = 0;
        String strQ0 = kx5.Q0("", '/');
        StringBuilder sbQ = zv3.q("https://", subdomain.getPrefix(), ".", requestMode.getDomain(), "/");
        sbQ.append(strQ0);
        String strO0 = kx5.O0(sbQ.toString(), '/');
        p54 p54Var = v55Var.b;
        Object objComputeIfAbsent = p54Var.k.computeIfAbsent(requestMode, new o54(i, new n54(p54Var, requestMode, i)));
        objComputeIfAbsent.getClass();
        strO0.getClass();
        oa1 oa1Var = new oa1();
        oa1Var.i(null, strO0);
        lx2 lx2VarB = oa1Var.b();
        oa1 oa1VarG = ((lx2) zxVar.b).g();
        oa1VarG.k(lx2VarB.a);
        oa1VarG.h(lx2VarB.d);
        oa1VarG.j(lx2VarB.e);
        lx2 lx2VarB2 = oa1VarG.b();
        k30 k30VarK = zxVar.k();
        k30VarK.a = lx2VarB2;
        k30VarK.q("accept", "application/vnd.picacomic.com.v1+json");
        return new bz4((m54) objComputeIfAbsent, new zx(k30VarK));
    }