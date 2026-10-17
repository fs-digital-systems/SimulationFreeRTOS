#include "app_tasks.h"
#include "cmsis_os2.h"

#include <stdio.h>

void Task3(void *argument) {
    (void)argument;
    uint32_t count = 0;

    for (;;) {
        ++count;
        printf("[Task 3 | Priorität %d] Log-Nachricht %u\n",
               (int)osThreadGetPriority(osThreadGetId()),
               (unsigned int)count);
        fflush(stdout);
        osDelay(2000U);
    }
}
