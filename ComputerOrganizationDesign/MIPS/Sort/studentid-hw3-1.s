#--------------------
#	algorithm: QuickSort
#	Designer: 41053A041 Kuihao Chang
#	Describe: This sorting is that
#		1. picking a pivot in the array
#		2. regard array[0] as Low side, array[array.length - 1] as High side 
#		3. let two flags(or call pointers) which are i and j.  
#			i records the last position of value which is less than pivot.
#			j, scaning every value from Lo to Hi, which records the current position.
#			If j is less than or equal to pivot, then swap i and j.
#			Repeat above until i stop and j meet Hi
#			then we find a good position for piovt, swap pivot and i+1, this is "LoHi-sandwich method". yummy~
#		4. Now array is divide in three part, left-array, mid-Pillar and right-array.    
#		5. Choose a new pivot(i.e. means of current array, first one or last one), then repeat above until finish the sorting.
#
#	Register interpretation:
#	$s0: array[0]'s address.
#	$s1: 
#	$t0: temp(flow-ctrl)
#	$t1: i
#	$t2: offset | array[i]
#	$a0, $a1 is temp-type variable.
#--------------------
.data
	prompt0: .asciiz "Welcome to Quick Sorting Service.\n"
	prompt1: .asciiz "Please enter a number into ready-sort array.(enter 0 to end the input process)\n"
	prompt2: .asciiz "The sorted array is:\n"
	space: .asciiz " "
	ByeBye: .asciiz "The service is done. See you next time.\n"
	array: .word 0

.text
.globl main

main:
# Print prompt
li $v0, 4
la $a0, prompt0
syscall

la $s0, array
li $t1, 0

#--Input start--
InputNumber:
beq $t0, $zero, L1 #!!: t2 can substitute t0

	# Print prompt
	li $v0, 4
	la $a0, prompt1
	syscall

	# Read integer
	li $v0, 5
	syscall
	
	sll $t2, $t1, 2
	add $t2, $s0, $t2 
	sw $v0, 0($t2)
	
	move $t0, $t2 
	beq $zero, $zero, InputNumber

#--End of input--
L1:











#---funct below---
SWAP:
xor $a0, $a0, $a1
xor $a1, $a0, $a1
xor $a0, $a0, $a1
	# --XOR------ #
	# A xor A = 0
	# A xor 0 = A
	# A xor B xor A = B
	# --lemma---- #













