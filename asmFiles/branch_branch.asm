main:
    org 0x0000
    addi $t0, $t0, 0
    addi $t1, $t1, 1

    beq $t0, $t1, branch1
    beq $t0, $t1, branch2

    addi $1, $1, 10
    halt

branch1:
    addi $1, $1, 1
    halt

branch2:
    addi $1, $1, 2
    halt
