让我们添加一个 **OPC-UA 连接器**，它会将一些数据从演示服务器读取到创建的网关。

### 设置演示服务器

作为演示模拟服务器，我们将使用 docker 镜像，可以使用以下命令安装并运行：

```shell
docker ps
```
{:.copy-code}

找到您的网关容器名称，如下面的图片所示，并复制它：

![](/images/gateway/dashboard/copy-gateway-docker-container-name.png)

使用以下命令创建一个环境变量，将 `YOUR_TB_GATEWAY_CONTAINER_NAME` 替换为复制的网关容器名称。复制并运行终端中提供的命令：

```shell
export TB_GATEWAY_CONTAINER_NAME=YOUR_TB_GATEWAY_CONTAINER_NAME
```
{:.copy-code}

复制并执行终端中的以下命令：

{% assign containerId = "{" | append: "{" | append: ".Id" | append: "}" | append: "}" %}

```shell
docker run -it --net=container:$(docker inspect -f '{{containerId}}' ${TB_GATEWAY_CONTAINER_NAME}) thingsboard/tb-gw-opcua-server:latest
```
{:.copy-code}

运行 docker 镜像后，您可以在终端中看到以下日志：

![](/images/gateway/dashboard/run-demo-opcua-server.png)

### 设置连接器

复制以下连接器配置（我们稍后会用到）：

```json
{
  "server": {
    "name": "OPC-UA Demo Server",
    "url": "opc.tcp://localhost:4840/freeopcua/server/",
    "timeoutInMillis": 5000,
    "scanPeriodInMillis": 5000,
    "disableSubscriptions": false,
    "subCheckPeriodInMillis": 100,
    "showMap": true,
    "security": "Basic128Rsa15",
    "identity": {
      "type": "anonymous"
    },
    "mapping": [
      {
        "deviceNodePattern": "Root\\.Objects\\.MyObject",
        "deviceNamePattern": "Device Demo",
        "deviceTypePattern": "default",
        "attributes": [
          {
            "key": "frequency",
            "path": "${Frequency}"
          },
          {
            "key": "power",
            "path": "${Power}"
          }
        ],
        "timeseries": [
          {
            "key": "temperature",
            "path": "${Temperature}"
          },
          {
            "key": "humidity",
            "path": "${Humidity}"
          }
        ],
        "rpc_methods": [],
        "attributes_updates": []
      }
    ]
  }
}
```
{:.copy-code.expandable-20}

要创建连接器，请执行以下步骤：

{% assign addNewConnector = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-7-ce.png,
        title: 单击右侧面板上的“**连接器配置**”按钮。
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-8-ce.png,
        title: 单击“**+**”按钮，填写“**名称**”、“**类型**”和“**日志级别**”字段，将连接器配置粘贴到**配置**字段中，然后单击**保存**按钮。
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-9-ce.png,
        title: 连接器已成功添加。
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-10-ce.png,
        title: 切换开关以启用连接器。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=addNewConnector %} 

按照概述的步骤，您的网关将接收并应用新配置。然后，它将与其远程服务器同步其状态。您可以在“**配置**”列中查看连接器配置的同步状态，该列将指示网关是否已成功与远程设置对齐。

此外，您可以查看连接器日志以确保连接器正常工作，为此，请执行以下步骤：
{% assign seeConnectorLogs = '
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-11-logs-ce.png,
        title: 单击日志图标以打开连接器日志页面。
    ===
        image: /images/gateway/dashboard/gateway-getting-started-opc-ua-logs-12-ce.png,
        title: 您可以看到由“**创建时间**”、“**状态**”和“**消息**”列组成的“**日志**”表。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=seeConnectorLogs %}

现在，网关已准备好通过新创建和配置的 OPC-UA 连接器处理数据。