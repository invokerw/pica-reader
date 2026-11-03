    /* JADX WARN: Code duplicated, block: B:247:0x0568  */
    /* JADX WARN: Code duplicated, block: B:250:0x0570  */
    /* JADX WARN: Code duplicated, block: B:253:0x057e  */
    /* JADX WARN: Code duplicated, block: B:254:0x0584  */
    /* JADX WARN: Code duplicated, block: B:260:0x0595  */
    /* JADX WARN: Code duplicated, block: B:263:0x059b  */
    /* JADX WARN: Code duplicated, block: B:265:0x05a1  */
    /* JADX WARN: Code duplicated, block: B:267:0x05a9  */
    /* JADX WARN: Code duplicated, block: B:275:0x05d8 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:276:0x05da  */
    /* JADX WARN: Code duplicated, block: B:277:0x05df A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:278:0x05e1  */
    /* JADX WARN: Code duplicated, block: B:280:0x05e6 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:281:0x05e8  */
    /* JADX WARN: Code duplicated, block: B:283:0x060f  */
    /* JADX WARN: Code duplicated, block: B:355:0x07dd  */
    /* JADX WARN: Code duplicated, block: B:356:0x07e2  */
    /* JADX WARN: Code duplicated, block: B:359:0x07ff  */
    /* JADX WARN: Code duplicated, block: B:366:0x082b  */
    /* JADX WARN: Code duplicated, block: B:385:0x0885  */
    /* JADX WARN: Code duplicated, block: B:386:0x08ba  */
    /* JADX WARN: Code duplicated, block: B:446:0x08c4 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Multi-variable type inference failed */
    @Override // defpackage.o53
    public final s65 a(he3 he3Var) throws Throwable {
        boolean z;
        u65 u65Var;
        s65 s65Var;
        int iO;
        long j;
        long time;
        Date dateA;
        Date dateA2;
        Date dateA3;
        String str;
        String str2;
        String str3;
        s65 s65Var2;
        n33 n33Var;
        long j2;
        long time2;
        String string;
        int i;
        int i2;
        long millis;
        long millis2;
        String str4;
        String str5;
        long j3;
        q65 q65VarL;
        int i3;
        s65 s65VarF;
        s65 s65VarA;
        lh0 lh0Var;
        s65 s65VarA2;
        xt1 xt1VarL;
        xt1 xt1VarL2;
        s65 s65Var3;
        String strR;
        cz4 cz4VarC;
        Object y65Var;
        dg6 dg6Var;
        Socket socket;
        List list;
        boolean z2;
        boolean z3;
        SSLSocketFactory sSLSocketFactory;
        h54 h54Var;
        sl0 sl0Var;
        switch (this.a) {
            case 0:
                bt2 bt2Var = (bt2) this.b;
                zx zxVar = (zx) he3Var.i;
                k30 k30VarK = zxVar.k();
                lx2 lx2Var = (lx2) zxVar.b;
                at2 at2Var = (at2) zxVar.c;
                o55 o55Var = (o55) zxVar.d;
                if (o55Var != null) {
                    qr3 qr3VarB = o55Var.b();
                    if (qr3VarB != null) {
                        k30VarK.q("Content-Type", qr3VarB.a);
                    }
                    long jA = o55Var.a();
                    if (jA != -1) {
                        k30VarK.q("Content-Length", String.valueOf(jA));
                        ((ys2) k30VarK.c).q("Transfer-Encoding");
                    } else {
                        k30VarK.q("Transfer-Encoding", "chunked");
                        ((ys2) k30VarK.c).q("Content-Length");
                    }
                }
                if (at2Var.a("Host") == null) {
                    k30VarK.q("Host", bs6.i(lx2Var, false));
                }
                if (at2Var.a("Connection") == null) {
                    k30VarK.q("Connection", "Keep-Alive");
                }
                if (at2Var.a("Accept-Encoding") == null && at2Var.a("Range") == null) {
                    k30VarK.q("Accept-Encoding", "gzip");
                    z = true;
                } else {
                    z = false;
                }
                bt2Var.getClass();
                lx2Var.getClass();
                if (at2Var.a("User-Agent") == null) {
                    k30VarK.q("User-Agent", "okhttp/5.3.2");
                }
                zx zxVar2 = new zx(k30VarK);
                s65 s65VarF2 = he3Var.f(zxVar2);
                at2 at2Var2 = s65VarF2.n;
                ax2.b(bt2Var, (lx2) zxVar2.b, at2Var2);
                q65 q65VarL2 = s65VarF2.l();
                q65VarL2.a = zxVar2;
                if (z && "gzip".equalsIgnoreCase(s65.h(s65VarF2, "Content-Encoding")) && ax2.a(s65VarF2) && (u65Var = s65VarF2.o) != null) {
                    sr2 sr2Var = new sr2(u65Var.n());
                    ys2 ys2VarC = at2Var2.c();
                    ys2VarC.q("Content-Encoding");
                    ys2VarC.q("Content-Length");
                    q65VarL2.f = ys2VarC.d().c();
                    q65VarL2.g = new mz4(s65.h(s65VarF2, "Content-Type"), -1L, new xy4(sr2Var));
                }
                return q65VarL2.a();
            case 1:
                mh0 mh0Var = (mh0) this.b;
                if (mh0Var != null) {
                    zx zxVar3 = (zx) he3Var.i;
                    zxVar3.getClass();
                    lx2 lx2Var2 = (lx2) zxVar3.b;
                    try {
                        bu1 bu1VarN = mh0Var.i.n(jb5.x(lx2Var2));
                        if (bu1VarN == null) {
                            s65Var3 = null;
                        } else {
                            try {
                                jh0 jh0Var = new jh0((ou5) bu1VarN.k.get(0));
                                String str6 = jh0Var.c;
                                at2 at2Var3 = jh0Var.b;
                                lx2 lx2Var3 = jh0Var.a;
                                at2 at2Var4 = jh0Var.g;
                                String strA = at2Var4.a("Content-Type");
                                String strA2 = at2Var4.a("Content-Length");
                                lx2Var3.getClass();
                                at2Var3.getClass();
                                str6.getClass();
                                k30 k30Var = new k30(7);
                                k30Var.a = lx2Var3;
                                k30Var.c = at2Var3.c();
                                k30Var.s(!str6.equals("\u0000") ? str6 : "GET", null);
                                zx zxVar4 = new zx(k30Var);
                                t65 t65Var = u65.i;
                                ga6 ga6Var = ha6.g;
                                new ArrayList(20);
                                kp4 kp4Var = jh0Var.d;
                                kp4Var.getClass();
                                int i4 = jh0Var.e;
                                String str7 = jh0Var.f;
                                str7.getClass();
                                ys2 ys2VarC2 = at2Var4.c();
                                ih0 ih0Var = new ih0(bu1VarN, strA, strA2);
                                ds2 ds2Var = jh0Var.h;
                                long j4 = jh0Var.i;
                                long j5 = jh0Var.j;
                                if (i4 < 0) {
                                    nr3.i(c31.f(i4, "code < 0: "));
                                    return null;
                                }
                                at2 at2VarD = ys2VarC2.d();
                                s65Var3 = new s65(zxVar4, kp4Var, str7, i4, ds2Var, at2VarD, ih0Var, null, null, null, null, j4, j5, null, ga6Var);
                                if (lx2Var3.equals(lx2Var2) && str6.equals((String) zxVar3.g)) {
                                    Set setC = jb5.C(at2VarD);
                                    if (!(setC instanceof Collection) || !setC.isEmpty()) {
                                        Iterator it = setC.iterator();
                                        while (true) {
                                            if (it.hasNext()) {
                                                String str8 = (String) it.next();
                                                if (!at2Var3.e(str8).equals(((at2) zxVar3.c).e(str8))) {
                                                }
                                            }
                                        }
                                    }
                                }
                                zr6.b(s65Var3.o);
                                s65Var3 = null;
                            } catch (IOException unused) {
                                zr6.b(bu1VarN);
                            }
                        }
                    } catch (IOException unused2) {
                    }
                    s65Var = s65Var3;
                } else {
                    s65Var = null;
                }
                long jCurrentTimeMillis = System.currentTimeMillis();
                zx zxVar5 = (zx) he3Var.i;
                zxVar5.getClass();
                if (s65Var != null) {
                    j = s65Var.t;
                    time = s65Var.u;
                    at2 at2Var5 = s65Var.n;
                    int size = at2Var5.size();
                    int i5 = 0;
                    iO = -1;
                    dateA = null;
                    dateA2 = null;
                    dateA3 = null;
                    str = null;
                    str2 = null;
                    str3 = null;
                    while (i5 < size) {
                        String strB = at2Var5.b(i5);
                        long j6 = jCurrentTimeMillis;
                        String strD = at2Var5.d(i5);
                        if (strB.equalsIgnoreCase("Date")) {
                            str3 = strD;
                            dateA3 = yk1.a(strD);
                        } else if (strB.equalsIgnoreCase("Expires")) {
                            dateA = yk1.a(strD);
                        } else if (strB.equalsIgnoreCase("Last-Modified")) {
                            str2 = strD;
                            dateA2 = yk1.a(strD);
                        } else if (strB.equalsIgnoreCase("ETag")) {
                            str = strD;
                        } else if (strB.equalsIgnoreCase("Age")) {
                            iO = zr6.o(-1, strD);
                        }
                        i5++;
                        jCurrentTimeMillis = j6;
                    }
                } else {
                    iO = -1;
                    j = 0;
                    time = 0;
                    dateA = null;
                    dateA2 = null;
                    dateA3 = null;
                    str = null;
                    str2 = null;
                    str3 = null;
                }
                long j7 = jCurrentTimeMillis;
                TimeUnit timeUnit = TimeUnit.SECONDS;
                if (s65Var == null) {
                    s65Var2 = null;
                    n33Var = new n33(zxVar5, s65Var2);
                } else {
                    s65Var2 = null;
                    lx2 lx2Var4 = (lx2) zxVar5.b;
                    at2 at2Var6 = (at2) zxVar5.c;
                    if (!(lx2Var4.f() && s65Var.m == null) && a54.C(s65Var, zxVar5)) {
                        nh0 nh0VarI = zxVar5.i();
                        if (!nh0VarI.a && at2Var6.a("If-Modified-Since") == null && at2Var6.a("If-None-Match") == null) {
                            nh0 nh0VarG = s65Var.g();
                            long jMax = dateA3 != null ? Math.max(0L, time - dateA3.getTime()) : 0L;
                            if (iO != -1) {
                                jMax = Math.max(jMax, timeUnit.toMillis(iO));
                            }
                            long jMax2 = jMax + Math.max(0L, time - j) + Math.max(0L, j7 - time);
                            int i6 = s65Var.g().c;
                            if (i6 != -1) {
                                time2 = timeUnit.toMillis(i6);
                            } else {
                                if (dateA != null) {
                                    if (dateA3 != null) {
                                        time = dateA3.getTime();
                                    }
                                    time2 = dateA.getTime() - time;
                                    if (time2 <= 0) {
                                        time2 = 0;
                                    }
                                } else if (dateA2 == null) {
                                    j2 = 0;
                                    time2 = j2;
                                } else {
                                    List list2 = ((lx2) s65Var.i.b).g;
                                    if (list2 == null) {
                                        string = null;
                                    } else {
                                        StringBuilder sb = new StringBuilder();
                                        kx2.k(list2, sb);
                                        string = sb.toString();
                                    }
                                    if (string == null) {
                                        long time3 = (dateA3 != null ? dateA3.getTime() : j) - dateA2.getTime();
                                        j2 = 0;
                                        if (time3 > 0) {
                                            time2 = time3 / 10;
                                        }
                                    } else {
                                        j2 = 0;
                                    }
                                    time2 = j2;
                                }
                                i = nh0VarI.c;
                                if (i != -1) {
                                    time2 = Math.min(time2, timeUnit.toMillis(i));
                                }
                                i2 = nh0VarI.i;
                                if (i2 != -1) {
                                    millis = timeUnit.toMillis(i2);
                                } else {
                                    millis = j2;
                                }
                                if (!nh0VarG.g || (i3 = nh0VarI.h) == -1) {
                                    millis2 = j2;
                                } else {
                                    millis2 = timeUnit.toMillis(i3);
                                }
                                if (nh0VarG.a) {
                                    if (str != null) {
                                        str4 = str;
                                        str5 = "If-None-Match";
                                    } else {
                                        if (dateA2 != null) {
                                            str4 = str2;
                                        } else if (dateA3 != null) {
                                            str4 = str3;
                                        } else {
                                            s65Var2 = null;
                                            n33Var = new n33(zxVar5, s65Var2);
                                        }
                                        str5 = "If-Modified-Since";
                                    }
                                    ys2 ys2VarC3 = at2Var6.c();
                                    str4.getClass();
                                    yd6.a(ys2VarC3, str5, str4);
                                    k30 k30VarK2 = zxVar5.k();
                                    k30VarK2.c = ys2VarC3.d().c();
                                    n33Var = new n33(new zx(k30VarK2), s65Var);
                                    s65Var2 = null;
                                } else {
                                    j3 = millis + jMax2;
                                    if (j3 < millis2 + time2) {
                                        q65VarL = s65Var.l();
                                        if (j3 >= time2) {
                                            q65VarL.f.a("Warning", "110 HttpURLConnection \"Response is stale\"");
                                        }
                                        if (jMax2 > 86400000 && s65Var.g().c == -1 && dateA == null) {
                                            q65VarL.f.a("Warning", "113 HttpURLConnection \"Heuristic expiration\"");
                                        }
                                        s65Var2 = null;
                                        n33Var = new n33(s65Var2, q65VarL.a());
                                    } else {
                                        if (str != null) {
                                            str4 = str;
                                            str5 = "If-None-Match";
                                        } else {
                                            if (dateA2 != null) {
                                                str4 = str2;
                                            } else if (dateA3 != null) {
                                                str4 = str3;
                                            } else {
                                                s65Var2 = null;
                                                n33Var = new n33(zxVar5, s65Var2);
                                            }
                                            str5 = "If-Modified-Since";
                                        }
                                        ys2 ys2VarC4 = at2Var6.c();
                                        str4.getClass();
                                        yd6.a(ys2VarC4, str5, str4);
                                        k30 k30VarK3 = zxVar5.k();
                                        k30VarK3.c = ys2VarC4.d().c();
                                        n33Var = new n33(new zx(k30VarK3), s65Var);
                                        s65Var2 = null;
                                    }
                                }
                            }
                            j2 = 0;
                            i = nh0VarI.c;
                            if (i != -1) {
                                time2 = Math.min(time2, timeUnit.toMillis(i));
                            }
                            i2 = nh0VarI.i;
                            if (i2 != -1) {
                                millis = timeUnit.toMillis(i2);
                            } else {
                                millis = j2;
                            }
                            if (nh0VarG.g) {
                                millis2 = j2;
                            } else {
                                millis2 = j2;
                            }
                            if (nh0VarG.a) {
                                j3 = millis + jMax2;
                                if (j3 < millis2 + time2) {
                                    q65VarL = s65Var.l();
                                    if (j3 >= time2) {
                                        q65VarL.f.a("Warning", "110 HttpURLConnection \"Response is stale\"");
                                    }
                                    if (jMax2 > 86400000) {
                                        q65VarL.f.a("Warning", "113 HttpURLConnection \"Heuristic expiration\"");
                                    }
                                    s65Var2 = null;
                                    n33Var = new n33(s65Var2, q65VarL.a());
                                } else {
                                    if (str != null) {
                                        str4 = str;
                                        str5 = "If-None-Match";
                                    } else {
                                        if (dateA2 != null) {
                                            str4 = str2;
                                        } else if (dateA3 != null) {
                                            str4 = str3;
                                        } else {
                                            s65Var2 = null;
                                            n33Var = new n33(zxVar5, s65Var2);
                                        }
                                        str5 = "If-Modified-Since";
                                    }
                                    ys2 ys2VarC5 = at2Var6.c();
                                    str4.getClass();
                                    yd6.a(ys2VarC5, str5, str4);
                                    k30 k30VarK4 = zxVar5.k();
                                    k30VarK4.c = ys2VarC5.d().c();
                                    n33Var = new n33(new zx(k30VarK4), s65Var);
                                    s65Var2 = null;
                                }
                            } else {
                                if (str != null) {
                                    str4 = str;
                                    str5 = "If-None-Match";
                                } else {
                                    if (dateA2 != null) {
                                        str4 = str2;
                                    } else if (dateA3 != null) {
                                        str4 = str3;
                                    } else {
                                        s65Var2 = null;
                                        n33Var = new n33(zxVar5, s65Var2);
                                    }
                                    str5 = "If-Modified-Since";
                                }
                                ys2 ys2VarC6 = at2Var6.c();
                                str4.getClass();
                                yd6.a(ys2VarC6, str5, str4);
                                k30 k30VarK5 = zxVar5.k();
                                k30VarK5.c = ys2VarC6.d().c();
                                n33Var = new n33(new zx(k30VarK5), s65Var);
                                s65Var2 = null;
                            }
                        } else {
                            s65Var2 = null;
                            n33Var = new n33(zxVar5, s65Var2);
                        }
                    } else {
                        n33Var = new n33(zxVar5, s65Var2);
                    }
                }
                if (((zx) n33Var.i) != null && zxVar5.i().j) {
                    n33Var = new n33(s65Var2, s65Var2);
                }
                zx zxVar6 = (zx) n33Var.i;
                s65 s65Var4 = (s65) n33Var.j;
                mh0 mh0Var2 = (mh0) this.b;
                if (mh0Var2 != null) {
                    synchronized (mh0Var2) {
                    }
                }
                if (s65Var != null && s65Var4 == null) {
                    zr6.b(s65Var.o);
                }
                if (zxVar6 == null && s65Var4 == null) {
                    t65 t65Var2 = u65.i;
                    ga6 ga6Var2 = ha6.g;
                    ArrayList arrayList = new ArrayList(20);
                    zx zxVar7 = (zx) he3Var.i;
                    zxVar7.getClass();
                    return new s65(zxVar7, kp4.HTTP_1_1, "Unsatisfiable Request (only-if-cached)", 504, null, new at2((String[]) arrayList.toArray(new String[0])), t65Var2, null, null, null, null, -1L, System.currentTimeMillis(), null, ga6Var2);
                }
                if (zxVar6 == null) {
                    s65Var4.getClass();
                    q65 q65VarL3 = s65Var4.l();
                    s65 s65VarF3 = mg6.f(s65Var4);
                    q65.b(s65VarF3, "cacheResponse");
                    q65VarL3.j = s65VarF3;
                    return q65VarL3.a();
                }
                try {
                    s65 s65VarF4 = he3Var.f(zxVar6);
                    if (s65Var4 == null) {
                        q65 q65VarL4 = s65VarF4.l();
                        if (s65Var4 != null) {
                            s65VarF = mg6.f(s65Var4);
                        } else {
                            s65VarF = s65Var2;
                        }
                        q65.b(s65VarF, "cacheResponse");
                        q65VarL4.j = s65VarF;
                        s65 s65VarF5 = mg6.f(s65VarF4);
                        q65.b(s65VarF5, "networkResponse");
                        q65VarL4.i = s65VarF5;
                        s65VarA = q65VarL4.a();
                        if (((mh0) this.b) != null) {
                            if (!ax2.a(s65VarA) && a54.C(s65VarA, zxVar6)) {
                                mh0 mh0Var3 = (mh0) this.b;
                                q65 q65VarL5 = s65VarA.l();
                                q65VarL5.a = zxVar6;
                                s65 s65VarA3 = q65VarL5.a();
                                mh0Var3.getClass();
                                zx zxVar8 = s65VarA3.i;
                                String str9 = (String) zxVar8.g;
                                try {
                                    if (hr2.D(str9)) {
                                        mh0Var3.g(zxVar8);
                                    } else {
                                        if (str9.equals("GET") && !jb5.C(s65VarA3.n).contains("*")) {
                                            jh0 jh0Var2 = new jh0(s65VarA3);
                                            try {
                                                gu1 gu1Var = mh0Var3.i;
                                                String strX = jb5.x((lx2) zxVar8.b);
                                                j35 j35Var = gu1.B;
                                                xt1VarL = gu1Var.l(strX, -1L);
                                                if (xt1VarL == 0) {
                                                    lh0Var = s65Var2;
                                                } else {
                                                    try {
                                                        jh0Var2.c(xt1VarL);
                                                        lh0 lh0Var2 = new lh0();
                                                        lh0Var2.e = mh0Var3;
                                                        lh0Var2.b = xt1VarL;
                                                        bq5 bq5VarF = xt1VarL.f(1);
                                                        lh0Var2.c = bq5VarF;
                                                        lh0Var2.d = new kh0(mh0Var3, lh0Var2, bq5VarF);
                                                        lh0Var = lh0Var2;
                                                    } catch (IOException unused3) {
                                                        if (xt1VarL != 0) {
                                                            xt1VarL.a();
                                                        }
                                                        lh0Var = s65Var2;
                                                    }
                                                }
                                            } catch (IOException unused4) {
                                                xt1VarL = s65Var2;
                                            }
                                        } else {
                                            lh0Var = s65Var2;
                                        }
                                        if (lh0Var != 0) {
                                            rh0 rh0Var = new rh0(s65VarA.o.n(), lh0Var, lq2.u((kh0) lh0Var.d));
                                            String strH = s65.h(s65VarA, "Content-Type");
                                            long jH = s65VarA.o.h();
                                            q65 q65VarL6 = s65VarA.l();
                                            q65VarL6.g = new mz4(strH, jH, new xy4(rh0Var));
                                            s65VarA2 = q65VarL6.a();
                                        }
                                    }
                                    break;
                                } catch (IOException unused5) {
                                }
                                lh0Var = s65Var2;
                                if (lh0Var != 0) {
                                    rh0 rh0Var2 = new rh0(s65VarA.o.n(), lh0Var, lq2.u((kh0) lh0Var.d));
                                    String strH2 = s65.h(s65VarA, "Content-Type");
                                    long jH2 = s65VarA.o.h();
                                    q65 q65VarL7 = s65VarA.l();
                                    q65VarL7.g = new mz4(strH2, jH2, new xy4(rh0Var2));
                                    s65VarA2 = q65VarL7.a();
                                }
                            } else if (hr2.D((String) zxVar6.g)) {
                                try {
                                    ((mh0) this.b).g(zxVar6);
                                    break;
                                } catch (IOException unused6) {
                                }
                            }
                        }
                        return s65VarA;
                    }
                    if (s65VarF4.l != 304) {
                        zr6.b(s65Var4.o);
                        q65 q65VarL8 = s65VarF4.l();
                        if (s65Var4 != null) {
                            s65VarF = mg6.f(s65Var4);
                        } else {
                            s65VarF = s65Var2;
                        }
                        q65.b(s65VarF, "cacheResponse");
                        q65VarL8.j = s65VarF;
                        s65 s65VarF6 = mg6.f(s65VarF4);
                        q65.b(s65VarF6, "networkResponse");
                        q65VarL8.i = s65VarF6;
                        s65VarA = q65VarL8.a();
                        if (((mh0) this.b) != null) {
                            if (!ax2.a(s65VarA)) {
                                if (hr2.D((String) zxVar6.g)) {
                                    ((mh0) this.b).g(zxVar6);
                                }
                            } else if (hr2.D((String) zxVar6.g)) {
                                ((mh0) this.b).g(zxVar6);
                            }
                            break;
                        }
                        return s65VarA;
                    }
                    q65 q65VarL9 = s65Var4.l();
                    at2 at2Var7 = s65Var4.n;
                    at2 at2Var8 = s65VarF4.n;
                    ArrayList arrayList2 = new ArrayList(20);
                    int size2 = at2Var7.size();
                    for (int i7 = 0; i7 < size2; i7++) {
                        String strB2 = at2Var7.b(i7);
                        String strD2 = at2Var7.d(i7);
                        if ((!"Warning".equalsIgnoreCase(strB2) || !rx5.f0(strD2, IcyHeaders.REQUEST_HEADER_ENABLE_METADATA_VALUE, false)) && ("Content-Length".equalsIgnoreCase(strB2) || "Content-Encoding".equalsIgnoreCase(strB2) || "Content-Type".equalsIgnoreCase(strB2) || !x34.E(strB2) || at2Var8.a(strB2) == null)) {
                            arrayList2.add(strB2);
                            arrayList2.add(kx5.N0(strD2).toString());
                        }
                    }
                    int size3 = at2Var8.size();
                    for (int i8 = 0; i8 < size3; i8++) {
                        String strB3 = at2Var8.b(i8);
                        if (!"Content-Length".equalsIgnoreCase(strB3) && !"Content-Encoding".equalsIgnoreCase(strB3) && !"Content-Type".equalsIgnoreCase(strB3) && x34.E(strB3)) {
                            String strD3 = at2Var8.d(i8);
                            arrayList2.add(strB3);
                            arrayList2.add(kx5.N0(strD3).toString());
                        }
                    }
                    q65VarL9.f = new at2((String[]) arrayList2.toArray(new String[0])).c();
                    q65VarL9.l = s65VarF4.t;
                    q65VarL9.m = s65VarF4.u;
                    s65 s65VarF7 = mg6.f(s65Var4);
                    q65.b(s65VarF7, "cacheResponse");
                    q65VarL9.j = s65VarF7;
                    s65 s65VarF8 = mg6.f(s65VarF4);
                    q65.b(s65VarF8, "networkResponse");
                    q65VarL9.i = s65VarF8;
                    s65VarA2 = q65VarL9.a();
                    s65VarF4.o.close();
                    mh0 mh0Var4 = (mh0) this.b;
                    mh0Var4.getClass();
                    synchronized (mh0Var4) {
                    }
                    ((mh0) this.b).getClass();
                    jh0 jh0Var3 = new jh0(s65VarA2);
                    u65 u65Var2 = s65Var4.o;
                    u65Var2.getClass();
                    bu1 bu1Var = ((ih0) u65Var2).j;
                    try {
                        xt1VarL2 = bu1Var.l.l(bu1Var.i, bu1Var.j);
                        if (xt1VarL2 != 0) {
                            try {
                                jh0Var3.c(xt1VarL2);
                                xt1VarL2.b();
                                break;
                            } catch (IOException unused7) {
                                if (xt1VarL2 != 0) {
                                    try {
                                        xt1VarL2.a();
                                        break;
                                    } catch (IOException unused8) {
                                    }
                                }
                            }
                        }
                    } catch (IOException unused9) {
                        xt1VarL2 = s65Var2;
                    }
                    return s65VarA2;
                } catch (Throwable th) {
                    if (s65Var != null) {
                        zr6.b(s65Var.o);
                    }
                    throw th;
                }
            case 2:
                lh0 lh0Var3 = (lh0) he3Var.h;
                zx zxVar9 = (zx) he3Var.i;
                s65 s65VarF9 = he3Var.f(zxVar9);
                if (s65VarF9.l != 403 || (strR = rl4.R(s65VarF9)) == null || !kx5.i0(strR, "error code: 1034", true)) {
                    return s65VarF9;
                }
                String str10 = ((lx2) zxVar9.b).d;
                cz4 cz4VarC2 = lh0Var3 != null ? lh0Var3.c() : null;
                u85 u85Var = cz4VarC2 != null ? cz4VarC2.c : null;
                if (u85Var == null || u85Var.b.type() != Proxy.Type.DIRECT) {
                    SimpleDateFormat simpleDateFormat = sy2.a;
                    sy2.f("IP ⚠ 命中 CF 1034 但当前经代理连接，无法确定边缘 IP，跳过拉黑：" + str10, 'W');
                    return s65VarF9;
                }
                InetAddress address = u85Var.c.getAddress();
                String hostAddress = address != null ? address.getHostAddress() : null;
                if (hostAddress == null || kx5.t0(hostAddress)) {
                    return s65VarF9;
                }
                Log.w("EdgeIpGuard", "CF 1034 @ " + str10 + " via " + hostAddress);
                b73 b73Var = (b73) this.b;
                StringBuilder sb2 = new StringBuilder("CF 1034 @ ");
                sb2.append(str10);
                b73Var.g(hostAddress, sb2.toString());
                s12 s12Var = (s12) zxVar9.m(s12.class);
                if (s12Var != null && s12Var.a > 0) {
                    String str11 = (String) zxVar9.g;
                    if (rx5.Z(str11, "GET", true) || rx5.Z(str11, "HEAD", true)) {
                        if (lh0Var3 != null) {
                            try {
                                cz4VarC = lh0Var3.c();
                            } catch (Throwable th2) {
                                y65Var = new y65(th2);
                            }
                        } else {
                            cz4VarC = null;
                        }
                        if (cz4VarC == null || (socket = cz4VarC.e) == null) {
                            dg6Var = null;
                        } else {
                            socket.close();
                            dg6Var = dg6.a;
                        }
                        y65Var = dg6Var;
                        Throwable thA = z65.a(y65Var);
                        if (thA != null) {
                            Log.w("EdgeIpGuard", "关闭坏连接失败（忽略）", thA);
                        }
                    }
                    break;
                }
                q65 q65VarL10 = s65VarF9.l();
                ys2 ys2Var = q65VarL10.f;
                ys2Var.getClass();
                yd6.d("X-Pica-Bad-Edge-Ip");
                yd6.e(hostAddress, "X-Pica-Bad-Edge-Ip");
                ys2Var.q("X-Pica-Bad-Edge-Ip");
                yd6.a(ys2Var, "X-Pica-Bad-Edge-Ip", hostAddress);
                return q65VarL10.a();
            default:
                zx zxVar10 = (zx) he3Var.i;
                bz4 bz4Var = (bz4) he3Var.g;
                List listI0 = b42.i;
                s65 s65Var5 = null;
                int i9 = 0;
                zx zxVar11 = zxVar10;
                boolean z4 = true;
                while (true) {
                    zxVar11.getClass();
                    if (bz4Var.s == null) {
                        synchronized (bz4Var) {
                            try {
                                try {
                                    if (bz4Var.u) {
                                        throw new IllegalStateException("cannot make a new request because the previous response is still open: please call response.close()");
                                    }
                                    if (bz4Var.t || bz4Var.w || bz4Var.v) {
                                        throw new IllegalStateException("Check failed.");
                                    }
                                } catch (Throwable th3) {
                                    th = th3;
                                }
                            } catch (Throwable th4) {
                                th = th4;
                                bz4Var = bz4Var;
                            }
                            throw th;
                        }
                        if (z4) {
                            List list3 = listI0;
                            m54 m54Var = bz4Var.i;
                            h36 h36Var = m54Var.D;
                            nz1 nz1Var = bz4Var.k;
                            int i10 = m54Var.y;
                            int i11 = m54Var.z;
                            int i12 = he3Var.c;
                            int i13 = he3Var.d;
                            boolean z5 = m54Var.e;
                            boolean z6 = m54Var.f;
                            lx2 lx2Var5 = (lx2) zxVar11.b;
                            lx2Var5.getClass();
                            if (lx2Var5.f()) {
                                SSLSocketFactory sSLSocketFactory2 = m54Var.p;
                                if (sSLSocketFactory2 != null) {
                                    h54 h54Var2 = m54Var.t;
                                    sl0Var = m54Var.u;
                                    sSLSocketFactory = sSLSocketFactory2;
                                    h54Var = h54Var2;
                                } else {
                                    mz.h("CLEARTEXT-only client");
                                }
                            } else {
                                sSLSocketFactory = null;
                                h54Var = null;
                                sl0Var = null;
                            }
                            bz4 bz4Var2 = bz4Var;
                            list = list3;
                            nz4 nz4Var = new nz4(h36Var, nz1Var, i10, i11, i12, i13, z5, z6, new g8(lx2Var5.d, lx2Var5.e, m54Var.l, m54Var.o, sSLSocketFactory, h54Var, sl0Var, m54Var.n, m54Var.s, m54Var.r, m54Var.m), bz4Var.i.C, bz4Var2, zxVar11);
                            bz4Var = bz4Var2;
                            m54 m54Var2 = bz4Var.i;
                            bz4Var.p = m54Var2.f ? new ua2(nz4Var, m54Var2.D) : new oh3(nz4Var);
                        } else {
                            bz4Var = bz4Var;
                            list = listI0;
                        }
                        try {
                            if (bz4Var.y) {
                                throw new IOException("Canceled");
                            }
                            try {
                                q65 q65VarL11 = he3Var.f(zxVar11).l();
                                q65VarL11.a = zxVar11;
                                q65VarL11.k = s65Var5 != null ? mg6.f(s65Var5) : null;
                                s65 s65VarA4 = q65VarL11.a();
                                zx zxVarB = b(s65VarA4, bz4Var.s);
                                try {
                                    if (zxVarB == null) {
                                        bz4Var.l.getClass();
                                        z3 = false;
                                    } else {
                                        o55 o55Var2 = (o55) zxVarB.d;
                                        if (o55Var2 == null || !o55Var2.c()) {
                                            zr6.b(s65VarA4.o);
                                            int i14 = i9 + 1;
                                            o72 o72Var = bz4Var.l;
                                            if (i14 > 20) {
                                                o72Var.getClass();
                                                throw new ProtocolException("Too many follow-up requests: " + i14);
                                            }
                                            o72Var.getClass();
                                            bz4Var.f(true);
                                            s65Var5 = s65VarA4;
                                            listI0 = list;
                                            i9 = i14;
                                            z4 = true;
                                            zxVar11 = zxVarB;
                                        } else {
                                            bz4Var.l.getClass();
                                            z3 = false;
                                        }
                                    }
                                    bz4Var.f(z3);
                                    return s65VarA4;
                                } catch (Throwable th5) {
                                    th = th5;
                                    z2 = false;
                                }
                            } catch (IOException e) {
                                boolean zC = c(e, bz4Var, zxVar11);
                                bz4Var.l.f(bz4Var, e, zC);
                                if (!zC) {
                                    byte[] bArr = zr6.a;
                                    Iterator it2 = list.iterator();
                                    while (it2.hasNext()) {
                                        rl0.h(e, (Exception) it2.next());
                                    }
                                    throw e;
                                }
                                listI0 = nr0.I0(list, e);
                                bz4Var.f(true);
                                zxVar11 = zxVar11;
                                z4 = false;
                            }
                        } catch (Throwable th6) {
                            th = th6;
                            z2 = true;
                        }
                        bz4Var.f(z2);
                        throw th;
                    }
                    mz.h("Check failed.");
                }
                return null;
        }
    }