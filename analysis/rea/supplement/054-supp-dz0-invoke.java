    @Override // defpackage.lm2
    public final Object invoke(Object obj) throws Exception {
        int i = this.i;
        boolean z = true;
        dg6 dg6Var = dg6.a;
        switch (i) {
            case 0:
                ((qi) obj).getClass();
                return xm1.z(j52.d(null, 3), j52.e(null, 3));
            case 1:
                gg3 gg3Var = (gg3) obj;
                gg3Var.getClass();
                gg3.I(gg3Var, 10, null, j85.B, 6);
                return dg6Var;
            case 2:
                zg3 zg3Var = (zg3) obj;
                zg3Var.getClass();
                zg3.G(zg3Var, 10, null, j85.z, 14);
                return dg6Var;
            case 3:
                ((String) obj).getClass();
                return dg6Var;
            case 4:
                ((String) obj).getClass();
                return dg6Var;
            case 5:
                Comment comment = (Comment) obj;
                comment.getClass();
                return c31.i("top_", comment.getId());
            case 6:
                Comment comment2 = (Comment) obj;
                comment2.getClass();
                return c31.i("local_", comment2.getId());
            case 7:
                ((sz1) obj).getClass();
                return dg6Var;
            case 8:
                gg3 gg3Var2 = (gg3) obj;
                gg3Var2.getClass();
                gg3.I(gg3Var2, 5, null, ee0.K, 6);
                return dg6Var;
            case 9:
                xs xsVar = (xs) obj;
                xsVar.getClass();
                return Integer.valueOf(xsVar.a);
            case 10:
                vf1 vf1Var = (vf1) obj;
                if (vf1Var instanceof zf1) {
                    return (zf1) vf1Var;
                }
                return null;
            case 11:
                y95 y95Var = (y95) obj;
                y95Var.getClass();
                ea5 ea5VarT = y95Var.T("SELECT COUNT(*) FROM custom_categories");
                try {
                    return Integer.valueOf(ea5VarT.N() ? (int) ea5VarT.getLong(0) : 0);
                } finally {
                    ea5VarT.close();
                }
            case 12:
                return DataSource.invalidateCallbackTracker$lambda$0((DataSource.InvalidatedCallback) obj);
            case 13:
                return DataStoreDelegateKt.dataStore$lambda$0((Context) obj);
            case 14:
                return DataStoreDelegateKt.deviceProtectedDataStore$lambda$0((Context) obj);
            case 15:
                return dg6Var;
            case 16:
                Integer num = (Integer) obj;
                num.intValue();
                return num;
            case 17:
                ba3[] ba3VarArr = ji5.a;
                ki5 ki5Var = hi5.l;
                ba3 ba3Var = ji5.a[5];
                ((li5) obj).a(ki5Var, Boolean.TRUE);
                return dg6Var;
            case 18:
                ba3[] ba3VarArr2 = ji5.a;
                ki5 ki5Var2 = hi5.l;
                ba3 ba3Var2 = ji5.a[5];
                ((li5) obj).a(ki5Var2, Boolean.TRUE);
                return dg6Var;
            case 19:
                int i2 = 25;
                vc5 vc5Var = new vc5(new lw0(i2), new lw0(i2), false);
                ba3[] ba3VarArr3 = ji5.a;
                ki5 ki5Var3 = hi5.u;
                ba3 ba3Var3 = ji5.a[12];
                ((li5) obj).a(ki5Var3, vc5Var);
                return dg6Var;
            case 20:
                ji5.j((li5) obj);
                return dg6Var;
            case 21:
                List list = (List) obj;
                Object obj2 = list.get(0);
                obj2.getClass();
                int iIntValue = ((Integer) obj2).intValue();
                Object obj3 = list.get(1);
                obj3.getClass();
                return new up1(iIntValue, ((Float) obj3).floatValue(), new f6(2, list));
            case 22:
                ji5.j((li5) obj);
                return dg6Var;
            case 23:
                Byte b = (Byte) obj;
                b.byteValue();
                return String.format("%02x", Arrays.copyOf(new Object[]{b}, 1));
            case 24:
                Subdomain subdomain = (Subdomain) obj;
                subdomain.getClass();
                return subdomain.getPrefix();
            case 25:
                ((sz1) obj).getClass();
                return dg6Var;
            case 26:
                ((sz1) obj).getClass();
                return dg6Var;
            case 27:
                DownloadTask downloadTask = (DownloadTask) obj;
                downloadTask.getClass();
                return Long.valueOf(downloadTask.getId());
            case 28:
                vv1 vv1Var = (vv1) obj;
                vv1Var.getClass();
                return vv1Var.a;
            default:
                DownloadTask downloadTask2 = (DownloadTask) obj;
                downloadTask2.getClass();
                if (downloadTask2.getStatus() != DownloadStatus.DOWNLOADING && downloadTask2.getStatus() != DownloadStatus.PENDING) {
                    z = false;
                }
                return Boolean.valueOf(z);
        }
    }