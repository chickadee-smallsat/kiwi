#import "@preview/cetz:0.3.1": canvas
#import "@preview/cetz-plot:0.1.0": chart, plot
#import "@preview/gentle-clues:1.3.0": *
#import "tids.typ": tids

#let gpred = rgb(168, 42, 72)
#let i2c = [I#super([2])C]

#let metadata = (
  title: [Kiwi Mainboard Datasheet (Work In Progress)],
  product: "Kiwi Mainboard",
  product_url: "https://github.com/chickadee-smallsat/kiwi-mainboard",
)

#let features = [
  - #link("https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf")[Raspberry Pi RP2350B Microcontroller] with 2 to 4 MB program memory
  - 5V Supply Voltage, 5V tolerant I/O#footnote[The GPIO pins are 5V tolerant (up to 5.5V) only when `IOVDD` is present and is 3V3. The GPIO pins are only 3V3 failsafe otherwise. Note, the on-board 5V to 3V3 regulator takes time to power up and stabilize and `IOVDD` is absent at this time. Refer to the #link("https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf#gpio-pins-table")[Raspberry Pi RP2350B Datasheet] for more details.]
  - Low power operation (< 1W)
  - 60 mm $times$ 60 mm single board
  - Temperature Range: -40°C to 150°C
  - Power over USB or stack connector
  - Connectivity:
    - IEEE 802.11n 2.4GHz WiFi
    - Bluetooth 5.2 with BLE
    - Integrated CAN transceiver
  - Micro-SD storage up to 16GB
  - Accelerometer, Gyroscope, Magnetometer, Humidity, Air Quality, Temperature, Pressure, Flux sensors
  - Stackable for further I/O expansion
  - Supports ARM Serial Wire Debug, compatible with #link("https://www.raspberrypi.com/documentation/microcontrollers/debug-probe.html")[Raspberry Pi Debug Probe]
]


#let applications = [

  Kiwi Mainboard is a highly integrated module geared towards
  - Education
  - Table-top experiments
  - Environmental sensing
  - Sub-orbital experiments

  //   #figure(
  //     rect(image("./assets/741.svg"), stroke: 0.5pt),
  //     caption: "Typical Application",
  //   )
]

#let desc = [
  Kiwi Mainboard is a compact, low-power microcontroller board providing core functionality to the Kiwi family of laboratory, bench-top flat satellites; and environmental sensing and communication to the RAIL family of sub-orbital experiments.

  The board includes a variety of sensors, modes of communication, and exposes many general purpose input/output (GPIO) pins for expansion. It is designed to be stackable, allowing expansion of capabilities through additional boards.
]

#let rev_list = (
  (
    rev: [Rev. B1],
    date: [2025-10-06],
    body: [
      - Hardware
        - Replaced Bosch BMP390 with Measurement Specialty MS560702BA03-50 for pressure and altitude measurement.
      - Documentation
        - First release.
    ],
  ),
  (
    rev: [Rev. B0],
    date: [2025-09-15],
    body: [
      - Hardware
        - Integrated microcontroller instead of using separate stamp.
        - Added micro SD card slot.
    ],
  ),
  (
    rev: [Rev. A0],
    date: [2025-07-30],
    body: [
      - Hardware
        - Internal hardware release using the Chickadee Stamp.
        - Flight qualified on PICTURE-D mission as CHARIOT.
      - Software
        - Memory safe, event-driven, asynchronous firmware written in Rust.
    ],
  ),
)

#set text(lang: "en")

#show: doc => tids(
  ds_metadata: metadata,
  features: features,
  applications: applications,
  desc: desc,
  rev_list: rev_list,
  doc: doc,
)

#set par(justify: true)

= Specifications
#grid(
  columns: (1fr, 1fr),
  [#figure(
    rect(
      height: 31%,
      image("assets/kiwi_mainboard_b1_top.png"),
    ),
    caption: [Top View],
  )<BoardTop>],
  [#figure(
    rect(
      height: 31%,
      // canvas(length: 0.75cm, {
      //     plot.plot(size: (8, 6),
      //     x-tick-step: 1,
      //     x-ticks: ((-calc.pi, $-pi$), (0, $0$), (calc.pi, $pi$)),
      //     y-tick-step: 1,
      //     {
      //         plot.add(
      //         domain: (-calc.pi, calc.pi), x => calc.sin(x * 1rad))
      //     })
      // })
      image("assets/kiwi_mainboard_b1_bot.png"),
    ),
    caption: [Bottom View],
  )<BoardBottom>],
)

== Specifications
<Specifications>

