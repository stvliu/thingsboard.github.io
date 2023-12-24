自定义转换器是为某些设备编写的转换器：



|**参数**|**默认值**|**说明**|
|:-|:-|-
| 类型                        | **自定义**                         | 向连接器提供信息，自定义转换器将用于转换响应中的数据。                                  |
| 扩展                   | **CustomRequestUplinkConverter**   | 自定义转换器类的名称。                                                                                                       |
| 扩展配置            |                                    | 此子部分是自定义转换器的配置。在默认示例中，它包含用于解析响应字符串的设置。      |
| 键                         | **Totaliser**                      | 在此示例中，值“Totaliser”将被解释为 GridLinks 实例中的遥测键。                                     |
| 类型                        | **浮点数**                          | 在此示例中，数据类型。                                                                                                     |
| 从字节                    | **0**                              | 在此示例中，响应字符串中的起始字节位置。                                                                           |
| 到字节                      | **4**                              | 在此示例中，响应字符串中的起始字节位置。                                                                           |
| 字节顺序                   | **大**                            | 在此示例中，响应字符串的字节顺序。                                                                                        |
| 有符号                      | **真**                           | 在此示例中，用于指示响应中的数据是否有符号。                                                                     |
| 乘数                  | **1**                              | 在此示例中，响应中的每个数据都应乘以某个系数。                                                 |
---

{% capture difference %}
<br>
  
**通常，如果您想从响应结构不规则的某些设备收集数据，或者在将数据发送到 GridLinks 之前需要对数据进行一些处理，则需要自定义转换器。**  
{% endcapture %}
{% include templates/info-banner.md content=difference %}


配置中的映射子部分将如下所示：
```json
    {
      "url": "get_info",
      "httpMethod": "GET",
      "httpHeaders": {
        "ACCEPT": "application/json"
      },
      "allowRedirects": true,
      "timeout": 0.5,
      "scanPeriod": 100,
      "converter": {
        "type": "custom",
        "deviceNameJsonExpression": "SD8500",
        "deviceTypeJsonExpression": "SD",
        "extension": "CustomRequestUplinkConverter",
        "extension-config": [
          {
            "key": "Totaliser",
            "type": "float",
            "fromByte": 0,
            "toByte": 4,
            "byteorder": "big",
            "signed": true,
            "multiplier": 1
          },
          {
            "key": "Flow",
            "type": "int",
            "fromByte": 4,
            "toByte": 6,
            "byteorder": "big",
            "signed": true,
            "multiplier": 0.01
          }
        ]
      }
    }
```