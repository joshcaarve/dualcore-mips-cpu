org 0x0000
addi $30, $0, 0xFFFC
# already fails lat2
sw $30, 5000($0)
jal save
addi $0, $0, 0
halt

save:
  lw $30, 5000($0)
  addi $30, $30, -4
  sw $30, 5000($0)
  jr $31
