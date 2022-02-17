org 0x0000

addi $t0, $t0, 1
addi $t1, $t1, 1

beq $t0, $t1, fake
addi $t0, $t0, 1
addi $t0, $t0, 1
addi $t0, $t0, 1
addi $t0, $t0, 1


fake:
    addi $t1, $t1, 1
    addi $t1, $t1, 1
    addi $t1, $t1, 1
    addi $t1, $t1, 1
    addi $t1, $t1, 1
    halt
