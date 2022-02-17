org 0x0000
addi $30, $0, 0xFF00
addi $1, $0, 0
addi $2, $0, 0
sw $30, 5000($0)
add $5, $1, $0
jal save
add $5, $2, $0
jal save
add $3, $0, $0

loop:
  jal load
  beq $3, $5, end
  jal load
  add $4, $4, $5
  addi $3, $3, 1
  add $5, $1, $0
  jal save
  add $5, $2, $0
  jal save
  j loop

save:
  lw $30, 5000($0)
  addi $30, $30, -4
  sw $30, 5000($0)
  sw $5, 0($30)
  jr $31

load:
  lw $30, 5000($0)
  lw $5, 0($30)
  addi $30, $30, 4
  sw $30, 5000($0)
  jr $31

end:
  jal load
  add $30, $4, $0
  jal save
  add $29, $4, $0
  halt

org 0xFF00
cfw 0xFFF0
