main:
  org 0x0000

  addi $t0, $t0, 28    # Current Day

  addi $t1, $t1, 30    # Constant to mul for month
  addi $t2, $t2, 8     # Current Month

  addi $t3, $t3, 365   # Constant to mul for year
  addi $t4, $t4, 2019  # Current Year

  addi $t2, $t2, -1
  addi $t4, $t4, -2000

  # add 30 to stack
  lw $t9, 0xFFFC($0)
  addi $t9, $t9, -4
  sw $t1, 4($t9)
  sw $t9, 0xFFFC($0)

  # add current month to stack
  lw $t9, 0xFFFC($0)
  addi $t9, $t9, -4
  sw $t2, 4($t9)
  sw $t9, 0xFFFC($0)

mulMonth:

  lw $t9, 0xFFFC($0)
  lw $a2, 4($t9)
  addi $t9, $t9, 4
  sw $t9, 0xFFFC($0)

  lw $t9, 0xFFFC($0)
  lw $a3, 4($t9)
  addi $t9, $t9, 4
  sw $t9, 0xFFFC($0)

  addi $a0, $a0, 0  # (30 * (currentMonth - 1))  result
  addi $a1, $a1, 0  # LCV

loop:
  beq $a2, $a1, mulYearInit
  add $a0, $a0, $a3
  addi $a1, $a1, 1
  j loop

mulYearInit:
  add $t0, $t0, $a0  # t0 = currentDay + (30 * (currentMonth - 1))

  # add 365 to stack
  lw $t9, 0xFFFC($0)
  addi $t9, $t9, -4
  sw $t3, 4($t9)
  sw $t9, 0xFFFC($0)

  # add current year to stack
  lw $t9, 0xFFFC($0)
  addi $t9, $t9, -4
  sw $t4, 4($t9)
  sw $t9, 0xFFFC($0)

mulYear:

  lw $t9, 0xFFFC($0)
  lw $a2, 4($t9)
  addi $t9, $t9, 4
  sw $t9, 0xFFFC($0)

  lw $t9, 0xFFFC($0)
  lw $a3, 4($t9)
  addi $t9, $t9, 4
  sw $t9, 0xFFFC($0)

  andi $a0, $a0, 0
  andi $a1, $a1, 0
  addi $a0, $a0, 0  # (365 * (currentYear - 1))  result
  addi $a1, $a1, 0  # LCV

loopYear:
  beq $a2, $a1, exit
  add $a0, $a0, $a3
  addi $a1, $a1, 1
  j loopYear


exit:
  add $t0, $t0, $a0   # 1BFF
  halt

org 0xFFFC
cfw 1000
