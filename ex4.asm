.global _start

.section .text
_start:

    movzbl wrap_mode(%rip), %r15d
    movl $0, %r8d

ROW_HW1:

    cmpl $8, %r8d
    je END_HW1
    movl $0, %r9d

COL_HW1:

    cmpl $8, %r9d
    je NEXTROW_HW1

    movl $0 , %r10d
    movl $-1, %r11d

DR_HW1:

    cmpl $2, %r11d
    je CHECK_HW1
    movl $-1, %r12d

DC_HW1:

    cmpl $2, %r12d
    je NEXTDR_HW1

    cmpl $0, %r11d
    jne CALC_HW1
    cmpl $0, %r12d
    je NEXTDC_HW1

CALC_HW1:

    movl %r8d, %eax
    addl %r11d, %eax
    movl %r9d, %ebx
    addl %r12d, %ebx

    cmpl $1, %r15d
    je WRAP_HW1

    cmpl $0, %eax
    jl NEXTDC_HW1
    cmpl $8, %eax
    jge NEXTDC_HW1
    cmpl $0, %ebx
    jl NEXTDC_HW1
    cmpl $8, %ebx
    jge NEXTDC_HW1
    jmp FETCH_HW1

WRAP_HW1:

    addl $8, %eax
    andl $7, %eax
    addl $8, %ebx
    andl $7, %ebx

FETCH_HW1:

    shll $3, %eax
    addl %ebx, %eax
    leaq board(%rip), %rsi
    movb (%rsi, %rax, 1), %cl
    cmpb $1, %cl
    jne NEXTDC_HW1
    incl %r10d

NEXTDC_HW1:

    incl %r12d
    jmp DC_HW1

NEXTDR_HW1:

    incl %r11d
    jmp DR_HW1

CHECK_HW1:

    movl %r8d, %eax
    shll $3, %eax
    addl %r9d, %eax
    leaq board(%rip), %rsi
    movb (%rsi, %rax, 1), %cl

    movb $0, %dl

    cmpb $1, %cl
    je ALIVE_HW1

    cmpl $3, %r10d
    jne WRITE_HW1
    movb $1, %dl
    jmp WRITE_HW1

ALIVE_HW1:

    cmpl $2, %r10d
    je KEEP_HW1
    cmpl $3, %r10d
    je KEEP_HW1
    jmp WRITE_HW1


KEEP_HW1:

    movb $1, %dl

WRITE_HW1:

    leaq next_board(%rip), %rdi
    movb %dl, (%rdi, %rax, 1)

    incl %r9d
    jmp COL_HW1

NEXTROW_HW1:

    incl %r8d
    jmp ROW_HW1

END_HW1:
