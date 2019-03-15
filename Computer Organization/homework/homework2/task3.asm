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
