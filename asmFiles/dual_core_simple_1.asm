# dual_core_simple_1

# core 1
org 0x0000
  addi $t0, $t0, 1
  addi $t0, $t0, 1
  addi $t0, $t0, 1
  halt

# core 2
org 0x0200
   ori $t0, $t0, 1
   ori $t0, $t0, 1
   ori $t0, $t0, 1
   halt

