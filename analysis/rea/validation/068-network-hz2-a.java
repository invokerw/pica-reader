    @Override // defpackage.o53
    public final s65 a(he3 he3Var) {
        oa1 oa1Var;
        zx zxVar = (zx) he3Var.i;
        String str = ((lx2) zxVar.b).i;
        LruCache lruCache = a;
        String str2 = (String) lruCache.get(str);
        if (str2 != null) {
            SimpleDateFormat simpleDateFormat = sy2.a;
            lx2 lx2Var = (lx2) zxVar.b;
            sy2.f("⚡ 301缓存命中: " + lx2Var.d + kx5.L0(60, lx2Var.b()) + "...", 'D');
            k30 k30VarK = zxVar.k();
            k30VarK.v(str2);
            return he3Var.f(new zx(k30VarK));
        }
        int i = 0;
        while (true) {
            lx2 lx2Var2 = (lx2) zxVar.b;
            s65 s65VarF = he3Var.f(zxVar);
            int i2 = s65VarF.l;
            if (!pl0.M(301, 302, 303, 307, 308).contains(Integer.valueOf(i2))) {
                return s65VarF;
            }
            String strH = s65.h(s65VarF, "Location");
            if (strH == null) {
                Log.w("ImgRedirect", i2 + " 无 Location header: " + lx2Var2);
                return s65VarF;
            }
            i++;
            if (i > 5) {
                Log.e("ImgRedirect", "重定向链超过 5 次，终止: ".concat(str));
                return s65VarF;
            }
            lx2Var2.getClass();
            try {
                oa1Var = new oa1();
                oa1Var.i(lx2Var2, strH);
            } catch (IllegalArgumentException unused) {
                oa1Var = null;
            }
            lx2 lx2VarB = oa1Var != null ? oa1Var.b() : null;
            if (lx2VarB == null) {
                Log.w("ImgRedirect", "无法解析 Location: ".concat(strH));
                return s65VarF;
            }
            String str3 = lx2Var2.d;
            String str4 = lx2VarB.d;
            boolean Z = rx5.Z(str3, str4, true);
            SimpleDateFormat simpleDateFormat2 = sy2.a;
            String str5 = !Z ? "跨域" : "同域";
            String strL0 = kx5.L0(50, lx2VarB.b());
            StringBuilder sb = new StringBuilder("↪ ");
            sb.append(i2);
            sb.append(" 重定向 [");
            sb.append(str5);
            sb.append("] ");
            zv3.w(sb, str3, " → ", str4, strL0);
            sb.append("...");
            sy2.f(sb.toString(), 'D');
            if (i2 == 301 || i2 == 308) {
                lruCache.put(str, lx2VarB.i);
            }
            s65VarF.o.close();
            k30 k30VarK2 = zxVar.k();
            k30VarK2.a = lx2VarB;
            zxVar = new zx(k30VarK2);
        }
    }