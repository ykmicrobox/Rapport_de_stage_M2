@spirFilename = private unnamed_addr constant [30 x i8] c"tf_calc_next_val_task.spir.bc\00"
@openclPrograms = private global i8* null
@tf_calc_next_val_ocl_kernel = private unnamed_addr constant [28 x i8] c"tf_calc_next_val_ocl_kernel\00"
@tf_calc_next_val_ocl_kernel_handles = global i8* null
@tf_calc_next_val_ocl_kernel1 = private unnamed_addr constant [29 x i8] c"tf_calc_next_val_ocl_kernel1\00"
@tf_calc_next_val_ocl_kernel1_handles = global i8* null
@tf_calc_next_val_ocl_kernel2 = private unnamed_addr constant [29 x i8] c"tf_calc_next_val_ocl_kernel2\00"
@tf_calc_next_val_ocl_kernel2_handles = global i8* null
@tf_calc_next_val_ocl_kernel3 = private unnamed_addr constant [29 x i8] c"tf_calc_next_val_ocl_kernel3\00"
@tf_calc_next_val_ocl_kernel3_handles = global i8* null
@symbol = internal unnamed_addr constant [17 x i8] c"tf_calc_next_val\00"

define void @init_tf_calc_next_val_spir(%bdcr_task_t*) {
entry:
  call void @bdcr_task_implement(%bdcr_task_t* %0, void (i8**, i8*)* @tf_calc_next_val_ocl, i32 2)
  %1 = load i8** @openclPrograms
  %2 = icmp eq i8* %1, null
  br i1 %2, label %load_ocl_program, label %load_ocl_kernel

load_ocl_program:                                 ; preds = %entry
  call void @setup_ocl_program(i8** @openclPrograms, i8* getelementptr inbounds ([30 x i8]* @spirFilename, i64 0, i64 0))
  br label %load_ocl_kernel

load_ocl_kernel:                                  ; preds = %load_ocl_program, %entry
  call void @setup_ocl_kernel(i8** @openclPrograms, i8** @tf_calc_next_val_ocl_kernel_handles, i8* getelementptr inbounds ([28 x i8]* @tf_calc_next_val_ocl_kernel, i64 0, i64 0))
  %3 = load i8** @openclPrograms
  %4 = icmp eq i8* %3, null
  br i1 %4, label %load_ocl_program1, label %load_ocl_kernel2

load_ocl_program1:                                ; preds = %load_ocl_kernel
  call void @setup_ocl_program(i8** @openclPrograms, i8* getelementptr inbounds ([30 x i8]* @spirFilename, i64 0, i64 0))
  br label %load_ocl_kernel2

load_ocl_kernel2:                                 ; preds = %load_ocl_program1, %load_ocl_kernel
  call void @setup_ocl_kernel(i8** @openclPrograms, i8** @tf_calc_next_val_ocl_kernel1_handles, i8* getelementptr inbounds ([29 x i8]* @tf_calc_next_val_ocl_kernel1, i64 0, i64 0))
  %5 = load i8** @openclPrograms
  %6 = icmp eq i8* %5, null
  br i1 %6, label %load_ocl_program3, label %load_ocl_kernel4

load_ocl_program3:                                ; preds = %load_ocl_kernel2
  call void @setup_ocl_program(i8** @openclPrograms, i8* getelementptr inbounds ([30 x i8]* @spirFilename, i64 0, i64 0))
  br label %load_ocl_kernel4

load_ocl_kernel4:                                 ; preds = %load_ocl_program3, %load_ocl_kernel2
  call void @setup_ocl_kernel(i8** @openclPrograms, i8** @tf_calc_next_val_ocl_kernel2_handles, i8* getelementptr inbounds ([29 x i8]* @tf_calc_next_val_ocl_kernel2, i64 0, i64 0))
  %7 = load i8** @openclPrograms
  %8 = icmp eq i8* %7, null
  br i1 %8, label %load_ocl_program5, label %load_ocl_kernel6

load_ocl_program5:                                ; preds = %load_ocl_kernel4
  call void @setup_ocl_program(i8** @openclPrograms, i8* getelementptr inbounds ([30 x i8]* @spirFilename, i64 0, i64 0))
  br label %load_ocl_kernel6

load_ocl_kernel6:                                 ; preds = %load_ocl_program5, %load_ocl_kernel4
  call void @setup_ocl_kernel(i8** @openclPrograms, i8** @tf_calc_next_val_ocl_kernel3_handles, i8* getelementptr inbounds ([29 x i8]* @tf_calc_next_val_ocl_kernel3, i64 0, i64 0))
  ret void
}

define %bdcr_task_t* @create_task_tf_calc_next_val() {
entry:
  %0 = call %bdcr_task_t* @bdcr_task_create()
  call void (%bdcr_task_t*, ...)* @bdcr_task_register(%bdcr_task_t* %0, i32 1, i32 3, i32 0, i32 ptrtoint (float* getelementptr (float* null, i32 1) to i32), i32 ptrtoint (float* getelementptr (float* null, i32 1) to i32), i32 0)
  call void @init_tf_calc_next_val_spir(%bdcr_task_t* %0)
  call void @bdcr_task_set_symbol(%bdcr_task_t* %0, i8* getelementptr inbounds ([17 x i8]* @symbol, i64 0, i64 0))
  ret %bdcr_task_t* %0
}
