---
title: "Kiwi: The Single-Board Satellite Manual"
layout: default
---

Written by: Naira Poleo Sanchez

Supervised by: Sunip K. Mukherjee


---

# Kiwi: The Single-Board Satellite Manual


### Description

The Kiwi: Single-Board Satellite is a small and compact satellite
mainboard that contains multiple functions mainly made for tabletop
experiments and other educational purposes for people interested in STEM
related activities or careers. It is made for teens & adults, and it is
accessible in windows and iOS desktop devices (laptops and/or PCs).

This is a manual made easy to follow for people with some knowledge of
technology and science. It will be split into multiple sections
depending on the level of knowledge someone has such as
beginner/intermediate level and advanced level. Please look at the
contact information section towards the end if you’re interested in any
further information or have questions!

### WARNINGS & Safety Measures!

Electrical devices connected to this product cannot be near any liquids
and/or certain temperature environments as it can cause internal or
external damage to the product, your device connected to the product,
and/or even yourself. This is a low powered product and cannot exceed 3V
of power (further information in section “key functions” and/or inside
one of the “contact information” links).


--- 

### TABLE OF CONTENTS

| Section | Page |
|---|---|
| Title & Description | 1 |
| Warnings & Safety Measures | 1 |
| Materials / Equipment required | 2 |
| Step by Step Installation Process (Part 1) — Windows Version | 3 |
| Step by Step Installation Process (Part 1) — Mac Version | 9 |
| Step by Step Installation Process (Part 2) — Windows Version | — |
| Step by Step Installation Process (Part 2) — Mac Version | — |
| Key Functions | — |
| Troubleshooting | — |
| Contact Information | — |
| References / Citations | — |

---



---

### MATERIALS / EQUIPMENT REQUIRED!

- Kiwi satellite mainboard (This is provided)
- A laptop, pc, and/or a desktop device (This is NOT provided)

---




### Step by Step Installation Process (Part 1) — Windows Version

 *Step 1a)* Make sure your device has a USB Port. 

![USB port on a computer](assets/computer%20usb%20port%20-%20cropped.png)

Also, you must either buy or have your own USB cable A/microb (as it
is not provided). This is required for you to take the following
steps!

![USB Type-A to Micro-B cable](assets/kiwi-manual-media/media/image3.png)




*Step 1b)* Plug in the cable-A side into the computer’s USB Port and connect the
micro b side into the kiwi main board (as shown in the following images) 

![USB cable plugged into computer](assets/kiwi-manual-media/media/image4.jpeg)

![Micro-B cable plugged into Kiwi board](assets/kiwi-manual-media/media/image5.jpeg)


*Step 2*: Go to the website Putty.org

![PuTTY website homepage](assets/kiwi-manual-media/media/image6.png)

![PuTTY download page](assets/kiwi-manual-media/media/image7.png)


*Step 3*: Out of the top three options, Download either:

- “64-bit x86" if you have a windows intel or amd
- “64-bit" arm if you have a snapdragon

![PuTTY download options](assets/kiwi-manual-media/media/image8.png)


*Step 4*: Press windows key and type in “device manager” then open it

![Searching for Device Manager](assets/kiwi-manual-media/media/image9.png)

![Opening Device Manager](assets/kiwi-manual-media/media/image10.png)

![Device Manager window](assets/kiwi-manual-media/media/image11.png)


*Step 5*: In device manager go to “PORTS (COM & LPT)” and expand it

![Ports (COM & LPT) expanded in Device Manager](assets/kiwi-manual-media/media/image12.png)



*Step 6*: Take note of USB Serial Device (COMx)
- If you have multiple usb serial devices:
  - Double click each of them to open
  - Go to the "Details" tab
  - In the "property" dropdown; select "device instance path" and the
    correct kiwi device starts with “USB\VID_C001&PID_BEE5” and note the
    COMx of this device


![USB Serial Device in Device Manager](assets/kiwi-manual-media/media/image13.png)

![USB Serial Device properties](assets/kiwi-manual-media/media/image14.png)

![Device instance path detail](assets/kiwi-manual-media/media/image15.png)

![Kiwi VID/PID in device instance path](assets/kiwi-manual-media/media/image16.png)


*Step 7*: Press windows key and go to “Putty” then open it

![Searching for PuTTY in Start menu](assets/kiwi-manual-media/media/image17.png)


*Step 8*: After opening putty, this will show up. Select “serial
connection” and enter your COM number into “serial” line box

![PuTTY configuration with serial connection selected](assets/kiwi-manual-media/media/image18.png)


*Step 9*: Hit “Open”, which will send you to the serial console where
you type in “help” and press “enter” to get help.

![PuTTY serial console opening](assets/kiwi-manual-media/media/image20.png)

![PuTTY terminal window](assets/kiwi-manual-media/media/image19.png)

![Typing help in the serial console](assets/kiwi-manual-media/media/image21.png)



### Step by Step Installation Process (Part 1) — Mac Version


*Materials*: 

Mac with type c port needs a type c/micro b cable (NOT pprovided)

**OR**

Type C/type A adapter + type A/micro B cable (these port cables are NOT
provided)

with type c/micro b cable: Microb cable goes into the kiwi and the type c into the mac port

with type A adapter: type c into mac port, type a into type a adapter and micro b cable into the kiwi


After connecting the kiwi to your Mac, something like this will show
up:

“Allow accessory to connect? Do you want to connect LoCSST/SKM Kiwi
Mainboard Rev. X to this Mac?”\
You must press “Allow”



Next, open terminal
- Command + space / invoke spotlight search and search “terminal” then
  open terminal
- Go to applications -> utilities then open terminal




Then, Type “sudo screen /dev/cu.usbmodem\<Tab\>” which autocompletes to “sudo screen /dev/cu.usbmodem2025_00011” then put a space and add the number “115200” then press return.



If you’re asked for a password, then type in the password that you use
to log into your Mac.


Then type in “help” to get help.


