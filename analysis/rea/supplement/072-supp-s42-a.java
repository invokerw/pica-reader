    public final String a(String str) {
        SecretKey secretKeyF = f();
        if (secretKeyF == null) {
            return null;
        }
        try {
            byte[] bArrDecode = Base64.decode(str, 2);
            bArrDecode.getClass();
            byte[] bArrV = sx.V(bArrDecode, 0, 12);
            byte[] bArrV2 = sx.V(bArrDecode, 12, bArrDecode.length);
            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
            cipher.init(2, secretKeyF, new GCMParameterSpec(128, bArrV));
            byte[] bArrDoFinal = cipher.doFinal(bArrV2);
            bArrDoFinal.getClass();
            return new String(bArrDoFinal, do0.a);
        } catch (Throwable th) {
            Log.w("EncryptedTokenStore", "解密失败", th);
            return null;
        }
    }