#include "app_tasks.h"
#include "cmsis_os2.h"

#include <stdio.h>

void Task2(void *argument) {
    (void)argument;
    uint32_t count = 0;

    for (;;) {
        ++count;
        printf("[Task 2 | Priorität %d] Log-Nachricht %u\n",
               (int)osThreadGetPriority(osThreadGetId()),
               (unsigned int)count);
        fflush(stdout);
        osDelay(1500U);
    }
}
