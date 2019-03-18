# ---------- Data Segment ----------
.data
# Define the string messages and the array
msg1:    .asciiz "Please input the string to be decoded:\n"
msg2:    .asciiz "The run-length decoding of the string is:\n"
space:   .asciiz " "
newline: .asciiz "\n"

str1:     .byte 0:1000 # the string before decoding
str2:     .byte 0:1000 # the string after decoding

# ---------- Text Segment ----------
.text
.globl main
main:
    la $s0, str1 # load the base address of str1
    la $s1, str2 # load the base address of str2
    
    # print message 1
    li $v0, 4
    la $a0, msg1
    syscall

    # read string str1
    li $v0, 8
    add $a0, $s0, $zero
    li $a1, 100
    syscall
    
    jal run_length_decode
    
    jal print_str2
    
    li $v0, 10
    syscall

# ---------- TODO begin ----------
# complete the run_length_decode procedure
# input string is stored in $s0 (base address of array str1)
# 1. you should store the decoded string in $s1 (base address of array str2)
# Hint: ASCII values: '0': 48, '9': 57, A': 65, 'Z': 90
run_length_decode:

#Huang Daoji 16/03
# To do list:
#    [x] run and test
#    [x] full comments
#    [x] optimization
#          [x] trick: using one unsigned instruction checking 0 < c < 9
#                     refer to MIPS tutorial on its official website
#          [x] reduce redundant registers
#    [x] test cases: 2C6O1M1P, 12M3I4P5S, 0A, 1A0B1C, 100A

# save the saved registers
	addi $sp, $sp, 12
	sw $s2, 8($sp)
	sw $s3, 4($sp)
	sw $s4, 0($sp)


# $s2 for len, $s3 for k, $s4 for num_letter
	add $s2, $zero, $zero
	add $s3, $zero, $zero
    add $s4, $zero, $zero
   
# while(cond){A} translates into 'cond, A, goto cond' 
Test:
	add $t1, $s2, $s0
	lb $t1, 0($t1)
	beq $t1, $zero, Next_while
	
	addi $s2, $s2, 1
	j Test

# for(init, cond, inc){A} translate into 'init, goto cond, A, inc, cond'
# which is consistant with its meaning in C/C++
Next_while:	
	# $t1 for i
	add $t1, $zero, $zero
	j Cond
Body:
	# $t2 for c, $t3 for c - '0'
    add $t2, $t1, $zero
    add $t2, $t2, $s0
	lb $t2, 0($t2)
	
	addi $t3, $t2, -48
	# best way to compare if 0<=c<=9, as said in MIPS official tutorial
	bgtu $t3, 9, Else
	# cond(in if) is true
		mul $s4, $s4, 10
		add $s4, $s4, $t3
		j Inc
	Else:
		# $t4 for j
		add $t4, $zero, $zero
		j Cond_nested
		Body_nested:
			add $t5, $s3, $s1
			sb $t2, 0($t5)
			addi $s3, $s3, 1
		Inc_nested:
		    addi $t4, $t4, 1
		Cond_nested:
			blt $t4, $s4, Body_nested
			j Next_nested
		Next_nested:
			add $s4, $zero, $zero

Inc:
	addi $t1, $t1, 1

Cond:
	blt $t1, $s2, Body
	j Next_for

Next_for:
	# add the last \0
	add $t1, $s1, $s3
	lb $zero, ($t1)

	# load the saved registers
	lw $s2, 8($sp)
	lw $s3, 4($sp)
	lw $s4, 0($sp)
	addi $sp, $sp, -12
    
    jr $ra # last line of run_length_decode
# ---------- TODO end ----------

print_str2:
    li $v0, 4
    la $a0, msg2
    syscall
    
    li $v0, 4
    la $a0, str2
    syscall
    
    li $v0, 4
    la $a0, newline
    syscall
    
    jr $ra
