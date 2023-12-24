---
layout: docwithnav-gw
title: 物联网网关配置
description: GridLinks 物联网网关的安装结构和配置

---


* TOC
{:toc}


## 目录结构

请参阅以下守护程序安装的默认目录结构。

```text
/etc/thingsboard-gateway/config                   - 配置文件夹。
    tb_gateway.json                               - 网关的主要配置文件。
    logs.json                                     - 日志记录的配置文件。
    modbus.json                                   - Modbus 连接器配置。
    mqtt.json                                     - MQTT 连接器配置。
    ble.json                                      - BLE 连接器配置。
    opcua.json                                    - OPC-UA 连接器配置。
    request.json                                  - 请求连接器配置。
    can.json                                      - CAN 连接器配置。 
    ... 

/var/lib/thingsboard_gateway/extensions           - 自定义连接器/转换器的文件夹。                      
    modbus                                        - Modbus 自定义连接器/转换器的文件夹。
    mqtt                                          - MQTT 自定义连接器/转换器的文件夹。
        __init__.py                               - 默认 Python 包文件，用于正确的导入。
        custom_uplink_mqtt_converter.py           - 自定义 MQTT 转换器示例。
    ...
    opcua                                         - OPC-UA 自定义连接器/转换器的文件夹。
    ble                                           - BLE 自定义连接器/转换器的文件夹。
    request                                       - 请求自定义连接器/转换器的文件夹。
    can                                           - CAN 自定义连接器/转换器的文件夹。

/var/log/gridlinks-gateway                      - 日志文件夹。
    connector.log                                 - 连接器日志。
    service.log                                   - 主网关服务日志。
    storage.log                                   - 存储日志。
    tb_connection.log                             - 连接到 GridLinks 实例的日志。
```
        
## 常规配置文件

用于连接到 GridLinks 平台实例并启用/禁用连接器的主配置文件。

下面提供的示例配置文件设置了与位于 thingsboard.cloud 的 GridLinks 实例的连接，并利用内存文件存储，该存储被设置为最多保存 100,000 条记录。有 4 个不同的连接器处于活动状态。如果您只想使用一个，只需从配置中删除其他连接器即可。

<b>主配置文件示例。点击以显示。</b>

{% capture genConf %}

{
  "thingsboard": {
    "host": "thingsboard.cloud",
    "port": 1883,
    "remoteShell": false,
    "remoteConfiguration": true,
    "statistics": {
      "enable": true,
      "statsSendPeriodInSeconds": 60
    },
    "deviceFiltering": {
      "enable": false,
      "filterFile": "list.json"
    },
    "maxPayloadSizeBytes": 1024,
    "minPackSendDelayMS": 60,
    "minPackSizeToSend": 500,
    "checkConnectorsConfigurationInSeconds": 10,
    "handleDeviceRenaming": true,
    "security": {
      "type": "accessToken",
      "accessToken": "YOUR_ACCESS_TOKEN"
    },
    "qos": 1,
    "checkingDeviceActivity": {
      "checkDeviceInactivity": false,
      "inactivityTimeoutSeconds": 200,
      "inactivityCheckPeriodSeconds": 500
    }
  },
  "storage": {
    "type": "memory",
    "read_records_count": 100,
    "max_records_count": 10000
  },
  "grpc": {
    "enabled": false,
    "serverPort": 9595,
    "keepaliveTimeMs": 10000,
    "keepaliveTimeoutMs": 5000,
    "keepalivePermitWithoutCalls": true,
    "maxPingsWithoutData": 0,
    "minTimeBetweenPingsMs": 10000,
    "minPingIntervalWithoutDataMs": 5000,
    "keepAliveTimeMs": 10000,
    "keepAliveTimeoutMs": 5000
  },
  "connectors": [
    {
      "type": "mqtt",
      "name": "MQTT Broker Connector",
      "configuration": "mqtt.json"
    },
    {
      "type": "modbus",
      "name": "Modbus Connector",
      "configuration": "modbus.json"
    },
    {
      "type": "modbus",
      "name": "Modbus Serial Connector",
      "configuration": "modbus_serial.json"
    },
    {
      "type": "opcua",
      "name": "OPC-UA Connector",
      "configuration": "opcua.json"
    }
  ]
}

{% endcapture %}
{% include code-toggle.liquid code=genConf params="conf|.copy-code.expandable-20" %}

#### 配置文件中的部分

+ **thingsboard** -- 用于连接到 GridLinks 平台的配置。
  - *security* -- 加密和授权类型的配置。
+ **storage** -- 用于本地存储来自设备的传入数据的配置。
+ **connectors** -- 要使用的连接器及其配置的数组。

#### 连接到 GridLinks

