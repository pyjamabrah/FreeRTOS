    .section .vectors
vector_table:
    .word __stack
    .word reset_handler
    .zero 400

    .section .text
    .align 1
    .type reset_handler, %function

reset_handler:
    b start
    b .
