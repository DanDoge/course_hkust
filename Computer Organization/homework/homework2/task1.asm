# ---------- Data Segment ----------
.data
# Define the string messages and the array
msg1:    .asciiz "Please input an integer larger than 1:\n"
msg2:    .asciiz "The prime factorization is:\n"
space:   .asciiz " "
newline: .asciiz "\n"

factors: .word 0:20 # array of factors

# ---------- Text Segment ----------
.text
.globl main
main:
    la $s0, factors # load the base address of factors array
    li $s1, 0 # the number of factors

    # print message 1
    li $v0, 4
    la $a0, msg1
    syscall
    
    # read integer
    li $v0, 5
    syscall
    add $a0, $v0, $zero # set parameter of prime_factorization
    
    jal prime_factorization
    
    jal print_factors
    
    # exit
    li $v0, 10
    syscall
    
# ---------- TODO begin ----------
# complete the prime_factorization procedure
# parameter $a0 is the number to be factorized
# 1. you should store factors in $s0 (base address of factors array)
# 2. you should store the number of factors in $s1
prime_factorization:

#Huang Daoji 15/03
# To do list:
#    [x] run and test
#    [x] full comments
#    [x] register using convention
#    [x] optimization
#          [x] replace sll with addi for $t4
#          [x] replace all 0 by $zero, hope it will run faster...
#          [x] reduce redundant registers
#    [x] test case: 2, 2611, 162, 1024, 8, 373

# save $ra
	addi $sp, $sp, -4
	sw $ra, 4($sp)
# y is in $t0, x in $t5, address in $t4
	addi $t0, $zero, 2
	add $t5, $a0, $zero
	add $t4, $zero, $s0
# we translate while(True){A} into 
# While: A goto While, and for the A is a if(){}else{} statment
# we move in the 'goto While' to avoid the case where we have to jump twice
# similar to '.nextlist' method in the book 
# Compilers: Principles Techniques and Tools
While:
	add $a0, $t5, $zero
	add $a1, $t0, $zero
	jal divide
	# if begin
	bne $v1, $zero, Else
		# remainder == 0 case
		sw $t0, 0($t4)
		# let $t4 plus 4 instead of computing it each time
		addi $t4, $t4, 4
		addi $s1, $s1, 1
		add $t5, $v0, $zero
		beq $t5, 1, Return
		j While
		
	Else:
		addi $t0, $t0, 1
		j While
	# if end
		
Return:
# restore $ra
	lw $ra, 4($sp)
	addi $sp, $sp, 4
    jr $ra # last line of prime_factorization
# ---------- TODO end ----------

# the divide procedure
# arguments: $a0 is dividend, $a1 is divisor (both should be positive integer)
# return values: $v0 is quotient, $v1 is remainder
divide:
    li $v0, 0
    div_begin:
    blt $a0, $a1, div_end
        sub $a0, $a0, $a1
        addi $v0, $v0, 1
        j div_begin
    div_end:
    add $v1, $a0, $zero
    jr $ra

print_factors:
    # print message 2
    li $v0, 4
    la $a0, msg2
    syscall
    
    # print all the factors
    li $t0, 0
    add $t1, $s0, $zero # base address of factors array
    for:
        beq $t0, $s1, end_for # all the factors have been printed
        
        li $v0, 1
        lw $a0, ($t1)
        syscall
        
        li $v0, 4
        la $a0, newline
        syscall
        
        addi $t0, $t0, 1
        addi $t1, $t1, 4 # move address to next word
        j for
    end_for:
    
    jr $ra
