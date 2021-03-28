#--------------------#
#	algorithm: QuickSort
#	version: Recursion
#	Designer: 41053A041 Kuihao Chang
#	Describe: This sorting is that:
#		1. picking a pivot in the array
#		2. regard array[0] as Low side, array[array.length - 1] as High side 
#		3. let two flags(or call pointers) which are i and j.  
#			i records the last position of value which is less than pivot.
#			j, scaning every value from Lo to Hi, which records the current position.
#			If j is less than or equal to pivot, then swap i and j.
#			Repeat above until i stop and j meet Hi
#			then we find a good position for piovt, swap pivot and i+1, this is "LoHi-sandwich method". yummy~ 0w0
#		4. Now array is divide in three part, left-array, mid-Pillar and right-array.    
#		5. Choose a new pivot(i.e. means of current array, first one or last one), then repeat above until finish the sorting.
#		6. Time Complexity: Ο(n log n)~Ο(n2)  Space Complexity: Ο(log n) ~ Ο(n)
#
#	Register interpretation:
#	$s0: array[0]'s address.
#	$s1: array.length
#	$t0: temp don't care it
#	$t1: temp don't care it
#	$t2: temp don't care it
#	$a0, $a1 is transfering variable.
#--------------------#

.data
	prompt0: .asciiz "Welcome to Quick Sorting Service.\n"
	prompt1: .asciiz "Please enter a number into ready-sort array.(enter 0 to end the input process)\n"
	prompt2: .asciiz "The sorted array is:\n"
	prompt3: .asciiz "The Original array is:\n"
	space: .asciiz " "
	CRLF: .asciiz "\n"
	ByeBye: .asciiz "The service is done. See you next time.\n"
	alart: .asciiz "=-=-=-= alart! =-=-=-=\n"
	#log: asciiz must set before word
	length: .word 0
	array: .word 0


.text
.globl main

#<< set pivot to the tail of array >>#

#--main start--#
#Register: $s0: array[0]'s address. #$s1: array.length
main:
# Print prompt
li $v0, 4
la $a0, prompt0
syscall

#--Input start--#
la $s0, array
lw $s1, length
InputNumber:

	# Print prompt
	li $v0, 4
	la $a0, prompt1
	syscall

	# Read integer
	li $v0, 5
	syscall
	
	beq $v0, $zero, exit_input # input 0 -> break Loop
	
	sw $v0, 0($s0)
	addi $s0, $s0, 4
	addi $s1, $s1, 1
	
	beq $zero, $zero, InputNumber #Input Loop
#--End of input--#
exit_input:
sw $s1, length

		#--Output1 start(just for eazy to read the difference of result)--#
		la $s0, array
		lw $s1, length
		li $t0, 0
		
		# Print prompt
		li $v0, 4
		la $a0, prompt3
		syscall
		
		OutputOriginal:
		beq $t0, $s1, exit_output_original
		
		# Print integer
		li $v0, 1
		lw $a0, 0($s0)
		syscall
	
		# Print space
		li $v0, 4
		la $a0, space
		syscall
		
		addi $s0, $s0, 4
		addi $t0, $t0, 1
		beq $zero, $zero, OutputOriginal
		#--Output1 End--#

exit_output_original:
	# Print CRLF
	li $v0, 4
	la $a0, CRLF
	syscall
	
# call quickSort
la $a0, array
move $a1, $zero
addi $a2, $s1, -1
jal quickSort

#--Output2 start--#
la $s0, array
lw $s1, length
li $t0, 0

# Print prompt
li $v0, 4
la $a0, prompt2
syscall

OutputNumber:
	beq $t0, $s1, Exit
	
	# Print integer
	li $v0, 1
	lw $a0, 0($s0)
	syscall

	# Print space
	li $v0, 4
	la $a0, space
	syscall
	
	addi $s0, $s0, 4
	addi $t0, $t0, 1
	beq $zero, $zero, OutputNumber
#--Output2 End--#

#--Exit--#
Exit:
# Print CRLF
li $v0, 4
la $a0, CRLF
syscall

# Print leaving msg
li $v0, 4
la $a0, ByeBye
syscall

li $v0, 10
syscall
#--EOF--#


