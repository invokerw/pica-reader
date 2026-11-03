    @Override // defpackage.o72
    public final void b(bz4 bz4Var, InetSocketAddress inetSocketAddress, Proxy proxy, IOException iOException) {
        inetSocketAddress.getClass();
        SimpleDateFormat simpleDateFormat = sy2.a;
        String strB = et1.b(inetSocketAddress, proxy);
        String simpleName = iOException.getClass().getSimpleName();
        String message = iOException.getMessage();
        long jNanoTime = (System.nanoTime() - this.c) / 1000000;
        StringBuilder sbQ = zv3.q("NET ", this.b, " ✘ 连接失败 ", strB, " proto=null ");
        zv3.w(sbQ, simpleName, ": ", message, " (");
        sbQ.append(jNanoTime);
        sbQ.append("ms)");
        sy2.f(sbQ.toString(), 'E');
    }