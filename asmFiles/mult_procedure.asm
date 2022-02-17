main:
  org 0x0000  # start from address 0

  # stack pointer

  addi $t0, $t0, 996  # holds what SP should be at
  addi $a2, $a2, 0  # final result

  addi $t1, $t1, 3
  addi $t2, $t2, 2
  addi $t3, $t3, 8
  addi $t4, $t4, 1

  # add t1 to stack
  lw $t9, 0xFF00($0)
  addi $t9, $t9, -4
  sw $t1, 4($t9)
  sw $t9, 0xFF00($0)

  # add t2 to stack
  lw $t9, 0xFF00($0)
  addi $t9, $t9, -4
  sw $t2, 4($t9)
  sw $t9, 0xFF00($0)

  # add t3 to stack
  lw $t9, 0xFF00($0)
  addi $t9, $t9, -4
  sw $t3, 4($t9)
  sw $t9, 0xFF00($0)

  # add t4 to stack
  lw $t9, 0xFF00($0)
  addi $t9, $t9, -4
  sw $t4, 4($t9)
  sw $t9, 0xFF00($0)

  j fullMul

fullMul:
  # if stack only holds one value (result)
  lw $t9, 0xFF00($0)
  beq $t9, $t0, exit

  # pop from stack
  lw $t9, 0xFF00($0)
  lw $a1, 4($t9)
  addi $t9, $t9, 4
  sw $t9, 0xFF00($0)

  # pop from stack
  lw $t9, 0xFF00($0)
  lw $a0, 4($t9)
  addi $t9, $t9, 4
  sw $t9, 0xFF00($0)

  andi $t7, $t7, 0  # loop control variable for mult
  andi $a2, $a2, 0  # reset result

  j loop
loop:
  beq $a1, $t7, pushRes
  add $a2, $a0, $a2
  addi $t7, $t7, 1
  j loop

pushRes:
  lw $t9, 0xFF00($0)
  addi $t9, $t9, -4
  sw $a2, 4($t9)
  sw $t9, 0xFF00($0)
  j fullMul

exit:
    halt


org 0xFF00
cfw 1000
