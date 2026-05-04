<section class="manual-sheet" markdown="1">

# Receiving Data from your Kiwi

By default, Kiwi transmits data through the self-hosted `kiwi-ap` Wi-Fi access point.
To receive measurements from your Kiwi, you will need to use a Wi-Fi-enabled computer. 
After the data visualization tool, Kiwi Plotter, has been set up on your computer, connect your computer to the `kiwi-ap` Wi-Fi access point.
![Wi-Fi access point list showing `kiwi-ap`](/assets/media/kiwi-plotter/kiwi-plotter-connect-wifi.png){: style="width: 60%" }
Once your computer is connected to the `kiwi-ap` network access point, the device should show up in the Kiwi Plotter software.
> **Wi-Fi Network**
> If you have changed the name of the Wi-Fi access point that your Kiwi is broadcasting, look for that name in the list of available devices in the plotter instead of `kiwi-ap`.
> If you have configured your Kiwi to connect to a different Wi-Fi network, make sure your computer is connected to the same network to receive data from the Kiwi.
{: .callout-tip }
![Kiwi Plotter device list showing a connected Kiwi device](/assets/media/kiwi-plotter/kiwi-plotter-connected.png){: style="width: 60%" }
Clicking on the device in the list will open up a new tab in the plotter, showing real-time sensor measurements from the Kiwi.
![Kiwi Plotter tab showing real-time sensor measurements](/assets/media/kiwi-plotter/kiwi-plotter-device.png){: #fig-kiwi-plotter-device style="width: 60%" }
The various sensor measurements are shown in individual panels in the plotter (<a href="#fig-kiwi-plotter-device" class="figref"></a>).
Measurements from the accelerometer, gyroscope and magnetometer show three axes of data, corresponding to the x, y and z axes of the device.
These plots also show the magnitude of these measurements, calculated as $$\sqrt{x^2 + y^2 + z^2}$$.
The pressure, temperature, and inferred altitude measurements are shown in their individual panels.
These panels can be adjusted in size, and rearranged within the plotter tab to customize the layout.
The Y-axis limits can also be adjusted for each panel by clicking the gear icon in the top-right corner of the panel, and entering new limits in the "Y-Axis Limits" section.
![Kiwi Plotter panel reorganization and 3-D visualization](/assets/media/kiwi-plotter/kiwi-plotter-reorganize.png){: style="width: 60%" }
The viewer also shows a real-time 3D visualization of the orientation of the device, based on the accelerometer and magnetometer measurements.
This visualization is approximate, and does not (yet) account for the drift in the gyroscope measurements, so it may not be perfectly accurate.
Instantaneous values of the various sensor measurements can be viewed by hovering over the plots, or by clicking on the "Data Inspector" button in the top-right corner of the plotter tab.
![Instantaneous values shown on hover](/assets/media/kiwi-plotter/kiwi-plotter-instantaneous-value.png){: style="width: 60%" }
An individual, more detailed 3-D visualization of the device orientation is also available in a separate tab in the plotter, accessible through the "3D" button on the device list.
![3D visualization of device orientation](/assets/media/kiwi-plotter/kiwi-plotter-3d-view.png){: style="width: 60%" }
The data from the Kiwi can also be recorded and exported as a CSV file for offline analysis.
To start recording, click the "Start" button in the top-left of the device plot tab.
After recording has started, use the "Stop" button to stop recording, and the "Export" button to download the recorded data as an Excel spreadsheet.
Data from various sensors are recorded in separate sheets within the spreadsheet, with timestamps for each measurement.
</section>
