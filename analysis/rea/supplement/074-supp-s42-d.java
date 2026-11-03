    public final SecretKey d() {
        KeyStore keyStore = this.b;
        if (keyStore == null) {
            return null;
        }
        try {
            if (keyStore.containsAlias("picacg_token_key")) {
                try {
                    Key key = keyStore.getKey("picacg_token_key", null);
                    SecretKey secretKey = key instanceof SecretKey ? (SecretKey) key : null;
                    if (secretKey != null) {
                        return secretKey;
                    }
                    try {
                        keyStore.deleteEntry("picacg_token_key");
                    } catch (Throwable th) {
                        Log.w("EncryptedTokenStore", "删除损坏的 Keystore 条目失败", th);
                        return null;
                    }
                } catch (Throwable th2) {
                    Log.w("EncryptedTokenStore", "读取 Keystore 条目失败，本次降级（不动既有条目）", th2);
                    return null;
                }
            }
            try {
                return c();
            } catch (Throwable th3) {
                Log.w("EncryptedTokenStore", "Keystore 密钥生成失败，降级为「Token 仅存内存」", th3);
                return null;
            }
        } catch (Throwable th4) {
            Log.w("EncryptedTokenStore", "查询 Keystore alias 失败，本次降级（不动既有条目）", th4);
            return null;
        }
    }