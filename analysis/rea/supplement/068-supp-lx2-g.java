    public final oa1 g() {
        int i;
        oa1 oa1Var = new oa1();
        String str = this.a;
        oa1Var.e = str;
        oa1Var.f = e();
        oa1Var.g = a();
        oa1Var.h = this.d;
        str.getClass();
        if (str.equals("http")) {
            i = 80;
        } else {
            i = str.equals("https") ? 443 : -1;
        }
        int i2 = this.e;
        oa1Var.b = i2 != i ? i2 : -1;
        ArrayList arrayList = oa1Var.c;
        arrayList.clear();
        arrayList.addAll(c());
        String strD = d();
        String strSubstring = null;
        oa1Var.d = strD != null ? oa1.l(rz3.p(strD, " \"'<>#", 0, 0, 83)) : null;
        if (this.h != null) {
            String str2 = this.i;
            strSubstring = str2.substring(kx5.q0(str2, '#', 0, 6) + 1);
        }
        oa1Var.i = strSubstring;
        return oa1Var;
    }