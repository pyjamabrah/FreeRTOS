#include "FreeRTOS.h"
#include "task.h"
void start(void);

static void vTask1(void *pvParameters){
    volatile int a =0;
    while(1)
    {
        a++;
    }
}

static void vTask2(void *pvParameters){
    volatile int b =0;
    while(1)
    {
        b++;
    }
}



extern uint32_t _sdata;    //start of .data in RAM
extern uint32_t _edata;    //end of .data in RAM
extern uint32_t _sidata;   //start of .data in flash
extern uint32_t _sbss;     //start of .bss
extern uint32_t _ebss;        //end of .bss






void start(){
    BaseType_t xReturn;
    //Initialize .data section (copy from flash to RAM)
    uint32_t *src = &_sidata;//Source flash
    uint32_t *dst = &_sdata;//Destination RAM
    while(dst < &_edata){
        *dst++ = *src++; //copy word and increment pointer
    }

    //Initialize .bss section (zero out)
    dst = &_sbss;
    while(dst < &_ebss){
        *dst++ = 0; //zero word and increment pointer
    }
    xReturn = xTaskCreate(vTask1,"T1",configMINIMAL_STACK_SIZE,NULL,1,NULL);  // 256*4 = 1k stack size
    xReturn = xTaskCreate(vTask2,"T2",configMINIMAL_STACK_SIZE,NULL,1,NULL);

    xPortStartScheduler();
    return;
}