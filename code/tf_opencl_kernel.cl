__kernel void tf_calc_hand_kernel (__global float *a, __global float *b, unsigned int nx, unsigned int ny, float coef1, float k) {
   size_t x = get_global_id(0);
   size_t y = get_global_id(1);
   if(x < (nx-1) && y < (ny-1)){
      b[x+y*nx] = coef1 * (k * a[x+(y-1)*nx]\
                        + k * a[x+(y+1)*nx]\
                        + a[x+1+y*nx]\
                        + a[x-1+y*nx]);
   }
}
