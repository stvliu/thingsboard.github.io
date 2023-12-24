在 Arduino IDE 中安装电路板：
转到 **文件** > **首选项**，并将以下 URL 添加到 **其他电路板管理器 URL** 字段。

```bash 
https://m5stack.oss-cn-shenzhen.aliyuncs.com/resource/arduino/package_m5stack_index.json
```
{:.copy-code}

接下来，转到 **工具** > **电路板** > **电路板管理器**，并安装 ***M5Stack by M5Stack Official*** 电路板。

![M5Stack Arduino IDE 安装](/images/devices-library/basic/microcontrollers/m5stack-arduino-ide-board-manager.png)

安装完成后，通过电路板菜单选择电路板：
**工具** > **电路板** > {{ arduinoBoardPath }}。

使用 USB 电缆将设备连接到计算机，并为设备选择端口：

**工具** > **端口** > **/dev/ttyUSB0**。

端口取决于操作系统，可能不同：
- 对于 Linux，它将是 **/dev/ttyUSB**X
- 对于 MacOS，它将是 **usb.serial**X.. 或 **usb.modem**X..
- 对于 Windows - **COM**X。