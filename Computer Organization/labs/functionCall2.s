#------- DATA SEGMENT ----------------
	.data
msg1: .asciiz "This is callee function 1\n"
msg2: .asciiz "This is callee function 2\n"
msg3: .asciiz "Try return to caller function 1 (main)\n"
msg4: .asciiz "All functions completed\n"

#------- TEXT SEGMENT ----------------
	.text
	.globl __start
__start:


# Main function (caller function 1) starts here
	jal callee1       # (1) call function callee1

label1:
	la $a0, msg4
	syscall

# Terminate the program
	li $v0, 10
	syscall

### void callee1( )
callee1:
	# uncomment_solution
	# saving $ra is omitted by intention
	addi $sp,$sp,-4
	sw $ra, 0($sp)   # use the Drop-down List button on Mars' Data Segment window to switch the memory part to "current $sp" in order to display the data of the stack. Where is $ra saved? 
	la $a0, msg1
	li $v0, 4
	syscall
	jal callee2       # (2) - call function callee2

label2:
	# uncomment_solution
	lw $ra, 0($sp)
	addi $sp,$sp,4
	la $a0, msg3
	syscall
	jr $ra # (4) - Expected to return to caller function 1 (main)
### End of function callee1

### void callee2( )
callee2: 
	la $a0, msg2
	syscall
	jr $ra # (3) - Return to function callee1 - (3)
### end of function callee2
