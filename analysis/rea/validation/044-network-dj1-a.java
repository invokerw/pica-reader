    public static ArrayList a(String str, ArrayList arrayList) throws UnknownHostException {
        ArrayList arrayList2 = new ArrayList();
        int size = arrayList.size();
        int i = 0;
        while (i < size) {
            Object obj = arrayList.get(i);
            i++;
            String str2 = (String) obj;
            try {
                InetAddress byAddress = InetAddress.getByAddress(str, InetAddress.getByName(str2).getAddress());
                byAddress.getClass();
                arrayList2.add(byAddress);
            } catch (Exception e) {
                Log.w("CustomDns", c31.k("无效的 IP 地址: ", str2, " (域名: ", str, ")"), e);
            }
        }
        if (!arrayList2.isEmpty()) {
            return arrayList2;
        }
        Log.e("CustomDns", "没有有效的 IP 地址: " + str);
        throw new UnknownHostException(c31.i("没有有效的 IP 地址: ", str));
    }