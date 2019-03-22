	.data
myArray: 			.word 36 56 8 99 54 3 2 9 54 13
myArraySize: 		.word 10
sumMsg:			.asciiz "\nThe sum is "
meanMsg:			.asciiz "\nThe mean is "
maxMsg:			.asciiz "\nThe maximum is "

	.text
	.globl main_
main_:
		
		jal findSum		#Call the procedure to find the sum of myArray
		la $a0, sumMsg		#Output the message
		li $v0, 4
		syscall
						#Output the result

		
						
		jal findMean		#Call the procedure to find the mean of myArray
		la $a0, meanMsg	#Output the message
		li $v0, 4
		syscall
						#Output the result
	
		
			
					
		jal findMax		#Call the procedure to find the maximum of myArray	
		la $a0, maxMsg		#Output the message
		li $v0, 4
		syscall
						#Output the result
	
		
	
								
		li $v0, 10			#Teminate the program
		syscall	


#Procedure to find the sum of myArray				
findSum:	










		jr $ra

#Procedure to find the mean of myArray
findMean: 	




		jr $ra
#Procedure to find the maximum of myArray
findMax:							












		jr $ra