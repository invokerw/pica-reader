    public s42(Context context) {
        context.getClass();
        this.a = context;
        KeyStore keyStore = null;
        try {
            KeyStore keyStore2 = KeyStore.getInstance("AndroidKeyStore");
            keyStore2.load(null);
            keyStore = keyStore2;
        } catch (Throwable th) {
            Log.w("EncryptedTokenStore", "AndroidKeyStore 不可用，Token 将只保留在内存中", th);
        }
        this.b = keyStore;
        SharedPreferences sharedPreferences = this.a.getSharedPreferences("secure_tokens", 0);
        sharedPreferences.getClass();
        this.c = sharedPreferences;
        this.f = new Object();
    }