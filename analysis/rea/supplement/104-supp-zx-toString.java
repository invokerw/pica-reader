    public String toString() {
        switch (this.a) {
            case 3:
                sl4 sl4Var = (sl4) this.e;
                StringBuilder sb = new StringBuilder(32);
                sb.append("Request{method=");
                sb.append((String) this.g);
                sb.append(", url=");
                sb.append((lx2) this.b);
                at2 at2Var = (at2) this.c;
                if (at2Var.size() != 0) {
                    sb.append(", headers=[");
                    int i = 0;
                    for (Object obj : at2Var) {
                        int i2 = i + 1;
                        if (i < 0) {
                            pl0.b0();
                            throw null;
                        }
                        qb4 qb4Var = (qb4) obj;
                        String str = (String) qb4Var.i;
                        String str2 = (String) qb4Var.j;
                        if (i > 0) {
                            sb.append(", ");
                        }
                        sb.append(str);
                        sb.append(':');
                        if (zr6.l(str)) {
                            str2 = "██";
                        }
                        sb.append(str2);
                        i = i2;
                    }
                    sb.append(']');
                }
                if (!j63.u(sl4Var, j42.h)) {
                    sb.append(", tags=");
                    sb.append(sl4Var);
                }
                sb.append('}');
                return sb.toString();
            default:
                return super.toString();
        }
    }