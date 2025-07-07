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
    .align 2
    .thumb_func
    .type default, %function
    .type reset_handler, %function

reset_handler:
    // Copy initialized data from FLASH to RAM
    ldr r0, =_sidata      // source: flash
    ldr r1, =_sdata       // destination: ram
    ldr r2, =_edata       // end of data

copy_data:
    cmp r1, r2
    bcs zero_bss          // if r1 >= r2, jump to zero_bss
    ldr r3, [r0]
    str r3, [r1]
    add r0, r0, #4
    add r1, r1, #4
    b copy_data

zero_bss:
    ldr r0, =_sbss
    ldr r1, =_ebss

zero_loop:
    cmp r0, r1
    bcs call_main
    movs r2, #0
    str r2, [r0]
    add r0, r0, #4
    b zero_loop

call_main:
    bl start
    b .

default:
    b .
