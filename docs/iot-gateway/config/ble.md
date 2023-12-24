---
layout: docwithnav-gw
title: BLE 连接器配置
description: GridLinks IoT 网关的 BLE 协议支持

---

* TOC
{:toc}

本指南将帮助您熟悉 GridLinks IoT 网关的 BLE 连接器配置。
使用 [常规配置](/docs/iot-gateway/configuration/) 启用此扩展。
我们将在下面描述连接器配置文件。

**BLE 连接器需要一些系统库，要安装它们，请在系统中选择软件包管理器的版本，然后运行命令以安装库：**

{% capture systemtogglespec %}
APT-GET<br>%,%deb%,%templates/iot-gateway/ble-requirements-deb.md%br%
YUM<br>%,%rpm%,%templates/iot-gateway/ble-requirements-rpm.md{% endcapture %}

{% include content-toggle.html content-toggle-id="SystemLibraries" toggle-spec=systemtogglespec %}

<b> BLE 连接器配置文件示例。</b>

{% capture bleConf %}

{
    "name": "BLE 连接器",
    "passiveScanMode": true,
    "showMap": false,
    "scanner": {
        "timeout": 10000,
        "deviceName": "STH11"
    },
    "devices": [
        {
            "name": "温度和湿度传感器",
            "MACAddress": "4C:65:A8:DF:85:C0",
            "pollPeriod": 5000,
            "showMap": false,
            "timeout": 10000,
            "telemetry": [
                {
                    "key": "temperature",
                    "method": "notify",
                    "characteristicUUID": "226CAA55-6476-4566-7562-66734470666D",
                    "valueExpression": "[2]"
                },
                {
                    "key": "humidity",
                    "method": "notify",
                    "characteristicUUID": "226CAA55-6476-4566-7562-66734470666D",
                    "valueExpression": "[:]"
                }
            ],
            "attributes": [
                {
                    "key": "name",
                    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB",
                    "method": "read",
                    "valueExpression": "[0:2]"
                }
            ],
            "attributeUpdates": [
                {
                    "attributeOnThingsBoard": "sharedName",
                    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB"
                }
            ],
            "serverSideRpc": [
                {
                    "methodRPC": "sharedName",
                    "withResponse": true,
                    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB",
                    "methodProcessing": "write"
                }
            ]
        }
    ]
}


{% endcapture %}
{% include code-toggle.liquid code=bleConf params="conf|.copy-code.expandable-20" %}

<br>

