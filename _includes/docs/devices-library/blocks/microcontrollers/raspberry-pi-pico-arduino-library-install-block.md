安装 Arduino IDE 的电路板：

{% assign raspberryPiPicoInstallation = '
    ===
        image: /images/devices-library/basic/microcontrollers/raspberry-pi-pico-w-arduino-ide-board-manager.png,
        title: 转到 **工具** > **电路板** > **电路板管理器** 并安装 ***Raspberry Pi Pico/RP2040 by Earle F. Philhower*** 电路板。
'
%}

安装 Arduino IDE 的电路板：

转到文件 > 首选项，并将以下 URL 添加到其他电路板管理器 URL 字段。

```bash
https://github.com/earlephilhower/arduino-pico/releases/download/global/package_rp2040_index.json
```
{:.copy-code}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=raspberryPiPicoInstallation %}

安装完成后，通过电路板菜单选择电路板：**工具** > **电路板** > {{ arduinoBoardPath }}。

使用 USB 电缆将设备连接到计算机，然后为设备选择端口：

**工具** > **端口** > **/dev/ttyUSB0**。

端口取决于操作系统，可能不同：

- 对于 Linux，它将是 **/dev/ttyUSB**X
- 对于 MacOS，它将是 **usb.serial**X.. 或 **usb.modem**X..
- 对于 Windows - **COM**X。

{% assign wifininaInstallationRequired = "true" %}