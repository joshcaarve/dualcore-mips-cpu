org 0x0000

# can be fixed with forwarding
addi $10, $10, 1
addi $10, $10, 5

addi $8, $8, 500

sw $10, 0($8)
sw $11, 4($8)

addi $8, $8, 500

sw $9,  0($8)
sw $10, 4($8)
sw $11, 8($8)

halt
