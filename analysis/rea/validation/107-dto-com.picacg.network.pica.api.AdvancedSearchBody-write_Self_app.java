    public static final /* synthetic */ void write$Self$app(AdvancedSearchBody advancedSearchBody, u91 u91Var, zi5 zi5Var) {
        kd3[] kd3VarArr = $childSerializers;
        tt3 tt3Var = (tt3) u91Var;
        tt3Var.b0(zi5Var, 0, advancedSearchBody.keyword);
        if (tt3Var.e(zi5Var) || !j63.u(advancedSearchBody.sort, "dd")) {
            tt3Var.b0(zi5Var, 1, advancedSearchBody.sort);
        }
        if (advancedSearchBody.categories != null) {
            tt3Var.p(zi5Var, 2, (ca3) kd3VarArr[2].getValue(), advancedSearchBody.categories);
        }
    }