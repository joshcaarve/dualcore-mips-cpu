#lw - s
#sw - m

#Req: I → S and Responder: M → S

org 0x0000
nop
nop
nop
nop
nop
lw $1, 0x0F00($0)
halt


org 0x0200
ori $1, $1, 0xDAB
sw $1, 0x0F00($0)
halt


org 0x0F00
cfw 0xDEAD
cfw 0xBEEF
