.method public static final synthetic write$Self$app(Lcom/picacg/network/pica/model/CategoriesData;Lu91;Lzi5;)V
    .registers 5

    .line 1
    sget-object v0, Lcom/picacg/network/pica/model/CategoriesData;->$childSerializers:[Lkd3;

    .line 2
    .line 3
    const/4 v1, 0x0

    .line 4
    aget-object v0, v0, v1

    .line 5
    .line 6
    invoke-interface {v0}, Lkd3;->getValue()Ljava/lang/Object;

    .line 7
    .line 8
    .line 9
    move-result-object v0

    .line 10
    check-cast v0, Lca3;

    .line 11
    .line 12
    iget-object p0, p0, Lcom/picacg/network/pica/model/CategoriesData;->categories:Ljava/util/List;

    .line 13
    .line 14
    check-cast p1, Ltt3;

    .line 15
    .line 16
    invoke-virtual {p1, p2, v1, v0, p0}, Ltt3;->a0(Lzi5;ILca3;Ljava/lang/Object;)V

    .line 17
    .line 18
    .line 19
    return-void
.end method