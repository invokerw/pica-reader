    /* JADX WARN: Code duplicated, block: B:59:0x00eb  */
    public static boolean c(String str, X509Certificate x509Certificate) throws EOFException {
        boolean zEquals;
        int length;
        str.getClass();
        if (xr6.a.c(str)) {
            String strB = xr6.b(str);
            List listA = a(x509Certificate, 7);
            if (!listA.isEmpty()) {
                Iterator it = listA.iterator();
                while (it.hasNext()) {
                    if (j63.u(strB, xr6.b((String) it.next()))) {
                        return true;
                    }
                }
            }
            return false;
        }
        if (b(str)) {
            Locale locale = Locale.US;
            locale.getClass();
            str = str.toLowerCase(locale);
            str.getClass();
        }
        List<String> listA2 = a(x509Certificate, 2);
        if (!listA2.isEmpty()) {
            for (String lowerCase : listA2) {
                if (str.length() == 0 || rx5.f0(str, ".", false) || rx5.Y(str, "..", false) || lowerCase == null || lowerCase.length() == 0 || rx5.f0(lowerCase, ".", false) || rx5.Y(lowerCase, "..", false)) {
                    zEquals = false;
                } else {
                    String strConcat = !rx5.Y(str, ".", false) ? str.concat(".") : str;
                    if (!rx5.Y(lowerCase, ".", false)) {
                        lowerCase = lowerCase.concat(".");
                    }
                    if (b(lowerCase)) {
                        Locale locale2 = Locale.US;
                        locale2.getClass();
                        lowerCase = lowerCase.toLowerCase(locale2);
                        lowerCase.getClass();
                    }
                    if (!kx5.i0(lowerCase, "*", false)) {
                        zEquals = strConcat.equals(lowerCase);
                    } else if (!rx5.f0(lowerCase, "*.", false) || kx5.q0(lowerCase, '*', 1, 4) != -1 || strConcat.length() < lowerCase.length() || "*.".equals(lowerCase)) {
                        zEquals = false;
                    } else {
                        String strSubstring = lowerCase.substring(1);
                        if (rx5.Y(strConcat, strSubstring, false) && ((length = strConcat.length() - strSubstring.length()) <= 0 || kx5.v0(strConcat, '.', length - 1, 4) == -1)) {
                            zEquals = true;
                        } else {
                            zEquals = false;
                        }
                    }
                }
                if (zEquals) {
                    return true;
                }
            }
        }
        return false;
    }