#ifndef APP_FREERTOS_CONFIG_H
#define APP_FREERTOS_CONFIG_H

#include "../FreeRTOS/FreeRTOS/Demo/Posix_GCC/FreeRTOSConfig.h"

#undef configMAX_PRIORITIES
#define configMAX_PRIORITIES 56

#undef configSUPPORT_STATIC_ALLOCATION
#define configSUPPORT_STATIC_ALLOCATION 0

#undef configUSE_IDLE_HOOK
#define configUSE_IDLE_HOOK 0

#undef configUSE_TICK_HOOK
#define configUSE_TICK_HOOK 0

#undef configUSE_DAEMON_TASK_STARTUP_HOOK
#define configUSE_DAEMON_TASK_STARTUP_HOOK 0

#undef configGENERATE_RUN_TIME_STATS
#define configGENERATE_RUN_TIME_STATS 0

#endif
