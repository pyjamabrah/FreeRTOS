
#include "FreeRTOS.h"
#include "task.h"

static void vTask1(void *pvParameters){
    volatile int a = 0;
    while(1){
        a++;
    }
}

static void vTask2(void *pvParameters){
    volatile int b = 0;
    while(1){
        b++;
    }
}

//Get the start from linker files
extern uint32_t _sdata; //start of .data in RAM
extern uint32_t _edata; //end of .data in RAM
extern uint32_t _sidata; //start of .data in FLASH
extern uint32_t _sbss; //start of .bss
extern uint32_t _ebss; //end of .bss

void start(){
    BaseType_t xReturn;

    //Intialize .data section (copy from FLASH to RAM)
    uint32_t *src = &_sidata;  //From flash
    uint32_t *dst = &_sdata;   //To RAM
    while(dst < &_edata){
        *dst++ = *src++;    //copy word and increament pointers
    }

    //Intialize .bss section (zero out)
    dst = &_sbss;
    while(dst < &_ebss){
        *dst++ = 0;  //zero word and increament pointer
    }
    
    xReturn = xTaskCreate(vTask1, "T1", configMINIMAL_STACK_SIZE, NULL, 1, NULL);
    xReturn = xTaskCreate(vTask2, "T2", configMINIMAL_STACK_SIZE, NULL, 1, NULL);

    vTaskStartScheduler();
    return;
}