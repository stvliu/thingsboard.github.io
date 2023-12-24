{% capture difference %}
<br>
**别忘了在设备上创建共享属性 `blinkingPeriod`。**
{% endcapture %}
{% include templates/info-banner.md content=difference %}

此外，我们可以使用 [共享属性](/docs/{{page.docsPrefix}}user-guide/attributes/#shared-attributes) 更新功能来更改闪烁周期。

此类属性仅适用于设备。它类似于服务器端属性，但有一个重要的区别。设备固件/应用程序可以请求共享属性的值或订阅属性的更新。共享属性最常见的案例是存储设备设置。

为了运行本指南此部分的代码，我们建议使用 Python 3.9 或更高版本。


如果你尚未安装 Python，请按照以下步骤操作：

```bash
sudo apt update
sudo apt install software-properties-common
```
{:.copy-code}

```bash
sudo add-apt-repository ppa:deadsnakes/ppa
```
{:.copy-code}

```bash
sudo apt install python3.9
```
{:.copy-code}

```bash
sudo apt-get install -y python3 git python3-pip
```
{:.copy-code}

此外，我们将需要 Adafruit-Blinka 库。请使用以下命令安装它：

```bash
pip3 install Adafruit-Blinka
```
{:.copy-code}


现在，我们准备编写代码了。在本部分中，我们在 `blink` 函数中使用新软件包来闪烁 LED。此外，我们使用 `attibute_callback` 函数，该函数将在我们更改共享属性的值时调用。最后，我们在 `main` 函数中将回调绑定到订阅者。

```python
import digitalio
import board

...

# 默认闪烁周期
period = 1.0

# 当我们更改共享属性的值时将调用的回调函数
def attribute_callback(client, result):
    print(client, result)
    # 确保粘贴你的共享属性名称
    period = result.get('blinkingPeriod', 1.0)

def main():
    ...
    # 确保粘贴你的共享属性名称
    sub_id_1 = client.subscribe_to_attribute("blinkingPeriod", attribute_callback)
    sub_id_2 = client.subscribe_to_all_attributes(attribute_callback)
    led = digitalio.DigitalInOut(board.PD14)
    led.direction = digitalio.Direction.OUTPUT
    ...
    led.value = True
    time.sleep(period)
    led.value = False
    time.sleep(period)
```

此外，如果你使用导入的仪表板，可以使用以下小部件更改闪烁周期，你可以在仪表板的右下角看到该小部件：

![](/images/devices-library/basic/single-board-computers/attribute-update-widget.png)