{% assign peDocsPrefix = '' %}
{% if docsPrefix == 'paas/' %}
{% assign peDocsPrefix = docsPrefix %}
{% endif %}

{% assign feature = "平台集成" %}{% include templates/pe-feature-banner.md %}

本教程将演示如何将下行消息推送到通过 Sigfox 集成连接的设备，前提是用户使用 ThingsBoard UI 更新设备属性

* TOC
{:toc}
 
## 使用案例

在本教程中，我们将使用 SigFox 集成获取指定设备的共享属性。
SigFox 后端将使用 Postman 模拟。

## 先决条件

我们假设您已完成以下指南并阅读了以下文章：

  * [入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)。
  * [SigFox 集成](/docs/{{peDocsPrefix}}user-guide/integrations/sigfox/)。
  * [数据转换器](/docs/{{peDocsPrefix}}user-guide/integrations/#data-converters)。

## 模型定义
  
我们将操作具有名称“恒温器 A”的设备，该设备将在集成工作过程中自动创建。

![image](/images/user-guide/integrations/sigfox/sigfox-device.png)

**注意**：必须创建此设备的共享属性。

## 入门

### 创建转换器

为了使集成正常工作，应创建下行和上行转换器。

- 转到 **数据转换器** -> **添加新的数据转换器** -> **导入转换器** 

![image](/images/user-guide/rule-engine-2-0/tutorials/mqtt-downlink/import_new_converter.png)

- 导入以下文件：[**上行转换器**](/docs/user-guide/resources/sigfox/uplink-sigfox-converter.json)，
 [**下行转换器**](/docs/user-guide/resources/sigfox/downlink-sigfox-converter.json)。

上行转换器应如下所示：

![image](/images/user-guide/integrations/sigfox/sigfox-uplink-converter.png) 

下行转换器应如下所示：

![image](/images/user-guide/integrations/sigfox/sigfox-uplink-converter.png)

### 创建集成

集成应如下所示：

- 转到 **集成** -> **添加新的集成**

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
          <td>新的 SigFox 集成</td>
      </tr>
      <tr>
          <td>类型</td>
          <td>SigFox</td>
      </tr>
      <tr>
          <td>调试模式</td>
          <td>否</td>
      </tr>
      <tr>
          <td>上行数据转换器</td>
          <td>新的上行 SigFox 转换器</td>
      </tr>
      <tr>
          <td>下行数据转换器</td>
          <td>新的下行 SigFox 转换器</td>
      </tr>
      <tr>
          <td>基本 URL</td>
          <td>http://thingsboard.cloud</td>
      </tr>
      <tr>
          <td>启用安全性</td>
          <td>否</td>
      </tr>
   </tbody>
</table> 

![image](/images/user-guide/integrations/sigfox/sigfox-create-integration.png)

## 消息流

在本节中，我们将解释本教程中每个节点的用途。将涉及一个规则链：

- **根规则链** - 将设备遥测数据保存到数据库的规则链，并将属性更新重定向到 **到 SigFox 集成** 链。
- **到 SigFox 集成** - 将所有具有指定键的传入数据发送到集成的规则链。

以下屏幕截图显示了上述规则链应如何显示：

- **到 SigFox 集成**：

![image](/images/user-guide/integrations/sigfox/sigfox-rule-chain.png)

- **根规则链**：

![image](/images/user-guide/integrations/sigfox/sigfox-root-rule-chain.png)

下载并[**导入**](/docs/{{docsPrefix}}user-guide/ui/rule-chains/#rule-import)附加的 json
 [**文件**](/docs/user-guide/integrations/tutorials/resources/sigfox/to-sigfox-integration.json) 作为
  **到 SigFox 集成** 规则链。
  
在根规则链中创建节点 C，如上图所示，以将属性更新消息转发到导入的规则链。

以下部分向您展示如何从头开始创建此规则链。

#### 创建新的规则链（**到 SigFox 集成**）

转到 **规则链** -> **添加新的规则链** 

配置：

- 名称：**到 SigFox 集成**

![image](/images/user-guide/integrations/sigfox/add-to-sigfox-integration-chain.png)

创建新的规则链。按 **编辑** 按钮并配置链。

###### 添加所需的节点

在此规则链中，您将创建 2 个节点，如下节所述：

###### 节点 A：**检查存在过滤器**

- 添加 **检查存在过滤器** 节点，并通过关系类型 **成功** 将其连接到 **输入** 节点。
此规则节点检查传入的更新属性是否为“状态”。

![image](/images/user-guide/integrations/sigfox/check-status-field.png)

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
          <td>检查状态字段</td>
      </tr>
      <tr>
          <td>消息数据</td>
          <td>状态</td>
      </tr>
   </tbody>
</table> 

###### 节点 B：**集成下行**

- 添加 **集成下行** 节点，并通过关系类型
 **成功** 将其连接到 **检查存在过滤器** 节点。此规则节点将消息推送到指定集成。 
 
 ![image](/images/user-guide/integrations/sigfox/push-to-integration.png)

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
          <td>推送到集成</td>
      </tr>
      <tr>
          <td>集成</td>
          <td>新的 SigFox 集成</td>
      </tr>
   </tbody>
</table> 

#### 修改根规则链

通过添加以下节点修改了初始根规则链：

###### 节点 С：**规则链**

- 添加 **规则链** 节点，并通过关系类型
 **更新属性** 将其连接到 **消息类型开关** 节点。此节点将传入消息转发到指定的规则链 **到 SigFox 集成**。

- 选择规则链字段：**到 SigFox 集成**。

![image](/images/user-guide/integrations/sigfox/add-rule-chain-node.png)

以下屏幕截图显示了最终的 **根规则链** 应如何显示：

![image](/images/user-guide/integrations/sigfox/sigfox-root-rule-chain.png)

## 结论

现在，当“状态”属性更新时，集成将发送下行消息。

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}