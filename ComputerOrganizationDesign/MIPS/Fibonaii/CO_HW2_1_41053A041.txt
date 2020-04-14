# 41053A041 Kuihao Chang
 .data 
IptN: .word 14
OptArray: .word 0xfffffff

 .text
 .globl main # every return value in $v0
main:
# I/O with Data seg. (for(i=0;i<n;i++))
 li $s6, 0 # i
 lw $s7, IptN # n
 la $t1, OptArray #output require

RunTimes:
bgt $s6, $s7, Exit

# call funct Fibonacci
 move $a0, $s6 # before jump-and-link to child-procedure, move n to argument(a0) 
 jal fibonacci # $ra=pc+4, $pc=addr(fibonacci), main is waiting for funct return from v0
 
# Outputing 
 #sw $v0, OptSum # save Fib return value(v0) to OptSum
 sll $t2, $s6, 2
 add $t2, $t2, $t1 
 sw $v0, 0($t2)
 addi $s6, 1
 beq $zero, $zero, RunTimes	
 
# Exit
Exit:
 li $v0, 10
 syscall

#---------funct place--------#

## Funct: int Fibonacci(int n)
fibonacci:
# Prologue: store first before caller switch callee 
 addi $sp, $sp, -12
 sw $ra, 8($sp)
 sw $s0, 4($sp) # s0 is args(n)
 sw $s1, 0($sp) # s1 is return value of fib(n-1)
 
# callee store args to local var
 move $s0, $a0
# Base Case(terminal conditionset)
 bgt $s0, 1, Recurr #s0 <= 1 ~>branch s0 > 1  
 move $v0, $s0 # return value 
 addi $sp, $sp, 12
 jr $ra

Recurr:
# fibonacci: return (fib(n-1)+fib(n-2))
 addi $a0, $s0, -1 # a0 = n-1
 jal fibonacci # fib(n-1)
 move $s1, $v0
 
 blt $s0, 2, SetZero # s0<2 ? 0:-2;
 addi $a0, $s0, -2 # a0 = n-2
 beq $zero, $zero, Fly 
 SetZero:
 li $a0, 0
 Fly:
 jal fibonacci # fib(n-2)
 move $t0, $v0
 
 add $v0, $s1, $t0 #add 2 results ready to return
 
# Epilogue: before callee switch caller, recovery the variables
 lw $s1, 0($sp)
 lw $s0, 4($sp)
 lw $ra, 8($sp)
 addi $sp, $sp, 12
 jr $ra
## End of funct Fibonacci

