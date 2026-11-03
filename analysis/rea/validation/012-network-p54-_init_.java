    public p54(Context context, nh4 nh4Var, at1 at1Var, dj1 dj1Var, if2 if2Var, b73 b73Var, dd1 dd1Var) {
        this.a = context;
        this.b = nh4Var;
        this.c = at1Var;
        this.d = dj1Var;
        this.e = if2Var;
        this.f = b73Var;
        this.g = dd1Var;
        TimeUnit timeUnit = TimeUnit.SECONDS;
        this.h = new up2(8, 30L, timeUnit);
        this.i = new r06(new t23(this, 12));
        this.j = new up2(8, 30L, timeUnit);
        this.k = new ConcurrentHashMap();
        this.l = new ConcurrentHashMap();
        this.m = new ConcurrentHashMap();
    }