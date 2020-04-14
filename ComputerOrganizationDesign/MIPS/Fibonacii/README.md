# MIPS Fibonacci Recursive(run in QTspim)
### \# ---int Fibonacci(int n) start--- \#  
**fibonacci:**  
_\# Prologue: before caller switch to callee, store the variable of caller_   
 **addi $sp, $sp, -12**  
 **sw $ra, 8($sp)**  
 **sw $s0, 4($sp)** _\# s0 is argument of input **n**_  
 **sw $s1, 0($sp)** _\# s1 is return value of **fib(n-1)**_  
 
_\# callee save argument to local variable_    
 **move $s0, $a0**
  
_\# Base Case(terminal conditionset)_  
 **bgt $s0, 1, Recur** _\# s0 <= 1 equal to **branch if s0 > 1**_    
 **move $v0, $s0** _\# directly return the value, when s0 = 1 | 0_   
 **addi $sp, $sp, 12**  
 **jr $ra**  
  
**Recur:** _\# return (fib(n-1)+fib(n-2))_  
 **addi $a0, $s0, -1** _\# a0 = n-1_  
 **jal fibonacci** _\# call fib(n-1)_  
 **move $s1, $v0** _\# v0 = the **return value** of fib(n-1)._  
_\#We'll going to call callee(fib(n-2)), **if we don't save** returns of fib(n-1) **in stack**, this value will **be gone**._     
 
 **blt $s0, 2, SetZero** _\# use (s0<2)? (s0=0) : (s0-=2); setting argument ready to call fib(n-2)_  
_\# MIPS's operation has problem on addi negation overflow, it can't express minus to 0 and stop._  
_\# So this place I divide in two conditions to deal with._    
 **addi $a0, $s0, -2** _\# (n-2) is greater than or equal to 0_  
 **beq $zero, $zero, JumpLine**   
 **SetZero:** _\# (n-2) is less than 0_  
 **li $a0, 0**  
 **JumpLine:**  
 **jal fibonacci** _\# call fib(n-2)_  
 **move $t0, $v0** _\# v0 = the **return value** of fib(n-2)._    
 
 **add $v0, $s1, $t0** _\#add 2 results on return value v0_ 
 
_\# Epilogue: before callee switch to caller, recovery the variables_  
 **lw $s1, 0($sp)**  
 **lw $s0, 4($sp)**  
 **lw $ra, 8($sp)**  
 **addi $sp, $sp, 12**  
 **jr $ra**  
### \# ---End of funct Fibonacci--- \# 