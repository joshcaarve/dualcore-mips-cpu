
# core 1
org 0x0000
  ori $t0, $0, data1
  lui $t1, 0xDEAD
  ori $t1, $t1, 0xBEEF
  sw  $t1, 0($t0)
  halt

# core 2
org 0x0200
  ori $t0, $0, data2
  lui $t1, 0xBA5E
  ori $t1, $t1, 0xBA11
  sw  $t1, 0($t0)
  halt

org 0x0400
data1:
  cfw 0xBAD0BAD0
data2:
  cfw 0xBAD0BAD0
data3:
  cfw 0xBAD0BAD0
data4:
  cfw 0xBAD0BAD0
