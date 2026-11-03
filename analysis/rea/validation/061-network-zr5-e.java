    public static final void e(zr5 zr5Var, SmartDnsData smartDnsData) {
        int i;
        Map<String, SmartDnsLine> lines = smartDnsData.getLines();
        if (lines.isEmpty()) {
            i = 0;
        } else {
            Iterator<Map.Entry<String, SmartDnsLine>> it = lines.entrySet().iterator();
            int i2 = 0;
            while (it.hasNext()) {
                if (it.next().getValue().isOk()) {
                    i2++;
                }
            }
            i = i2;
        }
        Collection<SmartDnsLine> collectionValues = smartDnsData.getLines().values();
        ArrayList arrayList = new ArrayList();
        for (Object obj : collectionValues) {
            if (((SmartDnsLine) obj).isOk()) {
                arrayList.add(obj);
            }
        }
        ArrayList arrayList2 = new ArrayList();
        int size = arrayList.size();
        int i3 = 0;
        while (i3 < size) {
            Object obj2 = arrayList.get(i3);
            i3++;
            nr0.k0(((SmartDnsLine) obj2).getCleanIps(), arrayList2);
        }
        int size2 = nr0.Y0(nr0.b1(arrayList2)).size();
        zr5Var.e = new SmartDnsStatusSnapshot(size2 > 0, size2, i, smartDnsData.getClientCountry(), smartDnsData.getDegraded());
    }