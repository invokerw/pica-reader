    public static void d(String str, String str2, List list) {
        SimpleDateFormat simpleDateFormat = sy2.a;
        String strC0 = nr0.C0(list, ", ", null, null, null, 62);
        StringBuilder sbQ = zv3.q("DNS ", str, " [", str2, "] 全部被拉黑（");
        sbQ.append(strC0);
        sbQ.append("），降到下一级");
        sy2.f(sbQ.toString(), 'D');
    }