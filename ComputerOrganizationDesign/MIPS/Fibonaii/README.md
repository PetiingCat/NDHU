# MIPS Fibonacci Recursive(run in QTspim)
### \# ---int Fibonacci(int n) start--- \#  
*fibonacci:*  
\# Prologue: before caller switch to callee, store the variable of caller   
 *addi $sp, $sp, -12*  
 *sw $ra, 8($sp)*  
 *sw $s0, 4($sp)* \# s0 is argument of input *n*  
 *sw $s1, 0($sp)* \# s1 is return value of *fib(n-1)*  
 
\# callee save argument to local variable    
 *move $s0, $a0*
  
\# Base Case(terminal conditionset)  
 *bgt $s0, 1, Recur* \# s0 <= 1 equal to *branch if s0 > 1*    
 *move $v0, $s0* \# directly return the value, when s0 = 1 | 0   
 *addi $sp, $sp, 12*  
 *jr $ra*  
  
*Recur:* \# return (fib(n-1)+fib(n-2))  
 *addi $a0, $s0, -1* \# a0 = n-1  
 *jal fibonacci* \# call fib(n-1)  
 *move $s1, $v0* \# v0 = the *return value* of fib(n-1).  
\#We'll going to call callee(fib(n-2)), *if we don't save* returns of fib(n-1) *in stack*, this value will *be gone*.     
 
 *blt $s0, 2, SetZero* \# use (s0<2)? (s0=0) : (s0-=2); setting argument ready to call fib(n-2)  
\# MIPS's operation has problem on addi negation overflow, it can't express minus to 0 and stop.  
\# So this place I divide in two conditions to deal with.    
 *addi $a0, $s0, -2* \# (n-2) is greater than or equal to 0  
 *beq $zero, $zero, JumpLine*   
 *SetZero:* \# (n-2) is less than 0  
 *li $a0, 0*  
 *JumpLine:*  
 *jal fibonacci* \# call fib(n-2)  
 *move $t0, $v0* v0 = the *return value* of fib(n-2).    
 
 *add $v0, $s1, $t0* \#add 2 results on return value v0 
 
\# Epilogue: before callee switch to caller, recovery the variables  
 *lw $s1, 0($sp)*  
 *lw $s0, 4($sp)*  
 *lw $ra, 8($sp)*  
 *addi $sp, $sp, 12*  
 *jr $ra*  
### \# ---End of funct Fibonacci--- \# 