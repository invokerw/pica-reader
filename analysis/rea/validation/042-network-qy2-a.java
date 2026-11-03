    /* JADX WARN: Code duplicated, block: B:96:0x027c  */
    @Override // defpackage.o53
    public final s65 a(he3 he3Var) throws Exception {
        boolean z;
        boolean z2;
        long j;
        String message;
        zx zxVar = (zx) he3Var.i;
        lx2 lx2Var = (lx2) zxVar.b;
        at2 at2Var = (at2) zxVar.c;
        String strC = et1.c(lx2Var);
        String str = lx2Var.d;
        List<String> list = a;
        if (list == null || !list.isEmpty()) {
            for (String str2 : list) {
                if (rx5.Y(str, "." + str2, true) || str.equalsIgnoreCase(str2)) {
                    List list2 = b;
                    if (list2 != null && list2.isEmpty()) {
                        z = false;
                        break;
                    }
                    Iterator it = list2.iterator();
                    while (true) {
                        if (!it.hasNext()) {
                            z = false;
                            break;
                        }
                        if (rx5.f0(lx2Var.b(), (String) it.next(), true)) {
                            z = true;
                            break;
                        }
                    }
                    long jNanoTime = System.nanoTime();
                    StringBuilder sb = new StringBuilder();
                    sb.append("▶ REQ " + ((String) zxVar.g) + " " + strC);
                    String strA = at2Var.a("accept");
                    if (strA == null) {
                        strA = at2Var.a("Accept");
                    }
                    String strA2 = at2Var.a("api-key");
                    String str3 = at2Var.a("authorization") != null ? "***[present]" : null;
                    if (strA != null) {
                        sb.append("\n    Accept: ".concat(strA));
                    }
                    if (strA2 != null) {
                        sb.append("\n    api-key: " + kx5.L0(8, strA2) + "…");
                    }
                    if (str3 != null) {
                        sb.append("\n    authorization: ".concat(str3));
                    }
                    String string = sb.toString();
                    SimpleDateFormat simpleDateFormat = sy2.a;
                    sy2.f(string, 'D');
                    try {
                        s65 s65VarF = he3Var.f(zxVar);
                        int i = s65VarF.l;
                        j = 1000000;
                        try {
                            long jNanoTime2 = (System.nanoTime() - jNanoTime) / 1000000;
                            boolean z3 = 300 <= i && i < 400;
                            boolean z4 = i >= 400;
                            String strH = s65.h(s65VarF, "Location");
                            String strC2 = z4 ? c(s65VarF) : null;
                            z2 = z;
                            try {
                                StringBuilder sb2 = new StringBuilder();
                                try {
                                    sb2.append("◀ " + i + " " + jNanoTime2 + "ms " + strC);
                                    String strD = d(he3Var);
                                    StringBuilder sb3 = new StringBuilder();
                                    sb3.append("\n    peer: ");
                                    sb3.append(strD);
                                    sb2.append(sb3.toString());
                                    String strB = b(s65VarF);
                                    if (strB != null) {
                                        sb2.append("\n    " + strB);
                                    }
                                    if (z3 && strH != null) {
                                        sb2.append("\n    → REDIRECT TO: " + strH);
                                    }
                                    String strH2 = s65.h(s65VarF, "Cache-Control");
                                    if (strH2 != null) {
                                        sb2.append("\n    Cache-Control: " + strH2);
                                    }
                                    if (strC2 != null) {
                                        sb2.append("\n    body: " + strC2);
                                    }
                                    sy2.f(sb2.toString(), z4 ? 'E' : z3 ? 'W' : 'D');
                                    if (!z2) {
                                        if (z3) {
                                            f(i, jNanoTime2, strC, strH);
                                        }
                                        if (z4) {
                                            e(strC, s65VarF, jNanoTime2, strC2);
                                        }
                                    }
                                    return s65VarF;
                                } catch (Exception e) {
                                    e = e;
                                    long jNanoTime3 = (System.nanoTime() - jNanoTime) / j;
                                    String strD2 = d(he3Var);
                                    String simpleName = e.getClass().getSimpleName();
                                    String message2 = e.getMessage();
                                    StringBuilder sb4 = new StringBuilder("✘ NET-ERR ");
                                    sb4.append(jNanoTime3);
                                    sb4.append("ms ");
                                    sb4.append(strC);
                                    zv3.w(sb4, "\n    peer: ", strD2, "\n    ", simpleName);
                                    String strN = c31.n(sb4, ": ", message2);
                                    SimpleDateFormat simpleDateFormat2 = sy2.a;
                                    sy2.f(strN, 'E');
                                    if (!z2 && sy2.a("net_error")) {
                                        try {
                                            FirebaseCrashlytics firebaseCrashlytics = FirebaseCrashlytics.getInstance();
                                            firebaseCrashlytics.getClass();
                                            firebaseCrashlytics.setCustomKey("pica_img_component", "ImageDiagnosticsInterceptor");
                                            firebaseCrashlytics.setCustomKey("pica_img_error_url", kx5.L0(400, strC));
                                            firebaseCrashlytics.setCustomKey("pica_img_error_class", e.getClass().getSimpleName());
                                            message = e.getMessage();
                                            if (message == null) {
                                                message = "null";
                                            }
                                            firebaseCrashlytics.setCustomKey("pica_img_error_msg", kx5.L0(200, message));
                                            firebaseCrashlytics.log("[PICA_IMG_NET_ERROR] Snapshot:\n".concat(sy2.d(4000)));
                                            firebaseCrashlytics.recordException(new RuntimeException("[PICA_IMG_NET_ERROR] " + e.getClass().getSimpleName() + " @ " + strC + ": " + e.getMessage(), e));
                                        } catch (Exception unused) {
                                        }
                                    }
                                    throw e;
                                }
                            } catch (Exception e2) {
                                e = e2;
                                long jNanoTime4 = (System.nanoTime() - jNanoTime) / j;
                                String strD3 = d(he3Var);
                                String simpleName2 = e.getClass().getSimpleName();
                                String message3 = e.getMessage();
                                StringBuilder sb5 = new StringBuilder("✘ NET-ERR ");
                                sb5.append(jNanoTime4);
                                sb5.append("ms ");
                                sb5.append(strC);
                                zv3.w(sb5, "\n    peer: ", strD3, "\n    ", simpleName2);
                                String strN2 = c31.n(sb5, ": ", message3);
                                SimpleDateFormat simpleDateFormat3 = sy2.a;
                                sy2.f(strN2, 'E');
                                if (!z2) {
                                    FirebaseCrashlytics firebaseCrashlytics2 = FirebaseCrashlytics.getInstance();
                                    firebaseCrashlytics2.getClass();
                                    firebaseCrashlytics2.setCustomKey("pica_img_component", "ImageDiagnosticsInterceptor");
                                    firebaseCrashlytics2.setCustomKey("pica_img_error_url", kx5.L0(400, strC));
                                    firebaseCrashlytics2.setCustomKey("pica_img_error_class", e.getClass().getSimpleName());
                                    message = e.getMessage();
                                    if (message == null) {
                                        message = "null";
                                    }
                                    firebaseCrashlytics2.setCustomKey("pica_img_error_msg", kx5.L0(200, message));
                                    firebaseCrashlytics2.log("[PICA_IMG_NET_ERROR] Snapshot:\n".concat(sy2.d(4000)));
                                    firebaseCrashlytics2.recordException(new RuntimeException("[PICA_IMG_NET_ERROR] " + e.getClass().getSimpleName() + " @ " + strC + ": " + e.getMessage(), e));
                                }
                                throw e;
                            }
                        } catch (Exception e3) {
                            e = e3;
                            z2 = z;
                        }
                    } catch (Exception e4) {
                        e = e4;
                        z2 = z;
                        j = 1000000;
                    }
                }
            }
        }
        return he3Var.f(zxVar);
    }