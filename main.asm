.data
    buffer_frame: .space 0x8000
    prompt: .string "start value>"

	.include "bits/0_bits.asm"
	.include "bits/1_bits.asm"
	.include "bits/2_bits.asm"
	.include "bits/3_bits.asm"
	.include "bits/4_bits.asm"
	.include "bits/5_bits.asm"
	.include "bits/6_bits.asm"
	.include "bits/7_bits.asm"
	.include "bits/8_bits.asm"
	.include "bits/9_bits.asm"

    width: .word 32
    height: .word 64

    canvas_height: .word 64
    canvas_width: .word 128

# a1, a2, a3, a4, a5
.macro draw_num(%num, %position)

	la  a1, buffer_frame

	mv  a2, %num
	lw  a3, (a2)

    lw  a4, width
    lw  a5, height

    # width * position * word_size
    lw t3, width
    li t4, %position
    mul t3, t3, t4
    li t4, 4
    mul t3, t3, t4
    add a1, a1, t3

draw_line:
	sw   	a3, 0(a1)   # store the content of a3 (color) in the address pointed by a1

    # advance to next frame buffer pixel position and _number reference
	addi 	a1, a1, 4
	addi 	a2, a2, 4
	lw      a3, (a2)

	addi 	a4, a4, -1
    bnez    a4, draw_line


    addi    a1, a1, 384 # 128-32)*4

    addi    a4, a4, 32  # replenish width
    addi    a5, a5, -1  # decrease height counter
    bnez    a5, draw_line

.end_macro


.text

main:
    jal read_char
    mv t2, a0

    jal read_char
    mv t1, a0

    jal read_char
    mv t0, a0

    mv t4, t2
    jal map_t4_to_label
    draw_num t4, 0

    mv t4, t1
    jal map_t4_to_label
    draw_num t4, 1

    mv t4, t0
    jal map_t4_to_label
    draw_num t4, 2

loop:
    li a7, 32
    li a0, 10000
    ecall

    jal dec

dec_end:
    j loop

end_ex:
    li a7, 10 # exit with a status code 0
    ecall

dec:
dec_0:
    beq t0, zero, dec_1
    addi t0, t0, -1

    mv t4, t0
    jal map_t4_to_label
    draw_num t4, 2

    j dec_end

dec_1:
    addi t0, t0, 10
    beq t1, zero, dec_2
    addi t1, t1, -1

    mv t4, t1
    jal map_t4_to_label
    draw_num t4, 1

    j dec_end

dec_2:
    addi t1, t1, 10
    beq t2, zero, end_ex
    addi t2, t2, -1

    mv t4, t2
    jal map_t4_to_label
    draw_num t4, 0

    j dec_end

read_char:
    li a7, 5
    ecall
    ret

print_num:
    li a7, 11
    addi a0, a0, '0'
    ecall
    ret
    
# render
.include "render.asm"
