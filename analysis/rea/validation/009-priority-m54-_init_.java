    public m54(l54 l54Var) throws NoSuchAlgorithmException, KeyStoreException {
        this.a = l54Var.a;
        this.b = bs6.j(l54Var.c);
        this.c = bs6.j(l54Var.d);
        this.d = l54Var.e;
        this.e = l54Var.f;
        this.f = l54Var.g;
        this.g = l54Var.h;
        this.h = l54Var.i;
        this.i = l54Var.j;
        this.j = l54Var.k;
        this.k = l54Var.l;
        this.l = l54Var.m;
        ProxySelector proxySelector = l54Var.n;
        if (proxySelector == null && (proxySelector = ProxySelector.getDefault()) == null) {
            proxySelector = v34.a;
        }
        this.m = proxySelector;
        this.n = l54Var.o;
        this.o = l54Var.p;
        List list = l54Var.s;
        this.r = list;
        this.s = l54Var.t;
        this.t = l54Var.u;
        this.w = l54Var.x;
        this.x = l54Var.y;
        this.y = l54Var.z;
        this.z = l54Var.A;
        this.A = l54Var.B;
        this.B = l54Var.C;
        oh3 oh3Var = l54Var.D;
        this.C = oh3Var == null ? new oh3(16, false) : oh3Var;
        h36 h36Var = l54Var.E;
        this.D = h36Var == null ? h36.l : h36Var;
        up2 up2Var = l54Var.b;
        if (up2Var == null) {
            up2Var = new up2(5, 5L, TimeUnit.MINUTES);
            l54Var.b = up2Var;
        }
        this.E = up2Var;
        if (list != null && list.isEmpty()) {
            this.p = null;
            this.v = null;
            this.q = null;
            this.u = sl0.c;
            break;
        }
        Iterator it = list.iterator();
        while (true) {
            if (!it.hasNext()) {
                this.p = null;
                this.v = null;
                this.q = null;
                this.u = sl0.c;
                break;
            }
            if (((fb1) it.next()).a) {
                SSLSocketFactory sSLSocketFactory = l54Var.q;
                if (sSLSocketFactory != null) {
                    this.p = sSLSocketFactory;
                    rl0 rl0Var = l54Var.w;
                    rl0Var.getClass();
                    this.v = rl0Var;
                    X509TrustManager x509TrustManager = l54Var.r;
                    x509TrustManager.getClass();
                    this.q = x509TrustManager;
                    sl0 sl0Var = l54Var.v;
                    sl0Var.getClass();
                    this.u = j63.u(sl0Var.b, rl0Var) ? sl0Var : new sl0(sl0Var.a, rl0Var);
                    break;
                }
                bi4 bi4Var = bi4.a;
                bi4.a.getClass();
                TrustManagerFactory trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
                trustManagerFactory.init((KeyStore) null);
                TrustManager[] trustManagers = trustManagerFactory.getTrustManagers();
                trustManagers.getClass();
                if (trustManagers.length == 1) {
                    TrustManager trustManager = trustManagers[0];
                    if (trustManager instanceof X509TrustManager) {
                        X509TrustManager x509TrustManager2 = (X509TrustManager) trustManager;
                        this.q = x509TrustManager2;
                        bi4 bi4Var2 = bi4.a;
                        bi4Var2.getClass();
                        try {
                            SSLContext sSLContextK = bi4Var2.k();
                            sSLContextK.init(null, new TrustManager[]{x509TrustManager2}, null);
                            SSLSocketFactory socketFactory = sSLContextK.getSocketFactory();
                            socketFactory.getClass();
                            this.p = socketFactory;
                            rl0 rl0VarC = bi4.a.c(x509TrustManager2);
                            this.v = rl0VarC;
                            sl0 sl0Var2 = l54Var.v;
                            sl0Var2.getClass();
                            this.u = j63.u(sl0Var2.b, rl0VarC) ? sl0Var2 : new sl0(sl0Var2.a, rl0VarC);
                            break;
                        } catch (GeneralSecurityException e) {
                            throw new AssertionError("No System TLS: " + e, e);
                        }
                    }
                }
                String string = Arrays.toString(trustManagers);
                string.getClass();
                nr3.i("Unexpected default trust managers: ".concat(string));
                throw null;
            }
        }
        X509TrustManager x509TrustManager3 = this.q;
        rl0 rl0Var2 = this.v;
        SSLSocketFactory sSLSocketFactory2 = this.p;
        List list2 = this.c;
        List list3 = this.b;
        list3.getClass();
        if (list3.contains(null)) {
            nr3.j(list3, "Null interceptor: ");
            throw null;
        }
        list2.getClass();
        if (list2.contains(null)) {
            nr3.j(list2, "Null network interceptor: ");
            throw null;
        }
        List list4 = this.r;
        if (list4 == null || !list4.isEmpty()) {
            Iterator it2 = list4.iterator();
            while (it2.hasNext()) {
                if (((fb1) it2.next()).a) {
                    if (sSLSocketFactory2 == null) {
                        mz.h("sslSocketFactory == null");
                        throw null;
                    }
                    if (rl0Var2 == null) {
                        mz.h("certificateChainCleaner == null");
                        throw null;
                    }
                    if (x509TrustManager3 != null) {
                        return;
                    }
                    mz.h("x509TrustManager == null");
                    throw null;
                }
            }
        }
        if (sSLSocketFactory2 != null) {
            mz.h("Check failed.");
            throw null;
        }
        if (rl0Var2 != null) {
            mz.h("Check failed.");
            throw null;
        }
        if (x509TrustManager3 != null) {
            mz.h("Check failed.");
            throw null;
        }
        if (j63.u(this.u, sl0.c)) {
            return;
        }
        mz.h("Check failed.");
        throw null;
    }