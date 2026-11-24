.global _start

.section .text
_start:

    movq $0, %rbx # i = 0
    movl $0, %esi # value_sum = 0
    movl $0, %edx # error_count = 0
    movl n, %ecx
    testl %ecx, %ecx
    jz end_HW1

loop_HW1:

    movw samples(,%rbx,2), %ax
    testw $0x8000, %ax
    jnz invalid_sample_HW1
    andw $0x0FFF, %ax
    movzwl %ax, %eax # extend to 32 bit for the sum
    addl %eax, %esi
    jmp next_iter_HW1

invalid_sample_HW1:

    movw $0, %ax
    incl %edx

next_iter_HW1:

    movw %ax, filtered(,%rbx,2)
    incq %rbx
    cmpq %rcx, %rbx
    jb loop_HW1

end_HW1:

    movl %edx, error_count
    movl %esi, value_sum
