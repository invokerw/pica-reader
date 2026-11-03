    public void s(String str, o55 o55Var) {
        str.getClass();
        if (str.length() <= 0) {
            mz.f("method.isEmpty() == true");
            return;
        }
        if (o55Var == null) {
            if (str.equals(HlsMediaPlaylist.Interstitial.CUE_TRIGGER_POST) || str.equals("PUT") || str.equals("PATCH") || str.equals("PROPPATCH") || str.equals("QUERY") || str.equals("REPORT")) {
                mz.e(c31.j("method ", str, " must have a request body."));
                return;
            }
        } else if (!hr2.E(str)) {
            mz.e(c31.j("method ", str, " must not have a request body."));
            return;
        }
        this.b = str;
        this.d = o55Var;
    }