#---funct below---#
#--SWAP start--#
#SWAP( $a0=array[], $a1=i, $a2=j ) to swap(A[i],A[j])
SWAP:
sll $t1, $a1, 2		
add $t1, $a0, $t1	
sll $t2, $a2, 2		
add $t2, $a0, $t2	
lw $t3, 0($t1)    	
lw $t4, 0($t2)		
sw $t4, 0($t1)    	
sw $t3, 0($t2) 		
jr $ra
#--End of SWAP--# #log: SWAP is work 2020/04/22#

# --SWAP:XOR- #
# xor $a0, $a0, $a1
# xor $a1, $a0, $a1
# xor $a0, $a0, $a1
# -----------
# A xor A = 0
# A xor 0 = A
# A xor B xor A = B
# ---lemma--- #

#--quickSort start--#
#void quickSort = function(data, left(front), right(end))
#Register: 
quickSort: 
addi $sp, $sp, -16
sw $ra, 0($sp) # Only if callee is caller at the same time, sw $ra
sw $s2, 4($sp)
sw $s6, 8($sp)
sw $s7, 12($sp)

move $s6, $a1 # save argument a1 in s6 
move $s7, $a2 # save argument a2 in s7 

slt $t0 ,$s6, $s7
beq $t0, $zero, exitquickSort
#NC: a0, a1, a2
#move $a0, $a0
 move $a1, $s6
 move $a2, $s7
jal partition
move $s2, $v0 #s2 = pivot

# quickSort(data, left, pivot-1);
#Because later we will use original a2, so save it to protect.
#NC: a0, a1
#move $a0, $a0
 move $a1, $s6
 addi $a2, $s2, -1
jal quickSort

# quickSort(data, pivot+1, right);
# NC a0, a2
#move $a0, $a0
 addi $a1, $s2, 1
 move $a2, $s6
jal quickSort

exitquickSort:
lw $ra, 0($sp) 
lw $s2, 4($sp)
lw $s6, 8($sp)
lw $s7, 12($sp)
addi $sp, $sp, 16
jr $ra
#--End of quickSort--#

#<< smaller than pivot to right, the other to left. Fianl to return pivot's position >>#
#--partition start--#
#var partition = function(data, left, right)
#Register: s0 = i, s1 = j
partition:
addi $sp, $sp, -24
sw $ra, 0($sp) # it may call procedure swap.
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s6, 16($sp)
sw $s7, 20($sp)

move $s6, $a1 # save argument a1 in s6 
move $s7, $a2 # save argument a2 in s7 

sll $t1, $s7, 2
add $t1, $a0, $t1
lw $s2, 0($t1) #var s2 = pivot = array[end] ; we choose the position at the back of array to be pivot

addi $s0, $s6, -1 # $s0 = i = left-1 = front -1 = initialize(index -1) ; i is going to count the numbers which smaller than pivot
add $s1, $zero ,$s6 # $s1 = j = left = front ; j is a ptr to point the current number sequenrially to compare to pivot  
Loop1:
	slt $t0 ,$s1, $s7
	beq $t0, $zero, exit_partition
	
	#if array[j]<pivot, then swap#
	sll $t1, $s1, 2
	add $t1, $a0, $t1
	lw  $t2, 0($t1) # t2 = array[j]
	slt $t0, $t2, $s2 #To find the numbers which is smaller than pivot
	beq $t0, $zero, continue1
	
	addi $s0, $s0, 1 
	#NC a0
	#move $a0, $a0
	 move $a1, $s0
	 move $a2, $s1
	jal SWAP

continue1:
	addi $s1, $s1, 1
	beq $zero, $zero, Loop1
	
exit_partition:
	#NC a0, a2
	addi $s0, $s0, 1
	#move $a0, $a0
	 move $a1, $s0
	 move $a2, $s7
	jal SWAP # move pivot to middle position
move $t0, $s0

lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s6, 16($sp)
lw $s7, 20($sp)
addi $sp, $sp, 24

add $v0, $zero, $t0  #return pivot
jr $ra
#--End of partition--#

#--Discussion: How to speed-up this process--#
# when procedure send arguments, designer should use 
#   local variable to save the value, then argument value can be saved and reuse;
# Or designer can lw the argument from the stack when reuse.
# I'm not sure which one is better, but must better than the code this verson. 2020/04/22