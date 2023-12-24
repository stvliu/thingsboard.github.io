**Ubuntu** 安装 cURL：

```bash
sudo apt-get install curl
```
{: .copy-code}


**macOS** 安装 cURL：

```bash
brew install curl
```
{: .copy-code}

**Windows** 安装 cURL：

从 Windows 10 b17063 开始，cURL 默认可用。
更多信息请参阅此 MSDB 博客 [文章](https://blogs.msdn.microsoft.com/commandline/2018/01/18/tar-and-curl-come-to-windows/)。
如果您使用的是较旧版本的 Windows 操作系统，您可以在 [此处](https://curl.haxx.se/) 找到官方安装指南。

<br>

此命令适用于 Windows、Ubuntu 和 macOS，假设已安装 cURL 工具。

{% if docsPrefix == 'paas/' %}

用相应的值替换 $ACCESS_TOKEN。

```bash
curl -v -X POST -d "{\"temperature\": 25}" https://gridlinks.codingas.com/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

例如，$ACCESS_TOKEN 为 ABC123：

```bash
curl -v -X POST -d "{\"temperature\": 25}" https://gridlinks.codingas.com/api/v1/ABC123/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% else %}

用相应的值替换 $THINGSBOARD_HOST_NAME_AND_PORT 和 $ACCESS_TOKEN。

```bash
curl -v -X POST -d "{\"temperature\": 25}" http://$THINGSBOARD_HOST_NAME_AND_PORT/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME_AND_PORT 引用您的本地安装，端口为 8080，$ACCESS_TOKEN 为 ABC123：

```bash
curl -v -X POST -d "{\"temperature\": 25}" http://localhost:8080/api/v1/ABC123/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

{% endif %}