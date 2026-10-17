# CMSIS-RTOS2-FreeRTOS-Simulation unter Ubuntu

Dieses Projekt bindet die offizielle [FreeRTOS-Gesamtdistribution](https://github.com/FreeRTOS/FreeRTOS)
als Git-Submodul ein und baut den echten FreeRTOS-Kernel mit dem Linux/POSIX-
Port. Die eigene Demo in `APP/` verwendet ausschließlich die CMSIS-RTOS2-API
aus dem offiziellen [ARM CMSIS-FreeRTOS-Adapter](https://github.com/ARM-software/CMSIS-FreeRTOS).
CMSIS 6 wird ebenfalls direkt aus dem offiziellen [ARM-Repository](https://github.com/ARM-software/CMSIS_6)
eingebunden. Die drei Tasks haben unterschiedliche Prioritäten und schreiben
regelmäßig Logmeldungen.

## Klonen

```sh
git clone https://github.com/fs-digital-systems/SimulationFreeRTOS.git
cd SimulationFreeRTOS
make init
```

`make init` lädt gezielt den FreeRTOS-Kernel, den CMSIS-FreeRTOS-Adapter und
CMSIS 6. Nicht benötigte Bibliotheken und Hardware-Demos werden ausgelassen.

## Bauen und starten

Benötigt werden GCC und GNU Make. Auf Ubuntu:

```sh
sudo apt install build-essential
./build.sh
./start.sh
```

`build.sh` baut die drei Anwendungsdateien `APP/Task1.c`, `APP/Task2.c` und
`APP/Task3.c` zusammen mit dem unveränderten FreeRTOS-Kernel und CMSIS-RTOS2-
Adapter. `start.sh` baut bei Bedarf und startet danach die Demo. Mit `Ctrl+C`
wird sie beendet. Beide Skripte können aus jedem Arbeitsverzeichnis aufgerufen
werden. `make clean` entfernt die Build-Ausgabe.

## FreeRTOS aktualisieren

```sh
make update
```

Der Befehl aktualisiert Kernel, CMSIS-FreeRTOS-Adapter und CMSIS 6 auf deren
Upstream-`main`-Branches. Die verwendeten Versionen werden im äußeren Git-
Repository als Submodul-Commits festgehalten.

## Grenzen des Linux-Ports

Das ist der offizielle FreeRTOS-Kernel mit POSIX-Port, kein Mikrocontroller-
Emulator. Der Linux-Kernel stellt die Threads bereit; CMSIS-Geräteperipherie
wie GPIO und Interruptcontroller wird nicht simuliert. Scheduling- und
Zeitverhalten sind unter Ubuntu nicht echtzeitgarantiert und können von einem
Mikrocontroller abweichen.
