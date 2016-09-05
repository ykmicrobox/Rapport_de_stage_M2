ndarray<float> sx(argaslong(3));
ndarray<float> sy(argaslong(6));
ndarray<float> zx(argaslong(3));
ndarray<float> zy(argaslong(6));
ndarray<float> x(argaslong(3),argaslong(6));
ndarray<float> y(argaslong(3),argaslong(6));
ndarray<float> cx(argaslong(3),argaslong(6));
ndarray<float> cy(argaslong(3),argaslong(6));
ndarray<float> tmp(argaslong(3),argaslong(6));
ndarray<int> k(argaslong(3),argaslong(6));
int n;
n = argasint(7);
task {
    zx = 0.f;
}
task {
    zy = 0.f;
}
call seq_float(sx,argasfloat(1),argasfloat(2));
call seq_float(sy,argasfloat(4),argasfloat(5));
call outer_plus_float(cx,sx,zy);
call outer_plus_float(cy,zx,sy);
task {
    int i;
    i = 0;
    x = 0.f;
    y = 0.f;
    masked_while (i < n) {
        stopif (x*x+y*y < 4.f);
        tmp = x*x-y*y;
        y = 2.f*y*x + cy;
        x = tmp + cx;
        k = i;
        i = i+1;
    }
}
call nd_array_int_dump(k, "mandel.nda");
