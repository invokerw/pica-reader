    @Override // defpackage.fv1
    public final List g(String str) throws UnknownHostException {
        Object y65Var;
        str.getClass();
        List listB = this.i.b(str);
        if (listB == null || listB.isEmpty()) {
            try {
                InetAddress[] allByName = InetAddress.getAllByName(str);
                allByName.getClass();
                return sx.t0(allByName);
            } catch (NullPointerException e) {
                UnknownHostException unknownHostException = new UnknownHostException("Broken system behaviour for dns lookup of ".concat(str));
                unknownHostException.initCause(e);
                throw unknownHostException;
            }
        }
        ArrayList arrayList = new ArrayList();
        ArrayList arrayList2 = new ArrayList();
        for (Object obj : listB) {
            if (this.j.d((String) obj)) {
                arrayList2.add(obj);
            } else {
                arrayList.add(obj);
            }
        }
        ArrayList arrayListH0 = nr0.H0(arrayList2, arrayList);
        if (!arrayList2.isEmpty()) {
            SimpleDateFormat simpleDateFormat = sy2.a;
            sy2.f(c31.k("DNS ", str, " [固定IP] ", nr0.C0(arrayList2, ", ", null, null, null, 62), " 在黑名单中，已排到最后但仍会尝试"), 'D');
        }
        SimpleDateFormat simpleDateFormat2 = sy2.a;
        sy2.f("DNS " + str + " ← [固定IP] → " + nr0.C0(arrayListH0, ", ", null, null, null, 62), 'D');
        ArrayList arrayList3 = new ArrayList();
        int size = arrayListH0.size();
        int i = 0;
        while (i < size) {
            int i2 = i + 1;
            try {
                y65Var = InetAddress.getByAddress(str, InetAddress.getByName((String) arrayListH0.get(i)).getAddress());
            } catch (Throwable th) {
                y65Var = new y65(th);
            }
            if (y65Var instanceof y65) {
                y65Var = null;
            }
            InetAddress inetAddress = (InetAddress) y65Var;
            if (inetAddress != null) {
                arrayList3.add(inetAddress);
            }
            i = i2;
        }
        if (arrayList3.isEmpty()) {
            throw new UnknownHostException("固定 IP 全部无效: ".concat(str));
        }
        return arrayList3;
    }