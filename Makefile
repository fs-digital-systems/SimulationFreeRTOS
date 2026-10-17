UPSTREAM_DIR := FreeRTOS
DEMO_DIR := $(UPSTREAM_DIR)/FreeRTOS/Demo/Posix_GCC
DEMO_BINARY := $(DEMO_DIR)/build/posix_demo

.PHONY: all init update run clean

all:
	@test -f "$(UPSTREAM_DIR)/FreeRTOS/Source/tasks.c" || { \
		echo "FreeRTOS fehlt. Initialisiere zuerst mit: make init"; \
		exit 1; \
	}
	$(MAKE) -C "$(DEMO_DIR)" USER_DEMO=BLINKY_DEMO

init:
	git submodule update --init --recursive

update:
	git -C "$(UPSTREAM_DIR)" pull --ff-only origin main
	git -C "$(UPSTREAM_DIR)" submodule update --init --recursive

run: all
	"./$(DEMO_BINARY)"

clean:
	$(MAKE) -C "$(DEMO_DIR)" clean
