.method public final serialize(Ln42;Lcom/picacg/network/pica/model/RandomComicsResponse;)V
    .registers 3

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 5
    .line 6
    .line 7
    sget-object p0, Lcom/picacg/network/pica/model/RandomComicsResponse$$serializer;->descriptor:Lzi5;

    .line 8
    .line 9
    invoke-interface {p1, p0}, Ln42;->c(Lzi5;)Lu91;

    .line 10
    .line 11
    .line 12
    move-result-object p1

    .line 13
    invoke-static {p2, p1, p0}, Lcom/picacg/network/pica/model/RandomComicsResponse;->write$Self$app(Lcom/picacg/network/pica/model/RandomComicsResponse;Lu91;Lzi5;)V

    .line 14
    .line 15
    .line 16
    invoke-interface {p1, p0}, Lu91;->a(Lzi5;)V

    .line 17
    .line 18
    .line 19
    return-void
.end method