    public zr5(tr5 tr5Var) {
        tr5Var.getClass();
        this.a = tr5Var;
        this.b = new ConcurrentHashMap();
        this.c = new ConcurrentHashMap();
        this.e = new SmartDnsStatusSnapshot(false, 0, 0, null, false, 31, null);
    }