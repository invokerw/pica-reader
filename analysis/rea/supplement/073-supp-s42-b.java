    public final String b(String str) {
        SecretKey secretKeyF = f();
        if (secretKeyF == null) {
            return null;
        }
        try {
            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
            cipher.init(1, secretKeyF);
            byte[] iv = cipher.getIV();
            byte[] bytes = str.getBytes(do0.a);
            bytes.getClass();
            byte[] bArrDoFinal = cipher.doFinal(bytes);
            iv.getClass();
            bArrDoFinal.getClass();
            int length = iv.length;
            int length2 = bArrDoFinal.length;
            byte[] bArrCopyOf = Arrays.copyOf(iv, length + length2);
            System.arraycopy(bArrDoFinal, 0, bArrCopyOf, length, length2);
            return Base64.encodeToString(bArrCopyOf, 2);
        } catch (Throwable th) {
            Log.w("EncryptedTokenStore", "加密失败，本次跳过落盘", th);
            return null;
        }
    }