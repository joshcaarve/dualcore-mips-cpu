org 0x0000

andi $t0, $t0, 0
jal fake
ori $t0, $t0, 0xBEEF
halt

fake:
    addi $31, $31, 4
    jr $31
    ori $t1, $t1, 0xFAFA

    addi $10, $10, 500
    sw $t1,  0($10)


