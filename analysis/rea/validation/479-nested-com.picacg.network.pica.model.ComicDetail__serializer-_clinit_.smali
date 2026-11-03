.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lcom/picacg/network/pica/model/ComicDetail$$serializer;

    .line 2
    .line 3
    invoke-direct {v0}, Lcom/picacg/network/pica/model/ComicDetail$$serializer;-><init>()V

    .line 4
    .line 5
    .line 6
    sput-object v0, Lcom/picacg/network/pica/model/ComicDetail$$serializer;->INSTANCE:Lcom/picacg/network/pica/model/ComicDetail$$serializer;

    .line 7
    .line 8
    const/16 v1, 0x8

    .line 9
    .line 10
    sput v1, Lcom/picacg/network/pica/model/ComicDetail$$serializer;->$stable:I

    .line 11
    .line 12
    new-instance v1, Lqj4;

    .line 13
    .line 14
    const-string v2, "com.picacg.network.pica.model.ComicDetail"

    .line 15
    .line 16
    const/16 v3, 0x18

    .line 17
    .line 18
    invoke-direct {v1, v2, v0, v3}, Lqj4;-><init>(Ljava/lang/String;Lep2;I)V

    .line 19
    .line 20
    .line 21
    const-string v0, "_id"

    .line 22
    .line 23
    const/4 v2, 0x0

    .line 24
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 25
    .line 26
    .line 27
    const-string v0, "_creator"

    .line 28
    .line 29
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 30
    .line 31
    .line 32
    const-string v0, "title"

    .line 33
    .line 34
    const/4 v3, 0x1

    .line 35
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 36
    .line 37
    .line 38
    const-string v0, "description"

    .line 39
    .line 40
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 41
    .line 42
    .line 43
    const-string v0, "thumb"

    .line 44
    .line 45
    invoke-virtual {v1, v0, v2}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 46
    .line 47
    .line 48
    const-string v0, "author"

    .line 49
    .line 50
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 51
    .line 52
    .line 53
    const-string v0, "chineseTeam"

    .line 54
    .line 55
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 56
    .line 57
    .line 58
    const-string v0, "categories"

    .line 59
    .line 60
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 61
    .line 62
    .line 63
    const-string v0, "tags"

    .line 64
    .line 65
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 66
    .line 67
    .line 68
    const-string v0, "pagesCount"

    .line 69
    .line 70
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 71
    .line 72
    .line 73
    const-string v0, "epsCount"

    .line 74
    .line 75
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 76
    .line 77
    .line 78
    const-string v0, "finished"

    .line 79
    .line 80
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 81
    .line 82
    .line 83
    const-string v0, "updated_at"

    .line 84
    .line 85
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 86
    .line 87
    .line 88
    const-string v0, "created_at"

    .line 89
    .line 90
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 91
    .line 92
    .line 93
    const-string v0, "allowDownload"

    .line 94
    .line 95
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 96
    .line 97
    .line 98
    const-string v0, "allowComment"

    .line 99
    .line 100
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 101
    .line 102
    .line 103
    const-string v0, "totalLikes"

    .line 104
    .line 105
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 106
    .line 107
    .line 108
    const-string v0, "totalViews"

    .line 109
    .line 110
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 111
    .line 112
    .line 113
    const-string v0, "totalComments"

    .line 114
    .line 115
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 116
    .line 117
    .line 118
    const-string v0, "viewsCount"

    .line 119
    .line 120
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 121
    .line 122
    .line 123
    const-string v0, "likesCount"

    .line 124
    .line 125
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 126
    .line 127
    .line 128
    const-string v0, "commentsCount"

    .line 129
    .line 130
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 131
    .line 132
    .line 133
    const-string v0, "isFavourite"

    .line 134
    .line 135
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 136
    .line 137
    .line 138
    const-string v0, "isLiked"

    .line 139
    .line 140
    invoke-virtual {v1, v0, v3}, Lqj4;->j(Ljava/lang/String;Z)V

    .line 141
    .line 142
    .line 143
    sput-object v1, Lcom/picacg/network/pica/model/ComicDetail$$serializer;->descriptor:Lzi5;

    .line 144
    .line 145
    return-void
.end method