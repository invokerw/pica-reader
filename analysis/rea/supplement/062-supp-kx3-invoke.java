    @Override // defpackage.lm2
    public final Object invoke(Object obj) {
        int i = this.i;
        dg6 dg6Var = dg6.a;
        switch (i) {
            case 0:
                ((CommentUser) obj).getClass();
                return dg6Var;
            case 1:
                MyCommentItem myCommentItem = (MyCommentItem) obj;
                myCommentItem.getClass();
                return myCommentItem.getId();
            case 2:
                zg1 zg1Var = (zg1) obj;
                zg1Var.getClass();
                return new yx3(jb5.o(zg1Var));
            case 3:
                return new t30(jb5.o((zg1) obj));
            case 4:
                Context context = (Context) obj;
                context.getClass();
                if (context instanceof ContextWrapper) {
                    return ((ContextWrapper) context).getBaseContext();
                }
                return null;
            case 5:
                fz3 fz3Var = (fz3) obj;
                fz3Var.getClass();
                fz3Var.c = true;
                return dg6Var;
            case 6:
                py3 py3Var = (py3) obj;
                py3Var.getClass();
                sy3 sy3Var = py3Var.k;
                if (sy3Var == null || sy3Var.n.b != py3Var.j.b) {
                    return null;
                }
                return sy3Var;
            case 7:
                py3 py3Var2 = (py3) obj;
                py3Var2.getClass();
                sy3 sy3Var2 = py3Var2.k;
                if (sy3Var2 == null || sy3Var2.n.b != py3Var2.j.b) {
                    return null;
                }
                return sy3Var2;
            case 8:
                py3 py3Var3 = (py3) obj;
                py3Var3.getClass();
                return Integer.valueOf(py3Var3.j.b);
            case 9:
                ((zg1) obj).getClass();
                return new hy3();
            case 10:
                Context context2 = (Context) obj;
                context2.getClass();
                ContextWrapper contextWrapper = context2 instanceof ContextWrapper ? (ContextWrapper) context2 : null;
                if (contextWrapper != null) {
                    return contextWrapper.getBaseContext();
                }
                return null;
            case 11:
                Context context3 = (Context) obj;
                context3.getClass();
                if (context3 instanceof Activity) {
                    return (Activity) context3;
                }
                return null;
            case 12:
                py3 py3Var4 = (py3) obj;
                py3Var4.getClass();
                return py3Var4.k;
            case 13:
                py3 py3Var5 = (py3) obj;
                py3Var5.getClass();
                if (!(py3Var5 instanceof sy3)) {
                    return null;
                }
                ef efVar = ((sy3) py3Var5).n;
                return efVar.n(efVar.b);
            case 14:
                py3 py3Var6 = ((xx3) ((wi) ((qi) obj)).c()).j;
                py3Var6.getClass();
                int i2 = py3.m;
                for (py3 py3Var7 : sq2.B((n81) py3Var6)) {
                }
                return null;
            case 15:
                return j52.d(u04.U(700, 6, null), 2);
            case 16:
                return j52.e(u04.U(700, 6, null), 2);
            case 17:
                return ((xx3) obj).n;
            case 18:
                fz3 fz3Var2 = (fz3) obj;
                fz3Var2.getClass();
                fz3Var2.b = true;
                return dg6Var;
            case 19:
                String str = (String) obj;
                str.getClass();
                return "  ".concat(str);
            case 20:
                String str2 = (String) obj;
                str2.getClass();
                return "  ".concat(str2);
            case 21:
                sf sfVar = ((o14) obj).a;
                if (sfVar != null) {
                    sfVar.invoke();
                }
                return dg6Var;
            case 22:
                ne4 ne4Var = (ne4) obj;
                int i3 = df.a;
                uw5 uw5Var = zc.b;
                ne4Var.getClass();
                Context context4 = (Context) in0.Y(ne4Var, uw5Var);
                hs1 hs1Var = (hs1) in0.Y(ne4Var, ia1.h);
                e94 e94Var = (e94) in0.Y(ne4Var, f94.a);
                if (e94Var == null) {
                    return null;
                }
                return new zd(context4, hs1Var, e94Var.a, e94Var.b);
            case 23:
                ((qi) obj).getClass();
                return xm1.z(j52.d(u04.U(300, 6, null), 2), j52.e(u04.U(200, 6, null), 2));
            case 24:
                ea4 ea4Var = (ea4) obj;
                ea4Var.getClass();
                return ea4Var;
            case 25:
                return Boolean.valueOf(PagedList.addWeakLoadStateListener$lambda$0((WeakReference) obj));
            case 26:
                return Boolean.valueOf(PagedList.addWeakCallback$lambda$0((WeakReference) obj));
            case 27:
                return PagingSource.invalidateCallbackTracker$lambda$0((km2) obj);
            case 28:
                Byte b = (Byte) obj;
                b.byteValue();
                return String.format("%02x", Arrays.copyOf(new Object[]{b}, 1));
            default:
                return PreferenceDataStoreDelegateKt.preferencesDataStore$lambda$0((Context) obj);
        }
    }