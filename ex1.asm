.global _start

.section .text
_start:

    leaq str(%rip), %rsi
    movl $0, %ecx
    movl $0, %edx

LOOP_HW1:

    movb (%rsi), %al
    cmpb $0, %al
    je END_HW1

    cmpb $48, %al
    jb NEXT_HW1
    cmpb $57, %al
    ja NEXT_HW1

    incl %ecx
    subb $48, %al
    movzbl %al, %eax
    addl %eax, %edx

NEXT_HW1:

    incq %rsi
    jmp LOOP_HW1

END_HW1:

    movl %ecx, digit_count(%rip)
    movl %edx, digit_sum(%rip)
