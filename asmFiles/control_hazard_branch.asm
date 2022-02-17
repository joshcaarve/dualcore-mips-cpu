org 0x0000

addi $1, $1, 1
addi $2, $2, 1
beq $1, $1, branch
addi $1, $1, 9

halt

branch:
    addi $1, $1, 2
    addi $10, $10, 500
    sw $1, 0($10)
    sw $2, 4($10)

halt
