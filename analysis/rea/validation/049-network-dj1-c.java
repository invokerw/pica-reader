    public final void c() {
        ra2 ra2Var = this.k;
        Set setKeySet = ra2Var.a.keySet();
        Set setKeySet2 = ra2Var.b.keySet();
        setKeySet2.getClass();
        Set set = setKeySet2;
        setKeySet.getClass();
        Integer numValueOf = set instanceof Collection ? Integer.valueOf(set.size()) : null;
        LinkedHashSet<String> linkedHashSet = new LinkedHashSet(tq3.G(numValueOf != null ? setKeySet.size() + numValueOf.intValue() : setKeySet.size() * 2));
        linkedHashSet.addAll(setKeySet);
        nr0.k0(set, linkedHashSet);
        for (String str : linkedHashSet) {
            str.getClass();
            List listA = ra2Var.a(str);
            if (listA == null) {
                listA = ra2Var.b(str);
            }
            List list = listA;
            if (list != null && !list.isEmpty()) {
                this.i.b(str, list, kv1.PRELOAD, 600000L);
                nr0.C0(list, ", ", null, null, null, 62);
            }
        }
    }