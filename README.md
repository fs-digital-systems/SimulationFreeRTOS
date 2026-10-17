# FreeRTOS POSIX-Simulation unter Ubuntu

Dieses Projekt bindet die offizielle [FreeRTOS-Gesamtdistribution](https://github.com/FreeRTOS/FreeRTOS)
als Git-Submodul ein. Darin liegt das offizielle `Posix_GCC`-Demo: Es baut den
echten FreeRTOS-Kernel mit dem mitgelieferten Linux/POSIX-Port. Der Upstream-
Quellcode wird nicht in diesem Projekt dupliziert oder verändert.

## Klonen

```sh
git clone --recurse-submodules https://github.com/fs-digital-systems/SimulationFreeRTOS.git
cd SimulationFreeRTOS
```

Wenn das Projekt bereits ohne Submodule geklont wurde:

```sh
git submodule update --init --recursive
```

## Bauen und starten

Benötigt werden GCC und GNU Make. Auf Ubuntu:

```sh
sudo apt install build-essential
make
make run
```

`make run` startet die offizielle FreeRTOS-Blinky-Demo. Mit `Ctrl+C` wird sie
beendet. `make clean` entfernt die Build-Ausgabe des Demos.

## FreeRTOS aktualisieren

```sh
make update
```

Das aktualisiert die offizielle Distribution auf `main` und initialisiert die
von ihr festgelegten Versionen aller verschachtelten Submodule. Alternativ
entspricht dies:

```sh
cd FreeRTOS
git pull --ff-only origin main
git submodule update --init --recursive
```

Die gewählte FreeRTOS-Version wird im äußeren Git-Repository als Submodul-
Commit festgehalten. Nach `make update` kann dieser aktualisierte Commit mit
dem Projekt eingecheckt werden, damit andere denselben Stand verwenden.

## Grenzen des Linux-Ports

Das ist der offizielle FreeRTOS-Kernel mit POSIX-Port, kein Mikrocontroller-
Emulator. Der Linux-Kernel stellt die Threads bereit; MCU-Peripherie wie GPIO,
Timer und Interruptcontroller wird nicht automatisch simuliert. Scheduling-
und Zeitverhalten sind unter Ubuntu nicht echtzeitgarantiert und können von
einem Mikrocontroller abweichen.
