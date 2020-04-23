#----------------------------#
#	algorithm: Selection Sort
#	version: While Loop
#	Designer: 41053A041 Kuihao Chang
#	Describe how this sorting algorithm work?
#		1. Traverse the array and record the minimum value's position.
#		2. Swap the position between the unsorted number and the current minimum.
#		3. Repeat this algorithm until all number sorted(looping).
#		4. Time Complexity: Ο(n^2) theta(n^2) omega(n^2); Space Complexity: Ο(1)
#
#-- Register interpretation --#
#
#	$s0: array variable(a[0]) || procedure variable
#	$s1: array.length || procedure variable
#	$s2: procedure variable
#	$s3: procedure variable
#	$s4: procedure variable
#	$t0, t1, t2, t3, t4: temporary variable
#	$a0, $a1: transfering variable
#
#---------- C code -----------#
#
#	void selectionSort(int arr[], int n) 
#	{ 
#	    int i, j, min_idx; 
#	  
#	    // One by one move boundary of unsorted subarray 
#	    for (i = 0; i < n-1; i++) 
#	    { 
#	        // Find the minimum element in unsorted array 
#	        min_idx = i; 
#	        for (j = i+1; j < n; j++) 
#	          if (arr[j] < arr[min_idx]) 
#	            min_idx = j; 
#	  
#	        // Swap the found minimum element with the first element 
#	        swap(&arr[min_idx], &arr[i]); 
#	    } 
#	} 
#
#--- use gcc style to write ---#(rightest is label, a tab in the middle of instruction and operators)#
	.data
prompt0: .asciiz "Welcome to Selection Sorting Service.\n"
prompt1: .asciiz "Please type a number into array.(type 0 to end the input)\n"
prompt2: .asciiz "The Original array is:\n"
prompt3: .asciiz "The sorted array is:\n"
space: .asciiz " "
CRLF: .asciiz "\n"
ByeBye: .asciiz "The service is done. See you next time.\n"
alart: .asciiz "=-=-=-= alart! =-=-=-=\n"
length: .word 0
array: .word 0

	.text
	.globl	main

main:
# Print prompt
	li		$v0, 4
	la		$a0, prompt0
	syscall
	
## Input start:
	la		$s0, array
	lw		$s1, length

InputNumber:
# Print prompt
	li		$v0, 4
	la		$a0, prompt1
	syscall
	
# Read integer
	li		$v0, 5
	syscall
	
	beq		$v0, $zero, exit_input # input 0 -> break Loop
	
	sw		$v0, 0($s0) # v0(input) -> array[]
	addi	$s0, $s0, 4 # v0+=4 -> array[index++]
	addi	$s1, $s1, 1 # array.length++
	
	b		InputNumber #Input Loop
## End of input;
	
exit_input:
	sw		$s1, length # save final array.length
	
## Output1 start: (Show original array)
	la		$s0, array
	li		$t0, 0 # count loop of output
	
# Print prompt
	li		$v0, 4
	la		$a0, prompt2
	syscall

OutputOriginal:
	beq		$t0, $s1, exit_output_original
	
	# Print integer
	li		$v0, 1
	lw		$a0, 0($s0)
	syscall

	# Print space
	li		$v0, 4
	la		$a0, space
	syscall
	
	addi	$s0, $s0, 4
	addi	$t0, $t0, 1 # count++
	b		OutputOriginal
## End of Output1;

exit_output_original:
# Print CRLF
	li		$v0, 4
	la		$a0, CRLF
	syscall
		
# call SelectionSort
	la		$a0, array
	lw		$a1, length
	jal		SelectionSort
	
## Output2 start: (Show sorted array)
	la		$s0, array
	li		$t0, 0 # count loop of output 
	
# Print prompt
	li		$v0, 4
	la		$a0, prompt3
	syscall
	
OutputNumber:
	beq		$t0, $s1, Exit
	
# Print integer
	li		$v0, 1
	lw		$a0, 0($s0)
	syscall
	
# Print space
	li		$v0, 4
	la		$a0, space
	syscall

	addi	$s0, $s0, 4
	addi	$t0, $t0, 1
	b		OutputNumber
## End of Output2;
	
## Exit start:
Exit:
# Print CRLF
	li		$v0, 4
	la		$a0, CRLF
	syscall
	
# Print leaving msg
	li		$v0, 4
	la		$a0, ByeBye
	syscall
	
	li		$v0, 10
	syscall
## End Of File;

	
#--- funct area ---#
## SWAP start:
# SWAP (&arr[a1], &arr[a2])
SWAP:
	# $t1 = &arr[a1]
	sll		$t1, $a1, 2		
	add		$t1, $a0, $t1
	# $t2 = &arr[a2]	
	sll		$t2, $a2, 2		
	add		$t2, $a0, $t2	
	# swap
	lw		$t3, 0($t1)    	
	lw		$t4, 0($t2)		
	sw		$t4, 0($t1)    	
	sw		$t3, 0($t2) 		
	jr		$ra
## End of SWAP;

## SelectionSort start:
# void selectionSort (int arr[], int n) 
SelectionSort:
	addi 	$sp, $sp, -12
	sw		$s0, 0($sp)
	sw		$s1, 4($sp)
	sw		$ra, 8($sp)	# this is a non-leaf procedure( call swap later)
	
	move	$s0, $a0 # array variable address
	move	$s1, $a1 # array.length #log: this can be substitude by label "length" to reduce "space utilization"
	# i -> $s2: current ptr to unsorting number(range from 0 to n-1)
	# j -> $s3: current ptr to i+1(range from 1 to n)
	# minimum -> $s4: ptr to record the number of the current minimum value
	# (n-1) -> s5: array.length-1
	
	# for: i = 0
	li		$s2, 0
	addi	$s5, $s1, -1
	
Loop1:
	# for: i < n-1
	slt		$t1 ,$s2, $s5
	beq		$t1, $zero, exit_Loop1
	# min_idx = i
	move 	$s4, $s2
	# for: j = i+1
	addi	$s3, $s2, 1
	
Loop2:
	# for: j < n
	slt		$t1 ,$s3, $s1 
	beq		$t1, $zero, exit_Loop2
	# $t3 = arr[j]
	sll		$t3, $s3, 2
	add		$t3, $s0, $t3
	lw		$t5, 0($t3)
	# $t4 = arr[min_idx]
	sll		$t4, $s4, 2
	add		$t4, $s0, $t4
	lw		$t6, 0($t4)
	# if: arr[j] < arr[min_idx]
	slt 	$t1, $t5, $t6
	beq		$t1, $zero, flyover
	# min_idx = j
	move	$s4, $s3
	
flyover:
	# endfor: j++
	addi 	$s3, $s3, 1
	b Loop2
	
exit_Loop2:
	# SWAP(&arr[min_idx], &arr[i])
	move	$a0, $s0
	move	$a1, $s4
	move	$a2, $s2
	jal		SWAP
	# endfor: i++
	addi	$s2, $s2, 1
	b		Loop1
	
exit_Loop1:
	lw		$s0, 0($sp)
	lw		$s1, 4($sp)
	lw		$ra, 8($sp)
	addi	$sp, $sp, 12
	jr		$ra
## End of SelectionSort;

#-------- Discussion ---------#
# Be careful about useing branch and jump-and-link. if you want to come back, use jal.
# Be as sharp as a tack, slt(A < B) --> True, then beq(True==$zero) --> False, code move on don't branch.
# Be careful about useing la and lw, la is dangerous that "load address" might make system read illwgal memory section.