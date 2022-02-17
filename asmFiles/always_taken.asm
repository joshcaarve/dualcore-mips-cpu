org 0x0000

loop:
    addi $1, $1, 1
    beq $1, $0, branch
    addi $1, $1, 1
    addi $1, $1, 1
    addi $1, $1, 1
    halt

branch:
    addi $2, $2, 1
    addi $2, $2, 1
    addi $2, $2, 1

    halt
