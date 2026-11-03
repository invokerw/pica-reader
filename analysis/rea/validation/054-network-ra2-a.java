    public final List a(String str) {
        List list;
        str.getClass();
        ConcurrentHashMap concurrentHashMap = this.b;
        Set<String> setKeySet = concurrentHashMap.keySet();
        setKeySet.getClass();
        List list2 = (List) concurrentHashMap.get(str);
        if (list2 != null && !list2.isEmpty()) {
            return list2;
        }
        String str2 = null;
        for (String str3 : setKeySet) {
            if (rx5.Y(str, "." + str3, false) && (str2 == null || str3.length() > str2.length())) {
                str2 = str3;
            }
        }
        if (str2 == null || (list = (List) concurrentHashMap.get(str2)) == null || list.isEmpty()) {
            return null;
        }
        return list;
    }