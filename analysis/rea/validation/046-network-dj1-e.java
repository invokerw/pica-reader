    public static void e(long j, String str, String str2) {
        long jNanoTime = (System.nanoTime() - j) / 1000000;
        SimpleDateFormat simpleDateFormat = sy2.a;
        StringBuilder sbQ = zv3.q("DNS ", str, " ✘ 解析失败 ", str2, " (");
        sbQ.append(jNanoTime);
        sbQ.append("ms)");
        sy2.f(sbQ.toString(), 'E');
    }