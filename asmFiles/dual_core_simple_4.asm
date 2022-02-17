org 0x0000
halt


org 0x0200
addi $1, $1, 10
sw $1, 0x0F00($0)
halt

