# QtSpim 匯入檔案時，務必點選 file/Reinitialize and load file，不然 main 起始點會瘋狂跳錯
#########################################
#.data
#    array: .word 100, 200, 300, 400, 500
#.text
#.globl main
#
## --- main program --- #
#main:
#
## [宣告初值] 從 array[1] 開始放
#    la    $s0,    array # 將宣告變數 array 的位址存入 $0 (index = 0)
#    li    $s4,    1 # 令 index 是 $s4，$s4 = 1
#    sll    $s4,    $s4,    2 # MIPS 一個儲存格是 4 bytes, 故要左移 2 bits 即乘 4
#
## --- Input start --- #
#InputNumber:
#
## Syscall($v0 = 5) -> Read Integer from concle
#	li    $v0,    5
#	syscall
#
## if input 0, then break 
#	beq    $v0,    $zero,   exit_input # input 0 -> break Loop
#
## Stroe input data to array[index]
#    add    $t0,    $s0,    $s4 # 給位址加上 offset
#    sw    $v0,    0($t0) # v0 = input data -> array[index]
#	addi    $s4,    $s4,     4 # v0 += 4 -> array[index++]
#
#	b   InputNumber #Input Loop
#
## --- Output array[1] --- #
#exit_input:
#
## 輸出 array[2]
#    la    $s0,    array   # 將宣告變數 array 的位址存入 $0 (index = 0)
#    li    $s4,    2 # 令 index 是 $s4，$s4 = 2 
#    sll    $s4,    $s4,    2 # MIPS 一個儲存格是 4 bytes, 故要左移 2 bits 即乘 4
#
## Syscall($v0 = 1) -> Print Integer to concle
#    add    $t0,    $s0,    $s4 # 給位址加上 offset
#	lw    $a0,    0($t0) # Print array[2]
#	li    $v0,    1
#	syscall
#
## --- End Program --- #
## Syscall($v0 = 10) -> Go to SAO
#	li    $v0,    10
#	syscall
### --- EOF --- ##
#########################################

.data
    B: .word 0, 1, 2, 3, 4 # 宣告 B 陣列
.text
.globl main

main:
    la    $s7,    B # 宣告陣列 B 的位址存入 $s7 
    li    $s4,    1 # 令 s4為 index j，j 初值為 1
    li    $t2,    100 # 令欲存入值 $t2 = 100

    addi    $s4,    $s4,    2 # s4 = j+2 = 1+2 = 3
    sll    $s4,    $s4,    2 # MIPS 一個儲存格是 4 bytes, 故要左移 2 bits 即乘 4
    add    $t1,    $s7,    $s4 # $t1 = B[3]
    sw    $t2,    0($t1) # B[3] = 100 