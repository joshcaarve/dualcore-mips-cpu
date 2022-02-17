org 0x0000

addi $30, $0, 8
addi $29, $0, 9
sw $30, 5000($0)
lw $9,  5000($0)
# correct up to here
sw $29, 5004($0)


halt
