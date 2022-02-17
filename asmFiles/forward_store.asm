org 0x0000

addi $t1, $t1, 0xFF00
addi $t0, $t0, 1
sw $t0, 0x0000($t1)

halt
