一旦我们拥有访问令牌，我们就可以配置 MI-8。

所有 MI-8 DAQ 都通过 SD 卡根目录中的名为 **config.json** 的文件进行配置。

MI-8 [用户手册](https://fusiondaq.com/wp-content/uploads/2023/01/LTEdaq_OperatingManual-1.pdf) 包含有关更改此文件的详细信息，但对于此示例，我们将重点关注名称和推送字段。

这些是配置文件中存在的字段。

```json
{
   "name":"My MI-8 DAQ",
   "thermo_type":["k","k","k","k","k","k"],
   "num_thermo":3,
   "num_rtd":2,
   "ref_resistance":4000,
   "rtd_type":["pt100","pt100","pt100","pt100"],
   "rtd_connection":[4,4,4,4],
   "dig_in_mode":["pulldown","pulldown","pulldown"],
   "use_aux_header":false,
   "debug_level":255,
   "usb_mass_storage":true,
   "sleep_voltage":9.9,
   "wake_voltage":10.5,
   "display_sleep":10,
   "gnss_period":60,
   "flip_display":false,
   "network": {
      "apn":"hologram",
      "username":"",
      "password":""
   },
   "push": {
      "mode":"post",
      "path":"api/v1/YOUR_ACCESS_TOKEN/telemetry",
      "attributes_path":"api/v1/YOUR_ACCESS_TOKEN/attributes",
      "server": "{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}thingsboard.cloud{% else %}demo.thingsboard.io{% endif %}",
      "port":80,
      "username":"",
      "password":"",
      "use_ssl":false,
      "use_json":true,
      "push_attributes":true,
      "include_name":false,
      "include_imei":false,
      "include_iccid":false,
      "track_min_max":false,
      "use_headers":false
   },
   "trigger":[ {
      "name":"Default",
      "channels":"ambient,tc0,tc1,tc2,rtd0,rtd1,an0,lat,lon,alt,vbat,rssi",
      "log_period":60,
      "push_period":300,
      "start_delay":0,
      "stop_delay":0,
      "condition":"1",
	  "append_log":true
   }]
}
```
{:.copy-code}

连接所需的更改参数：

| 参数 | 默认值 | 说明 |
|-|-|
| 路径 | **api/v1/YOUR_ACCESS_TOKEN/telemetry** | 将 **YOUR_ACCESS_TOKEN** 替换为 GridLinks 上设备的访问令牌。 |
| attributes_path | **api/v1/YOUR_ACCESS_TOKEN/attributes** | 将 **YOUR_ACCESS_TOKEN** 替换为 GridLinks 上设备的访问令牌。 |
| 服务器 | **{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}thingsboard.cloud{% else %}demo.thingsboard.io{% endif %}** | 您的 ThingsBoard 实例地址。 |
| 端口 | **80** | 您的 ThingsBoard 实例 HTTP 端口。您可以将 **port** 设置为 443，并将 **use_ssl** 设置为 true 以使用 SSL 加密 (HTTPS)。支持任一协议，但每次将数据推送到服务器时，HTTPS 会消耗更多蜂窝数据。|

其他配置参数：

- 此文件中的 name 字段是可选的。此名称显示在 MI-8 OLED 屏幕上，并作为设备属性发送到 GridLinks。最佳做法是 config.json 中的名称与 GridLinks 中的设备名称匹配，但这并非必须。name 字段不用于在 MI-8 和 ThingsBoard 之间关联遥测数据。它仅用作用户的辅助工具。
- push 字段描述了与 GridLinks 服务器的连接。在此示例中，我们使用 HTTP POST 请求（“mode”:”post”）。MQTT 也受支持，但 POST 消耗的蜂窝数据更少。HTTP 请求 URL 通过 server、port、use_ssl 和 path/attributes_path 字段构建。
- 将 use_ssl 字段设置为 true，以便在每次开机时发送属性（例如 MI-8 IMEI 号码等不经常更改的内容）。
- 将 use_json 设置为 true。发送到 GridLinks 的所有数据都应采用 JSON 格式。
- 将 use_headers 设置为 false。ThingsBoard 不需要 HTTP 头，但每次推送都需要额外的蜂窝数据。
- 您可以将 include_name、include_imei 和 include_iccid 设置为 false。这些字段会导致 ICCID、IMEI 和 MI-8 名称包含在遥测推送中，这会消耗额外的蜂窝数据。它们不需要包含在这里，因为它们已经通过单独的属性 HTTP 请求在每次 MI-8 电源循环时发送到 GridLinks。

添加或更改配置文件后，执行以下步骤：

- 保存 config.json
- 断开 PC 与 MI-8 USB 端口的连接（如果已连接并启用了大容量存储）
- 循环 MI-8 电源，以便新设置生效。