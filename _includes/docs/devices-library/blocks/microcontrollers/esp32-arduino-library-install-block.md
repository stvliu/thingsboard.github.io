在 Arduino IDE 中安装电路板：

转到 **文件** > **首选项**，并将以下 URL 添加到其他电路板管理器 URL 字段。

```bash 
https://dl.espressif.com/dl/package_esp32_index.json
```
{:.copy-code}

{% assign esp32ArduinoPreferences='
    ===
        image: /images/devices-library/basic/arduino-ide/preferences.png
'%}

{% include images-gallery.liquid showListImageTitles="false" imageCollection=esp32ArduinoPreferences %}

然后转到 **工具** > **电路板** > **电路板管理器**，并安装 ***Espressif Systems 的 ESP32*** 电路板。

{% assign esp32ArduinoInstallation='
    ===
        image: /images/devices-library/basic/microcontrollers/esp32-arduino-ide-board-manager.png
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=esp32ArduinoInstallation %}

安装完成后，通过电路板菜单选择电路板：

**工具** > **电路板** > {{ arduinoBoardPath }}。

使用 USB 电缆将设备连接到计算机，并为设备选择端口：

**工具** > **端口** > **/dev/ttyUSB0**。

端口取决于操作系统，可能不同：
- 对于 Linux，它将是 **/dev/ttyUSB**X
- 对于 MacOS，它将是 **usb.serial**X.. 或 **usb.modem**X..
- 对于 Windows - **COM**X。

其中 X - 由您的系统分配的某个数字。