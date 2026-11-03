    @Override // defpackage.o72
    public final void c(bz4 bz4Var, InetSocketAddress inetSocketAddress, Proxy proxy) {
        inetSocketAddress.getClass();
        SimpleDateFormat simpleDateFormat = sy2.a;
        String strB = et1.b(inetSocketAddress, proxy);
        long jNanoTime = (System.nanoTime() - this.c) / 1000000;
        StringBuilder sbQ = zv3.q("NET ", this.b, " 拨号 ", strB, " (");
        sbQ.append(jNanoTime);
        sbQ.append("ms)");
        sy2.f(sbQ.toString(), 'D');
    }