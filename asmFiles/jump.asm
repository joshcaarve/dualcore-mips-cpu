main:
    org 0x0000
    andi $t0, $t0, 0
    jal jumpLink
    j jump
jumpLink:
    addi $t0, $t0, 1
    jr $31
jump:
    addi $t0, $t0, 8
    halt
