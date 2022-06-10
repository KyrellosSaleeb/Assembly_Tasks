#div x, 2
#lo 
#hi
#mfhi
#mflo

.data
  arr: .word 3, 2, 4, 5, 7, 8
  size: .word 6
  noOfOdd: .word 0
  noOfEven: .word 0
.text
  # i = 0
  addi $s0, $zero, 0  
  # size
  la $t0, size
  lw $s1, ($t0)
  # arr
  la $t0, arr
  
L1:
  # i < size
  slt $t1, $s0, $s1
  beq $t1, $zero, endL1
  # arr[i]
  sll $t1, $s0, 2
  add $t1, $t0, $t1
  lw $s2, ($t1)
  
  # if arr[i] % 2 == 0
  div  $t3, $s2, 2
  mfhi $t3
  
  bne $t3, 0, addOdd
  # even++
  lw $s4, noOfEven
  addi $t4, $s4, 1
  sw $t4, noOfEven
  j continueL1
  
addOdd:
  # odd++
  lw $s3, noOfOdd
  addi $t4, $s3, 1
  sw $t4, noOfOdd
  
continueL1:
  addi $s0, $s0, 1
  j L1

endL1: