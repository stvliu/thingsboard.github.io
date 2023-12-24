{% assign installESP8266='
    ===
        image: /images/devices-library/basic/microcontrollers/esp8266-arduino-ide-board-manager.png,
        title: 在搜索字段中输入 ESP8266，然后安装 Espressif Community 的 esp8266。
' %}

为 Arduino IDE 安装电路板：
转到文件 > 首选项，然后将以下 URL 添加到其他电路板管理器 URL 字段。

```bash 
http://arduino.esp8266.com/stable/package_esp8266com_index.json
```
{:.copy-code}

接下来，转到 **工具** > **电路板** > **电路板管理器**，然后安装 ***ESP8266*** 电路板。

{% include images-gallery.liquid showListImageTitles="true" imageCollection=installESP8266 %}

安装完成后，通过电路板菜单选择电路板：

**工具** > **电路板** > {{ arduinoBoardPath }}。

使用 USB 电缆将设备连接到计算机，然后为设备选择端口：

**工具** > **端口** > **/dev/ttyUSB0**。

端口取决于操作系统，可能不同：

- 对于 Linux，它将是 **/dev/ttyUSB**X
- 对于 MacOS，它将是 **usb.serial**X.. 或 **usb.modem**X..
- 对于 Windows - **COM**X。

{% assign mbedtlsInstallationRequired="true" %}