| **参数** | **默认值** | **描述** |
| --- | --- | --- |
| ***thingsboard*** | | 连接到服务器的配置。 |
| host | **thingsboard.cloud** | GridLinks 服务器的主机名或 IP 地址。 |
| port | **1883** | GridLinks 服务器上 MQTT 服务的端口。 |
| qos | **1** | QoS 级别 0（最多一次）和 1（至少一次）。 |
| minPackSendDelayMS | **200** | 发送数据包之间的延迟（减小此设置会导致 CPU 使用率增加）。 |
| minPackSizeToSend | **500** | 要发送的数据包的最小大小。 |

###### 小节“statistics”

此小节用于配置收集统计数据并将它们发送到 GridLinks 网关属性。

| **参数** | **默认值** | **描述** |
| :- | :- | :- |
| statistics | | 启用统计数据收集的配置。 |
| ... enable | true | 用于打开/关闭收集统计数据的布尔值。 |
| ... statsSendPeriodInSeconds | 3600 | 整数值用于以规则的时间间隔传输数据。 |
| ... configuration | statistics.json | 用于其他用户统计数据（以秒为单位）的配置文件的名称。 |
| --- | | |

您可以定义其他参数“configuration”，并提供您自己的命令来收集一些其他数据。
此配置文件可能如下例所示：
```json
[
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "ps -A -o cpu,%mem | awk '{cpu += $1}END{print cpu}'"],
    "attributeOnGateway": "CPU"
  },
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "ps -A -o %cpu,%mem | awk '{mem += $2}END{print mem}'"],
    "attributeOnGateway": "Memory"
  },
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "ipconfig getifaddr en0"],
    "attributeOnGateway": "IP address"
  },
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "sw_vers -productName"],
    "attributeOnGateway": "OS"
  },
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "uptime"],
    "attributeOnGateway": "Uptime"
  },
  {
    "timeout": 100,
    "command": ["/bin/sh", "-c", "system_profiler SPUSBDataType"],
    "attributeOnGateway": "USBs"
  }
]
```
此外，您可以在 `/config/statistics/` 文件夹中找到不同操作系统（Linux、macOS、Windows）的示例文件。

###### 小节“deviceFiltering”

此小节是可选的，用于筛选允许向 ThingsBoard 发送数据的设备。

设备筛选功能允许您根据特定条件定义筛选设备的规则。

| **参数** | **默认值** | **描述** |
| :--- | :--- | :--- |
| deviceFiltering | | 用于设备筛选的配置 |
| ... enable | **false** | 用于打开/关闭设备筛选的布尔值 |
| ... filterFile | **list.json** | 配置文件的名称 |
| --- | | |

配置文件可能如下例所示：
```json
{
  "deny": {
    "MQTT Broker Connector": [
      "Temperature Device",
      "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)"
    ],
    "Modbus Connector": [
      "My Modbus Device"
    ]
  },
  "allow": {
    "MQTT Broker Connector": [
      "My Temperature Sensor"
    ]
  }
}
```
上面的配置包含两个主要属性：“deny”和“allow”。每个属性都包含一组连接器类型作为键，以及相应的设备名称数组作为其值。

“deny”属性用于指定应拒绝访问某些连接器名称的设备。列在每个连接器名称下的设备将被阻止访问指定的连接器。

“deny”属性的结构如下：
```json
"deny": {
  "<Connector Name>": [
    "<Device Name 1>",
    "<Device Name 2>",
    ...
  ],
  ...
}
```
示例：
```json
"deny": {
  "MQTT Broker Connector": [
    "Temperature Device",
    "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)"
  ],
  "Modbus Connector": [
    "My Modbus Device"
  ]
}
```

在上面的示例中，定义了以下规则：
* 名为“Temperature Device”的设备和任何具有电子邮件地址格式的设备都被拒绝访问“MQTT Broker Connector”。
* 名为“My Modbus Device”的设备被拒绝访问“Modbus Connector”。

“allow”属性用于指定应明确允许访问某些连接器名称的设备。列在每个连接器名称下的设备将不受限制地访问指定的连接器。

“allow”属性的结构如下：
```json
"allow": {
  "<Connector Name>": [
    "<Device Name 1>",
    "<Device Name 2>",
    ...
  ],
  ...
}
```

示例：
```json
"allow": {
  "MQTT Broker Connector": [
    "My Temperature Sensor"
  ]
}
```

在上面的示例中，定义了以下规则：
* 名为“My Temperature Sensor”的设备被允许访问“MQTT Broker Connector”。

设备筛选功能提供了一种灵活的方式来定义允许或拒绝访问连接器类型的规则，具体取决于设备名称。通过使用“deny”和“allow”属性，您可以轻松控制网关内的设备访问。

###### 小节“checkingDeviceActivity”

此小节是可选的，用于监视每个已连接设备的活动。

