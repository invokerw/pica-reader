    public static final cs5 a(zr5 zr5Var, SmartDnsData smartDnsData) {
        Collection<SmartDnsLine> collectionValues = smartDnsData.getLines().values();
        ArrayList arrayList = new ArrayList();
        for (Object obj : collectionValues) {
            if (((SmartDnsLine) obj).isOk()) {
                arrayList.add(obj);
            }
        }
        ArrayList arrayList2 = new ArrayList();
        int size = arrayList.size();
        int i = 0;
        int i2 = 0;
        while (i2 < size) {
            Object obj2 = arrayList.get(i2);
            i2++;
            nr0.k0(((SmartDnsLine) obj2).getCleanIps(), arrayList2);
        }
        List listY0 = nr0.Y0(nr0.b1(arrayList2));
        String domain = smartDnsData.getDomain();
        String clientIp = smartDnsData.getClientIp();
        String clientCountry = smartDnsData.getClientCountry();
        Map<String, SmartDnsLine> lines = smartDnsData.getLines();
        if (!lines.isEmpty()) {
            Iterator<Map.Entry<String, SmartDnsLine>> it = lines.entrySet().iterator();
            while (it.hasNext()) {
                if (it.next().getValue().isOk()) {
                    i++;
                }
            }
        }
        return new cs5(domain, listY0, clientIp, clientCountry, i, smartDnsData.getDegraded(), smartDnsData.getFromCache());
    }