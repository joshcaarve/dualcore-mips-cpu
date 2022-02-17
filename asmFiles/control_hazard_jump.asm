org 0x0000

addi $1, $1, 1
j jump
addi $1, $1, 2
halt

jump:
    addi $1, $1, 10

    addi $8, $8, 500
    sw $1,  0($8)

halt
