    @Override // defpackage.lm2
    public final Object invoke(Object obj) {
        int i = this.i;
        int i2 = 3;
        int i3 = 2;
        RequestMode requestMode = this.k;
        p54 p54Var = this.j;
        RequestMode requestMode2 = (RequestMode) obj;
        switch (i) {
            case 0:
                requestMode2.getClass();
                requestMode.getDisplayName();
                g35.a(requestMode.getResolveStrategy().getClass()).d();
                l54 l54Var = new l54();
                up2 up2Var = p54Var.h;
                up2Var.getClass();
                l54Var.b = up2Var;
                l54Var.l = (mh0) p54Var.i.getValue();
                wi0 wi0Var = new wi0(i2);
                ArrayList arrayList = l54Var.c;
                arrayList.add(wi0Var);
                arrayList.add(new wi0(i3));
                arrayList.add(new fg4(p54Var.b, p54Var.c, p54Var.g));
                ue0 ue0Var = new ue0(p54Var.f, i3);
                ArrayList arrayList2 = l54Var.d;
                arrayList2.add(ue0Var);
                arrayList2.add(new qy2());
                fa4 fa4Var = dh4.e;
                fa4Var.getClass();
                l54Var.e = fa4Var;
                l54Var.a(30L);
                l54Var.c(30L);
                l54Var.d(30L);
                fv1 fv1VarA = p54Var.a(requestMode);
                if (fv1VarA != null) {
                    l54Var.b(fv1VarA);
                }
                return new m54(l54Var);
            case 1:
                requestMode2.getClass();
                requestMode.getDisplayName();
                g35.a(requestMode.getResolveStrategy().getClass()).d();
                l54 l54Var2 = new l54();
                up2 up2Var2 = p54Var.j;
                up2Var2.getClass();
                l54Var2.b = up2Var2;
                l54Var2.l = (mh0) p54Var.i.getValue();
                l54Var2.i = false;
                wi0 wi0Var2 = new wi0(i2);
                ArrayList arrayList3 = l54Var2.c;
                arrayList3.add(wi0Var2);
                arrayList3.add(new hz2());
                ue0 ue0Var2 = new ue0(p54Var.f, i3);
                ArrayList arrayList4 = l54Var2.d;
                arrayList4.add(ue0Var2);
                arrayList4.add(new qy2());
                fa4 fa4Var2 = dh4.e;
                fa4Var2.getClass();
                l54Var2.e = fa4Var2;
                l54Var2.a(30L);
                l54Var2.c(30L);
                l54Var2.d(30L);
                fv1 fv1VarA2 = p54Var.a(requestMode);
                if (fv1VarA2 != null) {
                    l54Var2.b(fv1VarA2);
                }
                return new m54(l54Var2);
            default:
                requestMode2.getClass();
                l54 l54Var3 = new l54();
                l54Var3.a(10L);
                l54Var3.c(10L);
                l54Var3.d(10L);
                fv1 fv1VarA3 = p54Var.a(requestMode);
                if (fv1VarA3 != null) {
                    l54Var3.b(fv1VarA3);
                }
                return new m54(l54Var3);
        }
    }