#figure(
  table(
    columns: (0.5fr, auto, auto, auto, auto, 1fr),
    align: (
      left + horizon,
      right + horizon,
      right + horizon,
      right + horizon,
      left + horizon,
      left + horizon,
    ),

    table.header([Parameters], [Minimum], [Typical], [Maximum], [Unit], [Notes]),

    [Width], [---], [60], [---], [mm], [—],
    [Height], [---], [60], [---], [mm], [---],
    [Weight], [---], [TBD], [---], [g], [---],
    [Stand-off Height Above], [---], [5], [---], [mm], [---],
    [Stand-off Height Below], [5], [5], [6], [mm], [Increments of 0.5 mm],
  ),
  caption: "Physical Characteristics",
)

#figure(
  table(
    columns: (1fr, auto, auto, auto, auto, auto, 1fr),
    align: (
      left + horizon,
      center + horizon,
      right + horizon,
      right + horizon,
      right + horizon,
      left + horizon,
      left + horizon,
    ),

    table.header([Parameters], [Symbol], [Minimum], [Typical], [Maximum], [Unit], [Condition]),

    [Operating Voltage], [$V_(upright("IN"))$], [4], [5], [5.5], [V], [—],

    [Operating Current],
    [$I$],
    [---],
    [250],
    [---],
    [mA],
    [Power over USB, sensors running at 50Hz cadence with TCP server serving data over WiFi at 22#sym.degree\C],
  ),
  caption: "Electrical Specifications",
)

== Absolute Maximum Ratings
<AbsoluteMaximumRatings>

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, 1fr),
    align: (left, center, right, right, center, left),

    table.header([Parameter], [Symbol], [Minimum Value], [Maximum Value], [Unit], [Note]),

    [Power Supply Voltage], [$V_(upright("IN"))$], [-0.3], [6.2], [V], [],

    [Ambient Temperature], [$T_A$], [-40], [85], [°C], [],
  ),
  caption: "Absolute Maximum Ratings",
)

#pagebreak()

= Detailed Description
<DetailedDescription>

== Overview

Kiwi Mainboard is a System-on-a-Module (SoM) around the #link("https://www.raspberrypi.com/products/rp2350/")[Raspberry Pi RP2350B] microcontroller.
Unlike a traditional microcontroller breakout board that provides access to the various I/O pins on the microcontroller, the SoM includes common environmental sensors and communication capabilities.
This makes the SoM suitable for table-top experiments without the need of additional hardware.

The SoM includes an accelerometer, a gyroscope, a magnetometer, an air quality and humidity sensor, a pressure and temperature sensor that also functions as an altimeter, and two light flux sensors on either sides of the module.
The SoM has a micro-SD card slot, allowing it to store data up to 16 GiB.
The integrated #link("https://www.raspberrypi.com/products/radio-module-2/")[Raspberry Pi RM2] provides wireless connectivity through 2.4GHz, single channel #link("https://en.wikipedia.org/wiki/Wi-Fi")[WiFi] or #link("https://en.wikipedia.org/wiki/Bluetooth")[Bluetooth] 5.2 with #link("https://en.wikipedia.org/wiki/Bluetooth_Low_Energy")[Low Energy].

The SoM can be powered via a USB micro-B port #box(image("assets/usb_microb.png"), height: 12pt) connected to a wall-wart or a PC.
#link("https://en.wikipedia.org/wiki/Firmware")[Firmware] can be uploaded to the SoM over USB.
The SoM can provide one or more UART interfaces over USB for communication depending on firmware configuration.
The SoM leverages the commercially available #link("https://www.raspberrypi.com/documentation/microcontrollers/debug-probe.html")[Raspberry Pi Debug Probe] for advanced programming and debugging capabilities offered by the Arm Serial-Wire-Debug (SWD) protocol.

The SoM is compatible with the #link(<BrdStack>)[Chickadee Stackable Bus] system.
The stack connectors can provide power and communication over #link("https://en.wikipedia.org/wiki/CAN_bus")[CAN] protocol, which allows multiple SoMs on the stack to communicate with each other.
28 #link("https://en.wikipedia.org/wiki/General-purpose_input/output")[#text(gpred, [`GPIO`])] pins are accessible on the stack connector for the microcontroller to connect to additional sensors and peripherals on the stack and expand its capabilities.

== Functional Block Diagram

#figure(
  rect(
    image("assets/kiwi_mainboard_revB1.drawio.svg"),
  ),
  caption: [Block diagram of Kiwi Mainboard.],
)

== Interfaces and Pin Configuration
<IfacePinConfig>

User servicable connectors are located on the top surface of the board (see @BoardTop).

