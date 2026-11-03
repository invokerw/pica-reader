    public final SecretKey f() {
        SecretKey secretKey;
        if (this.d) {
            return this.e;
        }
        synchronized (this.f) {
            try {
                if (!this.d) {
                    this.e = d();
                    this.d = true;
                }
                secretKey = this.e;
            } catch (Throwable th) {
                throw th;
            }
        }
        return secretKey;
    }