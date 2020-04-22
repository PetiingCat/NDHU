.data
	prompt0: .asciiz "Welcome to Quick Sorting Service.\n"
	prompt1: .asciiz "Please enter a number into ready-sort array.(enter 0 to end the input process)\n"
	prompt2: .asciiz "The sorted array is:\n"
	space: .asciiz " "
	ByeBye: .asciiz "\nThe service is done. See you next time.\n"
	alart: .asciiz "=-=-=-= alart! =-=-=-=\n"
	#log: asciiz must set before word
	length: .word 0
	array: .word 0


.text
.globl main

%%%%%%%%% old code %%%%%%%%%%%%%

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
## test swap
la $a0, array
add $a1, $zero, $zero
addi $s1, $s1, -1
add $a2, $zero, $s1
jal SWAP

## call quickSort
#la $a0, array
#add $a1, $zero, $zero
#addi $s1, $s1, -1
#add $a2, $zero, $s1
#jal quickSort

#--Output start--#
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
#--Exit--#
Exit:
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
#var quickSort = function(data, left, right)
#Register: 
quickSort: 
addi $sp, $sp, -16#-20
sw $ra, 0($sp) # Only if callee is caller at the same time, sw $ra
sw $s0, 4($sp)
sw $a1, 8($sp)
sw $a2, 12($sp)
#sw $a0, 16($sp)

slt $t0 ,$a1, $a2
beq $t0, $zero, exitquickSort
# NC a0, a1, a2
jal partition
move $s0, $v0 #s0 = pivot

# quickSort(data, left, pivotLocation-1);
# NC a0, a1
addi $a2, $s0, -1
jal quickSort
# quickSort(data, pivotLocation+1, right);
# NC a0, a2
addi $a1, $s0, 1
jal quickSort

exitquickSort:
lw $ra, 0($sp) 
lw $s0, 4($sp)
lw $a1, 8($sp)
lw $a2, 12($sp)
#lw $a0, 16($sp)
addi $sp, $sp, 16#20
jr $ra
#--End of quickSort--#

#<< smaller than pivot to right, the other to left. Fianl to return pivot's position >>#
#--partition start--#
#var partition = function(data, left, right)
#Register: s0 = i, s1 = j
partition:
addi $sp, $sp, -20
sw $ra, 0($sp) # it may call procedure swap.
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $a1, 12($sp)
sw $a2, 16($sp)

addi $s0, $a1, -1 # $s0 = i = left-1
add $s1, $zero ,$a1 # $s1 = j = left

Loop1:
	slt $t0 ,$s1, $a2
	beq $t0, $zero, exit_partition
	
	sll $t1, $s1, 2
	add $t1, $a0, $t1
	sll $t2, $a2, 2
	add $t2, $a0, $t2
	slt $t0, $t1, $t2
	beq $t0, $zero, continue1
	
	addi $s0, $s0, 1 #count the numbers which is smaller than pivot
	#NC a0
	move $a1, $s0
	move $a2, $s1
	jal SWAP

continue1:
	addi $s1, $s1, 1
	beq $zero, $zero, Loop1
	
exit_partition:
	#NC a0
	addi $a1, $s0, 1
	#NC a2 
	jal SWAP # move pivot to middle position
	
addi $v0, $s0, 1 #return pivot

lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $a1, 12($sp)
lw $a2, 16($sp)
addi $sp, $sp, 20
jr $ra
#--End of partition--#
