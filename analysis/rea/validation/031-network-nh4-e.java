    public final String e() {
        ArrayList arrayListH0;
        SharedPreferences sharedPreferences = this.a.getSharedPreferences("pica_nonce_prefs", 0);
        String string = sharedPreferences.getString("pica_nonce", null);
        if (string != null) {
            return string;
        }
        b53 b53Var = new b53(1, 32, 1);
        ArrayList arrayList = new ArrayList(or0.f0(b53Var, 10));
        Iterator it = b53Var.iterator();
        while (((a53) it).k) {
            ((t43) it).nextInt();
            Iterable ao0Var = new ao0('0', '9');
            ao0 ao0Var2 = new ao0('a', 'z');
            if (ao0Var instanceof Collection) {
                arrayListH0 = nr0.H0(ao0Var2, (Collection) ao0Var);
            } else {
                ArrayList arrayList2 = new ArrayList();
                nr0.k0(ao0Var, arrayList2);
                nr0.k0(ao0Var2, arrayList2);
                arrayListH0 = arrayList2;
            }
            f3 f3Var = dr4.i;
            Character ch = (Character) nr0.J0(arrayListH0);
            ch.getClass();
            arrayList.add(ch);
        }
        String strC0 = nr0.C0(arrayList, "", null, null, null, 62);
        sharedPreferences.edit().putString("pica_nonce", strC0).apply();
        return strC0;
    }