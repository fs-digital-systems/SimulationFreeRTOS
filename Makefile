CC ?= gcc
CFLAGS ?= -std=gnu11 -O2 -g -Wall -Wextra -Wpedantic
LDFLAGS ?=
LDLIBS := -pthread

BUILD_DIR := build
TARGET := $(BUILD_DIR)/cmsis_freertos_demo
KERNEL_DIR := FreeRTOS/FreeRTOS/Source
POSIX_DIR := $(KERNEL_DIR)/portable/ThirdParty/GCC/Posix
CMSIS_DIR := CMSIS_6/CMSIS
CMSIS_FREERTOS_DIR := CMSIS-FreeRTOS/CMSIS/RTOS2/FreeRTOS

APP_SOURCES := APP/Task1.c APP/Task2.c APP/Task3.c
KERNEL_SOURCES := $(wildcard $(KERNEL_DIR)/*.c)
KERNEL_SOURCES += $(KERNEL_DIR)/portable/MemMang/heap_3.c
KERNEL_SOURCES += $(POSIX_DIR)/port.c
KERNEL_SOURCES += $(POSIX_DIR)/utils/wait_for_event.c
SOURCES := $(APP_SOURCES) $(KERNEL_SOURCES) $(CMSIS_FREERTOS_DIR)/Source/cmsis_os2.c
OBJECTS := $(addprefix $(BUILD_DIR)/,$(SOURCES:.c=.o))
DEPFILES := $(OBJECTS:.o=.d)

CPPFLAGS += -IAPP
CPPFLAGS += -I$(CMSIS_DIR)/RTOS2/Include
CPPFLAGS += -I$(CMSIS_DIR)/Core/Include
CPPFLAGS += -I$(CMSIS_FREERTOS_DIR)/Include
CPPFLAGS += -I$(KERNEL_DIR)/include
CPPFLAGS += -I$(POSIX_DIR)
CPPFLAGS += -I$(POSIX_DIR)/utils
CPPFLAGS += -DCMSIS_device_header=\"cmsis_posix_device.h\"
CPPFLAGS += -DprojENABLE_TRACING=0 -DprojCOVERAGE_TEST=0

.PHONY: all init update run clean

all: check-dependencies $(TARGET)

check-dependencies:
	@test -f "$(KERNEL_DIR)/tasks.c" || { \
		echo "FreeRTOS-Kernel fehlt. Bitte zuerst 'make init' ausführen."; \
		exit 1; \
	}
	@test -f "$(CMSIS_FREERTOS_DIR)/Source/cmsis_os2.c" || { \
		echo "CMSIS-FreeRTOS-Adapter fehlt. Bitte zuerst 'make init' ausführen."; \
		exit 1; \
	}
	@test -f "$(CMSIS_DIR)/RTOS2/Include/cmsis_os2.h" || { \
		echo "CMSIS-RTOS2-Header fehlen. Bitte zuerst 'make init' ausführen."; \
		exit 1; \
	}

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(BUILD_DIR)/%.o: %.c APP/FreeRTOSConfig.h APP/cmsis_posix_device.h
	@mkdir -p "$(@D)"
	$(CC) $(CPPFLAGS) $(CFLAGS) -MMD -MP -c $< -o $@

-include $(DEPFILES)

init:
	git submodule update --init FreeRTOS CMSIS-FreeRTOS CMSIS_6
	git -C FreeRTOS submodule update --init FreeRTOS/Source

update:
	git -C FreeRTOS pull --ff-only origin main
	git -C FreeRTOS submodule update --init FreeRTOS/Source
	git -C CMSIS-FreeRTOS pull --ff-only origin main
	git -C CMSIS_6 pull --ff-only origin main

run: all
	./$(TARGET)

clean:
	rm -rf "$(BUILD_DIR)"
