    @Override // defpackage.o72
    public final void f(bz4 bz4Var, IOException iOException, boolean z) {
        String str = z ? "换下一个 IP 重试" : "放弃（不再重试）";
        SimpleDateFormat simpleDateFormat = sy2.a;
        String simpleName = iOException.getClass().getSimpleName();
        String message = iOException.getMessage();
        StringBuilder sbQ = zv3.q("NET ", this.b, " ↻ ", str, " ← ");
        sbQ.append(simpleName);
        sbQ.append(": ");
        sbQ.append(message);
        sy2.f(sbQ.toString(), 'W');
    }