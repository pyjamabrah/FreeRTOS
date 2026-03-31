#include "FreeRTOS.h"
#include "task.h"

static void vTask1(void *pvParameters)
{
    volatile int a = 0;
    while(1)
    {
        a++;
    }
}
static void vTask2(void *pvParameters)
{
    volatile int b = 0;
    while(1)
    {
        b++;
    }
}

extern uint32_t _sdata, _edata, _sidata, _sbss, _ebss;
void start()
{
    BaseType_t xReturn;
    uint32_t*src = &_sidata;
    uint32_t *dest = &_sdata;
    while(dest < &_edata)
    {
        *dest++ = *src++;
    }
    dest = &_sbss;
    while(dest < &_ebss)
    {
        *dest++ = 0;
    }
    xReturn = xTaskCreate(vTask1, "T1", configMINIMAL_STACK_SIZE, NULL, 1, NULL);
    xReturn = xTaskCreate(vTask2, "T2", configMINIMAL_STACK_SIZE, NULL, 1, NULL);
    portENABLE_INTERRUPTS();
    xPortStartScheduler();
    return;
}
