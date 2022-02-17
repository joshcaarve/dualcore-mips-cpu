org   0x0000

lw    $3, 0x00F0($0)
#addi  $3, $3, 1
#lw    $3, 0x00F0($0)
#addi  $3, $3, 1
#lw    $3, 0x00F0($0)


halt

org   0x00F0
cfw   0x7337
