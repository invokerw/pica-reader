    public void b(String str) {
        int iQ0 = kx5.q0(str, ':', 1, 4);
        if (iQ0 != -1) {
            yd6.a(this, str.substring(0, iQ0), str.substring(iQ0 + 1));
        } else if (str.charAt(0) == ':') {
            yd6.a(this, "", str.substring(1));
        } else {
            yd6.a(this, "", str);
        }
    }