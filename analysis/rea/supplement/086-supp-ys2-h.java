    public String h(String str) {
        str.getClass();
        ArrayList arrayList = this.a;
        int size = arrayList.size() - 2;
        int iU = ul4.u(size, 0, -2);
        if (iU > size) {
            return null;
        }
        while (!str.equalsIgnoreCase((String) arrayList.get(size))) {
            if (size == iU) {
                return null;
            }
            size -= 2;
        }
        return (String) arrayList.get(size + 1);
    }