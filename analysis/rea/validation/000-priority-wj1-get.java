    /* JADX WARN: Type inference failed for: r0v84, types: [ez2] */
    @Override // javax.inject.Provider
    public final Object get() {
        Object y65Var;
        int i = this.b;
        int i2 = i / 100;
        if (i2 != 0) {
            if (i2 != 1) {
                throw new AssertionError(i);
            }
            xj1 xj1Var = this.a;
            switch (i) {
                case 100:
                    return new oe5(ApplicationContextModule_ProvideContextFactory.provideContext(xj1Var.a));
                case 101:
                    return new p31((dg4) xj1Var.I.get(), (x55) xj1Var.L.get());
                case 102:
                    return new oi1((bi1) xj1Var.a1.get());
                case 103:
                    PicaComicDatabase picaComicDatabase = (PicaComicDatabase) xj1Var.q.get();
                    picaComicDatabase.getClass();
                    bi1 bi1VarS = picaComicDatabase.s();
                    tl4.w(bi1VarS);
                    return bi1VarS;
                case 104:
                    return new jb2(ApplicationContextModule_ProvideContextFactory.provideContext(xj1Var.a), (b83) xj1Var.h.get());
                case 105:
                    return new mo2((dg4) xj1Var.I.get(), (x55) xj1Var.L.get());
                case 106:
                    Context contextProvideContext = ApplicationContextModule_ProvideContextFactory.provideContext(xj1Var.a);
                    p54 p54Var = (p54) xj1Var.B.get();
                    contextProvideContext.getClass();
                    p54Var.getClass();
                    return new k95(contextProvideContext, p54Var);
                case 107:
                    return new cb3((dg4) xj1Var.I.get(), (x55) xj1Var.L.get());
                case 108:
                    return new di3((dg4) xj1Var.I.get(), (vz2) xj1Var.J.get(), (x55) xj1Var.L.get());
                case 109:
                    DataStore dataStore = (DataStore) xj1Var.z.get();
                    ht4 ht4Var = (ht4) xj1Var.O.get();
                    pk1.a.getClass();
                    dataStore.getClass();
                    ht4Var.getClass();
                    return new hw4(new ps4(dataStore), new z00(dataStore), new a12(dataStore), ht4Var);
                case 110:
                    return new cs(ApplicationContextModule_ProvideContextFactory.provideContext(xj1Var.a));
                case 111:
                    return new sh0((qt0) xj1Var.v.get(), (vx4) xj1Var.J0.get(), (rd2) xj1Var.t.get());
                case 112:
                    return new pw(ApplicationContextModule_ProvideContextFactory.provideContext(xj1Var.a), (b83) xj1Var.h.get());
                default:
                    throw new AssertionError(i);
            }
        }
        int i3 = 0;
        switch (i) {
            case 0:
                return new nh4(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a), (nz) this.a.c.get(), (s42) this.a.d.get());
            case 1:
                return new nz();
            case 2:
                return new s42(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a));
            case 3:
                return new at1(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a));
            case 4:
                return new dj1((hv1) this.a.g.get(), (yw2) this.a.m.get(), (ra2) this.a.n.get(), (b73) this.a.o.get());
            case 5:
                return new hv1();
            case 6:
                return new yw2((zr5) this.a.l.get());
            case 7:
                return new zr5((tr5) this.a.k.get());
            case 8:
                e75 e75Var = (e75) this.a.j.get();
                e75Var.getClass();
                Object objB = e75Var.b(tr5.class);
                objB.getClass();
                return (tr5) objB;
            case 9:
                b83 b83Var = (b83) this.a.h.get();
                ip3 ip3Var = (ip3) this.a.i.get();
                b83Var.getClass();
                ip3Var.getClass();
                l54 l54Var = new l54();
                l54Var.a(5L);
                l54Var.c(5L);
                l54Var.d(5L);
                l54Var.c.add(ip3Var);
                m54 m54Var = new m54(l54Var);
                p34 p34Var = new p34(9);
                p34Var.f("https://" + hp3.a.get(0) + "/");
                p34Var.j = m54Var;
                j35 j35Var = qr3.e;
                p34Var.d(pr2.m(b83Var, sq2.x("application/json")));
                return p34Var.g();
            case 10:
                x83 x83Var = hj5.a;
                tl4.w(x83Var);
                return x83Var;
            case 11:
                return new ip3();
            case 12:
                return new ra2();
            case 13:
                return new b73();
            case 14:
                return new tw0((cx1) this.a.s.get(), (xv1) this.a.u.get(), (n21) this.a.M.get(), (vz2) this.a.J.get(), (v55) this.a.E.get(), (hg1) this.a.D.get(), (zf1) this.a.C.get());
            case 15:
                return new cx1((hx1) this.a.r.get());
            case 16:
                PicaComicDatabase picaComicDatabase2 = (PicaComicDatabase) this.a.q.get();
                picaComicDatabase2.getClass();
                hx1 hx1VarT = picaComicDatabase2.t();
                tl4.w(hx1VarT);
                return hx1VarT;
            case 17:
                return wk1.a(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a));
            case 18:
                return new xv1((rd2) this.a.t.get());
            case 19:
                return new rd2(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a));
            case 20:
                return new n21((qt0) this.a.v.get(), (qm0) this.a.w.get(), (dg4) this.a.I.get(), (vz2) this.a.J.get(), (dd1) this.a.A.get(), (xv1) this.a.u.get(), (x55) this.a.L.get());
            case 21:
                PicaComicDatabase picaComicDatabase3 = (PicaComicDatabase) this.a.q.get();
                picaComicDatabase3.getClass();
                qt0 qt0VarR = picaComicDatabase3.r();
                tl4.w(qt0VarR);
                return qt0VarR;
            case 22:
                PicaComicDatabase picaComicDatabase4 = (PicaComicDatabase) this.a.q.get();
                picaComicDatabase4.getClass();
                qm0 qm0VarQ = picaComicDatabase4.q();
                tl4.w(qm0VarQ);
                return qm0VarQ;
            case 23:
                eg4 eg4Var = (eg4) this.a.H.get();
                v55 v55Var = (v55) this.a.E.get();
                b83 b83Var2 = (b83) this.a.h.get();
                eg4Var.getClass();
                v55Var.getClass();
                b83Var2.getClass();
                return new dg4(eg4Var, v55Var, b83Var2);
            case 24:
                e75 e75Var2 = (e75) this.a.G.get();
                e75Var2.getClass();
                Object objB2 = e75Var2.b(eg4.class);
                objB2.getClass();
                return (eg4) objB2;
            case 25:
                j12 j12Var = (j12) this.a.F.get();
                b83 b83Var3 = (b83) this.a.h.get();
                j12Var.getClass();
                b83Var3.getClass();
                j35 j35Var2 = qr3.e;
                qr3 qr3VarX = sq2.x("application/json; charset=UTF-8");
                p34 p34Var2 = new p34(9);
                p34Var2.f("https://picaapi.picacomic.com/");
                p34Var2.j = j12Var;
                p34Var2.d(pr2.m(b83Var3, qr3VarX));
                return p34Var2.g();
            case 26:
                v55 v55Var2 = (v55) this.a.E.get();
                v55Var2.getClass();
                return new j12(v55Var2);
            case 27:
                p95 p95Var = (p95) this.a.x.get();
                p54 p54Var2 = (p54) this.a.B.get();
                hg1 hg1Var = (hg1) this.a.D.get();
                p95Var.getClass();
                p54Var2.getClass();
                hg1Var.getClass();
                return new v55(p95Var, p54Var2, hg1Var);
            case 28:
                Context contextProvideContext2 = ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a);
                contextProvideContext2.getClass();
                return new p95(contextProvideContext2);
            case 29:
                Context contextProvideContext3 = ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a);
                nh4 nh4Var = (nh4) this.a.e.get();
                at1 at1Var = (at1) this.a.f.get();
                dj1 dj1Var = (dj1) this.a.p.get();
                if2 if2Var = (if2) this.a.y.get();
                b73 b73Var = (b73) this.a.o.get();
                dd1 dd1Var = (dd1) this.a.A.get();
                contextProvideContext3.getClass();
                nh4Var.getClass();
                at1Var.getClass();
                dj1Var.getClass();
                if2Var.getClass();
                b73Var.getClass();
                dd1Var.getClass();
                return new p54(contextProvideContext3, nh4Var, at1Var, dj1Var, if2Var, b73Var, dd1Var);
            case 30:
                return new if2((ra2) this.a.n.get(), (b73) this.a.o.get());
            case 31:
                DataStore dataStore2 = (DataStore) this.a.z.get();
                pk1.a.getClass();
                dataStore2.getClass();
                return new dd1(dataStore2);
            case 32:
                Context contextProvideContext4 = ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a);
                pk1.a.getClass();
                contextProvideContext4.getClass();
                DataStore dataStore3 = (DataStore) pk1.c.getValue(contextProvideContext4, pk1.b[0]);
                tl4.w(dataStore3);
                return dataStore3;
            case 33:
                zf1 zf1Var = (zf1) this.a.C.get();
                zf1Var.getClass();
                return in0.j(bm0.A(bl4.p(), zf1Var).plus(new ig1(lg0.K, i3)));
            case 34:
                zp1 zp1Var = nu1.a;
                dp1 dp1Var = dp1.k;
                tl4.w(dp1Var);
                return dp1Var;
            case 35:
                v55 v55Var3 = (v55) this.a.E.get();
                v55Var3.getClass();
                return new vz2(v55Var3);
            case 36:
                return new x55((fq2) this.a.K.get(), (nz) this.a.c.get());
            case DescriptorProtos.FileOptions.CSHARP_NAMESPACE_FIELD_NUMBER /* 37 */:
                return new fq2();
            case FlacConstants.STREAM_INFO_BLOCK_SIZE /* 38 */:
                Context contextProvideContext5 = ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a);
                final v55 v55Var4 = (v55) this.a.E.get();
                ht4 ht4Var2 = (ht4) this.a.O.get();
                contextProvideContext5.getClass();
                v55Var4.getClass();
                ht4Var2.getClass();
                ne1 ne1Var = null;
                try {
                    zp1 zp1Var2 = nu1.a;
                    y65Var = Integer.valueOf(((Number) k64.P(dp1.k, new fk(ht4Var2, ne1Var, 18))).intValue());
                    break;
                } catch (Throwable th) {
                    y65Var = new y65(th);
                }
                if (y65Var instanceof y65) {
                    y65Var = 1024;
                }
                int iIntValue = ((Number) y65Var).intValue();
                ?? r0 = new si0() { // from class: ez2
                    /* JADX WARN: Code duplicated, block: B:52:0x00ff  */
                    /* JADX WARN: Code duplicated, block: B:53:0x0102  */
                    @Override // defpackage.si0
                    public final bz4 a(zx zxVar) {
                        String str;
                        List list;
                        String strD0;
                        zxVar.getClass();
                        v55 v55Var5 = v55Var4;
                        RequestMode requestModeB = v55Var5.b();
                        lx2 lx2Var = (lx2) zxVar.b;
                        String str2 = lx2Var.d;
                        List list2 = vz2.b;
                        boolean z = false;
                        if (list2 == null || !list2.isEmpty()) {
                            Iterator it = list2.iterator();
                            while (it.hasNext()) {
                                if (kx5.i0(lx2Var.i, (String) it.next(), true)) {
                                    z = true;
                                    break;
                                }
                            }
                        }
                        if (z || ((list = vz2.c) != null && list.isEmpty())) {
                            if (z) {
                                str = "AdURL白名单";
                            } else {
                                str = "域名无需替换";
                            }
                            SimpleDateFormat simpleDateFormat = sy2.a;
                            String displayName = requestModeB.getDisplayName();
                            String str3 = lx2Var.d;
                            StringBuilder sbQ = zv3.q("callFactory 放行 [", str, "] [模式:", displayName, "] ");
                            sbQ.append(str3);
                            sy2.f(sbQ.toString(), 'D');
                        } else {
                            Iterator it2 = list.iterator();
                            while (true) {
                                if (it2.hasNext()) {
                                    String str4 = (String) it2.next();
                                    if (!rx5.Z(str2, str4, true)) {
                                        if (rx5.Y(str2, "." + str4, true)) {
                                        }
                                    }
                                    String domain = requestModeB.getDomain();
                                    if (rx5.Z(str2, "picacomic.com", true) || rx5.Y(str2, ".picacomic.com", true)) {
                                        strD0 = rx5.d0(str2, "picacomic.com", domain, true);
                                    } else if (str2.equalsIgnoreCase("manhuabika.com") || rx5.Y(str2, ".manhuabika.com", true)) {
                                        strD0 = rx5.d0(str2, "manhuabika.com", domain, true);
                                    } else {
                                        strD0 = (str2.equalsIgnoreCase("diwodiwo.xyz") || rx5.Y(str2, ".diwodiwo.xyz", true)) ? c31.i("storage1.", domain) : str2;
                                    }
                                    oa1 oa1VarG = lx2Var.g();
                                    oa1VarG.h(strD0);
                                    lx2 lx2VarB = oa1VarG.b();
                                    String displayName2 = requestModeB.getDisplayName();
                                    String str5 = str2.equals(strD0) ? " (no-op，domain 相同)" : "";
                                    StringBuilder sbQ2 = zv3.q("callFactory 域名替换: ", str2, " → ", strD0, " [模式:");
                                    sbQ2.append(displayName2);
                                    sbQ2.append("]");
                                    sbQ2.append(str5);
                                    String string = sbQ2.toString();
                                    SimpleDateFormat simpleDateFormat2 = sy2.a;
                                    sy2.f(string, 'D');
                                    k30 k30VarK = zxVar.k();
                                    k30VarK.a = lx2VarB;
                                    zxVar = new zx(k30VarK);
                                } else {
                                    if (z) {
                                        str = "AdURL白名单";
                                    } else {
                                        str = "域名无需替换";
                                    }
                                    SimpleDateFormat simpleDateFormat3 = sy2.a;
                                    String displayName3 = requestModeB.getDisplayName();
                                    String str6 = lx2Var.d;
                                    StringBuilder sbQ3 = zv3.q("callFactory 放行 [", str, "] [模式:", displayName3, "] ");
                                    sbQ3.append(str6);
                                    sy2.f(sbQ3.toString(), 'D');
                                }
                            }
                        }
                        return new bz4(v55Var5.b.b((RequestMode) v55Var5.d.getValue()), zxVar);
                    }
                };
                mw0 mw0Var = new mw0(contextProvideContext5);
                mw0Var.b = new x23(r0);
                mw0Var.c = zy2.c;
                ArrayList arrayList = new ArrayList();
                ArrayList arrayList2 = new ArrayList();
                ArrayList arrayList3 = new ArrayList();
                ArrayList arrayList4 = new ArrayList();
                ArrayList arrayList5 = new ArrayList();
                if (Build.VERSION.SDK_INT >= 28) {
                    arrayList5.add(new ky2());
                } else {
                    arrayList5.add(new sp2());
                }
                mw0Var.d = new t61(u04.Q(arrayList), u04.Q(arrayList2), u04.Q(arrayList3), u04.Q(arrayList4), u04.Q(arrayList5));
                int i4 = 4;
                mw0Var.h = new r06(new mw(contextProvideContext5, i4));
                mw0Var.i = new r06(new ok(contextProvideContext5, iIntValue, i4));
                mw0Var.e = fz2.a((fz2) mw0Var.e, 27);
                yp1 yp1VarA = yp1.a((yp1) mw0Var.g, new nh1(100), 32751);
                mw0Var.g = yp1VarA;
                yp1 yp1VarA2 = yp1.a(yp1VarA, null, 24575);
                mw0Var.g = yp1VarA2;
                mw0Var.g = yp1.a(yp1VarA2, null, 28671);
                return mw0Var.f();
            case 39:
                return new ht4((DataStore) this.a.z.get());
            case 40:
                return new nv(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a), (b83) this.a.h.get());
            case DescriptorProtos.FileOptions.PHP_NAMESPACE_FIELD_NUMBER /* 41 */:
                return new g7((n7) this.a.R.get(), (hg1) this.a.D.get());
            case AacUtil.AUDIO_OBJECT_TYPE_AAC_XHE /* 42 */:
                return new n7(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a), (nv) this.a.Q.get(), (hz4) this.a.P.get(), (b83) this.a.h.get(), (hg1) this.a.D.get(), (zf1) this.a.C.get(), (dj1) this.a.p.get());
            case 43:
                return new fw((DataStore) this.a.z.get());
            case DescriptorProtos.FileOptions.PHP_METADATA_NAMESPACE_FIELD_NUMBER /* 44 */:
                return new e14(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a), (v55) this.a.E.get(), (zr5) this.a.l.get(), (hv1) this.a.g.get(), (b73) this.a.o.get(), (f22) this.a.Y.get());
            case 45:
                return new f22((zr5) this.a.l.get(), (r22) this.a.U.get(), (b73) this.a.o.get(), (c73) this.a.V.get(), (iv1) this.a.W.get(), (ra2) this.a.n.get(), (p22) this.a.X.get(), (hg1) this.a.D.get());
            case 46:
                return new r22();
            case 47:
                return new c73((at1) this.a.f.get());
            case NalUnitUtil.H265_NAL_UNIT_TYPE_UNSPECIFIED /* 48 */:
                return new iv1((hv1) this.a.g.get(), (ra2) this.a.n.get(), (b73) this.a.o.get(), (p54) this.a.B.get());
            case 49:
                return new p22(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a));
            case 50:
                return new ss5();
            case 51:
                DataStore dataStore4 = (DataStore) this.a.z.get();
                pk1.a.getClass();
                dataStore4.getClass();
                return new z76(dataStore4);
            case 52:
                return new d9((o8) this.a.e0.get());
            case 53:
                e75 e75Var3 = (e75) this.a.d0.get();
                e75Var3.getClass();
                Object objB3 = e75Var3.b(o8.class);
                objB3.getClass();
                return (o8) objB3;
            case 54:
                m54 m54Var2 = (m54) this.a.c0.get();
                m54Var2.getClass();
                j35 j35Var3 = qr3.e;
                qr3 qr3VarX2 = sq2.x("application/json; charset=UTF-8");
                x83 x83VarD = fs2.d(new o4(3));
                p34 p34Var3 = new p34(9);
                p34Var3.f("https://www.aibika.site/");
                p34Var3.j = m54Var2;
                p34Var3.d(pr2.m(x83VarD, qr3VarX2));
                return p34Var3.g();
            case 55:
                l54 l54Var2 = new l54();
                l54Var2.a(10L);
                l54Var2.c(10L);
                l54Var2.d(10L);
                return new m54(l54Var2);
            case 56:
                jp3 jp3Var = (jp3) this.a.i0.get();
                uq uqVar = (uq) this.a.j0.get();
                jp3Var.getClass();
                uqVar.getClass();
                return new qr(jp3Var, uqVar);
            case 57:
                e75 e75Var4 = (e75) this.a.h0.get();
                e75Var4.getClass();
                Object objB4 = e75Var4.b(jp3.class);
                objB4.getClass();
                return (jp3) objB4;
            case 58:
                m54 m54Var3 = (m54) this.a.g0.get();
                b83 b83Var4 = (b83) this.a.h.get();
                m54Var3.getClass();
                b83Var4.getClass();
                j35 j35Var4 = qr3.e;
                qr3 qr3VarX3 = sq2.x("application/json");
                p34 p34Var4 = new p34(9);
                p34Var4.f("https://" + hp3.a.get(0) + "/maccms/json/baofeng/");
                p34Var4.j = m54Var3;
                p34Var4.d(pr2.m(b83Var4, qr3VarX3));
                return p34Var4.g();
            case 59:
                ip3 ip3Var2 = (ip3) this.a.i.get();
                ip3Var2.getClass();
                cx2 cx2Var = new cx2();
                cx2Var.b = bx2.i;
                l54 l54Var3 = new l54();
                l54Var3.a(30L);
                l54Var3.c(30L);
                l54Var3.d(30L);
                l54Var3.c.add(ip3Var2);
                l54Var3.c.add(cx2Var);
                return new m54(l54Var3);
            case 60:
                return new uq();
            case 61:
                return new mm((nm) this.a.m0.get(), (xl) this.a.n0.get(), (m54) this.a.g0.get(), (hg1) this.a.D.get(), (zf1) this.a.C.get());
            case 62:
                return new nm((tl) this.a.l0.get());
            case 63:
                PicaComicDatabase picaComicDatabase5 = (PicaComicDatabase) this.a.q.get();
                picaComicDatabase5.getClass();
                tl tlVarL = picaComicDatabase5.l();
                tl4.w(tlVarL);
                return tlVarL;
            case 64:
                return new xl((rd2) this.a.t.get());
            case 65:
                po poVar = (po) this.a.u0.get();
                poVar.getClass();
                return poVar;
            case 66:
                return new po((ho) this.a.p0.get(), (iq) this.a.t0.get(), (qr) this.a.k0.get());
            case MdtaMetadataEntry.TYPE_INDICATOR_INT32 /* 67 */:
                PicaComicDatabase picaComicDatabase6 = (PicaComicDatabase) this.a.q.get();
                picaComicDatabase6.getClass();
                ho hoVarM = picaComicDatabase6.m();
                tl4.w(hoVarM);
                return hoVarM;
            case 68:
                return new iq((so) this.a.q0.get(), (yq) this.a.r0.get(), (ho) this.a.p0.get(), (zs) this.a.s0.get());
            case 69:
                return new so(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a));
            case 70:
                return new yq(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a));
            case TsExtractor.TS_SYNC_BYTE /* 71 */:
                PicaComicDatabase picaComicDatabase7 = (PicaComicDatabase) this.a.q.get();
                picaComicDatabase7.getClass();
                zs zsVarN = picaComicDatabase7.n();
                tl4.w(zsVarN);
                return zsVarN;
            case 72:
                mt mtVar = (mt) this.a.w0.get();
                mtVar.getClass();
                return mtVar;
            case 73:
                return new mt((zs) this.a.s0.get(), (iq) this.a.t0.get(), (qr) this.a.k0.get());
            case 74:
                return new gu2((dg4) this.a.I.get(), (x55) this.a.L.get());
            case MdtaMetadataEntry.TYPE_INDICATOR_8_BIT_UNSIGNED_INT /* 75 */:
                return new e90((DataStore) this.a.z.get(), (b83) this.a.h.get());
            case 76:
                return new o90((DataStore) this.a.z.get(), (b83) this.a.h.get());
            case 77:
                return new nn5((DataStore) this.a.z.get());
            case MdtaMetadataEntry.TYPE_INDICATOR_UNSIGNED_INT64 /* 78 */:
                return new zb0((mb0) this.a.C0.get(), (pb0) this.a.D0.get(), (dg4) this.a.I.get());
            case 79:
                PicaComicDatabase picaComicDatabase8 = (PicaComicDatabase) this.a.q.get();
                picaComicDatabase8.getClass();
                mb0 mb0VarO = picaComicDatabase8.o();
                tl4.w(mb0VarO);
                return mb0VarO;
            case 80:
                PicaComicDatabase picaComicDatabase9 = (PicaComicDatabase) this.a.q.get();
                picaComicDatabase9.getClass();
                pb0 pb0VarP = picaComicDatabase9.p();
                tl4.w(pb0VarP);
                return pb0VarP;
            case 81:
                return new un5((zb0) this.a.E0.get(), (nn5) this.a.B0.get(), (nh4) this.a.e.get(), (hg1) this.a.D.get());
            case 82:
                return new xk0((dg4) this.a.I.get(), (vz2) this.a.J.get(), (nv) this.a.Q.get(), (x55) this.a.L.get());
            case 83:
                return new pb2((kb2) this.a.H0.get(), (dg4) this.a.I.get(), (x55) this.a.L.get());
            case 84:
                PicaComicDatabase picaComicDatabase10 = (PicaComicDatabase) this.a.q.get();
                picaComicDatabase10.getClass();
                kb2 kb2VarU = picaComicDatabase10.u();
                tl4.w(kb2VarU);
                return kb2VarU;
            case 85:
                return new iy4((vx4) this.a.J0.get());
            case 86:
                PicaComicDatabase picaComicDatabase11 = (PicaComicDatabase) this.a.q.get();
                picaComicDatabase11.getClass();
                vx4 vx4VarV = picaComicDatabase11.v();
                tl4.w(vx4VarV);
                return vx4VarV;
            case 87:
                return new ps4((DataStore) this.a.z.get());
            case 88:
                return new dx4((DataStore) this.a.z.get());
            case TsExtractor.TS_STREAM_TYPE_DVBSUBS /* 89 */:
                g15 g15Var = (g15) this.a.Q0.get();
                g15Var.getClass();
                return g15Var;
            case 90:
                return new g15((x05) this.a.O0.get(), (DataStore) this.a.z.get(), (z05) this.a.P0.get());
            case 91:
                e75 e75Var5 = (e75) this.a.N0.get();
                e75Var5.getClass();
                Object objB5 = e75Var5.b(x05.class);
                objB5.getClass();
                return (x05) objB5;
            case 92:
                b83 b83Var5 = (b83) this.a.h.get();
                ip3 ip3Var3 = (ip3) this.a.i.get();
                b83Var5.getClass();
                ip3Var3.getClass();
                l54 l54Var4 = new l54();
                l54Var4.a(15L);
                l54Var4.c(15L);
                l54Var4.d(15L);
                l54Var4.c.add(ip3Var3);
                m54 m54Var4 = new m54(l54Var4);
                p34 p34Var5 = new p34(9);
                p34Var5.f("https://" + hp3.a.get(0) + "/");
                p34Var5.j = m54Var4;
                j35 j35Var5 = qr3.e;
                p34Var5.d(pr2.m(b83Var5, sq2.x("application/json")));
                return p34Var5.g();
            case 93:
                return new z05(new rn4(15));
            case 94:
                return new at0();
            case 95:
                return new w11(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a));
            case 96:
                return new dx0(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a));
            case 97:
                return new yl5(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a));
            case 98:
                return new hi6(ApplicationContextModule_ProvideContextFactory.provideContext(this.a.a), (dg4) this.a.I.get(), (nh4) this.a.e.get(), (x55) this.a.L.get());
            case 99:
                return new da6();
            default:
                throw new AssertionError(i);
        }
    }