=== USB (J1)
USB-micro B connector for power and USB data. Supports USB 1.1 Full Speed (12 Mbps) device mode. The USB port is used for uploading UF2 firmware when the board is booted into flash storage mode by holding down the #text(blue, [`BOOTSEL`]) button before powering up the board. The USB port also exposes multiple COM/UART devices to a connected host device via the USB CDC-ACM mode, if configured as such in the device firmware.

=== Arm Serial Wire Debug (J2)
1 mm pitch, 3-pin JST SH connector for ARM Serial Wire Debug (SWD) interface. Compatible with #link("https://www.raspberrypi.com/documentation/microcontrollers/debug-probe.html")[Raspberry Pi Debug Probe]. Connect to the Debug Probe "D" port using a 3-pin JST SH cable available with the probe. Refer to the Debug Probe documentation for the pinout of the port.

=== UART Connector (J3)
<UartConnJ3>
1.25 mm pitch Molex#sym.trademark.registered PicoBlade 53261-0671 6-pin, horizontal connector to provide a UART link (logic level 3V3) without hardware flow control.
5V (unregulated) and 3V3 (regulated) power is also available on this connector for the downstream device.

#figure(
  table(
    columns: (10%, 15%, 50%),
    align: (center + horizon, center + horizon, left + horizon),

    table.header([Pin], [Function], [Description]),

    [1], [+5V], [Unregulated/externally regulated bus voltage],
    [2], [+3V3], [3.3V power, 300 mA max.],
    [3], [RX], [Receive data from UART device],
    [4], [TX], [Send data to UART device],
    [5], [PPS], [Connected to #text(gpred, `GPIO0`) of the RP2350B. Intended for use as PPS input from a GPS device.],
    [6], [GND], [Ground return pin.],
  ),
  caption: "Pinout of UART Connector (J3)",
)<J3Pinout>

=== Bottom Stack Connector 1 (`BOT1`)
<StackBot1>
Amphenol Bergstack 10132798-062100LF 60-pin connector that mates with the board below it, allowing stack heights of 5 mm, 5.5 mm or 6 mm (depending on the height of the complimentary `TOP` connector on the board underneath it in the stack).
This connector provides power to the SoM, and continues the CAN bus signals downstream.
#figure(
  table(
    columns: (10%, 15%, 50%),
    align: (center + horizon, center + horizon, left + horizon),

    table.header([Pin], [Function], [Description]),

    [1--16], [+5V], [Externally regulated power input],
    [18, 21, 24, 28--30, 32, 37, 43, 49--52, 57--60], [GND], [Ground return for power],
    [22], [CAN+], [Positive wire of the CAN differential pair],
    [23], [CAN-], [Negative wire of the CAN differential pair],
    [17, 19--20, 25--27, 31, 33--36, 38--39, 41--42, 44--48, 53--56],
    [Reserved],
    [Pass from `BOT1` to `TOP1`, DO NOT CONNECT elsewhere.],
  ),
  caption: [Pinout of Stack Bottom 1 Connector (`BOT1`)],
)<StackBot1Pinout>

