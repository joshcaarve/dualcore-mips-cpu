org 0x0000

# can be fixed with forwarding
addi $10, $10, 1
add $11, $10, $0

addi $8, $8, 500

sw $10, 0($8)
sw $11, 4($8)

halt
