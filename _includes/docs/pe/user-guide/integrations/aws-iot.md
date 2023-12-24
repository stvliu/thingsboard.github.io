{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 概述

AWS IoT 集成允许将数据从 AWS IoT 后端流式传输到 GridLinks，并将设备有效负载转换为 GridLinks 格式。AWS IoT 将主要负责接收所有消息（作为代理 - 消息服务器），过滤它们，确定谁感兴趣，然后将消息发送给所有订阅者，在我们的集成案例中。

<object width="100%" style="max-width: max-content;" data="/images/user-guide/integrations/aws-iot-integration.svg"></object>

## AWS IOT

您应该已经准备了一个 [AWS 帐户](https://aws.amazon.com/iot/)，并在其上执行一些设置。要在服务和 ThingsBoard 之间建立正确且安全的连接，您需要为它们创建策略、设备和证书。

#### 创建策略

策略是 AWS 中的对象，当与实体或资源关联时，定义它们的权限。策略中的权限决定允许还是拒绝请求。大多数策略都以 JSON 文档的形式存储在 AWS 中。

要添加新策略，请在主菜单中选择 **安全** - **策略**，然后选择 **创建策略** 按钮。

{% include images-gallery.html imageCollection="create-policies_0" %}

您将被重定向到策略创建页面，您必须在其中指定 **策略名称** 并切换到 **JSON** 类型。

{% include images-gallery.html imageCollection="create-policies_1" %}

在 **策略文档** 的字段中，您需要使用您的唯一 **个人资料 ID** 粘贴下面的代码。

{% capture update_server_first %}
请务必将 **YOUR_REGION** 和 **YOUR_AWS_ID** 分别替换为您的区域和帐户 ID，<br>
（例如区域和 ID "<strong><h style="color:DarkOrange;">eu-west-1:111197721064</h></strong>"）。
{% endcapture %}
{% include templates/info-banner.md title="重要提示：" content=update_server_first %}

**策略文档示例：**

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iot:Publish",
        "iot:Receive"
      ],
      "Resource": [
        "arn:aws:iot:YOUR_REGION:YOUR_AWS_ID:topic/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "iot:Subscribe"
      ],
      "Resource": [
        "arn:aws:iot:YOUR_REGION:YOUR_AWS_ID:topicfilter/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "iot:Connect"
      ],
      "Resource": [
        "arn:aws:iot:YOUR_REGION:YOUR_AWS_ID:client/*"
      ]
    }
  ]
}
```
{: .copy-code}

当您登录 AWS IoT 帐户时，您的区域会列在 URL 中。 <br> 例如：**https://<h style="color:orange;">eu-west-1</h>.console.aws.amazaon.com**

{% include images-gallery.html imageCollection="create-policies_2" %}

之后，单击 **创建** 按钮。该策略将被添加到列表中，您将收到 **成功创建策略 tb_policy** 消息。

{% include images-gallery.html imageCollection="create-policies_3" %}

#### 创建事物和证书
事物是 AWS IoT 中物理设备或逻辑实体的数字表示。

您可以通过几个步骤创建条件设备，但需要转到相应的部分。在左侧，选择 **所有设备** 类别 - 然后选择 **事物** 项目。如果您还没有设备，此页面将显示您的所有设备。在右上角，选择 **创建事物** 按钮以继续添加设备。

{% include images-gallery.html imageCollection="add_device_0" %}

考虑添加单个设备的示例，选择相应的选项 **创建单个事物**，然后选择 **下一步** 按钮。

{% include images-gallery.html imageCollection="add_device_1" %}

在第一阶段，我们将为设备设置 **名称**，并根据您的判断设置其他参数。然后按 **下一步** 按钮转到以下步骤。

{% include images-gallery.html imageCollection="add_device_2" %}

在此阶段，选择 **自动生成新证书**。在确认添加设备后，证书和密钥可供下载，因此只需单击下一步按钮即可。

{% include images-gallery.html imageCollection="add_device_3" %}

在最后阶段，选择您之前添加的策略并使用 **创建事物** 按钮确认创建事物（设备）。

{% include images-gallery.html imageCollection="add_device_4" %}

完成后，您将看到一个其他窗口，可以下载证书和密钥。

需要配置集成以进行文件列表：
- 设备证书 (_*.pem.crt_)
- 私钥 (_*-private.pem.key_)
- 根 CA 证书 (_*.pem_)

AWS 还要求您为自己保存 **公钥文件**，因此请也下载该文件。

保存所需内容后，单击 **完成**。

{% include images-gallery.html imageCollection="save_certificates" %}

## ThingsBoard 设置

### 创建上行转换器

在创建集成之前，您需要在数据转换器中创建上行转换器。上行对于将来自设备的传入数据转换为在 GridLinks 中显示它们所需的格式是必要的。单击“加号”和“创建新转换器”。要查看事件，请启用调试。在函数解码器字段中，指定一个脚本，为此复制示例上行转换器，或使用自己的配置来解析和转换数据。

{% capture noteDebug %}
虽然调试模式对于开发和故障排除非常有用，但在生产模式下启用它会显着增加数据库使用的磁盘空间，因为所有调试数据都存储在那里。强烈建议在调试完成后关闭调试模式。
{% endcapture %}
{% include templates/info-banner.md title="注意：" content=noteDebug %}

{% include templates/tbel-vs-js.md %}

{% capture awsiotuplinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/aws-iot/aws-iot-uplink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/aws-iot/aws-iot-uplink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="awsiotuplinkconverterconfig" toggle-spec=awsiotuplinkconverterconfig %}

您可以在创建转换器时或创建转换器后更改解码器函数。如果转换器已经创建，则单击“铅笔”图标进行编辑。
{% include images-gallery.html imageCollection="edit_converter" %}

### 创建集成

- 转到 **集成** 部分，然后单击 **添加新集成** 按钮。将其命名为 **“AWS IoT 集成”**，选择类型 **AWS IoT**。

![image](/images/user-guide/integrations/aws-iot/aws-iot-add-integration-1-pe.png)

{% capture allowCreateDevice %}
请注意，如果取消选中“允许创建设备或资产”复选框，则在向 thingsboard 发送带有任何设备（或资产）参数的消息时，如果不存在此类设备（资产），则不会创建设备（资产）。
{% endcapture %}
{% include templates/info-banner.md content=allowCreateDevice %}

- 下一步是添加最近创建的 **上行** 转换器。

![image](/images/user-guide/integrations/aws-iot/aws-iot-add-integration-2-pe.png)

- 现在，将“下行数据转换器”字段留空。

![image](/images/user-guide/integrations/aws-iot/aws-iot-add-integration-3-pe.png)

- 输入 AWS IoT 端点。如果您转到 **设置** - **设备数据端点**，可以在您的 [AWS 帐户](https://aws.amazon.com/iot/) 中找到它。

{% include images-gallery.html imageCollection="aws_endpoint" %}

- 下载之前生成的证书和密钥。

![image](/images/user-guide/integrations/aws-iot/aws-iot-add-integration-4-pe.png)

- 添加主题过滤器 **tb/aws/iot/#**。您还可以选择 QoS 级别。我们默认使用 QoS 级别 0（最多一次）。

- 单击 **添加** 以创建集成。

![image](/images/user-guide/integrations/aws-iot/aws-iot-add-integration-5-pe.png)

### 发送上行消息

要发送测试消息，请使用 AWS IoT 的附加功能，MQTT 测试客户端。
在主菜单中，转到 **MQTT 测试客户端**，然后选择 **发布到主题** 选项卡。

{% include images-gallery.html imageCollection="send_uplink_0" %}

**主题示例：**
```
tb/aws/iot/sensors/freezer-432
```
{: .copy-code}

**有效负载示例：**
```ruby
{
    "val0": "loaded",
    "val1": -18,
    "val2": 1785,
    "val3": 548
}
```
{: .copy-code}

要检查消息是否已到达 AWS IoT 集成，请打开集成的事件选项卡。

{% include images-gallery.html imageCollection="send_uplink_1" %}

## 高级用法：创建下行转换器

让我们看一个简单的示例来测试连接并发送消息。为此，需要创建一个下行数据转换器。然后在 AWS IoT 集成中设置转换器和主题。

{% include templates/tbel-vs-js.md %}

{% capture awsiotdownlinkconverterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/integration/aws-iot/aws-iot-downlink-converter-config-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/integration/aws-iot/aws-iot-downlink-converter-config-javascript.md{% endcapture %}

{% include content-toggle.html content-toggle-id="awsiotdownlinkconverterconfig" toggle-spec=awsiotdownlinkconverterconfig %}

接下来，配置在哪些条件下将通过 AWS IoT 下行集成发送消息。
为此，您需要打开用于设备的规则链（在我们的示例中，是默认的根规则链），然后添加 [集成下行节点](https://thingsboard.io/docs/pe/user-guide/rule-engine-2-0/action-nodes/#integration-downlink-node)，对于链接条件，设置属性已更新。

{% include images-gallery.html imageCollection="downlink_2-3" %}

要订阅主题以接收来自 Thingsboard 的消息，请使用 **AWS MQTT 测试客户端**。

{% include images-gallery.html imageCollection="downlink_4" %}

现在，您可以更新设备属性。为此，请打开 **设备**、**属性** 选项卡，然后选择 **共享属性**，然后选择任何属性或添加一个新属性来更新它。

{% include images-gallery.html imageCollection="downlink_5" %}

可以在您订阅主题的 AWS 页面上跟踪结果：

{% include images-gallery.html imageCollection="downlink_6" %}

## 视频教程

请参阅下面的视频教程，了解有关如何设置 AWS IoT 集成（过时的界面）的分步说明。

<br>
<div id="video">  
 <div id="video_wrapper">
     <iframe src="https://www.youtube.com/embed/udkuOUrNzWk" frameborder="0" allowfullscreen></iframe>
 </div>
</div>

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}