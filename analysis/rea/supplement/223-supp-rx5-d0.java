    public static String d0(String str, String str2, String str3, boolean z) {
        zv3.v(str, str2, str3);
        int i = 0;
        int iO0 = kx5.o0(str, str2, 0, z);
        if (iO0 < 0) {
            return str;
        }
        int length = str2.length();
        int i2 = length >= 1 ? length : 1;
        int length2 = str3.length() + (str.length() - length);
        if (length2 < 0) {
            throw new OutOfMemoryError();
        }
        StringBuilder sb = new StringBuilder(length2);
        do {
            sb.append((CharSequence) str, i, iO0);
            sb.append(str3);
            i = iO0 + length;
            if (iO0 >= str.length()) {
                break;
            }
            iO0 = kx5.o0(str, str2, iO0 + i2, z);
        } while (iO0 > 0);
        sb.append((CharSequence) str, i, str.length());
        return sb.toString();
    }