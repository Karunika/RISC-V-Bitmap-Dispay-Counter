.data
    prompt: .string "start value>"

.text

main:
    jal read_char
    mv t2, a0

    jal read_char
    mv t1, a0

    jal read_char
    mv t0, a0

loop:
    jal dec

dec_end:
    # show result
    mv a0, t2
    jal print_num

    mv a0, t1
    jal print_num

    mv a0, t0
    jal print_num

    # print new line
    li a0, '\n'
    li a1, 11
    ecall

    j loop

end_ex:
    li a7, 10 # exit with a status code 0
    ecall

dec:
dec_0:
    beq t0, zero, dec_1
    addi t0, t0, -1
    j dec_end

dec_1:
    addi t0, t0, 9
    beq t1, zero, dec_2
    addi t1, t1, -1
    j dec_end

dec_2:
    addi t1, t1, 9
    beq t2, zero, end_ex
    addi t2, t2, -1
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
    
