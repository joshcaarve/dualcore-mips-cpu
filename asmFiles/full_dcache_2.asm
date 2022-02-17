org 0x0000

org 0x0000

addi $1, $1, 0x0A00

lw $2, 0($1)
sw $2, 0($1)


lw $2, 4($1)
sw $2, 4($1)

lw $2, 8($1)
sw $2, 8($1)


lw $2, 12($1)
sw $2, 12($1)

lw $2, 16($1)
sw $2, 16($1)

lw $2, 20($1)
sw $2, 20($1)

lw $2, 24($1)
sw $2, 24($1)

lw $2, 28($1)
sw $2, 28($1)

lw $2, 32($1)
sw $2, 32($1)


lw $2, 36($1)
sw $2, 36($1)

lw $2, 40($1)
sw $2, 40($1)

lw $2, 44($1)
sw $2, 44($1)

lw $2, 48($1)
sw $2, 48($1)

lw $2, 52($1)
sw $2, 52($1)

lw $2, 56($1)
sw $2, 56($1)

lw $2, 60($1)
sw $2, 60($1)

lw $2, 64($1)
sw $2, 64($1)

lw $2, 68($1)
sw $2, 68($1)

addi $3, $3, 0x0B00
lw $4, 0($1)
sw $4, 0($1)


lw $4, 4($1)
sw $4, 4($1)

lw $4, 8($1)
sw $4, 8($1)

lw $4, 12($1)
sw $4, 12($1)

lw $4, 16($1)
sw $4, 16($1)

lw $4, 20($1)
sw $4, 20($1)

lw $4, 24($1)
sw $4, 24($1)

lw $4, 28($1)
sw $4, 28($1)

lw $4, 32($1)
sw $4, 32($1)


halt



org 0x0A00
cfw 0x0001

org 0x0A04
cfw 0x0002

org 0x0A08
cfw 0x0003

org 0x0A0C
cfw 0x0004

org 0x0A10
cfw 0x0005

org 0x0A14
cfw 0x0006

org 0x0A18
cfw 0x0007

org 0x0A1C
cfw 0x0008

org 0x0A20
cfw 0x0009

org 0x0A24
cfw 0x000A

org 0x0A28
cfw 0x000B

org 0x0A2C
cfw 0x000C

org 0x0A30
cfw 0x000D

org 0x0A34
cfw 0x000E

org 0x0A38
cfw 0x000F

org 0x0A3C
cfw 0x0010

org 0x0A40
cfw 0x0011

org 0x0A44
cfw 0x0012

org 0x0A48
cfw 0x0013

org 0x0A4C
cfw 0x0014

org 0x0A50
cfw 0x0015

org 0x0A54
cfw 0x0016

org 0x0A58
cfw 0x0017

org 0x0A5C
cfw 0x0018


# new addresses
org 0x0B00
cfw 0x0019

org 0x0B04
cfw 0x0020

org 0x0B08
cfw 0x0021

org 0x0B0C
cfw 0x0022

org 0x0B10
cfw 0x0023

org 0x0B14
cfw 0x0024

org 0x0B18
cfw 0x0025

org 0x0B1C
cfw 0x0026

org 0x0B20
cfw 0x0026


halt
