---
layout: docwithnav
title: RPC 回复与相关设备的数据
description: RPC 回复与相关设备的数据

---

* TOC
{:toc}


在本教程中，我们将解释如何使用 **RPC 调用回复** 规则节点，以及如何：

- 使用 **规则链** 节点创建和连接不同的规则链
- 使用 **脚本** 节点过滤消息
- 使用 **脚本** 节点转换传入的消息
- 使用 **相关属性** 节点获取相关实体的属性
- 使用 **RPC 调用回复** 节点处理来自设备的 RPC 调用
- 使用 **日志** 节点记录消息


## 简介
我们有 2 个设备 - 控制器和恒温器。我们希望从控制器发起 RPC 调用并请求相关恒温器的当前温度值。
RPC 调用将具有 2 个属性：

- 方法：**getTemperature**
- 参数：**空数组**

## 模型定义
有一个房间安装了 2 个设备：恒温器和控制器。

- 恒温器表示为名称为 **恒温器 A** 和类型为 **恒温器** 的设备。
- 控制器表示为名称为 **控制器 A** 和类型为 **控制器** 的设备。
- 通过关系 **恒温器** 从 **控制器 A** 创建到 **恒温器 A** 的关系。
- 将属性（具有服务器范围）添加到设备 **恒温器 A**。
    - 属性名称：**温度**
    - 属性值：**52**

我们希望从 **控制器 A** 发起 RPC 请求，并询问同一房间（**恒温器 A**）中恒温器的最新温度
<br>
<br>

## 配置规则链

### 创建新的规则链 **相关恒温器温度**

转到 **规则链** -> **添加新的规则链**

配置：

- 名称：**相关恒温器温度**

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/create-chain.png)

创建新的规则链。按 **编辑** 按钮并配置链。

##### 添加 **相关属性** 节点
添加 **相关属性** 节点并将其连接到 **输入** 节点。

此节点将加载相关恒温器的 **温度** 属性，并将其保存在消息元数据中，名称为 **temp**。

配置：

- 名称：**获取相关温度**
- 方向：**从**
- 最大关系级别：**1**
- 关系类型：**恒温器**
- 实体类型：**设备**
- 最新遥测：**false**
- 源属性：**温度**
- 目标属性：**temp**

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/get-related.png)

##### 添加 **转换脚本** 节点
添加 **转换脚本** 节点并将其连接到 **相关属性** 节点。

此节点将原始消息转换为 RPC 回复消息。**RPC 调用回复** 节点将消息有效负载作为对请求的响应发送，因此我们需要在转换节点中构建适当的有效负载。

配置：

- 名称：**构建响应**
- 脚本：{% highlight javascript %} msg = {"temperature" : metadata.temp} return {msg: msg, msgType: msgType}; {% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/transform.png)

##### 添加 **RPC 调用回复** 节点
**RPC 调用回复** 节点从消息元数据中获取 RPC 请求 ID。此 ID 用于标识传入的 RPC 调用。

此节点获取消息有效负载并将其作为对消息发起者的响应发送。

配置：

- 名称：**发送响应**
- 请求 ID：**requestId**

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/reply.png)

<br>
<br>

此规则链已准备就绪，我们应该保存它。以下是 **相关恒温器温度** 规则链的外观：

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/rpc-chain-view.png)


### 连接规则链
现在，我们将把我们的新链与 **根链** 连接起来。我们希望将具有 **方法** 属性等于 **getTemperature** 的传入 RPC 请求路由到我们的新规则链（**相关恒温器温度**）。

让我们返回 **根规则链**，按 **编辑** 按钮并进行必要的更改。

##### 添加 **过滤脚本** 节点
添加 **过滤脚本** 节点并将其连接到具有关系类型 **RPC 请求** 的 **消息类型开关** 节点。

配置：

- 名称：filter getTemperature
- 脚本：{% highlight javascript %} return msg.method === 'getTemperature'; {% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/root-filter.png)

此后，所有具有消息类型 **RPC 请求** 的传入消息都将被路由到此节点。
在此节点内，函数将仅过滤具有 **方法** = **getTemperature** 的允许的 RPC 请求

##### 添加 **规则链** 节点
将具有 **True** 关系类型的 **规则链** 节点添加到前面的 *过滤脚本* 节点（**filter getTemperature**）。

配置：

- 规则链：**相关恒温器温度**

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/connect-Rule-Chain.png)

现在，满足配置的过滤条件的所有消息都将被路由到 **相关恒温器温度** 规则链

##### 记录未知请求
如果未知，我们还希望记录所有其他 RPC 请求。我们需要将具有关系类型 **False** 的 **日志** 节点添加到 **过滤脚本** 节点（**filter getTemperature**）。

具有 **方法** 不等于 **getTemperature** 的所有传入 RPC 请求都将从 **过滤脚本** 传递到 **日志** 节点。

配置：

- 名称：log others
- 脚本：{% highlight javascript %} return 'Unexpected RPC call request message:\n' + JSON.stringify(msg) + '\metadata:\n' + JSON.stringify(metadata); {% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/log-unexpected.png)

<br>
<br>

**根规则链** 中的更改已完成，我们应该保存它。以下是 **根规则链** 的外观：

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/root-chain-view.png)


## 验证配置
配置已完成，我们可以验证规则链按预期工作。

我们将使用 REST RPC API 来模拟 **控制器 A** 设备。

对于发送 HTTP 请求，我们将使用 **curl** 实用程序。


对于触发 RPC 请求，我们需要：

- 获取 **控制器 A** 设备 API 令牌。我们可以从设备页面复制令牌。在本教程中，它是 **IAkHBb9N7kKD9ieLRMFN**，但它是唯一的，您需要复制您的设备令牌。

![image](/images/user-guide/rule-engine-2-0/tutorials/rpc-reply/copy-token.png)

- 向 Thingsboard URL - http://localhost:8080/api/v1/**$ACCESS_TOKEN**/rpc 发出 **POST** 请求，内容类型 = **application/json**，有效负载为 <code>{"method": "getTemperature", "params":{}}</code>

{% highlight bash%}
curl -X POST -d '{"method": "getTemperature", "params":{}}' http://localhost:8080/api/v1/IAkHBb9N7kKD9ieLRMFN/rpc --header "Content-Type:application/json"
{% endhighlight %}

响应：
{% highlight bash %}
{"temperature":"52"}
{% endhighlight %}

这是预期的结果。**控制器 A** 向 Thingsboard 发送 RPC 调用，方法为 **getTemperature**。
消息通过配置的规则链路由，并且相关恒温器的属性被获取并在响应中返回。

如果我们尝试提交具有未知方法的请求，我们将在 Thingsboard 日志文件中看到消息：
{% highlight bash %}
curl -X POST -d '{"method": "UNKNOWN", "params":{}}' http://localhost:8080/api/v1/IAkHBb9N7kKD9ieLRMFN/rpc --header "Content-Type:application/json"
{% endhighlight %}

<code>
[pool-35-thread-3] INFO  o.t.rule.engine.action.TbLogNode - Unexpected RPC call request message:
{"method":"UNKNOWN","params":{}}metadata:
{"deviceType":"Controller","requestId":"0","deviceName":"Controller A"}
</code>

<br>
<br>
有关 RPC 在 Thignsboard 中的工作方式的更多详细信息，请阅读 [RPC 功能](/docs/user-guide/rpc/#server-side-rpc-api) 文章。
<br>
<br>