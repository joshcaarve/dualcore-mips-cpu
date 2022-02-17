# Joshua Brard
# Rohan Prabhu
# This class though



# ------------------------------------ CORE 0 -------------------------------------------------------
# This core is the "Producer" generates a random number with the CRC
# random[0] = crc (seed)
# random[N] = crc random(N - 1)
# push random number to stack


# ----------------- CORE 0 BEGIN -------------------
org 0x0000
	ori		$s0, $0, 256	    	# Amount of random numbers to be generated
	ori		$s1, $0, 0			        # value to generate
	ori		$s2, $0, 0			        # values generated
	ori		$s3, $0, 0xA			    # seed to generate the first random number
	ori 	$s4, $0, 0			        # Head of the buffer
	ori		$s5, $0, 0			        # Current buffer size
	ori		$s6, $0, 10			        # max buffer size
	ori		$s7, $0, 40			        # buffer head end (10 * 4 = 40)

producer:
	lw		$s5, buffer_size($0)		# load size
	beq		$s5, $s6, producer          # if (buffer.length == 10) { WAIT }
	beq		$s2, $s0, core_0_exit	    # if (numbers_generated == 256) { return EXIT_SUCCESS }
	ori 	$a0, $0, lock_value			# move lock to argument register (see subroutine declaration)
	jal     lock				        # acquire lock
	lw 		$s5, buffer_size($0)		# load size from memory
	addiu	$s5, $s5, 1			        # increment size because we made it passed the lock
	sw		$s5, buffer_size($0)		# store size
	ori		$a0, $s3, 0			        # move seed into argument register (see subroutine declaration)
	jal 	crc32				        # generate random number with subroutine
	addiu	$t0, $s4, buffer 	        # buffer head location
	sw		$v0, 0($t0)			        # store on ring buffer
	ori		$s3, $v0, 0x0000	        # update seed (random[N] = crc random(N - 1))
	addiu	$s4, $s4, 0x0004	        # increment the buffer ptr
	jal		buffer_ptr_reset_fake       # reset the head of the buffer if necessary
	ori 	$a0, $0, lock_value         # move unlock to argument register (see subroutine declaration)
	jal 	unlock				        # unlock
	addiu 	$s2, $s2, 1			        # increment
	j 		producer                    # re-loop

buffer_ptr_reset_fake:
	beq		$s4, $s7, buffer_ptr_reset_real     # see if its time to reset
	jr 		$ra

buffer_ptr_reset_real:
	ori		$s4, $0, 0                          # actually reset
	jr		$ra

core_0_exit:
	or		$t5, $0, $s0
	sw		$t5, finish($0)
	halt    # we.....we......we......made it!!!!
# ----------------- CORE 0 END -------------------


# ------------------------------------ CORE 1 -------------------------------------------------------
# This core is the "consumer" Uses all the random numbers to generate max, min, and average
# ----------------- CORE 1 BEGIN -------------------
org	0x0200
	ori 	$s5, $0, 40                     # buffer tail end
	ori		$s2, $0, 0					    # buffer tail pointer
	ori		$s3, $0, 0xFFFF				    # min
	ori		$s7, $0, 0x0000				    # max
	ori 	$s0, $0, 0x0000				    # sum
	ori 	$t9, $0, 0x0008				    # shift amount (division)
consumer:
	lw		$t3, buffer_size($0)
	beq		$t3, $0, core_0_exit_check	    # if (buffer.size == 0) { go see if c0 is done}
	ori 	$a0, $0, lock_value			    # prepare argument (see subroutine declaration)
	jal		lock				            # try to acquire lock
	lw 		$t3, buffer_size($0)		    # lock is over so buffer.size should be > 0
	ori		$t0, $0, 1					    # setting up for subtraction
	subu 	$t3, $t3, $t0		            # decrease size
	sw		$t3, buffer_size($0) 	        # store value as new buffer size
	addiu	$t4, $s2, buffer 	            # tail location
	lw 		$t1, 0($t4) 		            # load val from tail
	ori 	$a1, $t1, 0			            # current value pop from the tail
	andi    $a1, $a1, 0xFFFF                # use the lower 16 bits of the produced number
	addiu 	$s2, $s2, 4			            # increment the tail

	jal		tail_ptr_reset_fake             # go see if it is time to reset

	ori 	$a0, $s3, 0			            # setup argument (see subroutine declaration)
	jal		min 				            # get the minimum
	ori 	$s3, $v0, 0			            # put the sum in the register
	ori 	$a0, $s7, 0			            # setup argument
	jal		max 				            # get the max
	ori 	$s7, $v0, 0			            # pull the returned result
	addu 	$s0, $s0, $a1 		            # sum += value
	ori 	$a0, $0, lock_value			    # move lock to argument (see subroutine declaration)
	jal		unlock				            # release the lock

	j 		consumer			            # re-loop

