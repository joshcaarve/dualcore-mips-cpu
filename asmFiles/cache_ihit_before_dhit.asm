# WIP

org 0x0000

addi $t0, $t0, 0xBEEF
addi $t3, $t3, 10
addi $t4, $t4, 0xFF00

sw $t0, 0($t4)
beq $0, $0, branch

branch:
    lw $t1,  0($t4)
    addi $t1, $t1, 1
    sw $t1,  0($t4)

    addi $t4, $t4, 4


    addi $t2, $t2, 1

    beq $t2, $t3, branchHalt
    j branch

branchHalt:
    halt
