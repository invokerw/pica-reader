    /* JADX WARN: Code duplicated, block: B:7:0x0013  */
    public final Object c(pe1 pe1Var) {
        ys1 ys1Var;
        String strA;
        int i;
        if (pe1Var instanceof ys1) {
            ys1Var = (ys1) pe1Var;
            int i2 = ys1Var.l;
            if ((i2 & Integer.MIN_VALUE) != 0) {
                ys1Var.l = i2 - Integer.MIN_VALUE;
            } else {
                ys1Var = new ys1(this, pe1Var);
            }
        } else {
            ys1Var = new ys1(this, pe1Var);
        }
        Object objI = ys1Var.j;
        int i3 = ys1Var.l;
        ba3[] ba3VarArr = d;
        ir4 ir4Var = this.b;
        Context context = this.a;
        jg1 jg1Var = jg1.i;
        try {
            if (i3 == 0) {
                sl4.N(objI);
                ai aiVar = new ai(((DataStore) ir4Var.getValue(context, ba3VarArr[0])).getData(), 24);
                ys1Var.l = 1;
                objI = kl0.I(aiVar, ys1Var);
                if (objI != jg1Var) {
                }
            }
            if (i3 != 1) {
                if (i3 != 2) {
                    mz.h("call to 'resume' before 'invoke' with coroutine");
                    return null;
                }
                String str = ys1Var.i;
                sl4.N(objI);
                return str;
            }
            sl4.N(objI);
            String string = Settings.Secure.getString(context.getContentResolver(), "android_id");
            if (string == null || string.length() == 0 || string.equals("9774d56d682e549c")) {
                strA = a();
            } else {
                try {
                    MessageDigest messageDigest = MessageDigest.getInstance("MD5");
                    byte[] bytes = string.getBytes(do0.a);
                    bytes.getClass();
                    byte[] bArrDigest = messageDigest.digest(bytes);
                    bArrDigest.getClass();
                    strA = sx.i0(bArrDigest, "", new dz0(23), 30);
                } catch (Exception unused) {
                    strA = a();
                }
            }
        } catch (Exception unused2) {
            strA = a();
        }
        String str2 = (String) objI;
        if (str2 != null && str2.length() != 0 && str2.length() == 32) {
            for (0; i < str2.length(); i + 1) {
                char cCharAt = str2.charAt(i);
                i = (('0' <= cCharAt && cCharAt < ':') || ('a' <= cCharAt && cCharAt < 'g') || ('A' <= cCharAt && cCharAt < 'G')) ? i + 1 : 0;
            }
            return str2;
        }
        DataStore dataStore = (DataStore) ir4Var.getValue(context, ba3VarArr[0]);
        zs1 zs1Var = new zs1(strA, null);
        ys1Var.i = strA;
        ys1Var.l = 2;
        return PreferencesKt.edit(dataStore, zs1Var, ys1Var) == jg1Var ? jg1Var : strA;
    }