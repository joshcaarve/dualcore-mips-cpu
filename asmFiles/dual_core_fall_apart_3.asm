
# core 0
org 0x0000
    ori $s0, $0, 0
    ori $s1, $s1, 2
start:
    jal check_end_fake
    addi $s0, $s0, 1
    j start
    halt

check_end_fake:
	beq		$s0, $s1, check_end_real     # see if its time to reset
	jr 		$ra

check_end_real:
	sw $31, 0x0F00($0)
	halt

# core 1
org 0x0200
      ori $s0, $0, 0
      ori $s1, $s1, 2
  start1:
      jal check_end_fake1
      addi $s0, $s0, 1
      j start
      halt

  check_end_fake1:
  	beq		$s0, $s1, check_end_real1     # see if its time to reset
  	jr 		$ra

  check_end_real1:
  	sw $31, 0x0F04($0)
  	halt
