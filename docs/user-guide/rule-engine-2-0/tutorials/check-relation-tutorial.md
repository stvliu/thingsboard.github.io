---
layout: docwithnav
title: 检查实体之间的关系
description: 检查关系

---
本教程的目的是展示如何使用 [**检查关系**](/docs/user-guide/rule-engine-2-0/filter-nodes/#check-relation-filter-node) 节点来检查实体之间的关系。

* TOC
{:toc}

## 使用案例

我们假设以下使用案例：

 - 您有 2 个设备：

   - **烟雾探测器** 带有 **烟雾传感器**，当出现烟雾时，它会将数据发送到 GridLinks。

   - **火灾报警系统** 在出现烟雾时提供火灾警报。

但是，有不同的方法来实现此案例，例如，可以使用 **开关** 节点来实现，该节点将传入消息路由到一个或多个输出链。<br>
有关如何使用 **开关** 节点的更多信息，请查看 [**开关节点文章**](/docs/user-guide/rule-engine-2-0/tutorials/check-relation-tutorial/#see-also) 中的 [**另请参阅**](/docs/user-guide/rule-engine-2-0/tutorials/check-relation-tutorial/#see-also) 部分的链接。

## 前提条件

在开始本教程之前，您需要阅读以下指南：

  * [入门](/docs/getting-started-guides/helloworld/)。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。

## 添加设备并在它们之间创建关系

  在 GridLinks 中添加两个设备实体：

   - 烟雾探测器表示为设备。它的名称是 **烟雾探测器**，类型是 **烟雾传感器**。

   - 火灾报警系统表示为设备。它的名称是 **火灾报警系统**，类型是 **火灾报警设备**。

  创建类型为使用关系：

   - 从烟雾探测器到火灾报警系统；

  以下屏幕截图显示了如何执行此操作：

   ![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/smoke-sensor.png) ![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/fire-alarm-system.png) <br>
   ![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/add-relation.png)

<br>

## 消息流

在本节中，我们将解释本教程中每个节点的用途：

- 节点 A： [**检查关系**](/docs/user-guide/rule-engine-2-0/filter-nodes/#check-relation-filter-node) 节点。
  - 使用关系的类型和方向检查从设备 **火灾报警系统** 到消息发起者 **烟雾探测器** 的关系。
- 节点 B： [**更改发起者**](/docs/user-guide/rule-engine-2-0/transformation-nodes/#change-originator) 节点。
  - 将发起者从设备 **烟雾探测器** 更改为相关设备 **火灾报警系统**，并将提交的消息作为来自设备 **火灾报警系统** 的消息进行处理。
- 节点 C： [**转换脚本**](/docs/user-guide/rule-engine-2-0/transformation-nodes/#script-transformation-node)。
  - 将原始消息转换为 RPC 请求消息。
- 节点 D： [**RPC 调用请求**](/docs/user-guide/rule-engine-2-0/action-nodes/#rpc-call-request-node) 节点。
  - 获取消息有效负载并将其作为对 **火灾报警系统** 的响应发送。
- 节点 E： [**筛选脚本**](/docs/user-guide/rule-engine-2-0/filter-nodes/#script-filter-node) 节点。
  - 检查传入消息的数据是否为 **烟雾**。
- 节点 F： [**清除警报**](/docs/user-guide/rule-engine-2-0/action-nodes/#clear-alarm-node) 节点。
  - 加载具有为消息发起者 **烟雾探测器** 配置的警报类型的最新警报，并在存在警报时清除警报。
- 节点 G： [**创建警报**](/docs/user-guide/rule-engine-2-0/action-nodes/#create-alarm-node) 节点。
  - 尝试加载具有为消息发起者配置的警报类型的最新警报，即 **烟雾探测器**。
- 节点 H： [**规则链**](/docs/user-guide/rule-engine-2-0/flow-nodes/#rule-chain-node) 节点。
  - 将传入消息转发到指定的规则链 **相关火灾报警系统**。

<br>

## 配置规则链

在本教程中，我们修改了我们的 **根规则链**，还创建了规则链 **相关火灾报警系统**

<br>以下屏幕截图显示了上述规则链应如何显示：

  - **相关火灾报警系统：**

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/fire-alarm-chain.png)

 - **根规则链：**

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/chain.png)

<br>

下载 [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/check-relation-tutorial.json) 以获取 **根规则链** 的 json。不要忘记将此规则链标记为 **根**。

<br>

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/root-chain.png)

此外，您需要创建 **相关火灾报警系统** 规则链，或者您可以下载此链的附加 json [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/related_fire_alarm_system.json) 并导入它。
<br>
<br>

以下部分向您展示如何创建它。

#### 创建新规则链（**相关火灾报警系统**）

转到 **规则链** -> **添加新规则链**

配置：

- 名称：**相关火灾报警系统**

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/add-fire-alarm-chain.png)

创建了新的规则链。按 **编辑** 按钮并配置链。

###### 添加所需节点

在此规则链中，您将创建 4 个节点，如下面各节所述：

###### 节点 A：**检查关系**

 - 添加 **检查关系** 节点并将其连接到 **输入** 节点。<br>

    此节点将使用关系的类型和方向检查从设备 **火灾报警系统** 到消息发起者 **烟雾探测器** 的关系。
    如果关系存在，则消息将通过 True 链发送。

 - 使用下表所示的输入数据填写字段：

 <table style="width: 25%">
   <thead>
       <tr>
           <td><b>字段</b></td><td><b>输入数据</b></td>
       </tr>
   </thead>
   <tbody>
       <tr>
           <td>名称</td>
           <td>检查关系</td>
       </tr>
       <tr>
           <td>方向</td>
           <td>到</td>
       </tr>
       <tr>
           <td>类型</td>
           <td>设备</td>
       </tr>
        <tr>
           <td>设备</td>
           <td>火灾报警系统</td>
        </tr>
       <tr>
           <td>关系类型</td>
           <td>使用</td>
       </tr>
    </tbody>
 </table>

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/check-relation.png)

###### 节点 B：**更改发起者**

- 添加 **更改发起者** 节点并将其连接到 **检查关系** 节点，关系类型为 **真**。 <br>
  此节点将发起者从设备 **烟雾探测器** 更改为相关设备 **火灾报警系统**，并将提交的消息作为来自另一个实体（即 **火灾报警系统**）的消息进行处理。

- 使用下表所示的输入数据填写字段：

<table style="width: 25%">
  <thead>
      <tr>
          <td><b>字段</b></td><td><b>输入数据</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>名称</td>
          <td>更改发起者</td>
      </tr>
      <tr>
          <td>发起者来源</td>
          <td>相关</td>
      </tr>
      <tr>
          <td>方向</td>
          <td>从</td>
      </tr>
      <tr>
          <td>最大关系级别</td>
          <td>1</td>
      </tr>
      <tr>
          <td>关系类型</td>
          <td>使用</td>
      </tr>
      <tr>
          <td>实体类型</td>
          <td>设备</td>
      </tr>
   </tbody>
</table>

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/change-originator.png)

###### 节点 C：**脚本转换**
 - 添加 **脚本转换** 节点并将其连接到 **更改发起者** 节点，关系类型为 **成功**。

此节点将原始消息转换为 RPC 请求消息。

- RPC 调用将具有 2 个属性：

    <table style="width: 25%">
      <thead>
          <tr>
              <td><b>属性</b></td><td><b>值</b></td>
          </tr>
      </thead>
      <tbody>
          <tr>
              <td>方法</td>
              <td>ON</td>
          </tr>
          <tr>
              <td>参数</td>
              <td>{}</td>
          </tr>
       </tbody>
    </table>

 - 为了做到这一点，添加以下脚本：

  {% highlight javascript %}
    var newMsg = {};
    if(msg.smoke == 'true'){
        newMsg.method = 'ON';
    }
    newMsg.params={};
    return {msg: newMsg, metadata: metadata, msgType: msgType};{% endhighlight %}


 - 将名称字段输入为 **新 RPC 消息**。

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/transformation-node.png)

###### 节点 D：**RPC 调用请求** 节点
- 添加 **RPC 调用请求** 节点并将其连接到 **脚本转换** 节点，关系类型为 **成功**。 <br>
  此节点获取消息有效负载并将其作为对消息发起者 **火灾报警系统** 的响应发送。
- 将名称字段输入为 **火灾报警系统**。
- 将超时值输入为 60 秒。

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/rpc-call-request.png)

此规则链已准备就绪，我们应该保存它。

#### 修改根规则链

通过添加以下节点修改了初始规则链：

###### 节点 E：**筛选脚本**
- 添加 **筛选脚本** 节点并将其连接到 **保存时序** 节点，关系类型为 **成功**。 <br>
  此节点将使用以下脚本检查传入消息的数据是否为 **烟雾**：

  {% highlight javascript %}return msg.smoke== 'true';{% endhighlight %}

- 将名称字段输入为 **烟雾警报筛选器**。

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/alarm-filter.png)

###### 节点 F：**清除警报**
- 添加 **清除警报** 节点并将其连接到 **筛选脚本** 节点，关系类型为 **假**。 <br>
  此节点加载具有为消息发起者 **烟雾探测器** 配置的警报类型的最新警报，并在存在警报时清除警报。

- 将名称字段输入为 **清除烟雾警报**，将警报类型输入为 **烟雾警报**。

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/clear-alarm.png)

