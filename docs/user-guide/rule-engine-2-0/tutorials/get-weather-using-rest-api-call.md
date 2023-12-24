---
layout: docwithnav
title: 使用 REST API 调用读取天气
description: REST API 天气指南

---



本教程将演示如何使用 REST API 获取天气数据。

* TOC
{:toc}

## 使用案例

假设您需要了解资产位置的当前天气。您可以将天气信息用于某些数据处理逻辑，或者仅用于跟踪历史记录并在仪表板上启用此信息的显示。

在本教程中，我们将配置 ThingsBoard 规则引擎以使用 REST API 自动获取天气信息。
您可以将本教程用作更复杂任务的基础。

## 先决条件

我们假设您已完成以下指南并阅读了以下列出的文章：

  * [入门](/docs/getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)。
  * [外部规则节点](/docs/user-guide/rule-engine-2-0/external-nodes/)。

## 添加资产

在 ThingsBoard 中添加资产实体。其名称为 **Building A**，其类型为 **building**。

![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/rest-api-weather-building.png)

**注意**：如果您拥有专业版，则需要使用客户层级将资产添加到客户，方法如下：

- 转到 **客户层级** -> **全部** -> **（当前租户）** -> **客户组** -> **（您的客户组）**
 -> **（您的客户）** -> **资产组** -> **（您的资产组）** -> **添加资产**

 ![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/add-asset-pe-weather-rest-api.png)

## 在社区版中将资产分配给客户

- 转到 **资产** -> **分配给客户** -> **（您的客户）** -> **分配**

 ![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/assign-asset-weather-rest-api.png)

## 在提供数据的网站上注册

