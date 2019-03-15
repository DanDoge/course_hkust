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
#    [x] run and test 16/03
#    [ ] full comments
#    [ ] optimization
#          [x] trick: using one unsigned instruction checking 0 < c < 9
#                     refer to MIPS tutorial on its official website
#          [ ] reduce redundant registers

	add $s2, $zero, $zero
	add $s3, $zero, $zero
    add $s4, $zero, $zero
    
Test:
	add $t1, $s2, $s0
	lb $t1, 0($t1)
	beq $t1, $zero, Next_while
	addi $s2, $s2, 1
	j Test
Next_while:
	
	add $t1, $zero, $zero
Body:
    add $t2, $t1, $zero
    add $t2, $t2, $s0
	lb $t2, 0($t2)
	
	addi $t3, $t2, -48
	bgtu $t3, 9, Else
	mul $s4, $s4, 10
	add $s4, $s4, $t3
	j Inc
Else:
		add $t4, $zero, $zero
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
	add $t1, $s1, $s3
	lb $zero, ($t1)

    
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
