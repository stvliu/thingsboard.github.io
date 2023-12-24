---
layout: docwithnav-pe
title: SODAQ Universal Tracker / Telemetry upload using UDP Integration
description: SODAQ Universal Tracker telemetry upload
hidetoc: "true"

---

{% assign feature = "Platform Integrations" %}{% include templates/pe-feature-banner.md %}

本指南包含有关如何通过 T-Mobile NB IoT 网络将 SODAQ NB-IoT 板连接到 GridLinks Professional Edition (PE) 的分步说明。
在本指南中，我们将使用免费的 ThingsBoard PE 演示服务器 [thingsboard.cloud](https://thingsboard.cloud/signup)。
本指南对希望将 SODAQ NB-IoT 板或其他硬件连接到 T-Mobile NB IoT 网络的任何人都有用。

* TOC
{:toc}

## 先决条件

我们假设您的实验室中至少有一个 SODAQ NB-IoT 追踪器，并且该追踪器已连接到您的 T-Mobile IoT 网络。
我们还假设您已经拥有 ThingsBoard PE 服务器或免费演示帐户。
否则，您可以在此处注册 30 天免费演示帐户：[thingsboard.cloud](https://thingsboard.cloud/signup)。

我们希望您对 ThingsBoard 有非常基本的了解。否则，我们建议您完成以下指南：
- [入门](/docs/getting-started-guides/helloworld/) 指南。
- [平台集成](/docs/user-guide/integrations/) 指南。

## 集成概述

GridLinks 平台集成功能允许将数据从各种平台和连接解决方案推送到 GridLinks。
我们将使用“UDP”平台集成来使用 T-Mobile NB IoT 网络的数据并自动在 GridLinks 中注册设备。
除了配置集成之外，我们还将设置 GridLinks 来解码传入数据，将其存储在数据库中，在仪表板上可视化并根据可配置阈值生成警报。

## 步骤 1. 数据转换器配置

为了创建 [集成](/docs/user-guide/integrations/)，我们应该首先创建 [上行数据转换器](/docs/user-guide/integrations/#uplink-data-converter)。
转换器将解码来自 T-Mobile NB IoT 的传入遥测有效载荷数据，该数据包含编码的十六进制字符串，以转换为人类可读的简化 ThingsBoard 数据格式。

- 来自 T-Mobile NB IoT 平台的输入数据是一个字节序列，在将它们转换为十六进制字符串类型后，如下所示：

{% highlight bash %}
    "010145292a2bfbfc0000000000000000e6e3355c751a879de31e6535d10306005600d00402"
{% endhighlight %}

- UDP 集成将上述十六进制字符串传递给 JSON，以获取以下有效载荷：
{% highlight bash %}
{
    "reports": [{
          "value": "010145292a2bfbfc0000000000000000e6e3355c751a879de31e6535d10306005600d00402"
    }]
}
{% endhighlight %}

- 对于此有效载荷，解码器具有以下外观：

```javascript
        /** Decoder **/

        // The field of input json
        var reports = decodeToJson(payload).reports;

        // Result object with device attributes/telemetry data
        var result = {
           deviceName: {},
           deviceType: "tracker",
           telemetry: []
        };

        for (var i = 0; i < reports.length; i++) {
          result.deviceName = parseInt(reports[i].value.substring(2, 16), 16);
          var telemetryObj = {
              ts: {},
              values: {}
          };
          timestamp = stringToInt(reports[i].value.substring(32,40))*1000;
          v = stringToInt(reports[i].value.substring(40,42))/100 + 3;
          t = stringToInt(reports[i].value.substring(42,44));
          lat = stringToInt(reports[i].value.substring(44,52))/10000000;
          lon = stringToInt(reports[i].value.substring(52,60))/10000000;
          alt = stringToInt(reports[i].value.substring(60, 64));
          speed = stringToInt(reports[i].value.substring(64, 68));
          sat = stringToInt(reports[i].value.substring(68, 70));
          ttf = stringToInt(reports[i].value.substring(70, 72));

          telemetryObj.ts = timestamp;
          telemetryObj.values.batteryVoltage = v;
          telemetryObj.values.temperature = t;
          if(lat !== 0) {
                telemetryObj.values.latitude = lat;
          }
          if(lon !== 0) {
                telemetryObj.values.longitude = lon;
          }
          if(alt !== 0) {
                telemetryObj.values.altitude = alt;
          }
          telemetryObj.values.speed = speed;
          telemetryObj.values.satellitesObserved = sat;
          telemetryObj.values.timetToFirstFix = ttf;
          result.telemetry.push(telemetryObj);
        }

        /** Helper functions **/

        function stringToInt(hex) {
            return parseInt('0x' + hex.match(/../g).reverse().join(''));
        }

        function decodeToString(payload) {
           return String.fromCharCode.apply(String, payload);
        }

        function decodeToJson(payload) {
          // convert payload to string.
          var str = decodeToString(payload);

          // parse string to JSON
          var data = JSON.parse(str);
          return data;
        }

        return result;

```

- 解码后，输出数据将如下所示：

{% highlight bash %}
{
    "deviceName": 357518080211964,
    "deviceType": "tracker",
    "telemetry": [{
        "ts": 1547035622000,
        "values": {
            "batteryVoltage": 4.17,
            "temperature": 26,
            "latitude": 51.8233479,
            "longitude": 6.4042341,
            "altitude": 6,
            "speed": 86,
            "satellitesObserved": 208,
            "timetToFirstFix": 4
        }
    }]
}
{% endhighlight %}

需要注意的几点：

* 来自传入消息的 IMEI 将成为 GridLinks 中的设备名称；
* ThingsBoard 将自动创建类型为“tracker”且名称等于 IMEI 的设备；
* 从传入的十六进制字符串中解码时间戳和传感器读数。
* 下表显示了传入十六进制字符串中包含的每个编码字段的第一个字节位置和字节数：

<table style="width: 22%">
  <thead>
      <tr>
          <td><b>字段</b></td><td><b>第一个字节</b></td><td><b>字节长度</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>deviceName</td>
          <td>2</td>
          <td>7</td>
      </tr>
      <tr>
          <td>ts</td>
          <td>16</td>
          <td>4</td>
      </tr>
      <tr>
          <td>batteryVoltage</td>
          <td>20</td>
          <td>1</td>
      </tr>
      <tr>
          <td>temperature</td>
          <td>21</td>
          <td>1</td>
      </tr>
      <tr>
          <td>latitude</td>
          <td>22</td>
          <td>4</td>
      </tr>
      <tr>
          <td>longitude</td>
          <td>26</td>
          <td>4</td>
      </tr>
      <tr>
          <td>altitude</td>
          <td>30</td>
          <td>2</td>
      </tr>
      <tr>
          <td>speed</td>
          <td>32</td>
          <td>2</td>
      </tr>
      <tr>
          <td>satellitesObserved</td>
          <td>35</td>
          <td>1</td>
      </tr>
      <tr>
          <td>timetToFirstFix</td>
          <td>36</td>
          <td>1</td>
      </tr>
   </tbody>
</table>

- 转到 **数据转换器** -> **添加新的数据转换器** -> **导入转换器**

- 导入以下 json 文件：[**SODAQ UDP 上行数据转换器**](/docs/user-guide/resources/sodaq/sodaq_udp_uplink_data_converter.json)（左键单击链接，然后按“Ctrl+S”下载）
如下面的屏幕截图所示：

<img data-gifffer="/images/user-guide/integrations/sodaq/import-udp-converter_updated.gif" alt="import udp converter updated">

## 步骤 2. 集成配置

- 根据以下屏幕截图创建新的集成。

请注意，您应该复制 **集成密钥** 和 **集成机密**，如 [**UDP 集成设置**](/docs/user-guide/integrations/udp/#udp-integration-setup) 指南中所述。


<img data-gifffer="/images/user-guide/integrations/sodaq/create-udp-integration.gif" alt="create udp integration">

- 使用下表中所示的输入数据填写字段：

<table style="width: 50%">
  <thead>
      <tr>
          <td><b>字段</b></td><td><b>输入数据</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>名称</td>
          <td>SODAQ UDP 集成</td>
      </tr>
      <tr>
          <td>类型</td>
          <td>UDP</td>
      </tr>
      <tr>
          <td>调试模式</td>
          <td>真</td>
      </tr>
      <tr>
          <td>上行数据转换器</td>
          <td>SODAQ UDP 数据上行转换器</td>
      </tr>
      <tr>
          <td>下行数据转换器</td>
          <td>（空）</td>
      </tr>
      <tr>
          <td>端口</td>
          <td>11560</td>
      </tr>
      <tr>
          <td>So 广播选项</td>
          <td>64</td>
      </tr>
      <tr>
          <td>处理程序配置</td>
          <td>处理程序类型 | HEX</td>
      </tr>
   </tbody>
</table>

- 填写所有字段后，单击 **添加** 按钮。

## 步骤 3：发布遥测并验证集成配置

在我们急于进行 T-Mobile IoT 平台配置之前，请确保您已完成 [**远程集成安装步骤**](/docs/user-guide/integrations/remote-integrations/#remote-integration-installation-steps)。

此外，让我们确保使用简单的 **echo** 命令和 **netcat** 实用程序正确配置了 ThingsBoard。
我们将使用以下命令模拟来自 T-Mobile IoT 平台的消息。
让我们执行以下命令：

{% highlight bash %}
echo -e -n '$PAYLOAD' | xxd -r -p | nc -q1 -w1 -u $URL_THINGSBOARD_CLOUD_HOST $PORT

您需要分别用实际有效载荷、云主机 URL 和端口替换 $PAYLOAD、$URL_THINGSBOARD_CLOUD_HOST 和 $PORT。
{% endhighlight %}

示例：
{% highlight bash %}
echo -e -n '010145292a2bfbfc0000000000000000e6e3355c751a879de31e6535d10306005600d00402' | xxd -r -p | nc -q1 -w1 -u 127.0.0.1 11560
{% endhighlight %}

导航到集成调试事件并检查数据是否真实到达并成功处理。

应该创建名称为 **357518080211964** 的设备。

<img data-gifffer="/images/user-guide/integrations/sodaq/validate-udp-integration.gif" alt="validate udp integration">

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/guides-banner.md %}