    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    public final Object a(pe1 pe1Var) {
        m95 m95Var;
        if (pe1Var instanceof m95) {
            m95Var = (m95) pe1Var;
            int i = m95Var.k;
            if ((i & Integer.MIN_VALUE) != 0) {
                m95Var.k = i - Integer.MIN_VALUE;
            } else {
                m95Var = new m95(this, pe1Var);
            }
        } else {
            m95Var = new m95(this, pe1Var);
        }
        Object objEdit = m95Var.i;
        int i2 = m95Var.k;
        try {
            if (i2 == 0) {
                sl4.N(objEdit);
                DataStore dataStore = (DataStore) this.b.getValue(this.a, c[0]);
                n95 n95Var = new n95(2, null);
                m95Var.k = 1;
                objEdit = PreferencesKt.edit(dataStore, n95Var, m95Var);
                jg1 jg1Var = jg1.i;
                if (objEdit == jg1Var) {
                    return jg1Var;
                }
            } else {
                if (i2 != 1) {
                    mz.h("call to 'resume' before 'invoke' with coroutine");
                    return null;
                }
                sl4.N(objEdit);
            }
        } catch (Throwable unused) {
        }
        return dg6.a;
    }