为了获取天气数据，您应该在提供数据的网站上注册。在这种情况下，将使用
 [OpenWeatherMap](https://openweathermap.org/)。

注册后，转到 [此](https://home.openweathermap.org/api_keys) 页面以获取您的 API 密钥。

![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/openweathermap-apikey.png)

## 创建属性

要执行 REST API 调用，我们需要以下 URL 参数：
API 密钥、经度、纬度和测量单位。

我们建议将 API 密钥参数添加到客户服务器端属性，并将其他参数添加到资产服务器端属性。

客户属性应如下所示：

 - 转到 **（分配的客户）** -> **属性** -> **添加**

 ![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/add-attribute-customer.png)

添加属性如下：

 <table style="width: 50%">
   <thead>
       <tr>
           <td><b>字段</b></td><td><b>数据类型</b></td><td><b>输入数据</b></td>
       </tr>
   </thead>
   <tbody>
       <tr>
           <td>APPID</td>
           <td>字符串</td>
           <td>（您从 OpenWeatherMap 获得的 API 密钥）</td>
       </tr>
    </tbody>
 </table>

资产属性应如下所示：

- 转到 **Building A** -> **属性** -> **添加**

![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/add-new-attribute.png)

- 使用下表中所示的输入数据填写属性：

<table style="width: 50%">
  <thead>
      <tr>
          <td><b>字段</b></td><td><b>数据类型</b></td><td><b>输入数据</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>latitude</td>
          <td>双精度</td>
          <td>资产的纬度</td>
      </tr>
      <tr>
          <td>longitude</td>
          <td>双精度</td>
          <td>资产的经度</td>
      </tr>
      <tr>
          <td>units</td>
          <td>字符串</td>
          <td>“metric”表示米/秒风速和摄氏温度，“imperial”表示英里/小时风速和华氏温度，空表示米/秒风速和开尔文温度</td>
      </tr>
   </tbody>
</table>


在此示例中，将使用纽约市的坐标和公制单位。

## 消息流

在本节中，我们将解释本教程中每个节点的用途。将涉及一个规则链：

  - **外部温度/湿度** - 规则链每 15 秒向 OpenWeatherMap 发送 API 调用，并将有关湿度和温度的数据发送到所选资产。

以下屏幕截图显示了上述规则链应如何显示：

![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/weather-rule-chain-customer.png)

下载并[**导入**](/docs/user-guide/ui/rule-chains/#rule-import) 附加的
json [**文件**](/docs/user-guide/resources/outside-temperature-humidity-customer.json) 作为本教程的规则链。请注意，您需要将您在开始时创建的资产设置为最左端生成器节点中的发起者。

以下部分向您展示如何从头开始创建此规则链。

#### 创建新的规则链（**外部温度/湿度**）

转到 **规则链** -> **添加新的规则链**

配置：

- 名称：**外部温度/湿度**

![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/add-weather-rest-api-chain.png)

创建新的规则链。按 **编辑** 按钮并配置链。

###### 添加所需节点

在此规则链中，您将创建 5 个节点，如下节所述：

###### 节点 A：**生成器节点**
   - 添加 **生成器** 节点。此规则节点生成空消息以触发 REST API 调用。
   - 如下方式填写其字段：
   <table style="width: 50%">
     <thead>
         <tr>
             <td><b>字段</b></td><td><b>值</b></td>
         </tr>
     </thead>
     <tbody>
         <tr>
             <td>名称</td>
             <td>生成请求</td>
         </tr>
         <tr>
             <td>消息计数</td>
             <td>0</td>
         </tr>
         <tr>
             <td>周期（秒）</td>
             <td>15</td>
         </tr>
         <tr>
             <td>发起者类型</td>
             <td>资产</td>
         </tr>
         <tr>
             <td>资产</td>
             <td>Building A</td>
         </tr>
         <tr>
             <td>生成函数</td>
             <td>return { msg: {}, metadata: {}, msgType: "POST_TELEMETRY_REQUEST" };</td>
         </tr>
      </tbody>
   </table>

   ![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/weather-rule-chain-node-A.png)

###### 节点 B：**客户属性扩充节点**

   - 添加 **客户属性节点** 并将其连接到 **生成器节点**，关系类型为 **成功**。
   此节点将客户属性 APPID 放入消息的元数据中。
   - 如下方式填写其字段：
   <table style="width: 50%">
            <thead>
                <tr>
                    <td><b>字段</b></td><td><b>值</b></td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>名称</td>
                    <td>获取客户 API 密钥</td>
                </tr>
                <tr>
                    <td>最新遥测</td>
                    <td>否</td>
                </tr>
                <tr>
                    <td>源属性</td>
                    <td>APPID</td>
                </tr>
                <tr>
                    <td>目标属性</td>
                    <td>APPID</td>
                </tr>
             </tbody>
   </table>
   ![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/weather-rule-chain-node-B.png)

###### 节点 C：**发起者属性扩充节点**
   - 添加 **发起者属性扩充节点** 并将其连接到 **客户属性节点** 节点，关系类型为 **成功**。此节点将从 **生成器** 节点中设置的发起者的服务器属性纬度、经度和单位提取到元数据中
   - 如下方式填写其字段：
       <table style="width: 50%">
         <thead>
             <tr>
                 <td><b>字段</b></td><td><b>值</b></td>
             </tr>
         </thead>
         <tbody>
             <tr>
                 <td>名称</td>
                 <td>纬度/经度</td>
             </tr>
             <tr>
                 <td>服务器属性</td>
                 <td>latitude, longitude, units</td>
             </tr>
          </tbody>
       </table>
   ![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/weather-rule-chain-node-C.png)

###### 节点 D：**外部 REST API 调用节点**
   - 添加 **外部 REST API 调用节点** 并将其连接到 **发起者属性扩充节点**，关系类型为 **成功**。此节点将对 OpenWeatherMap 执行 REST API 调用。
   - 如下方式填写其字段：
      <table style="width: 50%">
             <thead>
                <tr>
                    <td><b>字段</b></td><td><b>值</b></td>
                </tr>
             </thead>
             <tbody>
                <tr>
                    <td>名称</td>
                    <td>获取天气数据</td>
                </tr>
                <tr>
                    <td>端点 URL 模式</td>
                    <td>http://api.openweathermap.org/data/2.5/weather?lat=${ss_latitude}&lon=${ss_longitude}&units=${ss_units}&APPID=${APPID}</td>
                </tr>
                <tr>
                    <td>请求方法</td>
                    <td>GET</td>
                </tr>
                <tr>
                    <td>使用简单的客户端 HTTP 工厂</td>
                    <td>否</td>
                </tr>
             </tbody>
      </table>
   - ss_latitude、ss_longitude、ss_units、ss_APPID 是从元数据中提取的服务器属性，这些属性由 **发起者属性扩充节点** 放置在那里

   ![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/weather-rule-chain-node-D.png)

###### 节点 E：**脚本转换节点**
   - 添加 **脚本转换节点** 并将其连接到 **外部 REST API 调用节点**，关系类型为 **成功**。此节点将外部温度、最高温度、最低温度和湿度放入消息中。
   - 如下方式填写转换函数：


```js
    var newMsg = {
        "outsideTemp": msg.main.temp,
        "outsideMaxTemp": msg.main.temp_max,
        "outsideMinTemp": msg.main.temp_min,
        "outsideHumidity": msg.main.humidity,
    };

    return {msg: newMsg, metadata: metadata, msgType: msgType};
```
   ![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/weather-rule-chain-node-E.png)

###### 节点 F：**保存时序节点**

   - 添加 **脚本转换节点** 并将其连接到 **外部 REST API 调用节点**，关系类型为 **成功**。此节点将消息放入遥测中。

   ![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/weather-rule-chain-node-F.png)
 


## 设置仪表板

下载并[**导入**](/docs/user-guide/ui/dashboards/#dashboard-import) 附加的
json [**文件**](/docs/user-guide/resources/weather_dashboard.json) 作为本教程的仪表板。

仪表板应如下所示：
![image](/images/user-guide/rule-engine-2-0/tutorials/rest-api-weather/weather-dashboard.png)


## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/guides-banner.md %}