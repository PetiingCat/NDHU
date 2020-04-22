MIPS Sort(Quick sort) in QtSpim
========
Problem description:
--------
Sorting a sequence of positive integers enter from the console with one number in one line. The end of the sequence is indicated by a 0 (zero). Then print the sorted result to the console.  

Highligh:
--------
- I'm follow the c++ quicksort code in ( http://alrightchiu.github.io/SecondRound/comparison-sort-quick-sortkuai-su-pai-xu-fa.html ), if you not good at quicksort, this is the reference.
- Be careful of procedure **Partition**, which is also a **non-leaf procedure**, has a callee "**swap**". So be sure to use **lw** and **sw** with memory stack to protect rigisters' values in Partition. 
- Remember that memory is sequencial that claiming variables or labels in *.data section*  have to **reverse order**. Especially, **Array** must in last one because adding locations will overhead the original data(if code in sequence).
- Using **procedure call** must watchout whether the **arguments** will be **re-endue value**. If that so, use $s0~$s7 to save $a0~$a3 at **begining** of the procedure.
- To reduce the using of stack, we can **weite the job-code first** in non-leaf procedure, then consider which register(value) need to be save in stack.
- Only the **callee** which **is also caller** need to save **$ra(31)** in stack.
- Stack is prepare for caller not callee, callee need to use stack because it will break the data of caller.
- Please **follow the rule of MIPS GPR**, that is a manegement of saving data and transfering data. i.e. argument register uses in being assigned, or temparary register uses in a situation of neighbor lines(one is save, anther is send, so qucklly, it will not be change value in the job).
- This sorting code will use **loop**, **if-then-else**, **recursion**, **array**, **memory access** with assembly language.

Listing
--------
[studentid-hw3-2.s](https://github.com/PetiingCat/NDHU/blob/master/ComputerOrganizationDesign/MIPS/Sort/QuickSort/studentid-hw3-2.s)  

Demo(test and run):
--------
![testing image gif](https://github.com/PetiingCat/NDHU/blob/master/ComputerOrganizationDesign/MIPS/Sort/QuickSort/demo.gif)
## Assembly Language Code:
--------
```s
#---funct below---#
#--SWAP start--##like in C: void swap(int A[], int i, int j)
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
#--End of SWAP--# 

#--quickSort start--##like in C: void quickSort(data[], int left/front, int right/end)
quickSort: 
addi $sp, $sp, -16
sw $ra, 0($sp) # Only if callee is at the same time as caller, sw $ra
sw $s2, 4($sp)
sw $s6, 8($sp)
sw $s7, 12($sp)

move $s6, $a1 # save argument a1 in s6 
move $s7, $a2 # save argument a2 in s7 

# call Partition
slt $t0 ,$s6, $s7
beq $t0, $zero, exitquickSort
#NC: a0, a1, a2
#move $a0, $a0
 move $a1, $s6
 move $a2, $s7
jal partition
move $s2, $v0 #s2 = pivot

#Recursion1: quickSort(data, left, pivot-1);
#NC: a0, a1
#move $a0, $a0
 move $a1, $s6
 addi $a2, $s2, -1
jal quickSort

#Recursion2: quickSort(data, pivot+1, right);
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

#<<move small one to front, and move big one to end. To the end, switch pivot to small (array+1), which maen middle position>>#
#--partition start--##like C: int partition(data, left, right)
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
```
Discussion
--------
This is the second assembly code in my life, it is a mess in resource file, even I have trying to edit it or optimize the performance. Maybe someday I will rewrite this code after I'm good at this language.

