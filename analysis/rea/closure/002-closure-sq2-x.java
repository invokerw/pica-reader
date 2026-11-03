    public static qr3 x(String str) {
        str.getClass();
        xq3 xq3VarA = qr3.e.a(0, str);
        if (xq3VarA == null) {
            mz.f(zv3.g('\"', "No subtype found for: \"", str));
            return null;
        }
        String str2 = (String) ((vq3) xq3VarA.a()).get(1);
        Locale locale = Locale.ROOT;
        String lowerCase = str2.toLowerCase(locale);
        lowerCase.getClass();
        String lowerCase2 = ((String) ((vq3) xq3VarA.a()).get(2)).toLowerCase(locale);
        lowerCase2.getClass();
        ArrayList arrayList = new ArrayList();
        int i2 = xq3VarA.b().j;
        while (true) {
            int i3 = i2 + 1;
            if (i3 >= str.length()) {
                return new qr3(str, lowerCase, lowerCase2, (String[]) arrayList.toArray(new String[0]));
            }
            xq3 xq3VarA2 = qr3.f.a(i3, str);
            if (xq3VarA2 == null) {
                nr3.l("Parameter is not formatted correctly: \"", str.substring(i3), "\" for: \"", str, 34);
                return null;
            }
            wq3 wq3Var = xq3VarA2.c;
            uq3 uq3VarA = wq3Var.a(1);
            String str3 = uq3VarA != null ? uq3VarA.a : null;
            if (str3 == null) {
                i2 = xq3VarA2.b().j;
            } else {
                uq3 uq3VarA2 = wq3Var.a(2);
                String strSubstring = uq3VarA2 != null ? uq3VarA2.a : null;
                if (strSubstring == null) {
                    uq3 uq3VarA3 = wq3Var.a(3);
                    uq3VarA3.getClass();
                    strSubstring = uq3VarA3.a;
                } else if (kx5.F0(strSubstring, '\'') && kx5.n0(strSubstring, '\'') && strSubstring.length() > 2) {
                    strSubstring = strSubstring.substring(1, strSubstring.length() - 1);
                }
                arrayList.add(str3);
                arrayList.add(strSubstring);
                i2 = xq3VarA2.b().j;
            }
        }
    }