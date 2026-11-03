    /* JADX WARN: Code duplicated, block: B:22:0x0089  */
    @Override // defpackage.lm2
    public final Object invoke(Object obj) {
        int iOffsetByCodePoints;
        int i = this.i;
        boolean z = false;
        dg6 dg6Var = dg6.a;
        switch (i) {
            case 0:
                obj.getClass();
                List list = (List) obj;
                Object obj2 = list.get(0);
                w66 w66Var = (j63.u(obj2, Boolean.FALSE) || obj2 == null) ? null : (w66) ((lm2) x34.m.k).invoke(obj2);
                w66Var.getClass();
                int i2 = w66Var.a;
                Object obj3 = list.get(1);
                Boolean bool = obj3 != null ? (Boolean) obj3 : null;
                bool.getClass();
                return new x66(i2, bool.booleanValue());
            case 1:
                obj.getClass();
                return new w66(((Integer) obj).intValue());
            case 2:
                return new gd5(((Integer) obj).intValue());
            case 3:
                ik4 ik4Var = (ik4) obj;
                if (ik4Var != null && ik4Var.a == 2) {
                    z = true;
                }
                return Boolean.valueOf(!z);
            case 4:
                tj tjVar = (tj) obj;
                tjVar.getClass();
                return Integer.valueOf(tjVar.a);
            case 5:
                ba3[] ba3VarArr = ji5.a;
                ((li5) obj).a(hi5.e, dg6Var);
                return dg6Var;
            case 6:
                y44 y44Var = (y44) obj;
                long j = y44Var.a;
                return (9223372034707292159L & j) != 9205357640488583168L ? new mj(Float.intBitsToFloat((int) (j >> 32)), Float.intBitsToFloat((int) (y44Var.a & 4294967295L))) : kh5.a;
            case 7:
                mj mjVar = (mj) obj;
                return new y44((((long) Float.floatToRawIntBits(mjVar.b)) & 4294967295L) | (((long) Float.floatToRawIntBits(mjVar.a)) << 32));
            case 8:
                return new rh5(((Long) obj).longValue());
            case 9:
                return Boolean.valueOf(obj == null);
            case 10:
                g83 g83Var = (g83) obj;
                g83Var.getClass();
                g83Var.b = true;
                g83Var.c = true;
                g83Var.a = true;
                return dg6Var;
            case 11:
                r93 r93Var = (r93) obj;
                r93Var.getClass();
                ca3 ca3VarP = gk4.P(r93Var);
                if (ca3VarP != null) {
                    return ca3VarP;
                }
                if (lq2.H(r93Var).isInterface()) {
                    return new mk4(r93Var);
                }
                return null;
            case 12:
                r93 r93Var2 = (r93) obj;
                r93Var2.getClass();
                ca3 ca3VarP2 = gk4.P(r93Var2);
                if (ca3VarP2 == null) {
                    ca3VarP2 = lq2.H(r93Var2).isInterface() ? new mk4(r93Var2) : null;
                }
                if (ca3VarP2 != null) {
                    return uo3.M(ca3VarP2);
                }
                return null;
            case 13:
                li5 li5Var = (li5) obj;
                li5Var.getClass();
                ba3[] ba3VarArr2 = ji5.a;
                li5Var.a(hi5.h, dg6Var);
                return dg6Var;
            case 14:
                ((sz1) obj).getClass();
                return dg6Var;
            case 15:
                dc5 dc5Var = ot5.a;
                return dg6Var;
            case 16:
                ((qi) obj).getClass();
                return xm1.z(j52.d(null, 3).a(j52.f(null, 0.7f, 5)), j52.e(null, 3).a(j52.g(null, 0.7f, 5)));
            case 17:
                li5 li5Var2 = (li5) obj;
                li5Var2.getClass();
                ji5.c(li5Var2, "加载中");
                return dg6Var;
            case 18:
                hr0 hr0Var = (hr0) obj;
                hr0Var.getClass();
                return hr0Var.a;
            case 19:
                ((String) obj).getClass();
                return dg6Var;
            case 20:
                ((sz1) obj).getClass();
                return dg6Var;
            case 21:
                ba3[] ba3VarArr3 = ji5.a;
                ki5 ki5Var = hi5.l;
                ba3 ba3Var = ji5.a[5];
                ((li5) obj).a(ki5Var, Boolean.TRUE);
                return dg6Var;
            case 22:
                return dg6Var;
            case 23:
                Resources resources = (Resources) obj;
                resources.getClass();
                return Boolean.valueOf((resources.getConfiguration().uiMode & 48) == 32);
            case 24:
                ((Float) obj).getClass();
                return dg6Var;
            case 25:
                f56 f56Var = (f56) obj;
                String str = f56Var.g.j;
                long j2 = f56Var.f;
                int i3 = z66.c;
                int i4 = (int) (j2 & 4294967295L);
                if (i4 > 0) {
                    j32 j32VarZ = bl4.z();
                    if (j32VarZ != null) {
                        int iB = j32VarZ.b(str, i4 - 1);
                        if (iB >= 0) {
                            iOffsetByCodePoints = iB;
                        } else if (i4 <= 0) {
                            iOffsetByCodePoints = -1;
                        } else {
                            iOffsetByCodePoints = Character.offsetByCodePoints(str, i4, -1);
                        }
                    } else if (i4 <= 0) {
                        iOffsetByCodePoints = -1;
                    } else {
                        iOffsetByCodePoints = Character.offsetByCodePoints(str, i4, -1);
                    }
                } else {
                    iOffsetByCodePoints = -1;
                }
                if (iOffsetByCodePoints == -1) {
                    return null;
                }
                return new yr1(((int) (f56Var.f & 4294967295L)) - iOffsetByCodePoints, 0);
            case 26:
                f56 f56Var2 = (f56) obj;
                String str2 = f56Var2.g.j;
                long j3 = f56Var2.f;
                int i5 = z66.c;
                int iX = bl4.x((int) (j3 & 4294967295L), str2);
                if (iX != -1) {
                    return new yr1(0, iX - ((int) (f56Var2.f & 4294967295L)));
                }
                return null;
            case 27:
                f56 f56Var3 = (f56) obj;
                Integer numE = f56Var3.e();
                if (numE == null) {
                    return null;
                }
                int iIntValue = numE.intValue();
                long j4 = f56Var3.f;
                int i6 = z66.c;
                return new yr1(((int) (j4 & 4294967295L)) - iIntValue, 0);
            case 28:
                f56 f56Var4 = (f56) obj;
                Integer numD = f56Var4.d();
                if (numD == null) {
                    return null;
                }
                int iIntValue2 = numD.intValue();
                long j5 = f56Var4.f;
                int i7 = z66.c;
                return new yr1(0, iIntValue2 - ((int) (j5 & 4294967295L)));
            default:
                f56 f56Var5 = (f56) obj;
                Integer numC = f56Var5.c();
                if (numC == null) {
                    return null;
                }
                int iIntValue3 = numC.intValue();
                long j6 = f56Var5.f;
                int i8 = z66.c;
                return new yr1(((int) (j6 & 4294967295L)) - iIntValue3, 0);
        }
    }