如果您定义此部分，网关将每 n 秒检查每个设备的活动，这意味着如果设备在 n 秒内处于非活动状态，它将断开连接。

| **参数** | **默认值** | **描述** |
| :- | :- | :- |
| checkingDeviceActivity | | 用于检查设备活动的配置 |
| ... checkDeviceInactivity | **false** | 用于打开/关闭检查设备活动的布尔值 |
| ... inactivityTimeoutSeconds | **120** | 设备的非活动时间，网关将在其后断开连接 |
| ... inactivityCheckPeriodSeconds | **10** | 设备活动检查的周期性 |
| --- | | |

###### 小节“security”

{% capture securitytogglespec %}
访问令牌<small>基本安全</small>%,%accessToken%,%templates/iot-gateway/security-accesstoken-config.md%br%
用户名和密码<small>基本安全</small>%,%usernamepassword%,%templates/iot-gateway/security-usernamepassword-config.md%br%
TLS + 访问令牌<small>高级安全</small>%,%tlsToken%,%templates/iot-gateway/security-tls-token-config.md%br%
TLS + 私钥<small>高级安全</small>%,%tls%,%templates/iot-gateway/security-tls-config.md{% endcapture %}

安全小节有 3 种变体：

{% include content-toggle.html content-toggle-id="securityConfig" toggle-spec=securitytogglespec %}

###### 小节“provisioning”

{% capture provisioningtogglespec %}
自动<small>服务器生成的访问令牌</small>%,%auto%,%templates/iot-gateway/provisioning-auto-config.md%br%
访问令牌<small>预定义的访问令牌</small>%,%accesstoken%,%templates/iot-gateway/provisioning-access-token-config.md%br%
基本 MQTT<small>基本 MQTT 凭据</small>%,%basicmqtt%,%templates/iot-gateway/provisioning-basic-mqtt-config.md%br%
X.509 证书<small></small>%,%x509%,%templates/iot-gateway/provisioning-x-509-config.md%br%{% endcapture %}

有 4 个选项用于配置配置（您可以在 [官方文档](/docs/user-guide/device-provisioning/) 中阅读有关配置的更多信息）：
{% include content-toggle.html content-toggle-id="provisioningConfig" toggle-spec=provisioningtogglespec %}

#### 存储配置

存储小节中的配置提供了在将传入数据发送到 GridLinks 平台之前将其保存的配置。

此部分有 2 个变体：内存或文件。
1. **内存**存储 - 将接收到的数据保存到 RAM 内存。
2. **文件**存储 - 将接收到的数据保存到硬盘驱动器。
3. **SQLite** 存储 - 将接收到的数据保存到 .db 文件。

{% capture storagetogglespec %}
内存存储<br> <small>(推荐在磁盘空间不足时使用)</small>%,%memory%,%templates/iot-gateway/storage-memory-config.md%br%
文件存储<br> <small>(推荐用于更持久)</small>%,%file%,%templates/iot-gateway/storage-file-config.md%br%
SQLite 存储<br> <small>(推荐用于更高的速度)</small>%,%sqlite%,%templates/iot-gateway/sqlite-storage-config.md{% endcapture %}

{% include content-toggle.html content-toggle-id="storageConfig" toggle-spec=storagetogglespec %}

#### 连接器配置

连接器部分配置用于通过已实现的协议连接到设备。
此部分中每个连接器的配置必须具有如下表所示的参数：

| **参数** | **默认值** | **描述** |
| :- | :- | :- |
| useGRPC | **true** | **可选**参数，用于打开/关闭默认连接器实现的 GRPC 传输 |
| 名称 | **MQTT Broker Connector** | 连接到代理的连接器名称。 |
| 类型 | **mqtt** | 连接器类型，必须像包含配置文件的文件夹的名称。 |
| 配置 | **mqtt.json** | 配置文件在 config 文件夹中的名称。* |
| --- | | |

\* -- 包含此配置文件的文件夹。

配置文件中的部分连接器可能与下面显示的不同，但它们应该具有这样的结构：

```json
...
"connectors": [
  {
    "type": "mqtt",
    "name": "MQTT Broker Connector",
    "configuration": "mqtt.json"
  },
  {
    "type": "modbus",
    "name": "Modbus Connector",
    "configuration": "modbus.json"
  },
  {
    "type": "modbus",
    "name": "Modbus Serial Connector",
    "configuration": "modbus_serial.json"
  },
  {
    "type": "opcua",
    "name": "OPC-UA Connector",
    "configuration": "opcua.json"
  }
]
...
```

**注意：**您可以同时使用多个类似的连接器，但您应该为它们提供不同的名称和配置文件。

如果您需要不同类型的连接器，您可以使用 [自定义指南](/docs/iot-gateway/custom/) 实现它，或发送电子邮件给我们：<info@thingsboard.io>。