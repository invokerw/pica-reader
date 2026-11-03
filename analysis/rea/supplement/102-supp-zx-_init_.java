    public zx(w51 w51Var, n61 n61Var) {
        this.a = 4;
        HashSet hashSet = new HashSet();
        HashSet hashSet2 = new HashSet();
        HashSet hashSet3 = new HashSet();
        HashSet hashSet4 = new HashSet();
        HashSet hashSet5 = new HashSet();
        Set<ms1> set = w51Var.c;
        Set set2 = w51Var.g;
        for (ms1 ms1Var : set) {
            int i = ms1Var.c;
            int i2 = ms1Var.b;
            boolean z = i == 0;
            pq4 pq4Var = ms1Var.a;
            if (z) {
                if (i2 == 2) {
                    hashSet4.add(pq4Var);
                } else {
                    hashSet.add(pq4Var);
                }
            } else if (i == 2) {
                hashSet3.add(pq4Var);
            } else if (i2 == 2) {
                hashSet5.add(pq4Var);
            } else {
                hashSet2.add(pq4Var);
            }
        }
        if (!set2.isEmpty()) {
            hashSet.add(pq4.a(sp4.class));
        }
        this.b = Collections.unmodifiableSet(hashSet);
        this.c = Collections.unmodifiableSet(hashSet2);
        this.d = Collections.unmodifiableSet(hashSet3);
        this.e = Collections.unmodifiableSet(hashSet4);
        this.f = Collections.unmodifiableSet(hashSet5);
        this.g = n61Var;
    }