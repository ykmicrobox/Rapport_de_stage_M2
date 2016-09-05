; ModuleID = 'calc_jacobi_spir_kernel.bc'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024"
target triple = "spir64-unknown-unknown"

define cc76 void @tf_calc_hand_kernel(float addrspace(1)* %a, float addrspace(1)* %b, i32 %nx, i32 %ny, float %coef1, float %k) #0 {
entry:
  %call = call cc75 i64 @_Z13get_global_idj(i32 0) #1
  %call1 = call cc75 i64 @_Z13get_global_idj(i32 1) #1
  %conv = zext i32 %nx to i64
  %sub = sub i64 %conv, 1
  %cmp = icmp ult i64 %call, %conv
  br i1 %cmp, label %land.lhs.true, label %if.end

land.lhs.true:                                   ; preds = %entry
  %conv2 = zext i32 %ny to i64
  %sub3 = sub i64 %conv2, 1
  %cmp4 = icmp ult i64 %call1, %sub3
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %mul = mul i64 %call1, %conv
  %add = add i64 %call, %mul
  %sub5 = sub i64 %add, %conv
  %arrayidx = getelementptr inbounds float addrspace(1)* %a, i64 %sub5
  %0 = load float addrspace(1)* %arrayidx, align 4
  %mul6 = fmul float %k, %0
  %add7 = add i64 %add, %conv
  %arrayidx8 = getelementptr inbounds float addrspace(1)* %a, i64 %add7
  %1 = load float addrspace(1)* %arrayidx8, align 4
  %mul9 = fmul float %k, %1
  %add10 = fadd float %mul6, float %mul9
  %add11 = add i64 %add, 1
  %arrayidx12 = getelementptr inbounds float addrspace(1)* %a, i64 %add11
  %2 = load float addrspace(1)* %arrayidx12, align 4
  %add13 = fadd float %add10, %2
  %sub14 = sub i64 %add, 1
  %arrayidx15 = getelementptr inbounds float addrspace(1)* %a, i64 %sub14
  %3 = load float addrspace(1)* %arrayidx15, align 4
  %add16 = fadd float %add13, %3
  %mul17 = fmul float %coef1, %add16
  %arrayidx18 = getelementptr inbounds float addrspace(1)* %b, i64 %add
  store float %mul17, float addrspace(1)* %arrayidx18, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %land.lhs.true, %entry
  ret void
}

; Function Attrs: nounwind readnone
declare cc75 i64 @_Z13get_global_idj(i32) #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }

!opencl.kernels = !{!0}
!opencl.compiler.options = !{!7}

!0 = metadata !{void (float addrspace(1)*, float addrspace(1)*, i32, i32, float, float)* @tf_calc_hand_kernel, metadata !1, metadata !2, metadata !3, metadata !4, metadata !5, metadata !6}
!1 = metadata !{metadata !"kernel_arg_addr_space", i32 1, i32 1, i32 0, i32 0, i32 0, i32 0}
!2 = metadata !{metadata !"kernel_arg_access_qual", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none", metadata !"none"}
!3 = metadata !{metadata !"kernel_arg_type", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"uint", metadata !"float", metadata !"float"}
!4 = metadata !{metadata !"kernel_arg_type_qual", metadata !"", metadata !"", metadata !"", metadata !"", metadata !"", metadata !""}
!5 = metadata !{metadata !"kernel_arg_base_type", metadata !"float*", metadata !"float*", metadata !"uint", metadata !"uint", metadata !"float", metadata !"float"}
!6 = metadata !{metadata !"kernel_arg_name", metadata !"a", metadata !"b", metadata !"nx", metadata !"ny", metadata !"coef1", metadata !"k"}
!7 = metadata !{metadata !"-cl-kernel-arg-info"}
