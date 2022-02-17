org 0x0000


lw $t9, 0xFF00($0)
addi $t9, $t9, 4
sw $t9, 0xFF00($0)

lw $t9, 0xFF00($0)
addi $t9, $t9, 4
sw $t9, 0xFF00($0)


halt


org 0xFF00
cfw 0xFF00