=== Top Stack Connector 1 (`TOP1`)
Amphenol 10132797-065100LF 60-pin connector that allows a gap (stack height) of 5 mm with the board stacked above it.
This connector passes through power for the stack upwards (received through #link(<StackBot1>)[`BOT1`]), and continues the CAN bus signals downstream.
The pinout of this connector is identical to #link(<StackBot1Pinout>)[`BOT1`].

=== Bottom Stack Connector 2 (`BOT2`)
<StackBot2>
Amphenol Bergstack 10132798-062100LF 60-pin connector that mates with the board below it, allowing stack heights of 5 mm, 5.5 mm or 6 mm (depending on the height of the complimentary `TOP` connector on the board underneath it in the stack).
This connector breaks out available GPIO pins from the SoM.

#show figure: set block(breakable: true)
#figure(
  table(
    columns: (10%, 15%, 50%),
    align: (center + horizon, center + horizon, left + horizon),

    table.header([Pin], [Function], [Description]),
    [33],
    text(gpred, [`WIFI_GP2`]),
    table.cell(
      rowspan: 26,
    )[GPIO pins from the RP2350B microcontroller. The number corresponds to the GPIO number (not the physical pin number). #text(gpred, [`WIFI_GP#`]) are GPIO pins from the RM2 module, and can not be directly accessed by the microcontroller.],
    [34], text(gpred, [`WIFI_GP1`]),
    [35], text(gpred, [`WIFI_GP0`]),
    [36], text(gpred, [`GPIO47`]),
    [37], text(gpred, [`GPIO46`]),
    [38], text(gpred, [`GPIO45`]),
    [39], text(gpred, [`GPIO44`]),
    [40], text(gpred, [`GPIO43`]),
    [41], text(gpred, [`GPIO42`]),
    [43], text(gpred, [`GPIO36`]),
    [44], text(gpred, [`GPIO37`]),
    [45], text(gpred, [`GPIO38`]),
    [46], text(gpred, [`GPIO39`]),
    [47], text(gpred, [`GPIO40`]),
    [48], text(gpred, [`GPIO41`]),
    [49], text(gpred, [`GPIO22`]),
    [50], text(gpred, [`GPIO15`]),
    [51], text(gpred, [`GPIO14`]),
    [52], text(gpred, [`GPIO13`]),
    [53], text(gpred, [`GPIO12`]),
    [54], text(gpred, [`GPIO11`]),
    [55], text(gpred, [`GPIO10`]),
    [56], text(gpred, [`GPIO9`]),
    [57], text(gpred, [`GPIO8`]),
    [58], text(gpred, [`GPIO7`]),
    [59], text(gpred, [`GPIO6`]),
    [1, 30, 31, 42, 60], [GND], [Signal ground return.],
    [2--29, 32], [Reserved], [Pass from `BOT2` to `TOP2`, DO NOT CONNECT elsewhere.],
  ),
  caption: [Pinout of Stack Bottom 2 Connector (`BOT2`)],
)<StackBot2Pinout>
#show figure: set block(breakable: false)

=== Top Stack Connector 2 (`TOP2`)
Amphenol 10132797-065100LF 60-pin connector that allows a gap (stack height) of 5 mm with the board stacked above it.
The GPIO pins from the SoM are available on this conector.
The pinout of this connector is identical to #link(<StackBot2Pinout>)[`BOT2`].

=== #i2c Address Table
The various sensors present on the SoM are addressable over the #i2c bus (RP2350B peripheral #text(gpred, [`I2C0`])).
Each sensor has a unique address that is used to communicate with it. The addresses of various sensosrs are tabulated in @I2cAddresses.

#figure(
  table(
    columns: (1fr, 2fr, 0.5fr),
    align: (center + horizon, center + horizon, center + horizon),

    table.header([Sensor], [Function], [Address]),

    [#link(<BoschImu>)[Bosch BMI323]], [Accelerometer, Gyroscope], [`0x68`],
    [Memsic MMC5983MA], [Magnetometer], [`0x30`],
    [TE MS560702BA03-50], [Precision barometer], [`0x77`],
    [Bosch BME680], [AQI, Humidity, Temperature sensor], [`0x76`],
    [TI OPT3001], [Light flux sensor, SoM top], [`0x44`],
    [TI OPT3001], [Light flux sensor, SoM bottom], [`0x45`],
  ),
)<I2cAddresses>

== Capabilities
=== Microcontroller
The microcontroller features two Arm Cortex M33 or two #link("https://github.com/wren6991/hazard3")[Hazard3] RISC-V CPU cores with hardware, #link("https://en.wikipedia.org/wiki/IEEE_754")[IEEE-754] single-precision (32-bit) floating point math support, running at 150 MHz, with 520 KiB of on-chip static random access memory (SRAM).
The microcontroller offers 2$times$#link("https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter")[UART], 2$times$#link("https://en.wikipedia.org/wiki/Serial_Peripheral_Interface")[SPI] and 2$times$#link("https://en.wikipedia.org/wiki/I%C2%B2C")[I#super([2])C] hardware peripherals, along with 24$times$#link("https://en.wikipedia.org/wiki/Pulse-width_modulation")[PWM] channels and 8$times$#link("https://en.wikipedia.org/wiki/Analog-to-digital_converter")[ADC] channels.
Additionally, the RP2350B offers 3$times$#link("https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf#%5B%7B%22num%22%3A879%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2C115%2C841.89%2Cnull%5D")[PIO] blocks, each with 4 PIO state machines.
The PIO subsystem is programmable to extend the I/O capabilities of the RP2350B beyond the hardware peripherals already present on the chip.
For further details on the Raspberry Pi RP2350B, refer to its #link("https://datasheets.raspberrypi.com/rp2350/rp2350-datasheet.pdf")[datasheet].

=== Inertial Measurement Unit (IMU)
<BoschImu>
The SoM includes a #link("https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi323-ds000.pdf")[Bosch BMI323] inertial measurement unit.
An inertial measurement unit measures the inertial properties of itself, in this case the 3-axis (Cartesian) acceleration and angular speed.
The relevant performance metrics of the IMU is provided in @ImuSpecs.
The IMU is connected to the microcontroller over the I#super([2])C bus (#text(gpred, [`I2C0`])), at address `0x68`.

#show figure: set block(breakable: true)
#figure(
  table(
    columns: (30%, 30%, 0.75fr, auto, 0.75fr, 10%),
    align: (
      left + horizon,
      center + horizon,
      right + horizon,
      right + horizon,
      right + horizon,
      left + horizon,
      left + horizon,
    ),

    table.header([Parameters], [Condition], [Min.], [Typical], [Max.], [Unit]),

    [Power on time], [Time from supply "on" to serial I/F operational], [], [1.5], [], [ms],
    [Operating Temperature], [], [-40], [], [+85], [#sym.degree\C],
    // ODR accuracy
    table.cell(rowspan: 3)[Accuracy of output data rate],
    [Any mode with gyroscope enabled in any state],
    [],
    [],
    [1.7],
    [%],
    [Acceleration only, high performance mode], [], [], [2], [%],
    [Combo mode, high performance], [], [0.0037], [], [$%/(degree"C")$],
    // Accelerometer
    table.cell(colspan: 6, align: center + horizon)[*Accelerometer*],
    [Start-up time], [Suspend to high performance mode], [], [2], [], [ms],
    // Range
    table.cell(rowspan: 4)[Range],
    table.cell(rowspan: 4)[Selectable via serial command],
    [],
    [#sym.plus.minus\2],
    [],
    table.cell(rowspan: 4)[$g$],
    [], [#sym.plus.minus\4], [],
    [], [#sym.plus.minus\8], [],
    [], [#sym.plus.minus\16], [],

    [Resolution], [], [], [16], [], [bit],

    // Sensitivity
    table.cell(rowspan: 4)[Sensitivity], [Range: $plus.minus 2 g$], [], [16384], [], table.cell(rowspan: 4)[$"LSB"/g$],
    [Range: $plus.minus 4 g$], [], [8192], [],
    [Range: $plus.minus 8 g$], [], [4096], [],
    [Range: $plus.minus 16 g$], [], [2048], [],
    [Sensitivity error], [Soldered, over lifetime], [], [$plus.minus 0.5$], [], [%],

    // Offset
    table.cell(rowspan: 2)[Zero-g offset], [soldered], [], [$plus.minus 35$], [], table.cell(rowspan: 2)[$m g$],
    [soldered, over lifetime], [], [$plus.minus 50$], [],

    [Noise density], [High performance mode, range $plus.minus 8 g$], [], [180], [], [$(mu g) / sqrt("Hz")$],

    // ODR
    table.cell(rowspan: 2)[Output Data Rate],
    [High performance and normal mode],
    [12.5],
    [],
    [6400],
    table.cell(rowspan: 2)[Hz],
    [High performance and normal mode], [0.78125], [], [400],

    // Cross axis sensitivity
    table.cell(rowspan: 2)[Cross-axis sensitivity],
    [Non-orthogonality among axes, evaluated as lower triangular matrix],
    [],
    [$plus.minus 0.3$],
    [],
    [%],
    [Alignment error, relative to package outline], [], [$plus.minus 0.5$], [], [#sym.degree],

    // Gyroscope
    table.cell(colspan: 6, align: center + horizon)[*Gyroscope*],

    [Start-up time], [Suspend to high performance mode], [], [30], [], [ms],

    // Range
    table.cell(rowspan: 5)[Range],
    table.cell(rowspan: 5)[Selectable via serial command],
    [],
    [#sym.plus.minus\125],
    [],
    table.cell(rowspan: 5)[$degree "/" s$],
    [], [#sym.plus.minus\250], [],
    [], [#sym.plus.minus\500], [],
    [], [#sym.plus.minus\1000], [],
    [], [#sym.plus.minus\2000], [],
    [Resolution], [], [], [16], [], [bit],

    // Sensitivity
    table.cell(rowspan: 5)[Sensitivity],
    [Range: $plus.minus 2000 degree"/"s$],
    [],
    [16.384],
    [],
    table.cell(rowspan: 5)[$"LSB"/(degree "/" s)$],
    [Range: $plus.minus 1000 degree"/"s$], [], [32.678], [],
    [Range: $plus.minus 500 degree"/"s$], [], [65.536], [],
    [Range: $plus.minus 250 degree"/"s$], [], [131.072], [],
    [Range: $plus.minus 125 degree"/"s$], [], [262.144], [],

    // Sensitivity error
    table.cell(rowspan: 2)[Sensitivity error],
    [Soldered, over lifetime, after self-calibration],
    [],
    [$plus.minus 0.7$],
    [],
    table.cell(rowspan: 2)[%],
    [Soldered, over lifetime, without self-calibration], [], [$plus.minus 3$], [],

    [Zero-rate offset], [soldered, over lifetime], [], [$plus.minus 1$], [], [$degree "/" s$],

    [Noise density], [High performance mode], [], [0.007], [], [$(degree "/" s) / sqrt("Hz")$],

    // ODR
    table.cell(rowspan: 2)[Output Data Rate],
    [High performance and normal mode],
    [12.5],
    [],
    [6400],
    table.cell(rowspan: 2)[Hz],
    [High performance and normal mode], [0.78125], [], [400],

    table.cell(rowspan: 2)[Cross-axis sensitivity],
    [Non-orthogonality among axes, evaluated as lower triangular matrix],
    [],
    [$plus.minus 0.3$],
    [],
    [%],

    [Alignment error, relative to package outline], [], [$plus.minus 0.5$], [], [#sym.degree],

    [Zero rate offset error, gravity induced],
    [Gravitation ($1g$) parallel to each main axis],
    [],
    [],
    [0.1],
    [$degree "/" s$],

    // Temperature sensor
    table.cell(colspan: 6, align: center + horizon)[*Temperature*],
    [Resolution], [], [], [16], [], [bits],
    [Range], [], [-41], [], [87], [#sym.degree\C],
    [Output at 23#sym.degree\C], [], [], [0], [], [LSB],
    [Sensitivity], [], [], [512], [], [$"LSB" / "K"$],
    [Temperature offset], [], [], [$plus.minus 3$], [$plus.minus 4$], [$"K"$],
    [Temperature sensitivity error], [], [], [2], [4.5], [%],

    // ODR
    table.cell(rowspan: 3)[Output Data Rate],
    [Any power operation mode with gyroscope in high performance or normal mode],
    [],
    [],
    [50],
    table.cell(rowspan: 3)[Hz],

    [Any power operation mode with gyroscope either disabled, in low-power mode or drive-only mode], [], [], [12.5],

    [Accelerometer in low power mode, gyroscope disabled], [], [], [6.25],
  ),
  caption: [Capabilities of the Bosch BMI323 IMU],
)<ImuSpecs>
#show figure: set block(breakable: false)

=== Magnetometer
The SoM includes a #link("https://www.memsic.com/Public/Uploads/uploadfile/files/20220119/MMC5983MADatasheetRevA.pdf")[Memsic MMC5983MA] magnetometer.
A magnetometer measures the magnetic field around itself in 3-axis (Cartesian).
The relevant performance metrics of the magnetometer is provided in @MagnetometerSpecs.

#show figure: set block(breakable: true)
#figure(
  table(
    columns: (30%, 30%, 0.75fr, auto, 0.75fr, 10%),
    align: (
      left + horizon,
      center + horizon,
      right + horizon,
      right + horizon,
      right + horizon,
      left + horizon,
      left + horizon,
    ),

    table.header([Parameters], [Condition], [Min.], [Typical], [Max.], [Unit]),
    [Power on time], [], [], [5], [], [ms],
    [Operating Temperature], [], [-40], [], [+105], [#sym.degree\C],
    // Range
    [Range], [], [], [#sym.plus.minus 8], [], [Gauss],
    [Resolution], [], [], [18], [], [bit],
    // Noise
    table.cell(rowspan: 4)[Total RMS noise], [BW = 00], [], [0.4], [], table.cell(rowspan: 4)[$"mG"$],
    [BW = 00], [], [0.6], [],
    [BW = 00], [], [0.8], [],
    [BW = 00], [], [1.2], [],
    // ODR
    table.cell(rowspan: 5)[Output Data Rate], [BW = 00], [], [50], [], table.cell(rowspan: 5)[Hz],
    [BW = 01], [], [100], [],
    [BW = 10], [], [225], [],
    [BW = 11], [], [580], [],
    [BW = 11, CM Freq. = 111], [], [1000], [],
    // Heading accuracy
    [Heading accuracy], [], [], [#sym.plus.minus 1], [], [#sym.degree],
    // Sensitivity
    table.cell(rowspan: 2)[Sensitivity], [16-bit], [], [4096], [], table.cell(rowspan: 2)[$"LSB"/"G"$],
    [18-bit], [], [16384], [],
    // Sensitivity accuracy
    [Sensitivity accuracy], [Range: #sym.plus.minus 8G], [], [#sym.plus.minus 5], [], [%],
    // Alignment error
    [Alignment error], [], [], [#sym.plus.minus 1], [#sym.plus.minus 3], [#sym.degree],
    // Maximum field
    [Maximum exposed field], [], [], [10000], [], [$"G"$],
  ),
  caption: [Capabilities of the Memsic MMC5983MA Magnetometer],
)<MagnetometerSpecs>
#show figure: set block(breakable: false)

=== Pressure and Altitude Sensor
The TE Connectivity MS560702BA03-50 is a precision barometer capable of measuring pressure as low as 10 hPa (10 mbar). Using a precision temperature measurement, altitude can be derived from the pressure measurement. The sensor is connected to the microcontroller over the #i2c bus (#text(gpred, [`I2C0`])), at address `0x77`.

#show figure: set block(breakable: true)
#figure(
  table(
    columns: (30%, 30%, 0.75fr, auto, 0.75fr, 10%),
    align: (
      left + horizon,
      center + horizon,
      right + horizon,
      right + horizon,
      right + horizon,
      left + horizon,
      left + horizon,
    ),
    table.header([Parameters], [Condition], [Min.], [Typical], [Max.], [Unit]),

    // Operating temperature
    [Operating temperature], [], [-40], [], [+85], [#sym.degree\C],
    // Range
    table.cell(rowspan: 2)[Range], [Full accuracy], [300], [], [1100], table.cell(rowspan: 2)[mbar],
    [Extended, linear range of ADC], [10], [], [2000],
    // Resolution
    [Resolution], [], [], [24], [], [bit],
    // Conversion time
    table.cell(rowspan: 5)[Conversion time], [OSR = 4096], [7.40], [8.22], [9.04], table.cell(rowspan: 5)[ms],
    [OSR = 2048], [3.72], [4.13], [4.54],
    [OSR = 1024], [1.88], [2.08], [2.28],
    [OSR = 512], [0.95], [1.06], [1.17],
    [OSR = 256], [0.48], [0.54], [0.60],
    // Sensitivity
    table.cell(rowspan: 5)[Pressure Sensitivity], [OSR = 4096], [], [0.024], [], table.cell(rowspan: 5)[mbar],
    [OSR = 2048], [], [0.036], [],
    [OSR = 1024], [], [0.054], [],
    [OSR = 512], [], [0.084], [],
    [OSR = 256], [], [0.130], [],
    // Temperature Sensitivity
    table.cell(rowspan: 5)[Temperature Sensitivity],
    [OSR = 4096],
    [],
    [0.002],
    [],
    table.cell(rowspan: 5)[#sym.degree\C],
    [OSR = 2048], [], [0.003], [],
    [OSR = 1024], [], [0.005], [],
    [OSR = 512], [], [0.008], [],
    [OSR = 256], [], [0.012], [],
  ),
  caption: [Capabilities of the TE MS560702BA03-50 Pressure and Temperature Sensor],
)<BaroSpec>
#show figure: set block(breakable: false)

=== Air Quality, Humidity, and Temperature Sensor
#link("https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf")[Bosch BME680] is an integrated environmental sensor that combines gas, humidity, pressure and temperature sensing.
The sensor is connected to the microcontroller over the #i2c bus (#text(gpred, [`I2C0`])), at address `0x76`.
The relevant performance metrics of the sensor is provided in @Bme680Specs.

#show figure: set block(breakable: true)
#figure(
  table(
    columns: (30%, 30%, 0.75fr, auto, 0.75fr, 10%),
    align: (
      left + horizon,
      center + horizon,
      right + horizon,
      right + horizon,
      right + horizon,
      left + horizon,
      left + horizon,
    ),
    table.header([Parameters], [Condition], [Min.], [Typical], [Max.], [Unit]),
    // Startup time
    [Start-up time], [Time to first communication after both V#sub([DD]) > 1.58 V and V#sub([DDIO]) > 0.65 V], [], [2], [], [ms],
    // Gas sensor
    table.cell(colspan: 6, align: center + horizon)[*Gas Sensor*],
    table.cell(rowspan: 2)[Operating Range], [Temperature], [-40], [], [85], [#sym.degree\C],
    [Humidity], [10], [], [95], [%RH],
    table.cell(rowspan: 3)[Response time], [Ultra-low power mode], [], [92], [], table.cell(rowspan: 3)[s],
    [Low power mode], [], [1.4], [],
    [Continuous mode], [], [0.75], [],
    [Noise], [], [], [1.5], [], [%],
    // Air quality sensor
    table.cell(colspan: 6, align: center + horizon)[*Air Quality Sensor*],
    [Range], [], [0], [], [500], [],
    // Humidity sensor
    table.cell(colspan: 6, align: center + horizon)[*Humidity Sensor*],
    table.cell(rowspan: 2)[Measurement Range], [Temperature], [-40], [25], [85], [#sym.degree\C],
    [Humidity], [0], [], [100], [%RH],
    table.cell(rowspan: 2)[Full Accuracy Range], [Temperature], [0], [], [65], [#sym.degree\C],
    [Humidity], [10], [], [90], [%RH],
    [Resolution], [], [], [0.008], [], [%RH],
    [Noise], [Highest oversampling], [], [0.01], [], [%RH],
    // Pressure sensor
    table.cell(colspan: 6, align: center + horizon)[*Pressure Sensor*],
    [Measurement Range], [], [300], [], [1100], [hPa],
    table.cell(rowspan: 2)[Operating Temperature], [Operational], [-40], [25], [85], table.cell(rowspan: 2)[#sym.degree\C],
    [Full accuracy], [0], [], [65],
    [Resolution], [], [], [0.18], [], [Pa],
    // Temperature sensor
    table.cell(colspan: 6, align: center + horizon)[*Temperature Sensor*],
    [Measurement Range], [], [-40], [], [85], [#sym.degree\C],
    table.cell(rowspan: 2)[Absolute Accuracy], [At 25#sym.degree\C], [], [$plus.minus 0.5$], [], table.cell(rowspan: 2)[#sym.degree\C],
    [0 -- 65#sym.degree\C], [], [$plus.minus 1.0$], [],
    [Resolution], [], [], [0.01], [], [#sym.degree\C],
    [Noise], [Lowest oversampling], [], [0.005], [], [#sym.degree\C],
  )
)<Bme680Specs>
#show figure: set block(breakable: false)

=== Light Flux Sensors
The SoM includes two #link("https://www.ti.com/lit/ds/symlink/opt3001.pdf")[Texas Instruments OPT3001] light flux sensors, one on the top side and one on the bottom side of the board.
The sensors are connected to the microcontroller over the #i2c bus (#text(gpred, [`I2C0`])), at addresses `0x44` (top) and `0x45` (bottom).
It measures light with a spectral response very closely matched to the human eye, and with very good infrared rejection.
The relevant performance metrics of the sensors is provided in @Opt3001Specs.

#show figure: set block(breakable: true)
#figure(
  table(
    columns: (30%, 30%, 0.75fr, auto, 0.75fr, 10%),
    align: (
      left + horizon,
      center + horizon,
      right + horizon,
      right + horizon,
      right + horizon,
      left + horizon,
      left + horizon,
    ),
    table.header([Parameters], [Condition], [Min.], [Typical], [Max.], [Unit]),
    // Operating temperature
    [Operating temperature], [], [-40], [], [+85], [#sym.degree\C],
    // Range
    [Peak irradiance spectral responsivity], [], [], [550], [], [nm],
    [Resolution], [], [], [0.01], [], [$"lux" / "LSB"$],
    [Full-scale illuminance], [], [], [83865.6], [], [lux],
    [Dark noise], [], [], [0], [0.03], [lux],
    [Half-power angle], [], [], [47], [], [#sym.degree],
  ),
  caption: [Capabilities of the TI OPT3001 Light Flux Sensor],
)<Opt3001Specs>

#pagebreak()

= Application

== Board Stacking
<BrdStack>

#figure(
  rect(
    image("assets/kiwi_rail_stack.drawio.svg"),
  ),
  caption: [Stacking Kiwi Mainboard and #link("https://404notfound.com")[Kiwi Maker Board] to combine experiments.],
)
#warning(title: "Warning")[
  Use the GPIOs on Stack Connector 2 ONLY IF the signals are connected to an experiment on a corresponding Kiwi Maker Board. Failure to follow this WILL cause interference with other boards on the stack.

  Do not force the module onto the stack. Wiggling the module or applying too much pressure may damage it. If the module does not readily press into place, remove it, check for debris and alignment, and try again.

  Mating cycle should not exceed 50.
]

// #pagebreak()

// = Mechanical and Packaging Information

// #figure(
//   rect(image("assets/dimension.svg"), stroke: 0.5pt, inset: 5%),
//   caption: "Dimensions",
// )

// #lorem(30)

// #lorem(30)

// #lorem(200)

// #page(flipped: true)[


//   === Typical Applications

//   #figure(
//     rect(image("./assets/741.svg"), stroke: 0.5pt, height: 10cm),
//     caption: "Typical Application",
//   )

//   #lorem(100)
// ]
