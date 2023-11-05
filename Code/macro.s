.data 
half: .double 0.5  # value for constant
two_des: .double 0.2 # value for constant
print_res: .asciz "Finded x - "

#function for getting result specified function f(x) = 0
.macro f(%x)  # x - argument of function, return result
	fld ft4 two_des t0 # declare 0.2
	fld ft5 half t0 # declare 0.5
	li t1 4 
	fcvt.d.w ft6 t1 # declare 4.0
	
	addi sp sp -4 #save ra on stack
	sw ra (sp)

	fmv.d ft1 %x  # move input argument to double
	
	fmul.d ft2 ft1 ft1 # count x 2 degree
	fmul.d ft3 ft2 ft1 # count x 3 degree
	
	fnmsub.d ft3 ft2 ft5 ft3 # count x^3 - 0.5x^2
	fmadd.d ft3 ft4 ft1 ft3 # count  x^3 - 0.5x^2 + 0.2x
	
	fsub.d ft3 ft3 ft6 # count  x^3 - 0.5x^2 + 0.2x - 4
	
	fmv.d fa0 ft3 #load retutn value
	
	lw ra (sp)
	addi sp sp 4 # restore ar
.end_macro

#function for finding the root of the equation, a, b should be corrrect, return the root of the equation
.macro find_x(%a, %b, %eps, %f) # a - left boundaries, b - right boundaries, eps - epsilon, f - function f(x) = 0
loop:
	li t1 2 
	fcvt.d.w ft8 t1 # declare 2.0
	li t1 0
	fcvt.d.w ft9 t1 # declare 0.0

	fsub.d ft3 %b %a 
	fdiv.d ft3 ft3 ft8
	flt.d t1 %eps ft3
	beqz t1 end_loop # check accuracy for ending loop
	
	fadd.d ft4 %a %b
	fdiv.d ft4 ft4 ft8 # count mid of a and b - (a + b) / 2
	
	addi sp sp -12 # save boundaries and min on stack
	fsd %a 8(sp)
	fsd %b 4(sp)
	fsd ft4 (sp)
	
	fmv.d fa0 %a
	%f(fa0) # get result of function for left boundary

	addi sp sp -4 
	fsd fa0 (sp) # save result on stack
	
	fld fa0 4(sp)
	%f(fa0)  # get result of function for mid
	
	fld %a 12(sp)
	fld %b 8(sp)
	fld ft4 4(sp)
	fld ft5 (sp) 
	addi sp sp 16 # restore values a, b, mid, result of first calling func
	
	fmv.d ft6 fa0 # save result of the second func
	
	fmul.d ft5 ft5 ft6
	flt.d t1 ft9 ft5 # count f(a)*f(mid) > 0
	
	beqz t1 second_cond
	fmv.d %a ft4 # if f(a)*f(mid) > 0
	j loop
second_cond:
	fmv.d ft2 ft4 # if f(a)*f(mid) <= 0
	j loop
	
end_loop:
	fmv.d fa0 ft4 # return value
.end_macro

#function for checking the interval for correctness, return 1 if correct and 0 if not
.macro check_interval(%a, %b, %f) # a - left boundary, b - right boundary, f - function
	li t1 0
	fcvt.d.w ft8 t1 # declare 0.0

	addi sp sp -12 # save a b on stack
	fsd %a 8(sp)
	fsd %b 4(sp) 
	
	%f(%a) # call f(a)
	
	fsd fa0 (sp) # save result on stack
	
	fld %b 4(sp) # load b
	%f(%b) # call f(b)
	
	fmv.d ft4 fa0 #save result in ft4
	
	fld %a 8(sp)
	fld %b 4(sp)
	fld ft3 (sp)
	addi sp sp 12 # restore a, b, result of f(a)
	
	fmul.d ft3 ft3 ft4
	fle.d t1 ft3 ft8 # find f(a)*f(b) <= 0 
	 
	flt.d t2 %a %b # find a < b
	
	and t1 t1 t2 # check if both correct
	mv a0 t1 # return result
.end_macro

#print x: Finded x - ...
.macro print_x(%x) # x - input value
	la a0 print_res
	li a7 4
	ecall # print text
	
	fmv.d fa0 %x
	li a7 3 
	ecall # print x
.end_macro
