.include "macro.s"
.include "macro_tests.s"

.data
f_test_cases:
	.double 1.0 -3.3
	.double 2.0 2.4
	.double -1.0 -5.7
	.double -2.0 -14.4
	.double -5.5 -186.6
	.double 9.9 919.274
f_end_cases:

find_x_test_cases:
	.double 1.0 2.0 0.00001 1.72633
	.double 1.0 2.0 0.001 1.7246
	.double 1.0 2.0 0.000001 1.7263314
	.double -5.0 13.0 0.00001 1.72633
	.double 1.0 13.0 0.001 1.7246
	.double 1.3 1.8 0.000001 1.726331468
find_x_end_cases:

check_int_test_cases:
	.double 1.0 2.0
	.dword 1
	.double 1.0 7.0
	.dword 1
	.double -5.0 1.8
	.dword 1
	.double 3.0 2.0
	.dword 0
	.double 7.0 1.0
	.dword 0
	.double 2.0 2.0
	.dword 0
check_int_end_cases:

eps: .double 0.0001

error_msg: .asciz "Test failed\n"
pass_msg: .asciz "Test passed\n"
testing_f: .asciz "Testing program f:\n\n"
testing_find_x: .asciz "\n\nTesting program find_x:\n\n"
testing_check_int: .asciz "\n\nTesting program check_interval:\n\n"
count_passed: .asciz "\nCount of passed tests: "
of: .asciz " of "
    
.text

fld fs1 eps t0 # load eps
la s0 f_test_cases # load tests for f
la s1 f_end_cases # load end of tests f

check_program_f(testing_f, s0, s1)

la s0 find_x_test_cases # load tests for find_x
la s1 find_x_end_cases # load end of tests find_x

check_program_find_x(testing_find_x, s0, s1)

la s0 check_int_test_cases # load tests for check_interval
la s1 check_int_end_cases # load end of tests check_interval

check_program_check_int(testing_check_int, s0, s1)

li a7 10
ecall
