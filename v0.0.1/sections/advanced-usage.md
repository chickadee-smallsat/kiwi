<section class="manual-sheet" markdown="1">

# Advanced Usage

This section covers advanced topics for users who want to get more out of their Kiwi.

Datasheet for Kiwi is provided below.
{% include pdf-embed.html src="/datasheet/kiwi-mainboard-ds.pdf" label="Kiwi Datasheet" %}

# Programming your Kiwi

Kiwi supports [MicroPython](https://micropython.org/) out-of-the-box.
MicroPython has been compiled for the Kiwi, and is available from [here](https://github.com/chickadee-smallsat/kiwi-mainboard-micropython/releases/latest).

## Flashing the MicroPython Firmware
- Download the `micropython_<MicroPythonVersion>_kiwi_mb_revB0.uf2` file to your PC.
- Keep the USB micro-B cable plugged into the Kiwi, but not into the PC.
- With the `BOOTSEL` button held down (possibly with a small tool like a screwdriver), insert the cable into the PC.
- Kiwi should show up as a removable storage device. Copy the downloaded `.uf2` firmware to it.
- At this point, the removable storage should automatically be removed and the Kiwi should reboot.

## MicroPython on your Kiwi
Use the [Thonny IDE](https://thonny.org/) to write MicroPython code and execute it on your Kiwi.
Thonny allows you to store code on your Kiwi and run it when the Kiwi is powered on.

> **Kiwi Plotter will not work with MicroPython**
> Installing MicroPython to Kiwi will remove the pre-loaded firmware Kiwi came with.
> This will break the data transmission functionality Kiwi previously offered, and your Kiwi will not transmit any data over Wi-Fi to Kiwi Plotter by default.
{: .callout-caution }

## Data Format used by Kiwi

Kiwi broadcasts measurement packets over UDP on port `8099`.
Currently, this is not configurable in the on-board Kiwi firmware, or the Kiwi Plotter, so any data broadcast to the plotter will have to be broadcast on this port.

Kiwi broadcasts data packets that are fixed-size 24-byte binary structures.
All multi-byte values are [**little-endian**](https://en.wikipedia.org/wiki/Endianness), or least-significant-byte first.
This is in contrast to the typical network byte order (big-endian), since most consumer hardware, including the Kiwi, is little-endian.

### Default Packet Layout

<div class="pcb-viewer-wrap">
  <iframe src="{{ '/assets/media/packet-layout.html' | relative_url }}"
          title="Kiwi Packet Layout"
          loading="lazy"
          scrolling="no"
          onload="this.style.height=(this.contentWindow.document.body.scrollHeight+32)+'px'; (function(f){window.addEventListener('message',function(e){if(e.data&&e.data.type==='packet-layout-resize')f.style.height=(e.data.height+32)+'px';});})(this);">
  </iframe>
</div>

| Bytes | Size | Field | Description |
|-------|------|-------|-------------|
| 0–1 | 2 B | Type | Measurement type code (`u16`) |
| 2–13 | 12 B | Data | Measurement payload (layout varies by type) |
| 14–21 | 8 B | Timestamp | Microseconds since device start (`u64`) |
| 22–23 | 2 B | CRC | CRC-16/XMODEM over bytes 0–21 (`u16`) |

### Measurement Types

The type field identifies which sensor produced the data and how the 12-byte payload is laid out (<a class="tblref" href="#tbl-data-ids"/>).

<p class="table-caption">Table of type-field values identifying which sensor produced a data packet.</p>

| Type | Code | Bytes 2–13 | Units |
|------|------|------------|-------|
| Accelerometer | `0xACC1` | X (`f32`), Y (`f32`), Z (`f32`) | g |
| Gyroscope | `0x6E50` | X (`f32`), Y (`f32`), Z (`f32`) | °/s |
| Magnetometer | `0x9A61` | X (`f32`), Y (`f32`), Z (`f32`) | mG |
| Temperature | `0x7E70` | Label (8 B ASCII, null-padded), Value (`f32`) | °C |
| Barometer | `0xB480` | Temperature (`f32`), Pressure (`f32`), Altitude (`f32`) | °C / hPa / m |
| Humidity / AQI | `0xF0AC` | Temperature (`f32`), Humidity (`f32`), AQI (`f32`) | °C / % / — |
| Light | `0x1A2B` | Label (8 B ASCII, null-padded), Value (`f32`) | lux |
| Device ID | `0x1D1D` | ID string (12 B ASCII, null-padded) | — |
{: #tbl-data-ids }

The **Temperature** and **Light** types include an 8-character ASCII label (null-padded to 8 bytes, bytes 2–9) that identifies the specific sensor, followed by the value as an `f32` at bytes 10–13.
The **Device ID** type carries a 12-character null-padded ASCII string identifying the device (e.g. `kiwi#0001`), with no numeric value.

> **AQI Data**
> Due to the closed-source nature of the [AQI calculation algorithm (BSEC)](https://github.com/boschsensortec/BSEC-Arduino-library) provided by Bosch Sensortech, it has not been integrated into the pre-loaded Kiwi firmware.
> AQI data is reported as raw resistance measurement from the gas sensor, heated up to 300°C.
{: .callout-note }

> **Data Types**
> - `u8`: Unsigned 8-bits of data (a byte). Also known as `unsigned char` or `uint8_t` in the C programming language. The Python equivalent is a `byte`.
> - `u16`: Unsigned 16-bits of data (2 bytes). Also known as `unsigned short` or `uint16_t` in C. Python does not have a direct equivalent of this type. Use the [`struct`](https://docs.micropython.org/en/latest/library/struct.html) module to unpack a `u16` to an `int`, and vice-versa.
> - `u64`: Unsigned 64-bits of data (8 bytes). Also known as `unsigned long long` or `uint64_t` in C. Python does not have a direct equivalent of this type.
> - `f32`: A 32-bit, IEEE-758 floating point number. Also known as `float` in C. `float` in Python is usually 64-bits long, but MicroPython usually uses 32-bit floating point numbers by default.
{: .callout-tip }

### Integrity Check

The last 2 bytes of every packet carry a **CRC-16/XMODEM** checksum computed over the first 22 bytes.
Packets with a CRC mismatch should be discarded.

> **CRC-16/XMODEM**
> A cyclic redundancy check (CRC) is an error-detecting code commonly used in digital networks and storage devices to detect accidental changes to digital data. 
> Blocks of data entering these systems get a short check value attached, based on the remainder of a polynomial division of their contents. 
> On retrieval, the calculation is repeated and, in the event the check values do not match, corrective action can be taken against data corruption.<span class="cite-ref" data-ref="ref-crc"></span>
> The specific polynomial used in the CRC-16/XMODEM algorithm, also known as the CRC-16 [CCITT](https://en.wikipedia.org/wiki/ITU-T) algorithm, is $$x^{16} + x^{12} + x^{5} + 1$$, or `0x1021`, and the accumulator is initialized to `0x0000`.
{: .callout-note }

### Custom Data Packets

The reference implementation of the Kiwi software transmits data in 24-byte packets.
If your Kiwi is flying as part of the Kiwi-50 experiment, the following are **recommended** to ensure successful data acquisition:
- **Broadcast UDP packets on port `8099`.**
- **Adhere to the 24-byte packet size.**
- **Maintain the CRC-16 bytes at the end of the packet.**
- **Transmit the ID packet with your unique ID**. No data will be routed until this ID is received (Kiwi-50 experiments). It is recommended to broadcast the ID packet at a regular interval, at most 4 times every minute (15 seconds interval), to ensure the device is identified quickly without lowering data throughput with too many ID packets.
- **Use a custom ID (`u16`)**. There are over 60,000 to choose from.
- Implement a way to track the order of packets. UDP does not guarantee transmission or ordering of packets.

## Rust on your Kiwi

The [Rust Programming Language](https://rust-lang.org/) is the primary intended programming language for a Kiwi.
Rust is a memory-safe language that avoids many pitfalls of traditional system programming languages, such as C and C++, without any performance overhead.
Rust also allows for powerful patterns, such as the asynchronous programming model (using keywords `async` and `await`, and an asynchronous executor).
The asynchronous programming model is especially useful on the Kiwi, which is a resource-constrained embedded system and cannot run a full operating system that would take care of scheduling various tasks (reading multiple sensors, collecting the data, transmitting them over Wi-Fi, while waiting for USB commands for configuration updates, and more). 
Kiwi leverages the [embassy](https://embassy.dev/) framework to achieve this, which supports the Raspberry Pi RP2350B microcontroller very well.
The pre-loaded firmware is written in Rust, and leverages embassy to implement a cooperative multi-tasking environment.

However, Rust development is more advanced and would be more difficult to introduce in this manual.
Source code for the firmware pre-loaded in your Kiwi is available [here](https://github.com/chickadee-smallsat/kiwi-firmware).
Documentation for the firmware is available on [GitHub pages](https://chickadee-smallsat.github.io/kiwi-firmware).


</section>