为了了解此连接器的工作原理，我们将介绍如何使用网关将设备小米米家温湿度传感器连接到 GridLinks。
我们知道以下设备参数：
设备 **MAC 地址** - 4C:65:A8:DF:85:C0
默认名称特征 ID - 00002A00-0000-1000-8000-00805F9B34FB - 这是一个默认特征 - 我们从 [GATT 特征文档](https://www.bluetooth.com/specifications/gatt/characteristics/) 中获取了它的 ID
温度特征 ID - 00002A00-0000-1000-8000-00805F9B34FB - 这是一个自定义特征 - 我们在扫描设备特征后获得了它。

为此设备创建的默认配置可处理来自它的数据，接收通知并写入一些信息。

在 [主部分](#main-section) 中，我们为连接器编写常规配置，例如连接器名称、扫描模式、扫描仪等。
在 [设备子部分](#device-object-subsection) 中，我们为连接到我们的设备编写常规配置（GridLinks 中的设备名称和设备 MAC 地址等）。
在 [子部分遥测](#subsection-telemetry) 中，我们编写配置以处理来自设备的数据（网关应获取数据的位置、方法和转换器将这些数据解释为 GridLinks 上的遥测和属性）。
在 [子部分属性更新](#subsection-attributes) 中，我们编写配置以在从 ThingsBoard 收到属性更新请求后重命名设备。
如果设备共享属性的名称为“sharedName”，则网关会将此属性中的数据写入具有 ID - 00002A00-0000-1000-8000-00805F9B34FB 的特征。

### 主部分

此部分包含连接器的常规设置。

| **参数** | **默认值** | **描述** |
|:-|:-|:-|
| 名称 | **BLE 连接器** | 用于日志记录和保存到持久设备的连接器名称。 |
| showMap | **false** | 显示所有或特定已找到的 MAC 地址设备。 |
| 扫描仪 | **{"timeout": 1000, "deviceName": "NH11"}** | 用于按名称查找特定设备。这是可选部分，因此可以删除，BLE 连接器将找到所有可用的设备。 |
| passiveScanMode | **true** | 使用被动模式扫描。 |
| 设备 | | 包含感兴趣的设备数组。 |
|---

配置的这一部分将如下所示：

```json
{
    "name": "BLE 连接器",
    "passiveScanMode": true,
    "showMap": false,
    "scanner": {
        "timeout": 10000,
        "deviceName": "NH11"
    },
    "devices": [
        ...
    ]
}
```

我们还来看看发现可用设备的方法。为此，我们将使用两种不同的场景。
1. **第一个场景**

在第一个场景中，我们必须为 BLE 连接器配置以显示所有已找到的设备，因为我们不知道我们设备的 MAC 地址及其名称。
为此，我们必须使用以下配置：
```json
{
    ...
    "showMap": true
    ...
}
```
**网关输出：**

24:71:89:cc:09:05 - NH11

54:bb:12:ff:09:01 - 未知

23:cc:34:23:bb:56 - XYZ123
2. **第二个场景**

在第二个场景中，我们知道蓝牙显示设备名称，只想知道它的 MAC 地址。
为此，我们必须使用以下配置：
```json
{
    ...
    "showMap": true,
    "scanner": {
        "timeout": 10000,
        "deviceName": "NH11"
    }
    ...
}
```
**网关输出：**

24:71:89:cc:09:05 - NH11

#### 设备对象子部分

此子部分包含设备的常规设置以及用于处理数据的子部分。

| **参数** | **默认值** | **描述** |
|:-|:-|:-|
| 名称 | **BLE 连接器** | GridLinks 中的设备名称。 |
| MACAddress | **4C:65:A8:DF:C0** | 感兴趣的设备的 MAC 地址。 |
| deviceType | **BLEDevice** | GridLinks 的设备类型，默认情况下此参数不存在，但您可以添加它。 |
| pollPeriod | **5000** | 设备中读取数据的时间段（以毫秒为单位）。 |
| showMap | **false** | 如果设置为 **true**，将在设备中显示所有 GATT 对象（特征、服务等）。 |
| timeout | **10000** | BLE 连接器尝试连接到设备的时间。 |
| telemetry | | 用于处理设备遥测的数组对象。 |
| attributes | | 用于处理设备属性的数组对象。 |
| attributeUpdates | | 用于处理来自 GridLinks 的 attributeUpdate 请求的数组对象。 |
| serverSideRpc | | 用于处理来自 GridLinks 的 RPC 请求的数组对象。 |
|---

配置的这一部分将如下所示：

```json
{
    "name": "温度和湿度传感器",
    "MACAddress": "4C:65:A8:DF:85:C0",
    "showMap": true,
    "pollPeriod": 5000,
    "timeout": 10000,
    "telemetry": [
        ...
    ],
    "attributes": [
        ...
    ],
    "attributeUpdates": [
        ...
    ],
    "serverSideRpc": [
        ...
    ]
}
```

##### 子部分遥测

此子部分包含将数据解释为遥测的常规设置。

| **参数** | **默认值** | **描述** |
|:-|:-|:-|
| key | **temperature** | GridLinks 中的遥测名称。 |
| method | **notify** | 用于处理特征的方法（可以是 **NOTIFY** 或 **READ**）。 |
| characteristicUUID | **226CAA55-6476-4566-7562-66734470666D** | 设备上的特征 UUID。 |
| valueExpression | **[0:1]** | 将发送到 GridLinks 的数据的最终视图，[0:1] - 将使用 Python 切片规则替换为设备数据 |
|---

配置的这一部分将如下所示：

```json
{
    "key": "temperature",
    "method": "notify",
    "characteristicUUID": "226CAA55-6476-4566-7562-66734470666D",
    "valueExpression": "[0:1]"
},
```

**上表中显示的值可能与您的配置不同。**

例如，来自设备的响应是字节数组，如 b'\x08<\x08\x00'，在这种情况下——**8** 被解释为键的值。

如果您需要将完整响应解释为值，请使用 **"valueExpression": "[:]"**。

您可以在“数据转换示例”部分找到更多数据转换示例。



##### 子部分属性

此子部分包含将数据解释为属性的常规设置。

| **参数** | **默认名称** | **描述** |
|:-|:-|:-|
| key | **name** | GridLinks 中的遥测名称。 |
| method | **read** | 用于处理特征的方法（可以是 **NOTIFY** 或 **READ**）。 |
| characteristicUUID | **00002A00-0000-1000-8000-00805F9B34FB** | 设备上的特征 UUID。 |
| valueExpression | **[0:1] cm** | 将发送到 GridLinks 的数据的最终视图，[0:1] - 将使用 Python 切片规则替换为设备数据 |
|---

配置的这一部分将如下所示：

```json
{
    "key": "name",
    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB",
    "method": "read",
    "valueExpression": "[0:1] cm"
}
```

**上表中显示的值可能与您的配置不同。**

例如，来自设备的响应是字节字符串，如 b'**\x08<\x08\x00**'，在这种情况下——**8 cm** 被解释为键的值。

如果您需要将完整响应解释为值，请使用 **"valueExpression": "[:]"**。

您可以在“数据转换示例”部分找到更多数据转换示例。
<br><br>

{% capture bleGATTinfo %}
来自 <a target="_blank" rel="noopener noreferrer" href="https://www.bluetooth.com/specifications/gatt/services/">GATT 规范</a> 的服务和特征也将解释为设备的属性并自动加载到 GridLinks。
{% endcapture %}
{% include templates/info-banner.md content=bleGATTinfo %}



##### 数据转换示例
让我们回顾更多数据转换示例：

**基本场景：**我们有一个测量温度和湿度的设备。设备具有可读的特征，当我们从它接收数据时，数据结合了温度和湿度。因此，来自设备的数据具有以下视图：**b'\x08<\x08\x00'**，以人类可读格式：**[8, 34]**（第一个数组元素是温度，第二个是湿度）。
1. 我们只想读取温度值

   **"valueExpression": "[0]"**

   数据到 GridLinks：**8**
2. 我们只想读取湿度值

   **"valueExpression": "[1]"**

   数据到 GridLinks：**34**
3. 我们想读取所有值

   "valueExpression": "[:]" 或 "valueExpression": "[0:2]"

   数据到 GridLinks：**834**
4. 我们想读取所有值和单位

   **"valueExpression": "[0]°C [1]%"**

   数据到 GridLinks：**8°C 34%**    

##### 子部分属性更新

此子部分包含用于处理来自 GridLinks 的 attributeUpdate 请求的设置。

| **参数** | **默认名称** | **描述** |
|:-|:-|:-|
| attributeOnThingsBoard | **sharedName** | GridLinks 中共享设备属性的名称。 |
| characteristicUUID | **00002A00-0000-1000-8000-00805F9B34FB** | 将写入属性值的特征的 UUID。 |
|---

配置的这一部分将如下所示：

```json
{
    "attributeOnThingsBoard": "sharedName",
    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB"
}
```

{% capture bleAttrUpdInfo %}
特征应支持 **WRITE** 方法来处理 attributeUpdate 请求。
{% endcapture %}
{% include templates/info-banner.md content=bleAttrUpdInfo %}


##### 子部分服务器端 RPC

此子部分包含用于处理来自 GridLinks 的 RPC 请求的设置。

| **参数** | **默认名称** | **描述** |
|:-|:
| methodRPC | **rpcMethod1** | RPC 方法名称。 |
| withResponse | **true** | 如果为 true，则响应将发送到 GridLinks。 |
| characteristicUUID | **00002A00-0000-1000-8000-00805F9B34FB** | 特征的 UUID。 |
| methodProcessing | **read** | 用于处理特征的方法。（**READ**/**WRITE**/**NOTIFY**) |
|---

配置的这一部分将如下所示：

```json
{
    "methodRPC": "rpcMethod1",
    "withResponse": true,
    "characteristicUUID": "00002A00-0000-1000-8000-00805F9B34FB",
    "methodProcessing": "read"
}
```


## 后续步骤

探索与 ThingsBoard 主要功能相关的指南：

- [连接 BLE 传感器](/docs/iot-gateway/guides/how-to-connect-ble-sensor-using-gateway/) - 如何使用 GridLinks IoT Gateway 连接 BLE 传感器
- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集到的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。