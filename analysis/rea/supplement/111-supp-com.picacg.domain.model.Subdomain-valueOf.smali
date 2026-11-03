.method public static valueOf(Ljava/lang/String;)Lcom/picacg/domain/model/Subdomain;
    .registers 2

    const-class v0, Lcom/picacg/domain/model/Subdomain;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/picacg/domain/model/Subdomain;

    return-object p0
.end method