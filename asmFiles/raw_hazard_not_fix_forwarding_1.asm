org 0x0000

# cannot be fixed with forwarding

ori   $1, $zero, 0x0F00
lw    $3, 0($1)
addi  $3, $3, 1
sw    $3, 0xFF00($0)
addi $8, $8, 0xF000
#addi $0, $0, 0
sw $3,  0($8)


sw    $3, 0xFF00($0)
addi $8, $8, 0xF000
#addi $0, $0, 0
sw $3,  0($8)

halt

org   0x0F00
cfw   0x7337
