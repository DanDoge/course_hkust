.globl start

start:

lui $t4, 0x0003
ori $t5, $t4, 0xbf20
lw $t1, 1($t2)