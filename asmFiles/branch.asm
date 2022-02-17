main:
    org 0x0000
    andi $t0, $t0, 0
    andi $t1, $t1, 0

    addi $t0, $t0, 2
    addi $t1, $t1, 1

    bne $t0, $t1, writeMem
    addi $t0, $t0, 9
random:
    addi $t1, $t1, 10
writeMem:
    addi $t1, $t1, 2
    beq $t0, $t1, random
    addi $t1, $t1, 4
    halt
