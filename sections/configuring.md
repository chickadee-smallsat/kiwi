<section class="manual-sheet" markdown="1">

# Configuring your Kiwi

Kiwi exposes a simple configuration interface over [universal serial asynchronous receiver-transmitter (UART)](https://en.wikipedia.org/wiki/Universal_asynchronous_receiver-transmitter), better known as a ['serial port'](https://en.wikipedia.org/wiki/Serial_communication).
This serial port is accessible to the computer connected to Kiwi over the USB port.
The configuration interfaces uses text commands to configure the Kiwi.
The built-in firmware supports changing the Wi-Fi settings, and updating the unique identifier of the Kiwi (`Kiwi#XXXX` by default).

## Connecting to Kiwi Serial Port

### CoolTerm
[CoolTerm](https://freeware.the-meiers.org/) is a free software that provides an interface to communicate with a device over the serial port.
Depending on your operating system, use the links in the following table to get the correct version of CoolTerm.
For most users, the first (Windows users) and second (Mac users) should be sufficient.

<p class="table-caption">CoolTerm download options by platform and CPU architecture.</p>

|--|--|
| Computer | Operating System | Architecture | Link |
|--|--|
| Windows PC / Laptop | Windows 64-bit | `x86_64` | [Link](https://freeware.the-meiers.org/CoolTermWin64Bit.zip) |
| MacBook / iMac | macOS (Universal) | `x86_64` / `arm64` | [Link](https://freeware.the-meiers.org/CoolTermMac.dmg) |
| Windows PC / Laptop (before 2010) | Windows 32-bit | `x86` | [Link](https://freeware.the-meiers.org/CoolTermWin32Bit.zip) |
| Windows PC / Laptop with Snapdragon Chip | Windows ARM64 | `arm64` | [Link](https://freeware.the-meiers.org/CoolTermWinARM64Bit.zip) |
| Linux PC / Laptop | Linux | `x86` / `x86_64` | [32-bit](https://freeware.the-meiers.org/CoolTermLinux32Bit.zip) [64-bit](https://freeware.the-meiers.org/CoolTermLinux64Bit.zip) |
| Raspberry Pi | Linux | `armv7` / `arm64` | [32-bit](https://freeware.the-meiers.org/CoolTermRaspberryPi.zip) [64-bit](https://freeware.the-meiers.org/CoolTermRaspberryPi64Bit.zip) |
{: #tbl-coolterm }

### Windows PC
{: .collapsible .collapsible-open}
<!-- {: .collapsible} -->
#### Installation
- Download the version of CoolTerm compatible with your Windows PC from <a href="#tbl-coolterm" class="tblref"></a>.
- Navigate to the location where the file was downloaded on 
- Extract the files from the downloaded `.zip` archive.
  - Right click on the `.zip` archive to open the context menu and select the "Extract All..." option.
    {% include os-toggle.html id="fig-coolterm-extract" src1="assets/media/windows/coolterm_extract_win11.png" alt1="Extract CoolTerm (Windows 11)" src2="assets/media/windows/coolterm_extract_win10.png" alt2="Extract CoolTerm (Windows 10)" label1="Windows 11" label2="Windows10" style="width: 100%" collapsible=true %}
  - Click the "Extract" button in the extraction dialog.
    ![Extract the `.zip` file](assets/media/windows/coolterm_extract_dialog.png){: .collapsible style="width: 60%" }
  - Navigate into the extracted `CoolTermWin64Bit` directory, and launch the `CoolTerm` executable.
    ![Launch CoolTerm](assets/media/windows/coolterm_program.png){: .collapsible style="width: 80%" }

#### Usage
- Upon launching CoolTerm, you will be prompted to set the preferences for CoolTerm. Use default preferences.
  ![Use Default Preferences](assets/media/windows/coolterm_preferences.png)
- After CoolTerm opens, click on "▼" on the left of the bottom bar.
- Select a serial port under "Port". Your computer may have multiple serial connections available depending on which peripherals are connected to it.
  ![Select a serial device](assets/media/windows/coolterm_port_selection.png)
- Click "Connect" to connect to the Kiwi serial port.
  ![Connect to a serial device](assets/media/windows/coolterm_connect.png){: .collapsible }
  ![Serial device is connected](assets/media/windows/coolterm_after_connect.png){: .collapsible }
- Hit the <kbd>Enter</kbd> key. You should see a prompt that looks like `> `, which indicates you are connected to the Kiwi serial console, and your Kiwi is ready to receive commands.
  ![Kiwi is connected!](assets/media/windows/coolterm_connect_caret.png)
- If the `> ` does not show up and you have multiple serial devices under "Ports", switch to a different port, connect to it, and hit <kbd>Enter</kbd>.
- Type `help` and hit <kbd>Enter</kbd> to see the list of available commands.
  ![Available serial commands on Kiwi](assets/media/windows/coolterm_connected_help_menu.png)

> **Identify the Kiwi COM Port**
> The COM port presented by Kiwi can be identified in the `Device Manager` program in case multiple COM ports are present.
> To open Device Manager, first click on the 'Start' ({% include icon-windows.html %}) button on your desktop, or the <kbd>Windows {% include icon-windows.html %}</kbd> key on your keyboard.
> Then, type in 'device manager', and 'Device Manager (Control Panel)' should show up in the search results.
> ![Search result for device manager](assets/media/windows/device_manager_prompt.png){: style="width: 60%" .collapsible }
> Open Device Manager, and navigate to <ui-menu>Ports (COM & LPT)</ui-menu> in the device tree.
> ![Ports (COM & LPT) in Device Manager tree](assets/media/windows/device_manager_ports_com_lpt.png){: .collapsible }
> Then, right click on a COM port under the <ui-menu>Ports (COM & LPT)</ui-menu> devices and select **Properties**.
> ![Properties of a COM device](assets/media/windows/device_manager_properties.png){: .collapsible }
> In the device properties dialog box, navigate to <ui-tab>Details</ui-tab>, and select <ui-btn>Bus reported device description</ui-btn> under the <ui-menu>Property</ui-menu> dropdown. A Kiwi will report itself as `Kiwi Mainboard Rev. B`.
> ![Detecting a Kiwi](assets/media/windows/device_manager_identity.png)
> Note the COM port number once the Kiwi is found. Hit 'OK' to close the Properties dialog box, and close Device Manager.
{: .callout-tip .collapsible }

### MacBook / iMac
{: .collapsible}
#### Installation
- Download the macOS version of CoolTerm from <a href="#tbl-coolterm" class="tblref"></a>.
- Open the downloaded `CoolTermMac.dmg` file, and drag the CoolTerm application to your Applications folder.
  ![Dragging CoolTerm to Applications folder](assets/media/coolterm-mac-install.png){: style="width: 60%" }

#### Usage
- Open CoolTerm from the Applications folder.
  On first launch, you will be prompted to set up the preferences for CoolTerm.
  Use the default settings (press "Use Defaults" button).
  ![Opening CoolTerm on Mac](assets/media/coolterm-mac-startup.png){: style="width: 40%" }
- After CoolTerm opens, click on "▼" on the left of the bottom bar.
- Select the serial port that corresponds to your Kiwi (e.g., `usbmodem2025_0011`) under "Port".
- In the "▼" menu, click "Connect" to connect to the Kiwi serial port.
- Hit the <kbd>Return</kbd> key. You should see a prompt that looks like `> `, which indicates you are connected to the Kiwi serial console, and your Kiwi is ready to receive commands.
- Type `help` and hit <kbd>Return</kbd> to see the list of available commands.

<figure style="width: 80%; margin: 1.5rem auto">
  <video controls style="width: 100%; margin: 0; border-radius: 1rem">
    <source src="{{ '/assets/media/coolterm-mac-connect.mp4' | relative_url }}" type="video/mp4">
  </video>
  <figcaption>Connecting to the Kiwi serial port on macOS using CoolTerm.</figcaption>
</figure>

## Configuration Commands
Kiwi serial commands are strings, identified by one or more command keywords.
These command keywords are selected to be small, memorable mnemonics of the operation they perform.
Most commands are made of one or two keywords, separated by a single space.

Some commands also accept input parameters, some of which may be optional.
Required input parameters are indicated by `<>` symbols, and optional parameters are indicated by `[]`.
The inputs are positional, meaning the position after the command keywords determines which parameter is set by a passed value.
Commands are executed when the <kbd>Enter</kbd> or <kbd>Return</kbd> key is pressed.

<p class="table-caption">Available configuration commands</p>

|--|--|
| Command | Description | Inputs |
|--|--|
| [`help`](/#help) | Shows a help message describing what commands are available | -- |
| [`ident get`](/#ident-get) | Get the currently set identity for the Kiwi | -- |
| [`ident set <ID>`](/#ident-set) | Set a new identity | `ID`: New identity string (12 characters max.) |
| [`wifi status`](/#wifi-status) | Current status of the Wi-Fi connection, and broadcast data rate if a connection has been established | -- |
| [`wifi ap <ssid> [pw]`](/#wifi-ap) | Kiwi creates a Wi-Fi access point | `ssid`: Wi-Fi access point name (32 characters max.)<br>`pw`: Optional password for the access point (32 characters max.) |
| [`wifi cl <ssid> [pw]`](/#wifi-cl) | Kiwi joins a Wi-Fi network | `ssid`: Name of the Wi-Fi network (32 characters max.)<br>`pw`: Optional password for the Wi-Fi network (32 characters max.) |
| [`store`](/#store) | Update the identity, or Wi-Fi configuration of Kiwi. This operation causes the device to reset. | -- |
| [`reset`](/#reset) | Trigger a software reset of the device | -- |
| [`clear`](/#clear) | Use ANSI escape sequences to clear the terminal screen. This may not work on CoolTerm on Windows. | -- |
{: #tbl-commands }

### `help`
{: .no_toc }
The `help` command prints the available commands in the console.

### Identity Commands
{: .no_toc }
Each Kiwi board stores a unique identity string (12 characters) on board.

#### `ident get`
{: .no_toc }
Typing in `ident get` in the console and pressing <kbd>Enter</kbd> or <kbd>Return</kbd> prints the currently set identity string on the console.

#### `ident set`
{: .no_toc }
The `ident set` command takes a single parameter, the new identity to be set.
For example, if you want to set the identity string to `MyKiwi`, execute the following command:
```
ident set MyKiwi
``` 
Note, this does not update the identity string immediately.
Execute the `store` command for the update to take effect.
Identity strings must be alphanumeric, and can not contain a space.

#### `wifi status`
{: .no_toc }
The `wifi status` command does not take any parameters.
This command outputs the current status of the Wi-Fi connection.
For example, the Kiwi with device ID `Kiwi#0002`, set up in access point (Kiwi creates the Wi-Fi network) called `kiwi_ap` (this is what the Wi-Fi network shows up as in your PC/laptop/phone) without a password, returns the following output on `wifi status` command:
```
> wifi status
Device ID: Kiwi#0002
WiFi Credentials:
  Mode: Access Point
  SSID: kiwi_ap
  Open network
Data rate: 23.195875 kbps, Packet rate: 123.711334 pkt/s
```
If the Kiwi is unable to create the access point, or join a Wi-Fi network, it will report `WiFi not ready` instead of showing a data rate.

#### `wifi ap`
{: .no_toc }
The `wifi ap` command configures the Kiwi to host a Wi-Fi hotspot for you to connect to.
Kiwi broadcasts its measurements over this Wi-Fi hotspot.
This command takes two parameters:
- `ssid`: The service-set identifier (SSID) is the name of the Wi-Fi hotspot Kiwi creates.
- `pw`: An optional password for the Wi-Fi hotspot. If `pw` is not provided as an input, Kiwi will host an open network that can be joined without entering a password.

For example, executing `kiwi ap kiwi-network` will configure the Kiwi to set up an open network hotspot that will show up as `kiwi-network` on your device.
Executing `kiwi ap kiwi-private SecurePassword` will configure Kiwi to set up a network hotspot `kiwi-private` that will require `SecurePassword` for a device to join that network.

#### `wifi cl`
{: .no_toc }
The `wifi cl` command configures the Kiwi to connect to an open, or [WPA/WPA2](https://en.wikipedia.org/wiki/Wi-Fi_Protected_Access) protected network.
Most home/private networks use this form of authentication, where a passsword is entered to join the network.
The [eduroam](https://en.wikipedia.org/wiki/Eduroam) network uses more complex authentication methods, and Kiwi can not join such a network.
`wifi cl` command accepts the SSID (required) and password (optional) parameters.
To connect Kiwi to `MyHomeWiFi` secured by `MySecurePassword`, execute the following command:
```
wifi cl MyHomeWiFi MySecurePassword
```
Omit the password if you are connecting to an open network.

> **Wi-Fi SSID and Password Formatting**
> Wi-Fi SSID is an alphanumeric string of up to 32 characters, supporting characters *a--z*, *A--Z*, *0--9*, dashes (-) and underscores (_).
> Due to the positional parameter inputs to `wifi ap` and `wifi cl` commands, any space in the SSID will cause the part before the space to be interpreted as the SSID and the part after the space as the password.
> Special characters are **not** supported.
>
> Wi-Fi passwords are up to 32 characters long.
{: .callout-note .collapsible .collapsible-open }

#### `store`
{: .no_toc }
The `store` command stores any changes to Kiwi configuration (identity or Wi-Fi configuration), and resets the device for the settings to take effect.

#### `reset`
{: .no_toc }
The `reset` command triggers a software reset of the Kiwi.
The `store` command uses this trigger to reload the new configuration.

#### `clear`
{: .no_toc }
The `clear` command sends a set of characters to the terminal to clear any previous commands and their outputs.
This command may not work as intended in CoolTerm on Windows.

</section>
