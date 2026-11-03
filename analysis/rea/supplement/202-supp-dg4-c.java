    public static void c(PicaResponse picaResponse) throws tg4, xg4 {
        if (j63.u(picaResponse.getError(), "1023")) {
            throw new xg4();
        }
        if (j63.u(picaResponse.getMessage(), "success") || picaResponse.getCode() == 200) {
            return;
        }
        Log.e("PicaApi", "API业务错误: code=" + picaResponse.getCode() + ", message=" + picaResponse.getMessage() + ", error=" + picaResponse.getError());
        throw new tg4(picaResponse.getCode(), picaResponse.getMessage(), picaResponse.getError(), null, 8);
    }