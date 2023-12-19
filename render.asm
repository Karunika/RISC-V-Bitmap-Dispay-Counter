.data
.macro map_reg_to_bit(%reg)
    li t3, 0
    beq %reg, t3, to_zero

    li t3, 1
    beq %reg, t3, to_one

    li t3, 2
    beq %reg, t3, to_two

    li t3, 3
    beq %reg, t3, to_three

    li t3, 4
    beq %reg, t3, to_four

    li t3, 5
    beq %reg, t3, to_five

    li t3, 6
    beq %reg, t3, to_six

    li t3, 7
    beq %reg, t3, to_seven

    li t3, 8
    beq %reg, t3, to_eight

    li t3, 9
    beq %reg, t3, to_nine
.end_macro

.text
map_t4_to_label:
    li t3, 0
    beq t4, t3, to_zero

    li t3, 1
    beq t4, t3, to_one

    li t3, 2
    beq t4, t3, to_two

    li t3, 3
    beq t4, t3, to_three

    li t3, 4
    beq t4, t3, to_four

    li t3, 5
    beq t4, t3, to_five

    li t3, 6
    beq t4, t3, to_six

    li t3, 7
    beq t4, t3, to_seven

    li t3, 8
    beq t4, t3, to_eight

    li t3, 9
    beq t4, t3, to_nine
    ret


to_zero:
    la t4, _zero
    ret

to_one:
    la t4, _one
    ret

to_two:
    la t4, _two
    ret

to_three:
    la t4, _three
    ret

to_four:
    la t4, _four
    ret

to_five:
    la t4, _five
    ret

to_six:
    la t4, _six
    ret

to_seven:
    la t4, _seven
    ret

to_eight:
    la t4, _eight
    ret

to_nine:
    la t4, _nine
    ret
    