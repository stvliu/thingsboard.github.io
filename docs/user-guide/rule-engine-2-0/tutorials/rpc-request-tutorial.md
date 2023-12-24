---
layout: docwithnav
title: 向相关设备发送 RPC 请求
description: 向设备发送 RPC 请求

---

ThingsBoard 允许您从服务器端应用程序向设备发送远程过程调用 [**RPC**](/docs/user-guide/rpc/#server-side-rpc-api)，反之亦然。 <br>
本教程将向您展示如何使用规则引擎向相关设备发送远程请求调用。

* TOC
{:toc}

## 使用案例
让我们假设以下用例：

  - 您有以下设备连接到 ThingsBoard：
	- 风向传感器。
	- 旋转系统。
  - 此外，您还有一个资产：
	- 风力涡轮机。
 - 您想向旋转系统发起 RPC 请求，并根据风向改变风力涡轮机的方向。
 - RPC 调用将具有两个属性：
	- 方法：**spinLeft** 或 **spinRight**。
	- 参数：**value**。

<table  style="width: 60%">
   <thead>
     <tr>
	 <td><strong><em>注意：</em></strong></td>
     </tr>
   </thead>
   <tbody>
     <tr>
	<td>
	<p>将旋转系统向左或向右转动取决于哪种方式更好、更快，以便风向和风力涡轮机之间的角度不超过 5 度。</p>
	</td>
     </tr>
   </tbody>
</table>

## 先决条件

我们假设您已完成以下指南并阅读了下面列出的文章：

 * [入门](/docs/getting-started-guides/helloworld/) 指南。
 * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。

## 模型定义
风力涡轮机安装了两个设备：风向传感器和旋转系统。

- 风力涡轮机表示为资产。它的名称是 **风力涡轮机**，类型是 **风力涡轮机**。
- 风向传感器表示为设备。它的名称是 **风向传感器**，类型是 **方向传感器**。
- 旋转系统表示为设备。它的名称是 **旋转系统**，类型是 **旋转系统**。
- 创建类型为 **包含** 的关系：
	- 从 **风力涡轮机** 到 **风向传感器**，以及
	- 从 **风力涡轮机** 到 **旋转系统**。
- 创建类型为 **使用** 的关系：
	- 从 **旋转系统** 到 **风向传感器**。


## 消息流
在本节中，我们将解释本教程中每个节点的用途：

- 节点 A：[**消息类型开关**](/docs/user-guide/rule-engine-2-0/filter-nodes/#message-type-switch-node) 节点。
  - 根据消息类型路由传入的消息。
- 节点 B：[**保存时序**](/docs/user-guide/rule-engine-2-0/action-nodes/#save-timeseries-node) 节点。
  - 将 **风向传感器** 和 **旋转系统** 的消息遥测存储到数据库中。
- 节点 C：[**相关属性**](/docs/user-guide/rule-engine-2-0/enrichment-nodes/#related-attributes)。
  - 加载相关 **风向传感器** 的源遥测 **windDirection**，并将其以名称 **windDirection** 保存到消息元数据中。
- 节点 D：[**更改发起者**](/docs/user-guide/rule-engine-2-0/transformation-nodes/#change-originator) 节点。
  - 将发起者从设备 **风向传感器** 和 **旋转系统** 更改为相关资产 **风力涡轮机**，并将提交的消息作为来自资产的消息进行处理。
- 节点 E：[**保存时序**](/docs/user-guide/rule-engine-2-0/action-nodes/#save-timeseries-node) 节点。
  - 将资产 **风力涡轮机** 的消息遥测存储到数据库中。
- 节点 F：[**转换脚本**](/docs/user-guide/rule-engine-2-0/transformation-nodes/#script-transformation-node)。
  - 将原始消息转换为 RPC 请求消息。
- 节点 G：[**筛选脚本**](/docs/user-guide/rule-engine-2-0/filter-nodes/#script-filter-node) 节点。
  - 检查传入消息的 msgType 是否为 **RPC 消息**。
- 节点 H：[**RPC 调用请求**](/docs/user-guide/rule-engine-2-0/action-nodes/#rpc-call-request-node) 节点。
  - 获取消息有效负载并将其作为对 **旋转系统** 的响应发送。

<br>
<br>

## 配置规则链

以下屏幕截图显示了 **RPC 调用请求教程** 规则链应如何显示：

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/chain.png)

- 下载上面指示的规则链的附加 json [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/tutorial_of_rpc_call_request.json) 并导入它。
- 不要忘记将新的规则链标记为“根”。

此外，您可以从头开始创建新的规则链。以下部分将向您展示如何创建它。


#### 创建新的规则链（**RPC 调用请求教程**）

- 转到 **规则链** -> **添加新规则链**
- 将名称字段输入为 **RPC 调用请求教程**，然后单击 **添加** 按钮。

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/create-chain.png) ![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/root-chain.png)

- 现在创建了新的规则链。不要忘记将其标记为“根”。

##### 添加所需节点

在本教程中，您将创建 8 个节点，如下面的部分中所述：

###### 节点 A：**消息类型开关**
- 添加 **消息类型开关** 节点并将其连接到 **输入** 节点。 <br>
  此节点将根据消息类型（即 **POST_TELEMETRY_REQUEST**）路由传入的消息。

- 将名称字段输入为 **消息类型开关**。


![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/message-type-switch.png)

###### 节点 B：**保存时序**
- 添加 **保存时序** 节点并将其连接到 **消息类型开关** 节点，关系类型为 **发布遥测**。 <br>
  此节点将时序数据从传入消息有效负载存储到数据库，并将它们与由消息发起者（即 **风向传感器** 和 **旋转系统**）识别的设备相关联。

- 将名称字段输入为 **保存时序**。


![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/save-ts.png)

###### 节点 C：**相关属性**
- 添加 **相关属性** 节点并将其连接到 **保存时序** 节点，关系类型为 **成功**。 <br>
  此节点将从相关 **风向传感器** 加载源遥测 **windDirection** 到 **旋转系统**，并将其以名称 **windDirection** 保存到消息元数据中。
- 使用以下表中所示的输入数据填写字段：

<table style="width: 25%">
  <thead>
      <tr>
          <td><b>字段</b></td><td><b>输入数据</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>名称</td>
          <td>获取风传感器遥测</td>
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
      <tr>
          <td>最新遥测</td>
          <td>真</td>
      </tr>
      <tr>
          <td>源遥测</td>
          <td>windDirection</td>
      </tr>
      <tr>
          <td>目标遥测</td>
          <td>windDirection</td>
      </tr>
   </tbody>
</table>



![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/get-related.png)

###### 节点 D：**更改发起者**
- 添加 **更改发起者** 节点并将其连接到 **保存时序** 节点，关系类型为 **成功**。 <br>
  此节点将发起者从设备 **风向传感器** 和 **旋转系统** 更改为相关资产 **风力涡轮机**，后者与它们中的每一个都有类型为 **包含** 的关系。
  <br>因此，提交的消息将作为来自此实体的消息进行处理
- 使用以下表中所示的输入数据填写字段：

<table style="width: 25%">
  <thead>
      <tr>
          <td><b>字段</b></td><td><b>输入数据</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>名称</td>
          <td>创建新遥测</td>
      </tr>
      <tr>
          <td>发起者来源</td>
          <td>相关</td>
      </tr>
      <tr>
          <td>方向</td>
          <td>到</td>
      </tr>
      <tr>
          <td>最大关系级别</td>
          <td>1</td>
      </tr>
      <tr>
          <td>关系类型</td>
          <td>包含</td>
      </tr>
      <tr>
          <td>实体类型</td>
          <td>资产</td>
      </tr>
   </tbody>
</table>

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/change-originator.png)

###### 节点 E：**保存时序**
- 添加 **保存时序** 节点并将其连接到 **更改发起者** 节点，关系类型为 **成功**。 <br>
  此节点将来自消息发起者（即消息发起者为资产 **风力涡轮机**）的传入消息有效负载中的时序数据存储到数据库中。
- 将名称字段输入为 **保存时序**。


![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/save-ts.png)

###### 节点 F：**转换脚本**
- 添加 **转换脚本** 节点并将其连接到 **相关属性** 节点，关系类型为 **成功**。 <br>
此节点将原始消息转换为 RPC 请求消息。
- RPC 调用将具有 2 个属性：
	- 方法：**spinLeft** 或 **spinRight**。
	- 参数：**值**。


![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/rpc-message.png)

- 将名称字段输入为 **新 RPC 消息**。
- 添加以下脚本： {% highlight javascript %}
 var newMsg = {};
 var value = Math.abs(msg.turbineDirection - metadata.windDirection);
 if ((value < 180 && msg.turbineDirection < metadata.windDirection)||
     (value > 180 && msg.turbineDirection > metadata.windDirection)) {
     newMsg.method = 'spinLeft';
 }
 if ((value <= 180 && msg.turbineDirection > metadata.windDirection)||
     (value >= 180 && msg.turbineDirection < metadata.windDirection)) {
     newMsg.method = 'spinRight';
 }
 if(newMsg.method == 'spinLeft' || 'spinRight'){
     msgType = 'RPC message';
 }
 newMsg.params = Math.round(value * 100) / 100;
 return {msg: newMsg, metadata: metadata, msgType: msgType}; {% endhighlight %}


###### 节点 G：**筛选脚本**

- 添加 **筛选脚本** 节点并将其连接到 **转换脚本** 节点，关系类型为 **成功**。 <br>
  此节点将检查传入消息的 msgType 是否为 **RPC 消息**。

- 将名称字段输入为 **检查 RPC 消息**。
- 添加以下脚本： {% highlight javascript %}: return msgType == 'RPC message'; {% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/check-validity.png)


###### 节点 H：**RPC 调用请求**
- 添加 **RPC 调用请求** 节点并将其连接到 **筛选脚本** 节点，关系类型为 **真**。 <br>
  此节点获取消息有效负载并将其作为对消息发起者的响应发送。
- 将名称字段输入为 **旋转系统**。
- 将超时值输入为 60 秒。

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/request.png)

<br>

此规则链现在已准备就绪，您需要保存它。

<br>
<br>

## 如何验证规则链

- 使用以下 javascript 代码模拟 **风向传感器** 设备。
    - [**WindDirectionEmulator.js**](/docs/user-guide/rule-engine-2-0/tutorials/resources/WindDirectionEmulator.js).
- 此外，使用以下 javascript 代码模拟 **旋转系统** 设备。 <br>
  此代码包含一个方法，用于根据传入的 RPC 消息模拟改变涡轮方向。
    - [**RotatingSystemEmulator.js**](/docs/user-guide/rule-engine-2-0/tutorials/resources/RotatingSystemEmulator.js).


要运行脚本，您需要执行以下步骤：

- 复制 **风向传感器** 设备访问令牌和 **旋转系统** 设备访问令牌，然后将它们粘贴到脚本中。 <br>
  您可以从设备页面复制访问令牌。 <br> <br>
  在本教程中，
    - **风向传感器** 设备访问令牌为 **Z61K03FAGSziW9b0nKsm**
    - **旋转系统** 设备访问令牌为 **jSuvzrURCbw7q4LGtygc**

  但是，这些访问令牌是唯一的，您需要复制您设备的访问令牌。

 ![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/wind-token.png) ![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/rs-token.png)

- 打开终端并转到包含这些模拟器脚本的文件夹，然后运行以下命令：
    - node WindDirectionEmulator.js
    - node RotatingSystemEmulator.js


<br>
<br>

## 配置仪表板
以下屏幕截图显示了 **风力涡轮机仪表板** 的样子：

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/dashboard.png)

下载上面指示的仪表板的附加 json [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/wind_turbine_dashboard.json) 并导入它。

- 转到 **仪表板** -> **添加新仪表板** -> **导入仪表板** 并删除下载的 json 文件。

下一步是配置导入的仪表板使用的别名。

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-request/aliases.png)

单击 **编辑别名** 按钮并输入以下表中所示的输入数据：

<table style="width: 30%">
  <thead>
      <tr>
       <td>别名 </td>
       <td>字段</td>
       <td>输入数据 </td>
      </tr>
  </thead>
  <tbody>
      <tr>
           <td rowspan="3" >风力涡轮机
           </td>
           <td>过滤器类型
           </td>
           <td>单个实体
           </td>
      </tr>
      <tr>
           <td>类型
           </td>
           <td>资产
           </td>
      </tr>
      <tr>
           <td>资产
           </td>
           <td>风力涡轮机
           </td>
      </tr>
      <tr>
           <td rowspan="3" >风向传感器
           </td>
           <td>过滤器类型
           </td>
           <td>单个实体
           </td>
      </tr>
      <tr>
           <td>类型
           </td>
           <td>设备
           </td>
      </tr>
      <tr>
           <td>设备
           </td>
           <td>风向传感器
           </td>
          </tr>
      <tr>
           <td rowspan="3" >旋转系统
           </td>
           <td>过滤器类型
           </td>
           <td>单个实体
           </td>
      </tr>
      <tr>
           <td>类型
           </td>
           <td>设备
           </td>
      </tr>
      <tr>
           <td>设备
           </td>
           <td>旋转系统
           </td>
      </tr>
  </tbody>
</table>


仪表板的配置现在已完成，您可以验证它按预期工作。

此外，您还可以看到：

  - 如何使用 **RPC 调用回复** 规则节点

请参阅 **另请参阅** 部分下的第二个链接，了解如何执行此操作。

<br>
<br>

## 另请参阅

 - 有关 RPC 在 Thignsboard 中的工作方式的更多详细信息，请参阅 [RPC 功能](/docs/user-guide/rpc/#server-side-rpc-api) 指南。

 - [使用相关设备的数据进行 RPC 回复](/docs/user-guide/rule-engine-2-0/tutorials/rpc-reply-tutorial/) 指南。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}