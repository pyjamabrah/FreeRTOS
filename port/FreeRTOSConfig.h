#ifndef _CONFIG_H
#define __CONFIG_H__

#define configTICK_TYPE_WIDTH_IN_BITS               TICK_TYPE_WIDTH_32_BITS
#define configMAX_SYSCALL_INTERRUPT_PRIORITY        191  // 0xBF
#define configKERNEL_INTERRUPT_PRIORITY             255  // 0xFF

#define configMINIMAL_STACK_SIZE                    0x100
#define configMAX_PRIORITIES                        5
#define configUSE_PREEMPTION                        1
#define configUSE_IDLE_HOOK                         0
#define configUSE_TICK_HOOK                         0
#define configTOTAL_HEAP_SIZE                       0x1000
#define configCPU_CLOCK_HZ                          80000000UL
#define configTICK_RATE_HZ                          10
#define configASSERT(x) if((x)==0){taskDISABLE_INTERRUPTS(); for(;;);}

#endif
