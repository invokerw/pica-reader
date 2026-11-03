    @Override // defpackage.o72
    public final void a(bz4 bz4Var, IOException iOException) {
        SimpleDateFormat simpleDateFormat = sy2.a;
        Set set = et1.a;
        String strC = et1.c((lx2) bz4Var.j.b);
        String simpleName = iOException.getClass().getSimpleName();
        String message = iOException.getMessage();
        long jNanoTime = (System.nanoTime() - this.c) / 1000000;
        StringBuilder sbQ = zv3.q("NET ", this.b, " ✘ 请求失败 ", strC, " ");
        zv3.w(sbQ, simpleName, ": ", message, " (");
        sbQ.append(jNanoTime);
        sbQ.append("ms)");
        sy2.f(sbQ.toString(), 'E');
    }