core_1_exit:
	sw 		$s3, min_value($0)		        # min value
	sw		$s7, max_value($0)		        # max value

	srlv 	$s0, $t9, $s0
	sw 		$s0, avg_value($0)		        # average value

	halt                                    # we....we....we.....made it!!!!!!

core_0_exit_check:
	lw 		$t0, finish($0) 		        # check signal from p0
	beq 	$t0, $0, consumer	            # finish or return to consumer
	j 		core_1_exit

tail_ptr_reset_fake:
	beq 	$s2, $s5, tail_ptr_reset_real   # if we made it to the end of the buffer, reset
	jr 		$ra

tail_ptr_reset_real:
	ori 	$s2, $0, 0                      # reset the tail
	jr 		$ra

# ----------------- CORE 1 END -------------------


# ------------------------------------ GIVEN SUBROUTINES BEGIN ------------------------------------------------------


# ------------------ LOCK/ACQUIRE/UNLOCK BEGIN -------------------
# pass in an address to lock function in argument register 0
# returns when lock is available
lock:
acquire:
	ll		$t0, 0($a0)			# load lock location
	bne		$t0, $0, acquire 	# wait on lock to be open
	addiu	$t0, $t0, 1
	sc		$t0, 0($a0)
	beq		$t0, $0, lock 		# if sc failed retry
	jr		$ra


# pass in an address to unlock function in argument register 0
# returns when lock is free
unlock:
	sw		$0, 0($a0)
	jr		$ra
# ------------------ LOCK/ACQUIRE/UNLOCK END -------------------




# ------------------ MAX/MIN BEGIN -------------------
# registers a0-1,v0,t0
# a0 = a
# a1 = b
# v0 = result

#-max (a0=a,a1=b) returns v0=max(a,b)-----------------
max:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a0, $a1
  beq   $t0, $0, maxrtn
  or    $v0, $0, $a1
maxrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#----------------------------------------------------

#-min (a0=a,a1=b) returns v0=min(a,b)----------------
min:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a1, $a0
  beq   $t0, $0, minrtn
  or    $v0, $0, $a1
minrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
# ------------------ MAX/MIN END ----------------------

# ------------------ CRC BEGIN ------------------------
#REGISTERS
#at $1 at
#v $2-3 function returns
#a $4-7 function args
#t $8-15 temps
#s $16-23 saved temps (callee preserved)
#t $24-25 temps
#k $26-27 kernel
#gp $28 gp (callee preserved)
#sp $29 sp (callee preserved)
#fp $30 fp (callee preserved)
#ra $31 return address

# USAGE random0 = crc(seed), random1 = crc(random0)
#       randomN = crc(randomN-1)
#------------------------------------------------------
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

l1:
  slt $t4, $t2, $t3
  beq $t4, $zero, l2

  ori $t5, $0, 31
  srlv $t4, $t5, $a0
  ori $t5, $0, 1
  sllv $a0, $t5, $a0
  beq $t4, $0, l3
  xor $a0, $a0, $t1
l3:
  addiu $t2, $t2, 1
  j l1
l2:
  or $v0, $a0, $0
  jr $ra
# ------------------ CRC END ------------------------

# ---------------------------------------- GIVEN SUBROUTINES END --------------------------------------------

# ---------------------------------------- DATA  BEGIN ------------------------------------------------------

# lock value
lock_value:
	cfw 	0x0000

# checks if core 0 finished
finish:
	cfw 	0x0000

# The ten slot circular buffer
buffer:
	cfw 	0x0000
	cfw 	0x0000
	cfw 	0x0000
	cfw 	0x0000
	cfw 	0x0000
	cfw 	0x0000
	cfw 	0x0000
	cfw 	0x0000
	cfw 	0x0000
	cfw 	0x0000

# Current Size of the buffer
buffer_size:
	cfw 	0x0000


# Values held for minimum, maximum, and average
org 	0x0800
max_value:
	cfw 	0x0000
min_value:
	cfw 	0xFFFF
avg_value:
	cfw 	0xFFFF

# ------------------------------------------ DATA  END --------------------------------------------------------
