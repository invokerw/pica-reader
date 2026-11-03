    public final void e(String str, String str2) {
        str.getClass();
        str2.getClass();
        String strB = b(str);
        String strB2 = b(str2);
        SharedPreferences sharedPreferences = this.c;
        if (strB == null || strB2 == null) {
            sharedPreferences.edit().putBoolean("remember_password", false).apply();
        } else {
            sharedPreferences.edit().putString("saved_username", strB).putString("saved_password", strB2).putBoolean("remember_password", true).apply();
        }
    }