org 0x0000

addi $5, $0, 2
addi $30, $0, 0xFFFC
sw $30, 5000($0)
jal save
halt

save:
  lw $30, 5000($0)
  addi $30, $30, -4
  sw $30, 5000($0)
  sw $5, 0($30)
  jr $31
