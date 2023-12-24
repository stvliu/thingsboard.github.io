{% assign gatewayConfiguration = '
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/conn1.png,  
        title: 打开浏览器，使用 URL：https://[IP_DEVICE] 访问 Cell 1024 的管理 Web，然后转到“<b>云</b>”选项卡。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/conn2.png,
        title: 激活云控制并配置所有参数，以便通过 MQTT 将设备连接到特定的 ThingsBoard 平台。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/conn3.png,
        title: 单击“<b>保存配置</b>”按钮。
'
%}  

{% include images-gallery.liquid showListImageTitles="true" imageCollection=gatewayConfiguration %}

| 配置参数 | 说明 |
|-|-|
|**云平台**| 选择 ThingsBoard。 |
|**MQTT 代理 URL**| 要集成的服务器的代理 URL。 |
|**MQTT 代理端口**| 服务器使用的端口号。 |
|**TLS**| 如果服务器使用传输层安全协议，请选择 true。 |
|**连接类型**| 选择“访问令牌”选项。我们将使用之前在 ThingsBoard 中创建的访问令牌。 |
|**访问令牌**| 指示之前在 ThingsBoard 中复制的访问令牌。 |

{% capture provisioningIsComing %}
**注意**

目前，IoT EXXN 网关使用“访问令牌”集成方法。  
EXXN 团队正在研究一种预置集成方法，该方法将无需在设备上复制此访问令牌。  

{% endcapture %}
{% include templates/info-banner.md content=provisioningIsComing %}

要验证设备是否已正确连接到 ThingsBoard，请转到 **设备组** 菜单 -> **所有** 设备，选择您的设备。  
在 **设备详细信息** 中选择 **客户端属性** 选项卡，然后检查是否已将客户端属性传达给设备。  

{% assign checkConnection = '
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-client-attributes-device-1.png,
        title: 如果一切正确，我们将看到客户端属性，如<i>serial_number</i>、<i>last_reboot</i>、<i>device_model</i> 等。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=checkConnection %}

EXXN IoT 网关将使用 MQTT API 连接到 ThingsBoard。  
我们之前已经介绍了如何配置设备以连接到 ThingsBoard。  
现在，我们将展示在 ThingsBoard 中配置设备以监视数据和管理设备的步骤。  

为了配置 EXXN IoT 网关的数据记录器选项，我们应该为具有键“**config**”的设备创建一个新的 JSON“**共享属性**”。  

我们将使用以下 JSON：

```json
{
  "control_config": {
    "debug_level": 10
  },
  "datalogger_config": {
    "csv_path": "/opt/celling/datalogger/data/",
    "redis_list_max_len": 16384,
    "sensor_list": [
      {
        "id": "system_monitor",
        "description": "CPU 使用率（%）、磁盘可用空间（MB）、可用内存（MB）",
        "model": "sys_mon",
        "storage_device": "/dev/mmcblk0p2",
        "measures": [
          "disk_free",
          "mem_available",
          "cpu_usage"
        ],
        "enabled": true,
        "period": 60,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "temp_sc0",
        "description": "小蜂窝 #0 的温度",
        "model": "ds18b20",
        "name": "sc0",
        "address": "28-01212e9c95be",
        "measures": [
          "temperature"
        ],
        "enabled": true,
        "period": 15,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "temp_sc1",
        "description": "小蜂窝 #1 的温度",
        "model": "ds18b20",
        "name": "sc1",
        "address": "28-01212e96afff",
        "measures": [
          "temperature"
        ],
        "enabled": false,
        "period": 15,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "fan_rpm",
        "description": "风扇转速表监视器",
        "model": "tachometer",
        "name": "fan",
        "gpio": 22,
        "sampling_window": 5000,
        "measures": [
          "rpm"
        ],
        "enabled": true,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "temp_hum",
        "description": "温度（摄氏度）、湿度（%）",
        "model": "cwt_th01s",
        "name": "th",
        "config_params": {
          "port": "/dev/ttyS1",
          "baudrate": 9600,
          "read_timeout": 0.5,
          "slave_id": 2
        },
        "measures": [
          "temperature",
          "humidity"
        ],
        "enabled": true,
        "period": 15,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "gpio_monitor",
        "description": "GPIO 配置和监视",
        "model": "gpio_mon",
        "name": "gpio",
        "measures": [
          "state"
        ],
        "mapping": {
          "LOCK": {
            "pin": 1,
            "gpio": 4,
            "direction": "out",
            "boot_value": 0
          },
          "LED": {
            "pin": 3,
            "gpio": 2,
            "direction": "out",
            "boot_value": 0
          },
          "FAN": {
            "pin": 5,
            "gpio": 34,
            "direction": "out",
            "boot_value": 0
          },
          "BUZZER": {
            "pin": 1,
            "gpio": 43,
            "direction": "out",
            "boot_value": 0
          }
        },
        "enabled": true,
        "period": 15,
        "csv": true,
        "mqtt": true
      },
      {
        "id": "energy_meter",
        "description": "电压（V）、电流（A）、有功功率（KWh）、功率因数",
        "model": "ddm18sd",
        "config_params": {
          "port": "/dev/ttyS1",
          "baudrate": 9600,
          "read_timeout": 1,
          "slave_id": 0
        },
        "measures": [
          "voltage",
          "current",
          "active_power",
          "power_factor"
        ],
        "enabled": true,
        "period": 15,
        "csv": true,
        "mqtt": true
      }
    ]
  }
}
```
{: .copy-code}

通过此 JSON 文件正确配置设备的所有信息都可以在 EXXN IoT 网关手册中找到。

{% assign configureTheGateway = "
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-shared-attributes-device-1.png,
        title: 转到设备详细信息中的设备“<b>属性</b>”选项卡。添加一个键为“<b>config</b>”、类型为<b>JSON</b> 的新“<b>共享属性</b>”。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/ennx-config-json.png,
        title: 展开属性的内容以全屏显示，以便轻松编写。将设备配置文件的内容粘贴到属性值中。
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-shared-attributes-device-2.png,
        title: 单击“<b>添加</b>”属性。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=configureTheGateway %}