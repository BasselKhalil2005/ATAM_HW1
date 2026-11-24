.global _start

.section .text
_start:

    movl length, %ebx
    movl window_size, %ecx
    movq $0, %rsi # i = 0
    movl $0, %eax # window_sum = 0

first_window_HW1:

    cmpl %ecx, %esi
    jge init_max_HW1
    addl values(, %rsi, 4), %eax
    incq %rsi
    jmp first_window_HW1

init_max_HW1:

    movl %eax, %edx # max_sum = window_sum
    movl $0, %edi # start_index = 0
    movl $1, %r9d # max_windows = 1
    movq $0, %r8 # r8 = start of the window

loop_HW1:

    cmpl %ebx, %esi
    jge end_HW1
    addl values(, %rsi, 4), %eax
    subl values(, %r8, 4), %eax
    incq %r8
    cmpl %edx, %eax
    jl next_iter_HW1
    je same_max_HW1

new_max_HW1:

    movl %eax, %edx
    movl %r8d, %edi
    movl $1, %r9d
    jmp next_iter_HW1

same_max_HW1:

    incl %r9d

next_iter_HW1:

    incq %rsi
    jmp loop_HW1

end_HW1:

    movl %edx, max_sum
    movl %edi, start_index
    movl %r9d, max_windows
