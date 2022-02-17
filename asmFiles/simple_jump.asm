org 0x0000

andi $t0, $t0, 0

j fake
addi $t0, $t0, 9

fake:
    addi $t0, $t0, 1


halt
