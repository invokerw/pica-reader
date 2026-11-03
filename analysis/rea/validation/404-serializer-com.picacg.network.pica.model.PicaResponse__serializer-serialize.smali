.method public final serialize(Ln42;Lcom/picacg/network/pica/model/PicaResponse;)V
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ln42;",
            "Lcom/picacg/network/pica/model/PicaResponse<",
            "TT;>;)V"
        }
    .end annotation

    .line 1
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 2
    .line 3
    .line 4
    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 5
    .line 6
    .line 7
    iget-object v0, p0, Lcom/picacg/network/pica/model/PicaResponse$$serializer;->descriptor:Lzi5;

    .line 8
    .line 9
    invoke-interface {p1, v0}, Ln42;->c(Lzi5;)Lu91;

    .line 10
    .line 11
    .line 12
    move-result-object p1

    .line 13
    iget-object p0, p0, Lcom/picacg/network/pica/model/PicaResponse$$serializer;->typeSerial0:Lca3;

    .line 14
    .line 15
    invoke-static {p2, p1, v0, p0}, Lcom/picacg/network/pica/model/PicaResponse;->write$Self$app(Lcom/picacg/network/pica/model/PicaResponse;Lu91;Lzi5;Lca3;)V

    .line 16
    .line 17
    .line 18
    invoke-interface {p1, v0}, Lu91;->a(Lzi5;)V

    .line 19
    .line 20
    .line 21
    return-void
.end method