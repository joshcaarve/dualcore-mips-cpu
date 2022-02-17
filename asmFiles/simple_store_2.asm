org 0x0000

addi $t0, $t0, 9
sw $t0, 0xFF00($0)
lw $t0, 0xFF00($0)
addi $t0, $t0, 1

halt
