您应该安装一些系统库来使用 BLE Connector 和 bleak 库以供 python 使用。

只需复制以下命令并运行它们：

此命令将安装所需的库：

```bash
sudo yum groupinstall -y "development tools"
```
{: .copy-code}

此命令将安装 bluepy 库：

```bash
sudo pip3 install bleak
```
{: .copy-code}