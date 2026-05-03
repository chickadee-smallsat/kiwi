<section class="manual-sheet" markdown="1">

# Powering up your Kiwi

-  Locate the USB port on your computer. 

  ![USB port on a computer](assets/media/computer-usb-port.png){: #fig-usb-port-pc style="filter: invert(1); width: 40%" }

  ![USB Type-A to Micro-B cable](assets/media/usb-a-micro-b-cable.png){: #fig-usb-cable style="filter: invert(1); width: 40%" }

- Plug in the USB-A side of the cable into the computer's USB Port (<a href="#fig-usb-plugged-pc" class="figref"></a>).
  Connect the micro-B side into the Kiwi (as shown in <a href="#fig-usb-plugged-kiwi" class="figref"></a>).

  ![USB cable plugged into computer](assets/media/pc-usb-plugged.jpeg){: #fig-usb-plugged-pc style="width: 60%" }

  ![Micro-B cable plugged into Kiwi board](assets/media/kiwi-usb-plugged.jpeg){: #fig-usb-plugged-kiwi style="width: 60%" }

  At this point, the Kiwi is turned on, and by default, creates an open Wi-Fi access point called `kiwi-ap`.
  Kiwi broadcasts various sensor measurements over Wi-Fi at [UDP](https://en.wikipedia.org/wiki/User_Datagram_Protocol) port `8099`.

> **Note**
> If you are using a MacBook or iMac, or a Windows PC without an accessible USB type-A port, you may need a USB-C to USB-A adapter to connect the USB cable to your computer.
> Optionally, you can also use a [USB-C to micro-B cable](https://www.adafruit.com/product/3878) to connect the Kiwi directly to your Mac or PC without an adapter.
{: .callout-note }

> **Troubleshooting**
> - Give it up to a minute for the Wi-Fi network to show up.
> - If the default `kiwi-ap` network does not show up, disconnect and reconnect the device.
> - If the problem persists,
>   - Short the `PWLED_EN` jumper to verify both the red (5V power) and green (3.3V power) LEDs are lighting up.
>   - Write to us at [kiwi@uml.edu](mailto:kiwi@uml.edu).
{: .callout-tip }

</section>
