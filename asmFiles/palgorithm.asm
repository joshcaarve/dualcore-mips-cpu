
# ------------------------------------ CORE 0 -------------------------------------------------------
# This core is the "Producer" generates a random number with the CRC
# random[0] = crc (seed)
# random[N] = crc random(N - 1)
# push random number to stack

org 0x0000
  ori   $sp, $zero, 0x7FFC  # stack
  addi $1, $1, 10


   # acquire lock
   ori   $a0, $zero, l1      # move lock to arguement register
   jal   lock                # try to aquire the lock
   push $1
   # critical code segment
   ori   $a0, $zero, l1      # move lock to arguement register
   jal   unlock              # release the lock

l1:
  cfw 0x0

# ------------------------------------ CORE 1 -------------------------------------------------------
# This core is the "Consumer" Uses all the random numbers to generate max, min, and average
org 0x0200
    ori   $sp, $zero, 0x7FF8  # stack

    ori   $a0, $zero, l1      # move lock to arguement register
    jal   lock # try to aquire the lock
    pop $1
    addi $1, $1, 1
    # critical code segment
    ori   $a0, $zero, l1      # move lock to arguement register
    jal   unlock              # release the lock
    halt



# ---------------------------------------- END -------------------------------------------------------

# pass in an address to lock function in argument register 0
# returns when lock is available
lock:
aquire:
  ll    $t0, 0($a0)         # load lock location
  bne   $t0, $0, aquire     # wait on lock to be open
  addiu $t0, $t0, 1
  sc    $t0, 0($a0)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra


# pass in an address to unlock function in argument register 0
# returns when lock is free
unlock:
  sw    $0, 0($a0)
  jr    $ra
