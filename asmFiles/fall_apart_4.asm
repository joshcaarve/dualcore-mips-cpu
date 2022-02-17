org 0x0000

addi $5, $5, 0x0F00
addi $6, $6, 0x0A04

lui   $10, 0xDEED

lw $9, 0($6)

addi $1, $1, 0xABCD
addi $2, $2, 0x0CAB
addi $3, $3, 0x0DAB
addi $4, $4, 0x0DAD


sw $1, 0($5)
sw $2, 4($5)
sw $3, 8($5)
sw $4, 12($5)
sw $10,16($5)

halt

org 0x0A04
cfw 0xABCD
