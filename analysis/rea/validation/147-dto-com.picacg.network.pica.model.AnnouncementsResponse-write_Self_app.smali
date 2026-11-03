.method public static final synthetic write$Self$app(Lcom/picacg/network/pica/model/AnnouncementsResponse;Lu91;Lzi5;)V
    .registers 5

    .line 1
    sget-object v0, Lcom/picacg/network/pica/model/AnnouncementsData$$serializer;->INSTANCE:Lcom/picacg/network/pica/model/AnnouncementsData$$serializer;

    .line 2
    .line 3
    iget-object p0, p0, Lcom/picacg/network/pica/model/AnnouncementsResponse;->announcements:Lcom/picacg/network/pica/model/AnnouncementsData;

    .line 4
    .line 5
    check-cast p1, Ltt3;

    .line 6
    .line 7
    const/4 v1, 0x0

    .line 8
    invoke-virtual {p1, p2, v1, v0, p0}, Ltt3;->a0(Lzi5;ILca3;Ljava/lang/Object;)V

    .line 9
    .line 10
    .line 11
    return-void
.end method