###### 节点 G：**创建警报**
- 添加 **创建警报** 节点并将其连接到 **筛选脚本** 节点，关系类型为 **真**。 <br>
  此节点尝试加载具有为消息发起者配置的警报类型的最新警报，即 **烟雾探测器**。

 - 将名称字段输入为 **创建烟雾警报**，将警报类型输入为 **烟雾警报**。

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/create-alarm.png)

###### 节点 H：**规则链**
- 添加 **规则链** 节点并将其连接到 **筛选脚本** 节点，关系类型为 **真**。 <br>
  此节点将传入消息转发到指定的规则链 **相关火灾报警系统**。

- 将名称字段输入为 **相关火灾报警系统**。

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/add-alarm-chain.png)

以下屏幕截图显示了最终的 **根规则链** 应如何显示：

![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/view-chain.png)

<br>
<br>

## 如何验证规则链和发布遥测

- 使用以下 javascript 代码模拟 **火灾报警系统** 设备。

  - [**FireAlarmEmulator.js**](/docs/user-guide/rule-engine-2-0/tutorials/resources/FireAlarmEmulator.js)。

  - 要运行脚本，您需要执行以下步骤：

  - 复制 **火灾报警系统** 设备访问令牌，然后将它们粘贴到脚本中。 <br>
  您可以从设备页面复制访问令牌。 <br> <br>


