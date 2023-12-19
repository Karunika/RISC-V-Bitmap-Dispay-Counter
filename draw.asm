.data
	.include "bits/0_bits.asm"
    	frameBuffer: .space
    	width: .byte 32
    	height: .byte 64
    
.text
main:

	la 	t0, frameBuffer	# load frame buffer addres
	li 	t1, 2048		# save 512*256 pixels
	la a1, _zero
	lw 	t2, (a1)		# load light gray color
l1:
	sw   	t2, 0(t0)
	addi 	t0, t0, 4 	# advance to next pixel position in display
	addi 	t1, t1, -1	# decrement number of pixels

	addi 	a1, a1, 4
	lw	t2, (a1)
	bnez 	t1, l1		# repeat while number of pixels is not zero