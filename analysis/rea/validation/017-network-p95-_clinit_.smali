.method static constructor <clinit>()V
    .registers 4

    .line 1
    new-instance v0, Lap4;

    .line 2
    .line 3
    const-string v1, "dataStore"

    .line 4
    .line 5
    const-string v2, "getDataStore(Landroid/content/Context;)Landroidx/datastore/core/DataStore;"

    .line 6
    .line 7
    const-class v3, Lp95;

    .line 8
    .line 9
    invoke-direct {v0, v3, v1, v2}, Lap4;-><init>(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;)V

    .line 10
    .line 11
    .line 12
    sget-object v1, Lg35;->a:Lh35;

    .line 13
    .line 14
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 15
    .line 16
    .line 17
    const/4 v1, 0x1

    .line 18
    new-array v1, v1, [Lba3;

    .line 19
    .line 20
    const/4 v2, 0x0

    .line 21
    aput-object v0, v1, v2

    .line 22
    .line 23
    sput-object v1, Lp95;->c:[Lba3;

    .line 24
    .line 25
    const-string v0, "request_mode_id"

    .line 26
    .line 27
    invoke-static {v0}, Landroidx/datastore/preferences/core/PreferencesKeys;->stringKey(Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;

    .line 28
    .line 29
    .line 30
    move-result-object v0

    .line 31
    sput-object v0, Lp95;->d:Landroidx/datastore/preferences/core/Preferences$Key;

    .line 32
    .line 33
    const-string v0, "selected_dns_line_key"

    .line 34
    .line 35
    invoke-static {v0}, Landroidx/datastore/preferences/core/PreferencesKeys;->stringKey(Ljava/lang/String;)Landroidx/datastore/preferences/core/Preferences$Key;

    .line 36
    .line 37
    .line 38
    move-result-object v0

    .line 39
    sput-object v0, Lp95;->e:Landroidx/datastore/preferences/core/Preferences$Key;

    .line 40
    .line 41
    return-void
.end method