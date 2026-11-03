    public /* synthetic */ AnnouncementsResponse(int i, AnnouncementsData announcementsData, fj5 fj5Var) {
        if (1 == (i & 1)) {
            this.announcements = announcementsData;
        } else {
            pr2.D(i, 1, AnnouncementsResponse$$serializer.INSTANCE.getDescriptor());
            throw null;
        }
    }