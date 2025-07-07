/* Memory map definition */
MEMORY
{
  FLASH : ORIGIN = 0x00000000, LENGTH = 128K   /* Use 0x0 for QEMU boot */
  RAM   : ORIGIN = 0x20000000, LENGTH = 8K
}


SECTIONS
{
  /* Code and constants go into FLASH memory */
  .text :
  {
    _stext = .;               /* Mark the start of .text section with symbol _stext */

    *(.vectors)               /* Vector table (reset handler, IRQs) placed first */
    *(.text*)                 /* All code from .text sections of all object files */
    *(.rodata)                /* Read-only data (like const strings, tables) */
    *(.rodata.*)              /* Any other read-only sections (wildcard for safety) */

    _etext = .;               /* Mark the end of .text section with symbol _etext */
  } > FLASH                   /* Place all of the above into FLASH memory */

  /* Initialized data section: will be copied from FLASH to RAM during startup */
  .data : ALIGN(4)
  {
    _sdata = .;              /* Start of .data section in RAM */
    _sidata = LOADADDR(.data);/* Address in FLASH where initial data values are stored */

    *(.data*)                 /* All initialized data (global/static variables) */
    . = ALIGN(4);             /* Align to 4-byte boundary */

    _edata = .;               /* End of .data section in RAM */
  } > RAM AT > FLASH          /* Place in RAM, but initial values come from FLASH */

  /* Uninitialized data section: will be zero-initialized by startup code */
  .bss : ALIGN(4)
  {
    _sbss = .;                /* Start of .bss section */

    *(.bss*)                  /* All uninitialized data (e.g., int x;) */
    . = ALIGN(4);             /* Align to 4-byte boundary */

    _ebss = .;                /* End of .bss section */
  } > RAM                     /* Entire .bss section resides in RAM */

  /* Optional manual stack allocation section (commented out here)
  .stack (COPY):
  {
    __stack_start__ = .;     // Start of stack memory
    . = . + 0x400;           // Reserve 1 KB stack
    __stack_end__ = .;       // End of stack memory
  } > RAM */

  /* Set initial stack pointer to the top of RAM (MSP = __StackTop) */
  __StackTop = ORIGIN(RAM) + LENGTH(RAM);  /* Top of stack = start of RAM + RAM size */

  /* If __stack symbol is not already defined, define it here as __StackTop */
  PROVIDE(__stack = __StackTop);
}
