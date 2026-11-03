    public final Object f(String str, String str2, boolean z, sf6 sf6Var, pe1 pe1Var) {
        jw5 jw5Var;
        Object value;
        s42 s42Var = this.b;
        if (z) {
            s42Var.e(str, str2);
        } else {
            s42Var.c.edit().remove("saved_username").remove("saved_password").putBoolean("remember_password", false).apply();
        }
        do {
            jw5Var = this.d;
            value = jw5Var.getValue();
        } while (!jw5Var.j(value, ao3.a));
        fq2.f(this.c, sf6Var);
        Object objSend = this.h.send(sz3.a, pe1Var);
        return objSend == jg1.i ? objSend : dg6.a;
    }