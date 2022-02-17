org 0x0000
addi $1, $1, 2

loop:

    addi $1, $1, -1
    bne $1, $0, loop

fin:
    addi $1, $1, 10
    halt

end:
    addi $1, $1, 9
    halt
