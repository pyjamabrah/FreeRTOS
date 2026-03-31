.section .vectors
vector_table:
    .word __stack
    .word reset_handler
    .word default
    .word default
    .word default
    .word default
    .word default
    .word default
    .word default
    .word default
    .word default
    .word vPortSVCHandler
    .word default
    .word default
    .word xPortPendSVHandler
    .word xPortSysTickHandler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function
reset_handler:
    mov r1, #1
    mov r2, #2
    add r3, r2, r1
    b start
    b .

    .section .text
    .align 1
    .type default, %function
default:
    b .

