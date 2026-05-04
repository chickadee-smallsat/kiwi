<section class="manual-sheet" markdown="1">

# Get to know your Kiwi

Kiwi is a single-board satellite.
Meaning, it is a single, printed-circuit board (PCB) with different components attached to it that perform different functions.
The following sections will introduce you to various parts of a Kiwi - some that are visible, and some that are not.

### The Hardware

The interactive diagram below shows the front and back of the Kiwi PCB.
Click the rectangle around a component to see its designation, part number, and description.

<div class="pcb-viewer-wrap">
  <iframe src="{{ '/assets/media/kiwi-pcb-viewer.html' | relative_url }}?front={{ '/pcb-annotation/kiwi_front.png' | relative_url }}&back={{ '/pcb-annotation/kiwi_back.png' | relative_url }}"
          title="Kiwi PCB Interactive Viewer"
          loading="lazy"
          scrolling="no"
          id="pcb-viewer-frame"
          onload="this.style.height=(this.contentWindow.document.body.scrollHeight+32)+'px'; (function(f){window.addEventListener('message',function(e){if(e.data&&e.data.type==='pcb-resize')f.style.height=(e.data.height+32)+'px';});})(this);">
  </iframe>
</div>

The central component of the Kiwi is the Raspberry Pi RP2350B microcontroller, which serves as the "brain" of Kiwi, managing its operations in processing sensor data and handling communications.
Kiwi contains a 2 MiB (1 MiB = 1024 KiB = 1024 &times; 1024 bytes) flash memory chip, which is used to store the software program executed by the microcontroller.
Additional peripherals can be stacked on top of Kiwi through the 60-pin expansion sockets (`TOP1` and `TOP2`) and plugs (`BOT1` and `BOT2`).
Kiwi also contains a variety of sensors, including an accelerometer, gyroscope, magnetometer, barometer, temperature sensor, air quality index (AQI) and humidity sensor, and light sensors on each side of the board.
Kiwi has a built-in Wi-Fi (2.4 GHz) radio for wireless communication, and a USB port for power and configuration updates.
There is also an on-board micro-SD card slot for additional data storage.

### The Firmware

[Firmware](https://en.wikipedia.org/wiki/Firmware) is the software that runs on the microcontroller on-board the Kiwi, controlling its hardware functions and defining its operations.
Kiwis come preloaded with a firmware that provides the basic functionality of reading out various sensor measurements, and broadcasting them over Wi-Fi.

The firmware is upgradable (requires a computer and the [Raspberry Pi Debug Tool](https://www.raspberrypi.com/documentation/computers/debug-tool/)).
Custom firmware can also be developed and flashed onto the Kiwi, allowing for custom behavior and functionality.
A [MicroPython](https://micropython.org/) interpreter is also available for the Kiwi, allowing users to write and execute Python code directly on the device.

### Kiwi Plotter

[Kiwi Plotter](https://github.com/chickadee-smallsat/kiwi-clients/releases/latest) is a free, cross-platform software that allows you to visualize, and collect data from various sensors on your Kiwi over Wi-Fi.
Kiwi Plotter is available for Windows, macOS (ARM-based) and Linux (as an AppImage).

#### Windows Installation
Download `Kiwi Plotter Setup <Version> x64.zip`.
Navigate to the location of the ZIP archive, and double-click on the file to open it.
The archive contains a single file `Kiwi Plotter Setup <Version>-x64.exe`.
Double-click on this file to open it.
You will be presented with the Windows SmartScreen filter dialog, since the Kiwi Plotter installer is not signed by a digital signature.
Click on "More Info", then <ui-btn>Run Anyway</ui-btn> to proceed with the installation.
![Windows SmartScreen Filter](assets/media/windows/windows_smart_screen.png){: style="width: 50%" .collapsible }
![Windows SmartScreen Filter: Run Anyway](assets/media/windows/windows_smart_screen_run_anyway.png){: style="width: 50%" .collapsible }
As long as it is downloaded from [here](https://github.com/chickadee-smallsat/kiwi-clients/releases/latest), it should be completely safe to install and execute.
The source code for the plotter is available [here](https://github.com/chickadee-smallsat/kiwi-clients).
Upon installation, the Kiwi Plotter will start automatically.

#### macOS Installation

</section>
