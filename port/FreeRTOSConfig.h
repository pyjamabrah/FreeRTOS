#ifndef _CONFIG_H__
#define _CONFIG_H__

#define configTICK_TYPE_WIDTH_IN_BITS   TICK_TYPE_WIDTH_32_BITS
#define configMAX_SYSCALL_INTERRUPT_PRIORITY    1
#define configMINIMAL_STACK_SIZE    256
#define configMAX_PRIORITIES        5
#define configUSE_PREEMPTION        1
#define configUSE_IDLE_HOOK         0
#define configUSE_TICK_HOOK         0
#define configTOTAL_HEAP_SIZE       4096
#define configCPU_CLOCK_HZ          8000000
#define configTICK_RATE_HZ          10 /*10 TIMES IN 1 SECOND OR SCHEDULING RATE*/






#endif
