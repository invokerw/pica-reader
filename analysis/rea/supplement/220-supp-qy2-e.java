    public static void e(String str, s65 s65Var, long j, String str2) {
        SimpleDateFormat simpleDateFormat = sy2.a;
        if (sy2.a("http_failure")) {
            try {
                String strH = s65.h(s65Var, "cf-ray");
                int i = s65Var.l;
                FirebaseCrashlytics firebaseCrashlytics = FirebaseCrashlytics.getInstance();
                firebaseCrashlytics.getClass();
                firebaseCrashlytics.setCustomKey("pica_img_fail_http_code", i);
                firebaseCrashlytics.setCustomKey("pica_img_fail_http_url", kx5.L0(400, str));
                String str3 = "unknown";
                firebaseCrashlytics.setCustomKey("pica_img_fail_colo", strH != null ? kx5.H0('-', strH, strH) : "unknown");
                String strH2 = s65.h(s65Var, "server");
                if (strH2 != null) {
                    str3 = strH2;
                }
                firebaseCrashlytics.setCustomKey("pica_img_fail_server", str3);
                firebaseCrashlytics.log("[PICA_IMG_HTTP_FAILURE] " + i + " " + str + " (" + j + "ms) cf-ray=" + strH + " body=" + (str2 != null ? kx5.L0(200, str2) : null));
                StringBuilder sb = new StringBuilder("[PICA_IMG_HTTP_FAILURE] HTTP ");
                sb.append(i);
                sb.append(" @ ");
                sb.append(str);
                firebaseCrashlytics.recordException(new RuntimeException(sb.toString()));
            } catch (Exception unused) {
            }
        }
    }