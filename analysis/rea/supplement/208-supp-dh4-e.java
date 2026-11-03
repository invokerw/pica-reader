    @Override // defpackage.o72
    public final void e(bz4 bz4Var, String str, List list) {
        ArrayList arrayList = new ArrayList();
        Iterator it = list.iterator();
        while (it.hasNext()) {
            String hostAddress = ((InetAddress) it.next()).getHostAddress();
            if (hostAddress != null) {
                arrayList.add(hostAddress);
            }
        }
        String strC0 = nr0.C0(arrayList, ", ", null, null, null, 62);
        SimpleDateFormat simpleDateFormat = sy2.a;
        long jNanoTime = (System.nanoTime() - this.c) / 1000000;
        StringBuilder sbQ = zv3.q("NET ", str, " DNS→ [", strC0, "] (");
        sbQ.append(jNanoTime);
        sbQ.append("ms)");
        sy2.f(sbQ.toString(), 'D');
    }