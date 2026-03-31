MEMORY
{
    FLASH : ORIGIN = 0X08000000, LENGTH = 128K
    RAM : ORIGIN = 0X20000000, LENGTH = 8K
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
    } > RAM AT > FLASH

    .bss : ALIGN(4) {
        _sbss = .;
        *(.bss*)
        . = ALIGN(4);
        _ebss = .;
    } > RAM AT > FLASH

    __StackTop = ORIGIN(RAM) + LENGTH(RAM);
    PROVIDE(__stack = __StackTop - 4);
}
