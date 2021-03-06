# ---------- Data Segment ----------
.data
# Define the string messages and the array
msg1:    .asciiz "Please input the decimal integer:\n"
msg2:    .asciiz "The binary representation is:\n"
space:   .asciiz " "
newline: .asciiz "\n"

bin:     .byte 0:33 # the string of binary representation

# ---------- Text Segment ----------
.text
.globl main
main:
    la $s0, bin # load the base address of the binary string
    li $s1, 48 # ASCII value of '0'
    li $s2, 49 # ASCII value of '1'

    # print message 1
    li $v0, 4
    la $a0, msg1
    syscall
    
    # read integer
    li $v0, 5
    syscall
    add $a0, $v0, $zero
    
    jal to_binary
    
    jal print_binary
    
    li $v0, 10
    syscall
    
# ---------- TODO begin ----------
# complete the to_binary procedure
# parameter $a0 is the decimal number
# you can use $s1 and $s2, which are character '0' and '1'
# 1. you should store the binary representation in $s0 (base address of the bin array)
to_binary:
	
#Huang Daoji 16/03
# To do list:
#    [x] run and test
#    [x] full comments
#    [x] optimization
#          [x] reduce redundant registers	
#          [x] control flow optimization
#    [x] test case: 1, 2, 1024, MAX_INT, MIN_INT, MIN_INT + 1, 2611, -2611

	# save registers
	addi $sp, $sp, -16
	sw $s3, 12($sp)
	sw $s4, 8($sp)
	sw $s5, 4($sp)
	sw $ra, 0($sp)

	# $s4 for x
	add $s4, $zero, $a0
	li $t1, -2147483648
	bne $s4, $t1, L1
	
	# for in the first if
	sb $s2, 0($s0)
	# $t1 for i
	addi $t1, $zero, 1
	j Cond_1
	Body_1: 
		# save '0' to bin[i]
		add $t2, $t1, $s0
		sb $s1, 0($t2)
	Inc_1:
		addi $t1, $t1, 1
	Cond_1:
		blt $t1, 32, Body_1
	# end of for
	j Return

L1:
	add $s5, $s4, $zero
	bge $s4, $zero, L2
	# -x = ~x + 1
	not $s4, $s4
	addi $s4, $s4, 1
	# from here, $s4 for ans_x, $s5 for x

L2:
	# the second for
	addi $t1, $zero, 31
	j Cond_2
	Body_2:
		andi $t2, $s4, 1
		add $t3, $s0, $t1
		beqz $t2, Else_1
			# if abs_x & 1 == 1, execute here
			sb $s2, 0($t3)
			j Next_if
		Else_1:
			sb $s1, 0($t3)
		Next_if:
			srl $s4, $s4, 1
	Inc_2:
		addi $t1, $t1, -1
	Cond_2:
		bgez $t1, Body_2
	
	# x >= 0, return 
	bgez $s5, Return
		# x < 0 here
		# $t1 for i
		addi $t1, $zero, 31
		j Cond_3
		Body_3:
			add $t2, $t1, $s0
			lb $t3, 0($t2)
			beq $t3, $s1, Else_2
				sb $s1, 0($t2)
				j Inc_3
			Else_2:
				sb $s2, 0($t2)
		Inc_3:
			addi $t1, $t1, -1
		Cond_3:
			bgez $t1, Body_3
		
		jal add_one

Return:
	# restore the saved registers
	lw $s3, 12($sp)
	lw $s4, 8($sp)
	lw $s5, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 16
    jr $ra # last line of to_binary
# ---------- TODO end ----------

# add_one procedure: add one to the binary pattern
# directly operates on bin, no arguments or return values
add_one:
    addi $t0, $s0, 31
    li $t1, 31
    
    for_add:
        bltz $t1, end_for_add
        lbu $t2, ($t0)
        
        beq $t2, $s2, if_one
            sb $s2, ($t0)
            j end_for_add
        if_one:
            sb $s1, ($t0)
        
        addi $t0, $t0, -1
        addi $t1, $t1, -1
        j for_add
    end_for_add:
    
    jr $ra

print_binary:
    li $t0, 0
    sb $t0, 32($s0)

    li $v0, 4
    la $a0, msg2
    syscall
    
    li $v0, 4
    la $a0, bin
    syscall

    li $v0, 4
    la $a0, newline
    syscall
    
    jr $ra
