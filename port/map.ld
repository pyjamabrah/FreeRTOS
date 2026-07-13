MEMORY
{
    FLASH : ORIGIN = 0x0, LENGTH = 128K
    RAM : ORIGIN = 0x20000000, LENGTH = 8K
}

SECTIONS
{
    .text : {
        _stext = .;
        *(.vectors*)
        *(.text*)
        *(.rodata)
        *(.rodata.*)
        _etext = .;
    } > FLASH

    .data : ALIGN(4) {
        _sdata = .;
        _sidata = LOADADDR(.data);
        *(.data*)
        . = ALIGN(4);
        _edata = .;
    } > FLASH AT > RAM

    .bss : ALIGN(4) {
        _sbss = .;
        *(.bss*)
        . = ALIGN(4);
        _ebss = .;
    } > RAM

    __StackTop = ORIGIN(RAM) + LENGTH(RAM);
    PROVIDE(__stack = __StackTop - 4);
}