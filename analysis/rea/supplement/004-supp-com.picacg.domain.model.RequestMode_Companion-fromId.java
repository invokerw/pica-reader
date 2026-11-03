        public final RequestMode fromId(String str) {
            Object next;
            Iterator<T> it = getALL().iterator();
            do {
                if (!it.hasNext()) {
                    next = null;
                    break;
                }
                next = it.next();
            } while (!j63.u(((RequestMode) next).getId(), str));
            RequestMode requestMode = (RequestMode) next;
            return requestMode == null ? getDEFAULT() : requestMode;
        }