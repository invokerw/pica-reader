    public k30(rt rtVar, i76 i76Var, List list, hs1 hs1Var, qj2 qj2Var) {
        rt rtVar2 = rtVar;
        i76 i76Var2 = i76Var;
        this.a = rtVar2;
        this.b = list;
        final int i = 0;
        km2 km2Var = new km2(this) { // from class: xu3
            public final /* synthetic */ k30 j;

            {
                this.j = this;
            }

            @Override // defpackage.km2
            public final Object invoke() {
                int i2 = i;
                Object obj = null;
                int i3 = 1;
                k30 k30Var = this.j;
                switch (i2) {
                    case 0:
                        ArrayList arrayList = (ArrayList) k30Var.e;
                        if (!arrayList.isEmpty()) {
                            Object obj2 = arrayList.get(0);
                            float fB = ((tb4) obj2).a.b();
                            int size = arrayList.size() - 1;
                            if (1 <= size) {
                                while (true) {
                                    Object obj3 = arrayList.get(i3);
                                    float fB2 = ((tb4) obj3).a.b();
                                    if (Float.compare(fB, fB2) < 0) {
                                        obj2 = obj3;
                                        fB = fB2;
                                    }
                                    if (i3 != size) {
                                        i3++;
                                    }
                                }
                            }
                            obj = obj2;
                        }
                        tb4 tb4Var = (tb4) obj;
                        return Float.valueOf(tb4Var != null ? tb4Var.a.b() : 0.0f);
                    default:
                        ArrayList arrayList2 = (ArrayList) k30Var.e;
                        if (!arrayList2.isEmpty()) {
                            Object obj4 = arrayList2.get(0);
                            float fC = ((tb4) obj4).a.i.c();
                            int size2 = arrayList2.size() - 1;
                            if (1 <= size2) {
                                while (true) {
                                    Object obj5 = arrayList2.get(i3);
                                    float fC2 = ((tb4) obj5).a.i.c();
                                    if (Float.compare(fC, fC2) < 0) {
                                        obj4 = obj5;
                                        fC = fC2;
                                    }
                                    if (i3 != size2) {
                                        i3++;
                                    }
                                }
                            }
                            obj = obj4;
                        }
                        tb4 tb4Var2 = (tb4) obj;
                        return Float.valueOf(tb4Var2 != null ? tb4Var2.a.i.c() : 0.0f);
                }
            }
        };
        sh3 sh3Var = sh3.j;
        this.c = gr2.A(sh3Var, km2Var);
        final int i2 = 1;
        this.d = gr2.A(sh3Var, new km2(this) { // from class: xu3
            public final /* synthetic */ k30 j;

            {
                this.j = this;
            }

            @Override // defpackage.km2
            public final Object invoke() {
                int i3 = i2;
                Object obj = null;
                int i4 = 1;
                k30 k30Var = this.j;
                switch (i3) {
                    case 0:
                        ArrayList arrayList = (ArrayList) k30Var.e;
                        if (!arrayList.isEmpty()) {
                            Object obj2 = arrayList.get(0);
                            float fB = ((tb4) obj2).a.b();
                            int size = arrayList.size() - 1;
                            if (1 <= size) {
                                while (true) {
                                    Object obj3 = arrayList.get(i4);
                                    float fB2 = ((tb4) obj3).a.b();
                                    if (Float.compare(fB, fB2) < 0) {
                                        obj2 = obj3;
                                        fB = fB2;
                                    }
                                    if (i4 != size) {
                                        i4++;
                                    }
                                }
                            }
                            obj = obj2;
                        }
                        tb4 tb4Var = (tb4) obj;
                        return Float.valueOf(tb4Var != null ? tb4Var.a.b() : 0.0f);
                    default:
                        ArrayList arrayList2 = (ArrayList) k30Var.e;
                        if (!arrayList2.isEmpty()) {
                            Object obj4 = arrayList2.get(0);
                            float fC = ((tb4) obj4).a.i.c();
                            int size2 = arrayList2.size() - 1;
                            if (1 <= size2) {
                                while (true) {
                                    Object obj5 = arrayList2.get(i4);
                                    float fC2 = ((tb4) obj5).a.i.c();
                                    if (Float.compare(fC, fC2) < 0) {
                                        obj4 = obj5;
                                        fC = fC2;
                                    }
                                    if (i4 != size2) {
                                        i4++;
                                    }
                                }
                            }
                            obj = obj4;
                        }
                        tb4 tb4Var2 = (tb4) obj;
                        return Float.valueOf(tb4Var2 != null ? tb4Var2.a.i.c() : 0.0f);
                }
            }
        });
        wb4 wb4Var = i76Var2.b;
        rt rtVar3 = tt.a;
        ArrayList arrayList = rtVar2.l;
        String str = rtVar2.j;
        b42 b42Var = b42.i;
        List listR0 = arrayList != null ? nr0.R0(arrayList, new kj2(11)) : b42Var;
        ArrayList arrayList2 = new ArrayList();
        hx hxVar = new hx();
        int size = listR0.size();
        int i3 = 0;
        int i4 = 0;
        while (i3 < size) {
            qt qtVar = (qt) listR0.get(i3);
            qt qtVarA = qt.a(qtVar, wb4Var.a((wb4) qtVar.a), i, 14);
            Object obj = qtVarA.a;
            int i5 = qtVarA.c;
            int i6 = qtVarA.b;
            while (i4 < i6 && !hxVar.isEmpty()) {
                qt qtVar2 = (qt) hxVar.last();
                listR0 = listR0;
                int i7 = qtVar2.c;
                b42Var = b42Var;
                Object obj2 = qtVar2.a;
                if (i6 < i7) {
                    arrayList2.add(new qt(obj2, i4, i6));
                    i4 = i6;
                } else {
                    int i8 = size;
                    arrayList2.add(new qt(obj2, i4, i7));
                    i4 = qtVar2.c;
                    while (!hxVar.isEmpty() && i4 == ((qt) hxVar.last()).c) {
                        hxVar.removeLast();
                    }
                    size = i8;
                }
            }
            List list2 = listR0;
            b42 b42Var2 = b42Var;
            int i9 = size;
            if (i4 < i6) {
                arrayList2.add(new qt(wb4Var, i4, i6));
                i4 = i6;
            }
            qt qtVar3 = (qt) hxVar.g();
            if (qtVar3 != null) {
                int i10 = qtVar3.c;
                Object obj3 = qtVar3.a;
                int i11 = qtVar3.b;
                if (i11 == i6 && i10 == i5) {
                    hxVar.removeLast();
                    hxVar.addLast(new qt(((wb4) obj3).a((wb4) obj), i6, i5));
                } else if (i11 == i10) {
                    arrayList2.add(new qt(obj3, i11, i10));
                    hxVar.removeLast();
                    hxVar.addLast(new qt(obj, i6, i5));
                } else {
                    if (i10 < i5) {
                        fa4.e();
                        throw null;
                    }
                    hxVar.addLast(new qt(((wb4) obj3).a((wb4) obj), i6, i5));
                }
            } else {
                hxVar.addLast(new qt(obj, i6, i5));
            }
            i3++;
            listR0 = list2;
            b42Var = b42Var2;
            size = i9;
            i = 0;
        }
        b42 b42Var3 = b42Var;
        while (i4 <= str.length() && !hxVar.isEmpty()) {
            qt qtVar4 = (qt) hxVar.last();
            Object obj4 = qtVar4.a;
            int i12 = qtVar4.c;
            arrayList2.add(new qt(obj4, i4, i12));
            while (!hxVar.isEmpty() && i12 == ((qt) hxVar.last()).c) {
                hxVar.removeLast();
            }
            i4 = i12;
        }
        if (i4 < str.length()) {
            arrayList2.add(new qt(wb4Var, i4, str.length()));
        }
        if (arrayList2.isEmpty()) {
            arrayList2.add(new qt(wb4Var, 0, 0));
        }
        ArrayList arrayList3 = new ArrayList(arrayList2.size());
        int i13 = 0;
        for (int size2 = arrayList2.size(); i13 < size2; size2 = size2) {
            qt qtVar5 = (qt) arrayList2.get(i13);
            int i14 = qtVar5.b;
            int i15 = qtVar5.c;
            String strSubstring = i14 != i15 ? str.substring(i14, i15) : "";
            List listA = tt.a(rtVar2, i14, i15, new st(0));
            rt rtVar4 = new rt(strSubstring, listA == null ? b42Var3 : listA);
            wb4 wb4Var2 = (wb4) qtVar5.a;
            if (wb4Var2.b == 0) {
                wb4Var2 = new wb4(wb4Var2.a, wb4Var.b, wb4Var2.c, wb4Var2.d, wb4Var2.e, wb4Var2.f, wb4Var2.g, wb4Var2.h, wb4Var2.i);
            }
            i76 i76Var3 = new i76(i76Var2.a, wb4Var.a(wb4Var2));
            List list3 = rtVar4.i;
            List list4 = list3 == null ? b42Var3 : list3;
            List list5 = (List) this.b;
            ArrayList arrayList4 = new ArrayList(list5.size());
            int size3 = list5.size();
            int i16 = 0;
            while (i16 < size3) {
                qt qtVar6 = (qt) list5.get(i16);
                int i17 = qtVar6.b;
                wb4 wb4Var3 = wb4Var;
                int i18 = qtVar6.c;
                if (tt.b(i14, i15, i17, i18)) {
                    if (i14 > i17 || i18 > i15) {
                        g33.a("placeholder can not overlap with paragraph.");
                    }
                    arrayList4.add(new qt(qtVar6.a, i17 - i14, i18 - i14));
                }
                i16++;
                i76Var3 = i76Var3;
                wb4Var = wb4Var3;
            }
            arrayList3.add(new tb4(new kf(strSubstring, i76Var3, list4, arrayList4, qj2Var, hs1Var), i14, i15));
            i13++;
            rtVar2 = rtVar;
            i76Var2 = i76Var;
            str = str;
        }
        this.e = arrayList3;
    }