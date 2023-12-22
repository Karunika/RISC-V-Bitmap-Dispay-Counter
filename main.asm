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

    length: .space 1

# a1, a2, a3, a4, a5, (t3, t4)
.macro draw_num(%num, %position)

    la a1, buffer_frame

    mv a2, %num
    lw a3, (a2)

    lw a4, width
    lw a5, height

    # buffer_frame += width * position * word_size
    lw t3, width
    mv t4, %position
    mul t3, t3, t4
    li t4, 4
    mul t3, t3, t4
    add a1, a1, t3

draw_line:
	sw a3, 0(a1)   # store the content of a3 (color) in the address pointed by a1

    # advance to next frame buffer pixel position and _number reference
    addi a1, a1, 4
    addi a2, a2, 4
    lw a3, (a2)

	addi a4, a4, -1
    bnez a4, draw_line

    # buffer_frame += (canvas_width - width) * word_size
    lw t3, width
    lw t4, canvas_width
    sub t3, t4, t3
    li t4, 4
    mul t3, t3, t4
    add a1, a1, t3

    lw t3, width
    add a4, a4, t3 # replenish width
    addi a5, a5, -1  # decrease height counter
    bnez a5, draw_line

.end_macro

.text

main:
    li a7, 5 # read integer
    ecall
    mv t0, a0

    mv t1, t0
    li t6, 0

length_loop:
    li a0, 10
    div t1, t1, a0

    addi t6, t6, 1

    bnez t1, length_loop

    # store length
    la a0, length
    sw t6, (a0)

    # start again
    mv t1, t0
    lw t6, length

initial_draw_loop:
    li a0, 10
    rem t4, t1, a0
    div t1, t1, a0

    addi t6, t6, -1

    jal map_t4_to_label
    draw_num t4, t6

    bnez t1, initial_draw_loop

count_down_loop:
    li a7, 32 # sleep call
    li a0, 1000
    ecall

    mv t1, t0
    addi t2, t1, -1

    beqz t2, end_ex # zero reached

    mv t0, t2

    lw t6, length

loop_digits:

    li a1, 10
    rem a2, t1, a1
    rem a3, t2, a1

    beq a2, a3, count_down_loop

    addi t6, t6, -1

    mv t4, a3
    jal map_t4_to_label
    draw_num t4, t6

    li a1, 10
    div t1, t1, a1
    div t2, t2, a1

    j loop_digits

end_ex:
    li a7, 10   # exit with a status code 0
    ecall

# render
.include "render.asm"
