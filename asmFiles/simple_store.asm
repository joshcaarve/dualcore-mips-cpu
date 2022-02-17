org   0x0000

ori   $3, $3, 5
addi  $3, $3, 8
sw    $3, 0x00F0($0)
lw    $3, 0x00F0($0)
sw    $3, 0x00F0($0)

halt
# already failed here (regFile)

addi  $3, $3, 8
sw    $3, 0x00F4($0)
addi  $3, $3, 1
sw    $3, 0x00F8($0)
addi  $3, $3, 1
sw    $3, 0x00FC($0)
addi  $3, $3, 1
sw    $3, 0x0100($0)

halt




