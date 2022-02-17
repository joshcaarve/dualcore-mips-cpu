# core 1
org 0x0000
  ori $t0, $t0, 0x0F00
  lw $t1, 0($t0)
  addi $t1, $t1, 1
  halt

# core 2
org 0x0200
   ori $t0, $t0, 1
   ori $t0, $t0, 1
   ori $t0, $t0, 1
   halt

org 0x0F00
cfw 0xBA5EBA11
