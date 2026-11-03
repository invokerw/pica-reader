    public static void f(int i, long j, String str, String str2) {
        SimpleDateFormat simpleDateFormat = sy2.a;
        if (sy2.a("redirect")) {
            try {
                FirebaseCrashlytics firebaseCrashlytics = FirebaseCrashlytics.getInstance();
                firebaseCrashlytics.getClass();
                firebaseCrashlytics.log("[PICA_IMG_REDIRECT] " + i + " " + str + " → " + str2 + " (" + j + "ms)");
                firebaseCrashlytics.setCustomKey("pica_img_last_redirect_code", i);
                firebaseCrashlytics.setCustomKey("pica_img_last_redirect_from", kx5.L0(300, str));
                firebaseCrashlytics.setCustomKey("pica_img_last_redirect_to", str2 != null ? kx5.L0(300, str2) : "null");
            } catch (Exception unused) {
            }
        }
    }