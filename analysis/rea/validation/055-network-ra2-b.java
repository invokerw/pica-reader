    public final List b(String str) {
        List list;
        str.getClass();
        Map map = this.a;
        Set<String> setKeySet = map.keySet();
        List list2 = (List) map.get(str);
        if (list2 != null && !list2.isEmpty()) {
            return list2;
        }
        String str2 = null;
        for (String str3 : setKeySet) {
            if (rx5.Y(str, "." + str3, false) && (str2 == null || str3.length() > str2.length())) {
                str2 = str3;
            }
        }
        if (str2 == null || (list = (List) map.get(str2)) == null || list.isEmpty()) {
            return null;
        }
        return list;
    }