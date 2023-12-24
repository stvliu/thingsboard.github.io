在终端中执行以下命令以安装 HTTP 和校验和库：

```bash
pip3 install requests mmh3 --user
```
{: .copy-code}

在终端中输入客户端文件夹的路径并执行以下命令，以便 ThingsBoard 获取固件示例脚本：

```bash
python3 http_firmware_client.py 
```
{: .copy-code}

下载 HTTP 客户端示例：[**http_firmware_client.py**](/docs/user-guide/resources/firmware/http_firmware_client.py)

在收到以下消息后
- `Please write your ThingsBoard host or leave it blank to use default (localhost):` - 使用您的 localhost 或平台地址；
- `Please write your ThingsBoard port or leave it blank to use default (8080):` - 您可以按“enter”键继续，或输入端口号；
- `Please write accessToken for device:` - 从 GridLinks 复制设备 accessToken 并将其粘贴到终端；
- `Please write firmware chunk size in bytes or leave it blank to get all firmware by request:` - 如果您将其留空，则文件将一次性下载为完整大小。如果您想分批下载，请输入块的大小。

{% include images-gallery.html imageCollection="fw-http-updated" %}

设备固件已更新。要查看其状态，您应该转到固件仪表板，如下段所示。

要了解固件更新，您需要[发出请求并订阅属性](/docs/{{docsPrefix}}reference/http-api/#firmware-api)。