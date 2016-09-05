%nd_array_float_t = type opaque

declare <0 x float> @ndarray.load.float.shift(%nd_array_float_t * %a, ...)
declare <0 x float> @llvm.mach.alv.scalar.bcast.v0f32.v1f32 (<1 x float>)

declare void @ndarray.store.float(%nd_array_float_t *, <0 x float>)

; @MASK: Metadata "task" and "ufunc" guide the passes.
; @MASK: "ufunc" get a scratch area as first argument
define void @tf_calc_next_val(%nd_array_float_t *%old, %nd_array_float_t *%new, float %k, float %coef1) #1 #0
{
entry:
  %aalvH = call <0 x float>(%nd_array_float_t*, ...)* @ndarray.load.float.shift(%nd_array_float_t * %old, { i32, i32} {i32 1, i32 -1})
  %aalvG = call <0 x float>(%nd_array_float_t*, ...)* @ndarray.load.float.shift(%nd_array_float_t * %old, { i32, i32} {i32 0, i32 -1})
  %aalvD = call <0 x float>(%nd_array_float_t*, ...)* @ndarray.load.float.shift(%nd_array_float_t * %old, { i32, i32} {i32 0, i32 1})
  %aalvB = call <0 x float>(%nd_array_float_t*, ...)* @ndarray.load.float.shift(%nd_array_float_t * %old, { i32, i32} {i32 1, i32 1})

  ;Prepare the coefficients for larger scales
  %vkelem = insertelement <1 x float> undef, float %k, i32 0
  %vcoefelem =  insertelement <1 x float> undef, float %coef1, i32 0
  %vk = call <0 x float>  @llvm.mach.alv.scalar.bcast.v0f32.v1f32 (<1 x float> %vkelem)
  %vcoef1 = call <0 x float>  @llvm.mach.alv.scalar.bcast.v0f32.v1f32 (<1 x float> %vcoefelem)

  ;Compute coef1*(k*k*aalvB+k*k*aalvH+aalvG+aalvB)
  %vkk = fmul <0 x float> %vk, %vk
  %v1 = fmul <0 x float> %vkk, %aalvB 
  %v2 = fmul <0 x float> %vkk, %aalvH
  %v3 = fadd <0 x float> %v1, %v2 
  %v4 = fadd <0 x float> %aalvD, %v3
  %v5 = fadd <0 x float> %v4, %aalvG
  %vnew = fmul <0 x float> %v5, %vcoef1

  ;Store the results
  call void @ndarray.store.float(%nd_array_float_t * %new, <0 x float> %vnew)
  ret void
}
attributes #0 = { "ufunc" }
attributes #1 = { "task"  }
