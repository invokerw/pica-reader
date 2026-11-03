    public static void f(dj1 dj1Var, String str, String str2, ArrayList arrayList, long j) {
        long jNanoTime = (System.nanoTime() - j) / 1000000;
        SimpleDateFormat simpleDateFormat = sy2.a;
        String strC0 = nr0.C0(arrayList, ", ", null, null, null, 62);
        StringBuilder sbQ = zv3.q("DNS ", str, " ← [", str2, "] → ");
        sbQ.append(strC0);
        sbQ.append(" (");
        sbQ.append(jNanoTime);
        sbQ.append("ms)");
        sy2.f(sbQ.toString(), 'D');
    }