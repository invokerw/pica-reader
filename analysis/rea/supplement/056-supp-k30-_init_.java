    public k30(ey3 ey3Var) {
        Intent launchIntentForPackage;
        ey3Var.getClass();
        Context context = ey3Var.a;
        context.getClass();
        this.a = context;
        this.b = new ck1(context, (byte) 0);
        ge2 ge2Var = new ge2(new he2(new e26(xi5.Q(new kx3(10), context), new kx3(11), 1), false, new dc5(9)));
        Activity activity = (Activity) (!ge2Var.hasNext() ? null : ge2Var.next());
        if (activity != null) {
            launchIntentForPackage = new Intent(context, activity.getClass());
        } else {
            launchIntentForPackage = context.getPackageManager().getLaunchIntentForPackage(context.getPackageName());
            if (launchIntentForPackage == null) {
                launchIntentForPackage = new Intent();
            }
        }
        launchIntentForPackage.addFlags(268468224);
        this.c = launchIntentForPackage;
        this.e = new ArrayList();
        this.d = ey3Var.b.i();
    }