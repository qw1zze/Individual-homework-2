.macro check_program_f(%label, %cases, %end)
	la a0 %label
	li a7 4
	ecall #print label
	
	li s5 0 #count opf passed
	li s6 0 #count of all
f_loop:
	fld ft1, (%cases)
  	f(ft1) 
	fmv.d ft1, fa0 # find result
	fld ft2, 8(%cases) # load correct result
  	fsub.d ft3, ft1, ft2 
  	fabs.d ft3 ft3
  	flt.d t4, ft3, fs1 #compare results

 	bnez t4, f_test_passed  
 	li a7, 4 
  	la a0, error_msg 
  	ecall # tast failed
  	j f_test_failed

f_test_passed:
	li a7, 4
	la a0, pass_msg 
	ecall # test passed
	addi s5 s5 1 # add cortrect test

f_test_failed:
	addi s6 s6 1 #count tests
	addi %cases, %cases, 16
	blt %cases,  %end, f_loop # go to next test

	la a0 count_passed
	li a7 4
	ecall
	
	mv a0 s5
	li a7 1
	ecall
	
	la a0 of
	li a7 4
	ecall

	mv a0 s6
	li a7 1
	ecall

.end_macro

.macro check_program_find_x(%label, %cases, %end)
	la a0 %label
	li a7 4
	ecall #print label
	
	li s5 0 #count opf passed
	li s6 0 #count of all
f_loop:
	fld ft1, (%cases)
	fld ft2, 8(%cases)
	fld fs1, 16(%cases)
  	find_x(ft1, ft2, fs1, f) 
	fmv.d ft1, fa0 # find result
	fld ft2, 24(%cases) # load correct result
  	fsub.d ft3, ft1, ft2 
  	fabs.d ft3 ft3
  	flt.d t4, ft3, fs1 #compare results
 	bnez t4, f_test_passed  
 	li a7, 4 
  	la a0, error_msg 
  	ecall # tast failed
  	j f_test_failed

f_test_passed:
	li a7, 4
	la a0, pass_msg 
	ecall # test passed
	addi s5 s5 1 # add cortrect test

f_test_failed:
	addi s6 s6 1 #count tests
	addi %cases, %cases, 32
	blt %cases,  %end, f_loop # go to next test

	la a0 count_passed
	li a7 4
	ecall
	
	mv a0 s5
	li a7 1
	ecall
	
	la a0 of
	li a7 4
	ecall

	mv a0 s6
	li a7 1
	ecall
.end_macro

.macro check_program_check_int(%label, %cases, %end)
	la a0 %label
	li a7 4
	ecall #print label
	
	li s5 0 #count opf passed
	li s6 0 #count of all
f_loop:
	fld ft1, (%cases)
	fld ft2, 8(%cases)
  	check_interval(ft1, ft2, f) 
	mv t1, a0 # find result
	lw t2, 16(%cases) # load correct result
	
 	beq t1, t2, f_test_passed  
 	li a7, 4 
  	la a0, error_msg 
  	ecall # tast failed
  	j f_test_failed

f_test_passed:
	li a7, 4
	la a0, pass_msg 
	ecall # test passed
	addi s5 s5 1 # add cortrect test

f_test_failed:
	addi s6 s6 1 #count tests
	addi %cases, %cases, 24
	blt %cases,  %end, f_loop # go to next test

	la a0 count_passed
	li a7 4
	ecall
	
	mv a0 s5
	li a7 1
	ecall
	
	la a0 of
	li a7 4
	ecall

	mv a0 s6
	li a7 1
	ecall
.end_macro