- 使用 Rest API，[遥测上传 API](/docs/reference/http-api/#telemetry-upload-api)，从设备 **烟雾探测器** 发布遥测。 <br>

{% highlight bash %}
curl -v -X POST -d '{"smoke":"true"}' http://demo.docs.codingas.com/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"

**您需要将 $ACCESS_TOKEN 替换为实际的设备令牌**
{% endhighlight %}
<br>

  ![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/smoke-telemetry.png)![image](/images/user-guide/rule-engine-2-0/tutorials/check relation/fire-alarm-telemetry.png)

<br>
此外，您还可以：

  - 通过添加警报小部件来配置仪表板以可视化警报。

  - 定义警报处理的其他逻辑，例如发送电子邮件。

请参阅 **另请参阅** 部分下的第三个和第四个链接以了解如何执行此操作。

<br>

## 另请参阅

- [开关节点](/docs/user-guide/rule-engine-2-0/filter-nodes/#switch-node) 指南 - 有关如何在 Thignsboard 中使用开关节点的更多信息。

- [验证传入遥测](/docs/user-guide/rule-engine-2-0/tutorials/validate-incoming-telemetry/#step-1-adding-temperature-validation-node) 教程 - 有关如何使用脚本筛选器节点验证传入遥测的更多信息。

- [创建和清除警报：配置仪表板](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/#configure-device-and-dashboard) 指南 - 了解如何将警报小部件添加到仪表板。

- [发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/) 教程。

- [RPC 功能](/docs/user-guide/rpc/#server-side-rpc-api) 指南 - 有关 RPC 在 Thignsboard 中的工作原理的更多信息，请参阅 RPC 功能指南。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}