---
layout: docwithnav
title: 基于来自 2 个设备的遥测的数据函数
description: 基于来自 2 个设备的遥测的数据函数

---

本教程将演示如何根据室内外仓库温度计的读数计算温度差。

* TOC
{:toc}

## 使用案例

假设您有一个仓库，其中有两个温度计：室内和室外。在本教程中，我们将配置 GridLinks 规则引擎以根据温度传感器的最新读数自动计算仓库内外温度的差值。
请注意，这只是一个简单的理论用例，用于演示平台的功能。您可以将本教程用作更复杂场景的基础。

## 模型定义

我们将创建一个名为“仓库 A”且类型为“仓库”的资产。

![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/add-asset.png)

我们将创建两个名称分别为“室内温度计”和“室外温度计”且类型分别为“室内温度计”和“室外温度计”的设备。

![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/add-indoor-thermometer.png)
![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/add-outdoor-thermometer.png)

我们还必须创建资产“仓库 A”和设备“室内温度计”之间的关系。
此关系将在规则链中用于将消息的始发者从温度计更改为仓库本身，还将用于从设备“室内温度计”到设备“室外温度计”的关系以获取“室外温度计”的最新温度。


![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/add-relation-from-asset.png)

<br>

**注意**：请查看以下 [**文档页面**](/docs/user-guide/entities-and-relations/) 以了解如何创建资产和关系。

## 消息流

在本节中，我们将解释本教程中每个节点的用途。将涉及三个规则链：

  - “温度计模拟器” - 可选规则链，用于模拟来自两个温度传感器的的数据；

  - “根规则链” - 实际将遥测数据从设备保存到数据库的规则链，并在将其重定向到“差值温度”链之前按设备类型过滤消息

  - “差值温度” - 实际计算仓库和外部温度计之间差值温度的规则链；


### 温度计模拟器规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/thermostats-emulators-chain.png)

  - **节点 A 和 B**：生成器节点

    - 两个类似的节点，定期生成带有随机温度读数的非常简单的消息。

  - **节点 A：室内温度计模拟器**

             {% highlight javascript %}
             var msg = {
             	temperature: (20 + 5 * Math.random()).toFixed(1)
             };

             return {
             	msg: msg,
             	metadata: {
             		deviceType: "indoor thermometer"
             	},
             	msgType: "POST_TELEMETRY_REQUEST"
             };
             {% endhighlight %}

  - **节点 B：室外温度计模拟器**

             {% highlight javascript %}
             var msg = {
             	temperature: (18 + 5 * Math.random()).toFixed(1)
             };

             return {
             	msg: msg,
             	metadata: {
             		deviceType: "outdoor thermometer"
             	},
             	msgType: "POST_TELEMETRY_REQUEST"
             };
             {% endhighlight %}

  ![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/indoor-thermometer-emulator.png)

  ![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/outdoor-thermometer-emulator.png)

<br>

**注意**：在实际情况下，设备类型默认设置为消息元数据。

  - **节点 C**：规则链节点

    - 将所有消息转发到默认根规则链。

<br>

### 根规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/root-rule-chain.png)

   - **节点 D**：规则链节点

     - 将传入消息转发到指定的规则链“差值温度”。

<br>

### 差值温度规则链

![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/delta-temperature-chain.png)

  - **节点 E**：开关节点。

    - 按从消息元数据获取的 deviceType 路由传入消息。如果传入消息的 deviceType 为“室内温度计”，则通过“室内”关系类型切换到链，如果传入消息的 deviceType 为“室外温度计”，则通过“室外”关系类型切换到链。

        {% highlight javascript %}
        function nextRelation(metadata, msg) {
        	if (metadata.deviceType === 'indoor thermometer') {
        		return ['indoor'];
        	} else if (metadata.deviceType === 'outdoor thermometer')
        		return ['outdoor'];
        }

        return nextRelation(metadata, msg);
        {% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/switch-by-type.png)

  - **节点 F 和 G**：转换脚本节点

    - 两个类似的节点，根据前一个节点的关系类型，将消息有效负载中的键名从“temperature”更改为“indoorTemperature”或“outdoorTemperature”。

    - 创建一个新的出站消息，在其中放入新的遥测数据。<br>

  - **节点 F：更改为室外**

         {% highlight javascript %}
         var newMsg = {};

         newMsg.outdoorTemperature = msg.temperature;

         return {
            msg: newMsg,
           	metadata: metadata,
           	msgType: msgType
         };
         {% endhighlight %}

  - **节点 G：更改为室内**

         {% highlight javascript %}
         var newMsg = {};

         newMsg.indoorTemperature = msg.temperature;

         return {
          	msg: newMsg,
          	metadata: metadata,
          	msgType: msgType
         };
         {% endhighlight %}

 - **节点 H**：更改始发者节点。

    - 将始发者从“室内温度计”更改为相关资产“仓库 A”，提交的消息将作为来自资产的消息进行处理。

![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/to-asset.png)

 - **节点 I**：保存时序节点。

    - 将传入消息有效负载中的时序数据保存到数据库中。

 - **节点 J**：始发者属性节点。

    - 将消息始发者的最新遥测值添加到消息元数据中。

![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/fetch-latest-timeseries.png)

 - **节点 K**：转换脚本节点。

    - 创建一个新的出站消息，在其中放入新的遥测数据“deltaTemperature”，该数据计算为消息元数据遥测值（即“indoorTemperature”和“outdoorTemperature”）差值的绝对值。<br>

        {% highlight javascript %}
        var newMsg = {};

        newMsg.deltaTemperature = parseFloat(Math.abs(metadata.indoorTemperature - metadata.outdoorTemperature).toFixed(2));

        return {
        	msg: newMsg,
        	metadata: metadata,
        	msgType: msgType
        };
        {% endhighlight %}

![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/temperature-delta.png)

 - **节点 L**：保存时序节点。

    - 将传入消息有效负载中的时序数据保存到数据库中。

<br>

## 配置规则链

下载并 [**导入**](/docs/user-guide/ui/rule-chains/#rule-chains-importexport) 附加的模拟器规则链 [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/thermometer_emulators.json) 作为新的“温度计模拟器”规则链，根规则链 [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/root_rule_chain_function_from_two_devices.json) 作为新的“根规则链”和“差值温度” [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/delta_temperature.json)。请注意，某些节点已启用调试。

## 验证流程

下载并 [**导入**](/docs/user-guide/ui/dashboards/#iot-dashboard-importexport) 附加的仪表板 [**文件**](/docs/user-guide/rule-engine-2-0/tutorials/resources/warehouse_dashboard.json) 作为新的“仓库仪表板”。

![image](/images/user-guide/rule-engine-2-0/tutorials/data-function/dashboard.png) 

## 后续步骤

{% assign currentGuide = "DataAnalytics" %}{% include templates/guides-banner.md %}