{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}


## 概述

Azure IoT Hub 集成允许将数据从 AWS IoT 后端流式传输到 GridLinks，并将设备有效负载转换为 GridLinks 格式。

  <object width="80%" data="/images/user-guide/integrations/azure/iot-hub-integration.svg"></object>

## 创建和配置 Azure IoT Hub 帐户

- [创建 IoT 中心](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-create-through-portal#create-an-iot-hub)。

- [在 IoT 中心注册新设备](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-create-through-portal#register-a-new-device-in-the-iot-hub)。

## 与 Thingsboard 集成
我们已在 Azure IoT Hub 方面完成了所有必要步骤。现在我们可以开始配置 Thingsboard。

##### Thingsboard 上行数据转换器

首先，我们需要创建上行数据转换器，该转换器将用于转换从 Azure IoT Hub 接收到的消息。转换器应将传入有效负载转换为所需的消息格式。
消息必须包含 **deviceName** 和 **deviceType**。这些字段用于将数据提交给正确的设备。如果未找到设备，则将创建新设备。
以下是来自 Azure IoT Hub 的演示有效负载的外观：
{% highlight json %}
{
    "devName": "T1",
    "msg": {
        "temp": 42,
        "humidity": 77
    }
}
{% endhighlight %}

我们将采用 **devName** 并将其映射到 **deviceName**。但您可以在特定用例中使用其他映射。
此外，我们将采用 **temperature** 和 **humidity** 字段的值，并将其用作设备遥测。

转到 **数据转换器** 并使用此函数创建新的 **上行** 转换器：
{% highlight javascript %}
var data = decodeToJson(payload);
var deviceName = data.devName;
var deviceType = 'thermostat';

var result = {
   deviceName: deviceName,
   deviceType: deviceType,
   telemetry: {
       temperature: data.msg.temp,
       humidity: data.msg.humidity
   }
};

function decodeToString(payload) {
   return String.fromCharCode.apply(String, payload);
}

function decodeToJson(payload) {
   var str = decodeToString(payload);
   var data = JSON.parse(str);
   return data;
}

return result;
{% endhighlight %}

![image](/images/user-guide/integrations/azure/iot-hub-converter.png)

##### Azure IoT Hub 集成

接下来，我们将在 Thingsboard 内创建与 Azure IoT Hub 的集成。打开 **集成** 部分，并添加类型为 **Azure IoT Hub** 的新集成

- 名称：IoT Hub
- 类型：Azure IoT Hub
- 上行数据转换器：恒温器转换器
- 主机名：**AZURE_IOT_HUB_HOSTNAME**
- 设备 ID：T1
- 凭据：共享访问签名
- SAS 密钥：**DEVICE_SAS_KEY**
- 主题过滤器：devices/T1/messages/devicebound/#

![image](/images/user-guide/integrations/azure/iot-hub-add-integration.png)

- **主题** - 有关 IoT Hub 主题的更多信息，请使用 [链接](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-mqtt-support#receiving-cloud-to-device-messages)。
- **凭据** - Azure IoT Hub 连接凭据。可以是 *共享访问签名* 或 *PEM*。

Azure IoT Hub 支持不同的身份验证凭据：

- 共享访问签名 - SAS 密钥用于身份验证
- PEM - PEM 证书用于身份验证

如果选择了 **共享访问签名** 凭据类型，则应提供以下配置：
- SAS 密钥 - 这是您在 [Azure IoT Hub](https://docs.microsoft.com/en-us/azure/iot-edge/how-to-authenticate-downstream-device#symmetric-key-authentication) 中设备的密钥
- CA 证书文件，默认使用 Baltimore 证书。有关证书的更多信息，[请点击此处](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-mqtt-support#tlsssl-configuration)

如果选择了 **PEM** 凭据类型，则应提供以下配置：

- CA 证书文件，默认使用 Baltimore 证书。有关证书的更多信息，[请点击此处](https://docs.microsoft.com/en-us/azure/iot-hub/iot-hub-mqtt-support#tlsssl-configuration)
- 证书文件
- 私钥文件
- 私钥密码

[X.509 CA 签名身份验证](https://docs.microsoft.com/en-us/azure/iot-edge/how-to-authenticate-downstream-device#x509-ca-signed-authentication)

[CACertificates 说明](https://github.com/Azure/azure-iot-sdk-c/tree/master/tools/CACertificates)

## 验证

##### 验证上行消息
让我们验证我们的集成。首先，让我们将消息放入上行流中，以便 Thingsboard 获取此消息。

打开包含您的设备的页面，然后转到 **发送至设备**。

向设备发送测试消息。

![image](/images/user-guide/integrations/azure/iot-hub-send-test-msg.png)


转到 **设备组** -> **全部** -> **T1** - 您会看到

- 新设备已在 thingsboard 中注册
- 在 **最新遥测** 部分中，您将看到上次提交的温度 = 42，湿度 = 77。

![image](/images/user-guide/integrations/azure/iot-hub-validate-telemetry.png)

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}