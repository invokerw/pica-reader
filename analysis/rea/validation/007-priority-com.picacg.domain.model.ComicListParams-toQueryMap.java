    public final Map<String, String> toQueryMap() {
        dq3 dq3Var = new dq3();
        String str = this.category;
        if (str != null) {
        }
        String str2 = this.tag;
        if (str2 != null) {
        }
        String str3 = this.author;
        if (str3 != null) {
        }
        String str4 = this.creatorId;
        if (str4 != null) {
        }
        String str5 = this.chineseTeam;
        if (str5 != null) {
        }
        dq3Var.put(CmcdData.STREAMING_FORMAT_SS, this.sort);
        dq3Var.putAll(this.customParams);
        return dq3Var.b();
    }