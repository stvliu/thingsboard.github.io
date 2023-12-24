{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

本教程将演示如何使用旋钮控制小部件将数据发送到外部 MQTT 代理。

* TOC
{:toc}

## 使用案例

假设你的设备正在控制温度，你想借助 Thingsboard 将其用作外部 MQTT 代理。

在本教程中，我们将配置 ThingsBoard 规则引擎以使用 MQTT 协议自动发送消息。你可以将本教程作为更复杂任务的基础。

MQTT 集成允许将现有协议和有效负载格式转换为 ThingsBoard 消息格式，在多种部署场景中很有用：

- 将设备和/或资产数据从外部系统、物联网平台或连接提供商后端流式传输回来。
- 从在云中运行的自定义应用程序流式传输设备和/或资产数据。
- 将具有基于 MQTT 的自定义协议的现有设备连接到 ThingsBoard。

请查看集成图以了解更多信息。

![image](/images/user-guide/integrations/mqtt-integration.svg)

## 先决条件

我们假设你已经完成了以下指南并阅读了下面列出的文章：

* [入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南。
* [规则引擎概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)。
* [MQTT 集成](/docs/{{peDocsPrefix}}user-guide/integrations/mqtt/)。
* [数据转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#data-converters)。

## 模型定义

我们将使用名称为“Thermostat-A”且类型为“thermostat”的温度传感器设备，该设备将在集成工作过程中自动创建。

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-device.png)

## 开始

### 创建转换器

为了使集成正常工作，应创建下行和上行转换器。

- 转到 **数据转换器** -> **添加新数据转换器** -> **导入转换器**

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/import_new_converter.png)

- 导入以下文件：[**上行转换器**](/docs/user-guide/resources/sensor_uplink_converter.json)，
[**下行转换器**](/docs/user-guide/resources/sensor_downlink_converter.json)。

你可以这样检查它们：

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-check-converters.png)

上行转换器应如下所示：

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-uplink-converter.png)

下行转换器应如下所示：

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-downlink-converter.png)


### 创建集成

为了使集成正常工作，应使用远程服务器。在这种情况下，你可以将 iot.eclipse.org 用于你的 MQTT 数据。集成应如下所示：

- 转到 **集成** -> **添加新集成**

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/add-new-integration.png)

- 使用下表中所示的输入数据填写字段：

<table style="width: 25%">
  <thead>
      <tr>
          <td><b>字段</b></td><td><b>输入数据</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>名称</td>
          <td>Thermostat MQTT 集成</td>
      </tr>
      <tr>
          <td>类型</td>
          <td>MQTT</td>
      </tr>
      <tr>
          <td>调试模式</td>
          <td>否</td>
      </tr>
      <tr>
          <td>上行数据转换器</td>
          <td>传感器上行转换器</td>
      </tr>
      <tr>
          <td>下行数据转换器</td>
          <td>传感器下行转换器</td>
      </tr>
      <tr>
          <td>主机</td>
          <td>iot.eclipse.org</td>
      </tr>
      <tr>
          <td>端口</td>
          <td>1883</td>
      </tr>
      <tr>
          <td>连接超时（秒）</td>
          <td>10</td>
      </tr>
      <tr>
          <td>客户端 ID</td>
          <td>（空）</td>
      </tr>
      <tr>
          <td>清除会话</td>
          <td>是</td>
      </tr>
      <tr>
          <td>启用 SSL</td>
          <td>否</td>
      </tr>
      <tr>
          <td>凭据</td>
          <td>匿名</td>
      </tr>
      <tr>
          <td>主题过滤器</td>
          <td>devices/Thermostat-A/temperature/latest</td>
      </tr>
      <tr>
          <td>QOS</td>
          <td>最多一次</td>
      </tr>
      <tr>
          <td>主题过滤器</td>
          <td>devices/Thermostat-A/temperature/settings/</td>
      </tr>
      <tr>
                <td>QOS</td>
           <td>最多一次</td>
      </tr>
      <tr>
         <td>下行主题模式</td>
         <td>${topic}</td>
      </tr>
      <tr>
          <td>说明</td>
          <td>（空）</td>
      </tr>
      <tr>
          <td>元数据</td>
          <td>（空）</td>
      </tr>
   </tbody>
</table> 

- 填写所有字段后，单击 **添加** 按钮。

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-create-integration-1.png)
![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-create-integration-2.png)

### 设置仪表板

下载并[**导入**](/docs/{{docsPrefix}}user-guide/ui/dashboards/#dashboard-import) 附加的
json [**文件**](/docs/user-guide/resources/temperature_control_dashboard.json) 作为本教程的仪表板。

### 打开设备模拟器

为了使小部件在没有真实设备的情况下工作，应打开模拟器。

首先，你应使用以下命令检查是否已安装 node、npm 和 npm 模块 mqtt：

```bash
#显示 node 版本
node -v
#显示 npm 版本
npm -v
#显示 npm mqtt 模块版本
npm list mqtt 
```

如果你没有 npm，可以从 [此处](https://www.npmjs.com/package/npm) 安装它，并使用以下命令安装 npm MQTT 模块：

```bash
sudo npm install mqtt --save
```

并从 [此处](https://nodejs.org/en/download/) 下载 node。

下载 [**文件**](/docs/user-guide/resources/mqtt-downlink-virtual-device.js) 并使用以下
命令运行它以启动设备模拟器：

```bash
node mqtt-downlink-virtual-device.js
```

注意：应将设备模拟器放在 node-modules 所在的文件夹中。


### 工作演示

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-work-demonstration.png) 

使用控制小部件（在本例中，为旋钮）会导致仪表板上的值发生变化。

仪表板可以在 [**此处**](/docs/user-guide/resources/temperature_control_dashboard.json) 找到，
并像 [**这样**](/docs/{{docsPrefix}}user-guide/ui/dashboards/#dashboard-import) 导入。

## 消息流

在本节中，我们将解释本教程中每个节点的用途。

### 修改规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-root-rule-chain.png) 

  * **节点 A**：发起者属性扩充节点
      
    * 将客户端属性 deviceName 放入元数据
    
   ![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-node-A.png) 
    
  * **节点 B**：脚本转换节点
      
     * 将元数据中的 deviceName 放入消息参数
     
    ![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-node-B.png)

  * **节点 C**：集成下行节点
  
    * 将消息发送到集成
    
    ![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/mqtt-downlink-node-C.png) 

你可以下载并 [**导入**](/docs/{{docsPrefix}}user-guide/ui/rule-chains/#rule-chains-importexport) 附加的
json [**文件**](/docs/user-guide/resources/mqtt-downlink-root-rule-chain.json) 作为本教程的规则链。
它应标记为根。


## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/multi-project-guides-banner.md %}