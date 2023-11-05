.include "macro.s"

.data
a: .word 1 # left boundary
b: .word 2 # right boundary
eps: .double 0.00001 # epsilon
incorrect_interval: .asciz "The boundaries of the interval are set incorrectly"

.text
fld fs3 eps t0 # declare constant epsilon

lw t1 a
fcvt.d.w ft1 t1 # load a to ft1

lw t1 b
fcvt.d.w ft2 t1 # load b to ft2

addi sp sp -8 # save ft1 ft2 on stack
fsd ft1 4(sp)
fsd ft2 (sp)

check_interval(ft1, ft2, f) # check correctness of the interval, ft1, ft2 - boundaries of interval, f - function, return 0 if it is not correct and 1 if correct

beqz a0 error # if interval is not correct print error

fld ft1 4(sp)
fld ft2 (sp)
addi sp sp 8 # restore ft1 ft2 from stack

find_x(ft1, ft2, fs3, f) # return x, ft1, ft2 - boundaries of an interval, fs3 - epsilon, f - function for f(x) = 0

print_x(fa0) # print x

end_program: # end program
	li a7 10
	ecall

error: # print message:  boudaries are not correct
	la a0 incorrect_interval
	li a7 4
	ecall
	j end_program
