GridLinks 服务在 Java 11 上运行。按照以下说明安装 OpenJDK 11：

```bash
sudo apt update
sudo apt install openjdk-11-jdk
```
{: .copy-code}

请不要忘记将操作系统配置为默认使用 OpenJDK 11。
您可以使用以下命令配置哪个版本是默认版本：

```bash
sudo update-alternatives --config java
```
{: .copy-code}

您可以使用以下命令检查安装情况：

```bash
java -version
```
{: .copy-code}

预期的命令输出是：

```text
openjdk version "11.0.xx"
OpenJDK Runtime Environment (...)
OpenJDK 64-Bit Server VM (build ...)
```