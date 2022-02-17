#lw -s#
#sw - m

# Req: I → M and Responder: M → I

org 0x0000

addi $1, $1, 1
addi $2, $2, 0x0F00
sw $1, 0($2)
halt

org 0x0200

addi $1, $1, 11
addi $2, $2, 0x0F00
nop
sw $1, 0($2)
halt


org 0x0F00
cfw 0xDEAD
cfw 0xBEEF

