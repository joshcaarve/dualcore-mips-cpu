org 0x0000

addi $1, $1, 0x0FA0
lw $t0, 0($1)  # this LW should load 0x0FA0 && 0x0FA4
lw $t1, 4($1)

addi $2, $2, 0x0DA0
lw $t2, 0($2)  # this LW should load 0x0DA0 && 0x0DA4
lw $t3, 4($2)


or $t0, $t1, $t0
sw $t0, 8($1)

or $t2, $t2, $t3
sw $t2, 8($2)

halt


org 0x0DA0
cfw 0xDE00

org 0x0DA4
cfw 0x00AD



org 0x0FA0
cfw 0xBE00

org 0x0FA4
cfw 0x00EF
