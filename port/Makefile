PROJ = main
CPU ?= cortex-m3
BOARD ?= stm32vldiscovery

FREERTOS_PATH = ../FreeRTOS-Kernel



OBJ = boot.o \
	  start.o \
	  portFunctions.o \
	  $(FREERTOS_PATH)/tasks.o \
	  $(FREERTOS_PATH)/list.o \
	  $(FREERTOS_PATH)/portable/MemMang/heap_4.o  \
	  $(FREERTOS_PATH)/portable/GCC/ARM_CM3/port.o \

INC = -I$(FREERTOS_PATH)/portable/GCC/ARM_CM3/	\
	  -I$(FREERTOS_PATH)/include/	\
	  -I.	\

.PHONY: all
all: $(PROJ).elf

# Assemble .S file into .o
%.o: %.S
	arm-none-eabi-as -mthumb -mcpu=$(CPU) -g -o $@ $<

%.o: %.c
	arm-none-eabi-gcc $(INC) -mthumb -mcpu=$(CPU) -g -c $^ -o $@

# Link object into ELF
$(PROJ).elf: $(OBJ)
	arm-none-eabi-ld -Tmap.ld $^ -o $@

# Disassemble
	arm-none-eabi-objdump -D -S $@ > $@.lst
	arm-none-eabi-readelf -a $@ > $@.debug

# QEMU launch
qemu:
	qemu-system-arm -S -M $(BOARD) -cpu $(CPU) -nographic -kernel $(PROJ).elf -gdb tcp::1234

# GDB remote debug
gdb:
	gdb-multiarch -q $(PROJ).elf -ex "target remote localhost:1234"

clean:
	rm -rf *.o *.elf *.lst *.debug
