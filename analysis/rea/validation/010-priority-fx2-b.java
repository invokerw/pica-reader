    /* JADX WARN: Code duplicated, block: B:386:0x08f9 A[DONT_INVERT] */
    /* JADX WARN: Code duplicated, block: B:387:0x08fb  */
    /* JADX WARN: Code duplicated, block: B:589:0x0912 A[SYNTHETIC] */
    /* JADX WARN: Code duplicated, block: B:596:0x08fd A[SYNTHETIC] */
    /* JADX WARN: Type inference fix 'apply assigned field type' failed
    java.lang.UnsupportedOperationException: ArgType.getObject(), call class: class jadx.core.dex.instructions.args.ArgType$ArrayArg
    	at jadx.core.dex.instructions.args.ArgType.getObject(ArgType.java:596)
    	at jadx.core.dex.attributes.nodes.ClassTypeVarsAttr.getTypeVarsMapFor(ClassTypeVarsAttr.java:35)
    	at jadx.core.dex.nodes.utils.TypeUtils.replaceClassGenerics(TypeUtils.java:177)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.insertExplicitUseCast(FixTypesVisitor.java:397)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.tryFieldTypeWithNewCasts(FixTypesVisitor.java:359)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.applyFieldType(FixTypesVisitor.java:309)
    	at jadx.core.dex.visitors.typeinference.FixTypesVisitor.visit(FixTypesVisitor.java:94)
     */
    public static fx2 b(e75 e75Var, Class cls, Method method) {
        Type genericReturnType;
        boolean z;
        boolean z2;
        boolean z3;
        iq2 iq2Var;
        int i;
        int i2;
        iq2[] iq2VarArr;
        int i3;
        int i4;
        iq2 hc4Var;
        iq2 dc4Var;
        yb4 yb4Var;
        yb4 yb4Var2;
        t55 t55Var = new t55(e75Var, cls, method);
        Annotation[] annotationArr = t55Var.d;
        int length = annotationArr.length;
        int i5 = 0;
        int i6 = 0;
        while (true) {
            String str = "HEAD";
            boolean z4 = true;
            iq2 iq2Var2 = null;
            if (i6 >= length) {
                if (t55Var.o == null) {
                    throw tt3.m0(method, null, "HTTP method annotation is required (e.g., @GET, @POST, etc.).", new Object[0]);
                }
                if (!t55Var.p) {
                    if (t55Var.r) {
                        throw tt3.m0(method, null, "Multipart can only be specified on HTTP methods with request body (e.g., @POST).", new Object[0]);
                    }
                    if (t55Var.q) {
                        throw tt3.m0(method, null, "FormUrlEncoded can only be specified on HTTP methods with request body (e.g., @POST).", new Object[0]);
                    }
                }
                Annotation[][] annotationArr2 = t55Var.e;
                int length2 = annotationArr2.length;
                t55Var.w = new iq2[length2];
                int i7 = length2 - 1;
                int i8 = 0;
                while (i8 < length2) {
                    iq2[] iq2VarArr2 = t55Var.w;
                    Type type = t55Var.f[i8];
                    Annotation[] annotationArr3 = annotationArr2[i8];
                    int i9 = i8 == i7 ? 1 : i5;
                    if (annotationArr3 != null) {
                        int length3 = annotationArr3.length;
                        iq2Var = iq2Var2;
                        int i10 = i5;
                        while (i10 < length3) {
                            Annotation annotation = annotationArr3[i10];
                            Annotation[][] annotationArr4 = annotationArr2;
                            int i11 = length2;
                            if (annotation instanceof ih6) {
                                t55Var.c(i8, type);
                                if (t55Var.n) {
                                    throw tt3.o0(method, i8, "Multiple @Url method annotations found.", new Object[0]);
                                }
                                if (t55Var.j) {
                                    throw tt3.o0(method, i8, "@Path parameters may not be used with @Url.", new Object[0]);
                                }
                                if (t55Var.k) {
                                    throw tt3.o0(method, i8, "A @Url parameter must not come after a @Query.", new Object[0]);
                                }
                                if (t55Var.l) {
                                    throw tt3.o0(method, i8, "A @Url parameter must not come after a @QueryName.", new Object[0]);
                                }
                                if (t55Var.m) {
                                    throw tt3.o0(method, i8, "A @Url parameter must not come after a @QueryMap.", new Object[0]);
                                }
                                if (t55Var.s != null) {
                                    throw tt3.o0(method, i8, "@Url cannot be used with @%s URL", t55Var.o);
                                }
                                t55Var.n = true;
                                if (type != lx2.class && type != String.class && type != URI.class && (!(type instanceof Class) || !"android.net.Uri".equals(((Class) type).getName()))) {
                                    throw tt3.o0(method, i8, "@Url must be okhttp3.HttpUrl, String, java.net.URI, or android.net.Uri type.", new Object[0]);
                                }
                                hc4Var = new cc4(method, i8, 1);
                                i = i7;
                            } else {
                                i = i7;
                                boolean z5 = annotation instanceof jd4;
                                e75 e75Var2 = t55Var.a;
                                if (z5) {
                                    t55Var.c(i8, type);
                                    if (t55Var.k) {
                                        throw tt3.o0(method, i8, "A @Path parameter must not come after a @Query.", new Object[0]);
                                    }
                                    if (t55Var.l) {
                                        throw tt3.o0(method, i8, "A @Path parameter must not come after a @QueryName.", new Object[0]);
                                    }
                                    if (t55Var.m) {
                                        throw tt3.o0(method, i8, "A @Path parameter must not come after a @QueryMap.", new Object[0]);
                                    }
                                    if (t55Var.n) {
                                        throw tt3.o0(method, i8, "@Path parameters may not be used with @Url.", new Object[0]);
                                    }
                                    if (t55Var.s == null) {
                                        throw tt3.o0(method, i8, "@Path can only be used with relative url on @%s", t55Var.o);
                                    }
                                    t55Var.j = true;
                                    jd4 jd4Var = (jd4) annotation;
                                    String strValue = jd4Var.value();
                                    if (!t55.z.matcher(strValue).matches()) {
                                        throw tt3.o0(method, i8, "@Path parameter name must match %s. Found: %s", t55.y.pattern(), strValue);
                                    }
                                    if (!t55Var.v.contains(strValue)) {
                                        throw tt3.o0(method, i8, "URL \"%s\" does not contain \"{%s}\".", t55Var.s, strValue);
                                    }
                                    e75Var2.e(type, annotationArr3);
                                    hc4Var = new ec4(t55Var.c, i8, strValue, jd4Var.encoded());
                                } else {
                                    i2 = i10;
                                    iq2VarArr = iq2VarArr2;
                                    if (annotation instanceof qq4) {
                                        t55Var.c(i8, type);
                                        qq4 qq4Var = (qq4) annotation;
                                        String strValue2 = qq4Var.value();
                                        boolean zEncoded = qq4Var.encoded();
                                        i3 = i9;
                                        Class clsI0 = tt3.i0(type);
                                        i4 = length3;
                                        t55Var.k = true;
                                        if (!Iterable.class.isAssignableFrom(clsI0)) {
                                            if (clsI0.isArray()) {
                                                e75Var2.e(t55.a(clsI0.getComponentType()), annotationArr3);
                                                yb4Var2 = new yb4(new ac4(2, strValue2, zEncoded), 1);
                                            } else {
                                                e75Var2.e(type, annotationArr3);
                                                hc4Var = new ac4(2, strValue2, zEncoded);
                                            }
                                            str = str;
                                        } else {
                                            if (!(type instanceof ParameterizedType)) {
                                                throw tt3.o0(method, i8, clsI0.getSimpleName() + " must include generic type (e.g., " + clsI0.getSimpleName() + "<String>)", new Object[0]);
                                            }
                                            e75Var2.e(tt3.h0(0, (ParameterizedType) type), annotationArr3);
                                            yb4Var2 = new yb4(new ac4(2, strValue2, zEncoded), 0);
                                        }
                                        hc4Var = yb4Var2;
                                        str = str;
                                    } else {
                                        i3 = i9;
                                        i4 = length3;
                                        if (annotation instanceof sq4) {
                                            t55Var.c(i8, type);
                                            boolean zEncoded2 = ((sq4) annotation).encoded();
                                            Class clsI1 = tt3.i0(type);
                                            t55Var.l = true;
                                            if (Iterable.class.isAssignableFrom(clsI1)) {
                                                if (!(type instanceof ParameterizedType)) {
                                                    throw tt3.o0(method, i8, clsI1.getSimpleName() + " must include generic type (e.g., " + clsI1.getSimpleName() + "<String>)", new Object[0]);
                                                }
                                                e75Var2.e(tt3.h0(0, (ParameterizedType) type), annotationArr3);
                                                yb4Var2 = new yb4(new fc4(zEncoded2), 0);
                                            } else if (clsI1.isArray()) {
                                                e75Var2.e(t55.a(clsI1.getComponentType()), annotationArr3);
                                                yb4Var2 = new yb4(new fc4(zEncoded2), 1);
                                            } else {
                                                e75Var2.e(type, annotationArr3);
                                                hc4Var = new fc4(zEncoded2);
                                            }
                                            hc4Var = yb4Var2;
                                        } else if (annotation instanceof rq4) {
                                            t55Var.c(i8, type);
                                            Class clsI2 = tt3.i0(type);
                                            t55Var.m = true;
                                            if (!Map.class.isAssignableFrom(clsI2)) {
                                                throw tt3.o0(method, i8, "@QueryMap parameter type must be Map.", new Object[0]);
                                            }
                                            Type typeJ0 = tt3.j0(type, clsI2);
                                            if (!(typeJ0 instanceof ParameterizedType)) {
                                                throw tt3.o0(method, i8, "Map must include generic types (e.g., Map<String, String>)", new Object[0]);
                                            }
                                            ParameterizedType parameterizedType = (ParameterizedType) typeJ0;
                                            Type typeH0 = tt3.h0(0, parameterizedType);
                                            if (String.class != typeH0) {
                                                throw tt3.o0(method, i8, "@QueryMap keys must be of type String: " + typeH0, new Object[0]);
                                            }
                                            e75Var2.e(tt3.h0(1, parameterizedType), annotationArr3);
                                            hc4Var = new bc4(method, i8, ((rq4) annotation).encoded(), 2);
                                        } else {
                                            str = str;
                                            if (annotation instanceof vs2) {
                                                t55Var.c(i8, type);
                                                vs2 vs2Var = (vs2) annotation;
                                                String strValue3 = vs2Var.value();
                                                Class clsI3 = tt3.i0(type);
                                                if (Iterable.class.isAssignableFrom(clsI3)) {
                                                    if (!(type instanceof ParameterizedType)) {
                                                        throw tt3.o0(method, i8, clsI3.getSimpleName() + " must include generic type (e.g., " + clsI3.getSimpleName() + "<String>)", new Object[0]);
                                                    }
                                                    e75Var2.e(tt3.h0(0, (ParameterizedType) type), annotationArr3);
                                                    dc4Var = new yb4(new ac4(1, strValue3, vs2Var.allowUnsafeNonAsciiValues()), 0);
                                                } else if (clsI3.isArray()) {
                                                    e75Var2.e(t55.a(clsI3.getComponentType()), annotationArr3);
                                                    dc4Var = new yb4(new ac4(1, strValue3, vs2Var.allowUnsafeNonAsciiValues()), 1);
                                                } else {
                                                    e75Var2.e(type, annotationArr3);
                                                    hc4Var = new ac4(1, strValue3, vs2Var.allowUnsafeNonAsciiValues());
                                                }
                                                hc4Var = dc4Var;
                                            } else if (annotation instanceof xs2) {
                                                if (type == at2.class) {
                                                    hc4Var = new cc4(method, i8, 0);
                                                } else {
                                                    t55Var.c(i8, type);
                                                    Class clsI4 = tt3.i0(type);
                                                    if (!Map.class.isAssignableFrom(clsI4)) {
                                                        throw tt3.o0(method, i8, "@HeaderMap parameter type must be Map or Headers.", new Object[0]);
                                                    }
                                                    Type typeJ1 = tt3.j0(type, clsI4);
                                                    if (!(typeJ1 instanceof ParameterizedType)) {
                                                        throw tt3.o0(method, i8, "Map must include generic types (e.g., Map<String, String>)", new Object[0]);
                                                    }
                                                    ParameterizedType parameterizedType2 = (ParameterizedType) typeJ1;
                                                    Type typeH1 = tt3.h0(0, parameterizedType2);
                                                    if (String.class != typeH1) {
                                                        throw tt3.o0(method, i8, "@HeaderMap keys must be of type String: " + typeH1, new Object[0]);
                                                    }
                                                    e75Var2.e(tt3.h0(1, parameterizedType2), annotationArr3);
                                                    hc4Var = new bc4(method, i8, ((xs2) annotation).allowUnsafeNonAsciiValues(), 1);
                                                }
                                            } else if (annotation instanceof gd2) {
                                                t55Var.c(i8, type);
                                                if (!t55Var.q) {
                                                    throw tt3.o0(method, i8, "@Field parameters can only be used with form encoding.", new Object[0]);
                                                }
                                                gd2 gd2Var = (gd2) annotation;
                                                String strValue4 = gd2Var.value();
                                                boolean zEncoded3 = gd2Var.encoded();
                                                t55Var.g = true;
                                                Class clsI5 = tt3.i0(type);
                                                if (Iterable.class.isAssignableFrom(clsI5)) {
                                                    if (!(type instanceof ParameterizedType)) {
                                                        throw tt3.o0(method, i8, clsI5.getSimpleName() + " must include generic type (e.g., " + clsI5.getSimpleName() + "<String>)", new Object[0]);
                                                    }
                                                    e75Var2.e(tt3.h0(0, (ParameterizedType) type), annotationArr3);
                                                    dc4Var = new yb4(new ac4(0, strValue4, zEncoded3), 0);
                                                } else if (clsI5.isArray()) {
                                                    e75Var2.e(t55.a(clsI5.getComponentType()), annotationArr3);
                                                    dc4Var = new yb4(new ac4(0, strValue4, zEncoded3), 1);
                                                } else {
                                                    e75Var2.e(type, annotationArr3);
                                                    hc4Var = new ac4(0, strValue4, zEncoded3);
                                                }
                                                hc4Var = dc4Var;
                                            } else if (annotation instanceof id2) {
                                                t55Var.c(i8, type);
                                                if (!t55Var.q) {
                                                    throw tt3.o0(method, i8, "@FieldMap parameters can only be used with form encoding.", new Object[0]);
                                                }
                                                Class clsI6 = tt3.i0(type);
                                                if (!Map.class.isAssignableFrom(clsI6)) {
                                                    throw tt3.o0(method, i8, "@FieldMap parameter type must be Map.", new Object[0]);
                                                }
                                                Type typeJ2 = tt3.j0(type, clsI6);
                                                if (!(typeJ2 instanceof ParameterizedType)) {
                                                    throw tt3.o0(method, i8, "Map must include generic types (e.g., Map<String, String>)", new Object[0]);
                                                }
                                                ParameterizedType parameterizedType3 = (ParameterizedType) typeJ2;
                                                int i12 = 0;
                                                Type typeH2 = tt3.h0(0, parameterizedType3);
                                                if (String.class != typeH2) {
                                                    throw tt3.o0(method, i8, "@FieldMap keys must be of type String: " + typeH2, new Object[0]);
                                                }
                                                e75Var2.e(tt3.h0(1, parameterizedType3), annotationArr3);
                                                t55Var.g = true;
                                                hc4Var = new bc4(method, i8, ((id2) annotation).encoded(), i12);
                                            } else if (annotation instanceof xc4) {
                                                t55Var.c(i8, type);
                                                if (!t55Var.r) {
                                                    throw tt3.o0(method, i8, "@Part parameters can only be used with multipart encoding.", new Object[0]);
                                                }
                                                xc4 xc4Var = (xc4) annotation;
                                                t55Var.h = true;
                                                String strValue5 = xc4Var.value();
                                                Class clsI7 = tt3.i0(type);
                                                if (strValue5.isEmpty()) {
                                                    boolean zIsAssignableFrom = Iterable.class.isAssignableFrom(clsI7);
                                                    gc4 gc4Var = gc4.f;
                                                    if (zIsAssignableFrom) {
                                                        if (!(type instanceof ParameterizedType)) {
                                                            throw tt3.o0(method, i8, clsI7.getSimpleName() + " must include generic type (e.g., " + clsI7.getSimpleName() + "<String>)", new Object[0]);
                                                        }
                                                        int i13 = 0;
                                                        if (!jv3.class.isAssignableFrom(tt3.i0(tt3.h0(0, (ParameterizedType) type)))) {
                                                            throw tt3.o0(method, i8, "@Part annotation must supply a name or use MultipartBody.Part parameter type.", new Object[0]);
                                                        }
                                                        hc4Var = new yb4(gc4Var, i13);
                                                    } else if (clsI7.isArray()) {
                                                        if (!jv3.class.isAssignableFrom(clsI7.getComponentType())) {
                                                            throw tt3.o0(method, i8, "@Part annotation must supply a name or use MultipartBody.Part parameter type.", new Object[0]);
                                                        }
                                                        hc4Var = new yb4(gc4Var, 1);
                                                    } else {
                                                        if (!jv3.class.isAssignableFrom(clsI7)) {
                                                            throw tt3.o0(method, i8, "@Part annotation must supply a name or use MultipartBody.Part parameter type.", new Object[0]);
                                                        }
                                                        hc4Var = gc4Var;
                                                    }
                                                } else {
                                                    String[] strArr = {"Content-Disposition", c31.j("form-data; name=\"", strValue5, "\""), "Content-Transfer-Encoding", xc4Var.encoding()};
                                                    at2 at2Var = at2.j;
                                                    at2 at2VarS = lq2.S(strArr);
                                                    if (Iterable.class.isAssignableFrom(clsI7)) {
                                                        if (!(type instanceof ParameterizedType)) {
                                                            throw tt3.o0(method, i8, clsI7.getSimpleName() + " must include generic type (e.g., " + clsI7.getSimpleName() + "<String>)", new Object[0]);
                                                        }
                                                        int i14 = 0;
                                                        Type typeH3 = tt3.h0(0, (ParameterizedType) type);
                                                        if (jv3.class.isAssignableFrom(tt3.i0(typeH3))) {
                                                            throw tt3.o0(method, i8, "@Part parameters using the MultipartBody.Part must not include a part name in the annotation.", new Object[0]);
                                                        }
                                                        yb4Var = new yb4(new dc4(method, i8, at2VarS, e75Var2.c(typeH3, annotationArr3, annotationArr)), i14);
                                                    } else if (clsI7.isArray()) {
                                                        Class clsA = t55.a(clsI7.getComponentType());
                                                        if (jv3.class.isAssignableFrom(clsA)) {
                                                            throw tt3.o0(method, i8, "@Part parameters using the MultipartBody.Part must not include a part name in the annotation.", new Object[0]);
                                                        }
                                                        yb4Var = new yb4(new dc4(method, i8, at2VarS, e75Var2.c(clsA, annotationArr3, annotationArr)), 1);
                                                    } else {
                                                        if (jv3.class.isAssignableFrom(clsI7)) {
                                                            throw tt3.o0(method, i8, "@Part parameters using the MultipartBody.Part must not include a part name in the annotation.", new Object[0]);
                                                        }
                                                        dc4Var = new dc4(method, i8, at2VarS, e75Var2.c(type, annotationArr3, annotationArr));
                                                        hc4Var = dc4Var;
                                                    }
                                                    hc4Var = yb4Var;
                                                }
                                            } else if (annotation instanceof yc4) {
                                                t55Var.c(i8, type);
                                                if (!t55Var.r) {
                                                    throw tt3.o0(method, i8, "@PartMap parameters can only be used with multipart encoding.", new Object[0]);
                                                }
                                                t55Var.h = true;
                                                Class clsI8 = tt3.i0(type);
                                                if (!Map.class.isAssignableFrom(clsI8)) {
                                                    throw tt3.o0(method, i8, "@PartMap parameter type must be Map.", new Object[0]);
                                                }
                                                Type typeJ3 = tt3.j0(type, clsI8);
                                                if (!(typeJ3 instanceof ParameterizedType)) {
                                                    throw tt3.o0(method, i8, "Map must include generic types (e.g., Map<String, String>)", new Object[0]);
                                                }
                                                ParameterizedType parameterizedType4 = (ParameterizedType) typeJ3;
                                                Type typeH4 = tt3.h0(0, parameterizedType4);
                                                if (String.class != typeH4) {
                                                    throw tt3.o0(method, i8, "@PartMap keys must be of type String: " + typeH4, new Object[0]);
                                                }
                                                Type typeH5 = tt3.h0(1, parameterizedType4);
                                                if (jv3.class.isAssignableFrom(tt3.i0(typeH5))) {
                                                    throw tt3.o0(method, i8, "@PartMap values cannot be MultipartBody.Part. Use @Part List<Part> or a different value type instead.", new Object[0]);
                                                }
                                                hc4Var = new dc4(method, i8, e75Var2.c(typeH5, annotationArr3, annotationArr), ((yc4) annotation).encoding());
                                            } else if (annotation instanceof z90) {
                                                t55Var.c(i8, type);
                                                if (t55Var.q || t55Var.r) {
                                                    throw tt3.o0(method, i8, "@Body parameters cannot be used with form or multi-part encoding.", new Object[0]);
                                                }
                                                if (t55Var.i) {
                                                    throw tt3.o0(method, i8, "Multiple @Body method annotations found.", new Object[0]);
                                                }
                                                try {
                                                    se1 se1VarC = e75Var2.c(type, annotationArr3, annotationArr);
                                                    t55Var.i = true;
                                                    hc4Var = new zb4(method, i8, se1VarC);
                                                } catch (RuntimeException e) {
                                                    throw tt3.p0(method, e, i8, "Unable to create @Body converter for %s", type);
                                                }
                                            } else if (annotation instanceof b26) {
                                                t55Var.c(i8, type);
                                                Class clsA2 = t55.a(tt3.i0(type));
                                                for (int i15 = i8 - 1; i15 >= 0; i15--) {
                                                    iq2 iq2Var3 = t55Var.w[i15];
                                                    if ((iq2Var3 instanceof hc4) && ((hc4) iq2Var3).f.equals(clsA2)) {
                                                        throw tt3.o0(method, i8, "@Tag type " + clsA2.getName() + " is duplicate of " + ai4.b.o(i15, method) + " and would always overwrite its value.", new Object[0]);
                                                    }
                                                }
                                                hc4Var = new hc4(clsA2);
                                            } else {
                                                hc4Var = null;
                                            }
                                        }
                                        str = str;
                                    }
                                }
                                if (hc4Var != null) {
                                    if (iq2Var == null) {
                                        throw tt3.o0(method, i8, "Multiple Retrofit annotations found, only one allowed.", new Object[0]);
                                    }
                                    iq2Var = hc4Var;
                                }
                                i10 = i2 + 1;
                                annotationArr2 = annotationArr4;
                                i7 = i;
                                length2 = i11;
                                i9 = i3;
                                str = str;
                                iq2VarArr2 = iq2VarArr;
                                length3 = i4;
                            }
                            i2 = i10;
                            iq2VarArr = iq2VarArr2;
                            i3 = i9;
                            i4 = length3;
                            if (hc4Var != null) {
                                if (iq2Var == null) {
                                    throw tt3.o0(method, i8, "Multiple Retrofit annotations found, only one allowed.", new Object[0]);
                                }
                                iq2Var = hc4Var;
                            }
                            i10 = i2 + 1;
                            annotationArr2 = annotationArr4;
                            i7 = i;
                            length2 = i11;
                            i9 = i3;
                            str = str;
                            iq2VarArr2 = iq2VarArr;
                            length3 = i4;
                        }
                    } else {
                        iq2Var = null;
                    }
                    Annotation[][] annotationArr5 = annotationArr2;
                    int i16 = length2;
                    String str2 = str;
                    int i17 = i7;
                    iq2[] iq2VarArr3 = iq2VarArr2;
                    int i18 = i9;
                    if (iq2Var == null) {
                        if (i18 != 0) {
                            try {
                                if (tt3.i0(type) == ne1.class) {
                                    t55Var.x = true;
                                    iq2Var = null;
                                }
                            } catch (NoClassDefFoundError unused) {
                            }
                        }
                        throw tt3.o0(method, i8, "No Retrofit annotation found.", new Object[0]);
                    }
                    iq2VarArr3[i8] = iq2Var;
                    i8++;
                    annotationArr2 = annotationArr5;
                    i7 = i17;
                    length2 = i16;
                    str = str2;
                    i5 = 0;
                    iq2Var2 = null;
                }
                String str3 = str;
                if (t55Var.s == null && !t55Var.n) {
                    throw tt3.m0(method, null, "Missing either @%s URL or @Url parameter.", t55Var.o);
                }
                boolean z6 = t55Var.q;
                if (!z6 && !t55Var.r && !t55Var.p && t55Var.i) {
                    throw tt3.m0(method, null, "Non-body HTTP method cannot contain @Body.", new Object[0]);
                }
                if (z6 && !t55Var.g) {
                    throw tt3.m0(method, null, "Form-encoded method must contain at least one @Field.", new Object[0]);
                }
                if (t55Var.r && !t55Var.h) {
                    throw tt3.m0(method, null, "Multipart method must contain at least one @Part.", new Object[0]);
                }
                u55 u55Var = new u55(t55Var);
                Type genericReturnType2 = method.getGenericReturnType();
                if (tt3.k0(genericReturnType2)) {
                    throw tt3.m0(method, null, "Method return type must not include a type variable or wildcard: %s", genericReturnType2);
                }
                if (genericReturnType2 == Void.TYPE) {
                    throw tt3.m0(method, null, "Service methods cannot return void.", new Object[0]);
                }
                Annotation[] annotations = method.getAnnotations();
                boolean z7 = u55Var.l;
                if (z7) {
                    Type[] genericParameterTypes = method.getGenericParameterTypes();
                    Type typeH6 = ((ParameterizedType) genericParameterTypes[genericParameterTypes.length - 1]).getActualTypeArguments()[0];
                    if (typeH6 instanceof WildcardType) {
                        typeH6 = ((WildcardType) typeH6).getLowerBounds()[0];
                    }
                    if (tt3.i0(typeH6) == r65.class && (typeH6 instanceof ParameterizedType)) {
                        typeH6 = tt3.h0(0, (ParameterizedType) typeH6);
                        z2 = true;
                        z3 = false;
                    } else {
                        if (tt3.i0(typeH6) == ti0.class) {
                            throw tt3.m0(method, null, "Suspend functions should not return Call, as they already execute asynchronously.\nChange its return type to %s", tt3.h0(0, (ParameterizedType) typeH6));
                        }
                        z3 = tt3.p && typeH6 == dg6.class;
                        z2 = false;
                    }
                    genericReturnType = new ji6(null, ti0.class, typeH6);
                    if (!tt3.l0(annotations, qq5.class)) {
                        Annotation[] annotationArr6 = new Annotation[annotations.length + 1];
                        annotationArr6[0] = rq5.a;
                        System.arraycopy(annotations, 0, annotationArr6, 1, annotations.length);
                        annotations = annotationArr6;
                    }
                    z = z3;
                } else {
                    genericReturnType = method.getGenericReturnType();
                    z = false;
                    z2 = false;
                }
                try {
                    vi0 vi0VarA = e75Var.a(genericReturnType, annotations);
                    Type typeC = vi0VarA.c();
                    if (typeC == s65.class) {
                        throw tt3.m0(method, null, "'" + tt3.i0(typeC).getName() + "' is not a valid response body type. Did you mean ResponseBody?", new Object[0]);
                    }
                    if (typeC == r65.class) {
                        throw tt3.m0(method, null, "Response must include generic type (e.g., Response<String>)", new Object[0]);
                    }
                    if (u55Var.d.equals(str3) && !Void.class.equals(typeC) && (!tt3.p || typeC != dg6.class)) {
                        throw tt3.m0(method, null, "HEAD method must use Void or Unit as response type.", new Object[0]);
                    }
                    try {
                        se1 se1VarD = e75Var.d(typeC, method.getAnnotations());
                        si0 si0Var = e75Var.b;
                        if (z7) {
                            return z2 ? new dx2(u55Var, si0Var, se1VarD, vi0VarA, 1) : new ex2(u55Var, si0Var, se1VarD, vi0VarA, z);
                        }
                        return new dx2(u55Var, si0Var, se1VarD, vi0VarA, 0);
                    } catch (RuntimeException e2) {
                        throw tt3.m0(method, e2, "Unable to create converter for %s", typeC);
                    }
                } catch (RuntimeException e3) {
                    throw tt3.m0(method, e3, "Unable to create call adapter for %s", genericReturnType);
                }
            }
            Annotation annotation2 = annotationArr[i6];
            if (annotation2 instanceof pj1) {
                t55Var.b("DELETE", ((pj1) annotation2).value(), false);
            } else if (annotation2 instanceof fn2) {
                t55Var.b("GET", ((fn2) annotation2).value(), false);
            } else if (annotation2 instanceof tr2) {
                t55Var.b("HEAD", ((tr2) annotation2).value(), false);
            } else if (annotation2 instanceof m94) {
                t55Var.b("PATCH", ((m94) annotation2).value(), true);
            } else if (annotation2 instanceof n94) {
                t55Var.b(HlsMediaPlaylist.Interstitial.CUE_TRIGGER_POST, ((n94) annotation2).value(), true);
            } else if (annotation2 instanceof o94) {
                t55Var.b("PUT", ((o94) annotation2).value(), true);
            } else if (annotation2 instanceof e44) {
                t55Var.b("OPTIONS", ((e44) annotation2).value(), false);
            } else if (annotation2 instanceof ur2) {
                ur2 ur2Var = (ur2) annotation2;
                t55Var.b(ur2Var.method(), ur2Var.path(), ur2Var.hasBody());
            } else if (annotation2 instanceof zs2) {
                zs2 zs2Var = (zs2) annotation2;
                String[] strArrValue = zs2Var.value();
                if (strArrValue.length == 0) {
                    throw tt3.m0(method, null, "@Headers annotation is empty.", new Object[0]);
                }
                boolean zAllowUnsafeNonAsciiValues = zs2Var.allowUnsafeNonAsciiValues();
                ys2 ys2Var = new ys2(0);
                int length4 = strArrValue.length;
                int i19 = 0;
                while (i19 < length4) {
                    String str4 = strArrValue[i19];
                    int iIndexOf = str4.indexOf(58);
                    boolean z8 = z4;
                    if (iIndexOf == -1 || iIndexOf == 0 || iIndexOf == str4.length() - 1) {
                        throw tt3.m0(method, null, "@Headers value must be in the form \"Name: Value\". Found: \"%s\"", str4);
                    }
                    String strSubstring = str4.substring(0, iIndexOf);
                    String strTrim = str4.substring(iIndexOf + 1).trim();
                    if ("Content-Type".equalsIgnoreCase(strSubstring)) {
                        try {
                            j35 j35Var = qr3.e;
                            t55Var.u = sq2.x(strTrim);
                        } catch (IllegalArgumentException e4) {
                            throw tt3.m0(method, e4, "Malformed content type: %s", strTrim);
                        }
                    } else if (zAllowUnsafeNonAsciiValues) {
                        ys2Var.c(strSubstring, strTrim);
                    } else {
                        ys2Var.a(strSubstring, strTrim);
                    }
                    i19++;
                    z4 = z8;
                }
                t55Var.t = ys2Var.d();
            } else if (annotation2 instanceof iv3) {
                if (t55Var.q) {
                    throw tt3.m0(method, null, "Only one encoding annotation is allowed.", new Object[0]);
                }
                t55Var.r = true;
            } else if (!(annotation2 instanceof tk2)) {
                continue;
            } else {
                if (t55Var.r) {
                    throw tt3.m0(method, null, "Only one encoding annotation is allowed.", new Object[0]);
                }
                t55Var.q = true;
            }
            i6++;
        }
    }