    public final void b() {
        ConcurrentHashMap concurrentHashMap = this.i.a;
        Set setEntrySet = concurrentHashMap.entrySet();
        setEntrySet.getClass();
        ArrayList arrayList = new ArrayList();
        for (Object obj : setEntrySet) {
            gv1 gv1Var = (gv1) ((Map.Entry) obj).getValue();
            gv1Var.getClass();
            if (System.currentTimeMillis() > gv1Var.b) {
                arrayList.add(obj);
            }
        }
        ArrayList arrayList2 = new ArrayList(or0.f0(arrayList, 10));
        int size = arrayList.size();
        int i = 0;
        int i2 = 0;
        while (i2 < size) {
            Object obj2 = arrayList.get(i2);
            i2++;
            arrayList2.add((String) ((Map.Entry) obj2).getKey());
        }
        int size2 = arrayList2.size();
        while (i < size2) {
            Object obj3 = arrayList2.get(i);
            i++;
            concurrentHashMap.remove((String) obj3);
        }
        if (arrayList2.isEmpty()) {
            return;
        }
        arrayList2.size();
    }