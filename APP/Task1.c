#include "app_tasks.h"
#include "cmsis_os2.h"

#include <stdio.h>
#include <stdlib.h>

void Task1(void *argument) {
    (void)argument;
    uint32_t count = 0;

    for (;;) {
        ++count;
        printf("[Task 1 | Priorität %d] Log-Nachricht %u\n",
               (int)osThreadGetPriority(osThreadGetId()),
               (unsigned int)count);
        fflush(stdout);
        osDelay(1000U);
    }
}

int main(void) {
    const osThreadAttr_t task1_attributes = {
        .name = "Task1",
        .priority = osPriorityHigh,
    };
    const osThreadAttr_t task2_attributes = {
        .name = "Task2",
        .priority = osPriorityNormal,
    };
    const osThreadAttr_t task3_attributes = {
        .name = "Task3",
        .priority = osPriorityLow,
    };
    osStatus_t status;

    status = osKernelInitialize();
    if (status != osOK) {
        fprintf(stderr, "CMSIS-RTOS2: Kernel-Initialisierung fehlgeschlagen (%d).\n",
                (int)status);
        return EXIT_FAILURE;
    }

    if (osThreadNew(Task1, NULL, &task1_attributes) == NULL ||
        osThreadNew(Task2, NULL, &task2_attributes) == NULL ||
        osThreadNew(Task3, NULL, &task3_attributes) == NULL) {
        fprintf(stderr, "CMSIS-RTOS2: Ein Task konnte nicht erstellt werden.\n");
        return EXIT_FAILURE;
    }

    puts("CMSIS-RTOS2-Demo gestartet: Task 1 (hoch), Task 2 (normal), Task 3 (niedrig)");
    fflush(stdout);

    status = osKernelStart();
    if (status != osOK) {
        fprintf(stderr, "CMSIS-RTOS2: Schedulerstart fehlgeschlagen (%d).\n",
                (int)status);
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
