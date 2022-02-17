org 0x0000

org   0x0000

lw    $1, 0x00F0($0)
lw    $2, 0x00F0($0)
lw    $3, 0x00F0($0)
lw    $4, 0x00F0($0)
lw    $5, 0x00F0($0)
lw    $6, 0x00F0($0)
lw    $7, 0x00F0($0)

addi $1, $1, 1
addi $2, $2, 1
addi $3, $3, 1
addi $4, $4, 1
addi $5, $5, 1
addi $6, $6, 1
addi $7, $7, 1

jal store

store:
    sw    $1, 0x0F00($0)
    sw    $2, 0x0F04($0)
    sw    $3, 0x0F08($0)
    sw    $4, 0x0F0C($0)
    sw    $5, 0x0FA0($0)
    sw    $6, 0x0FA4($0)
    sw    $7, 0x0FA8($0)

halt

org   0x00F0
cfw   0xBEEF
