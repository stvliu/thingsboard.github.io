自定义转换器是为某些设备编写的转换器：



|**参数**|**默认值**|**说明**|
|:-|:-|-
| type                        | **custom**                      | 向连接器提供信息，自定义转换器将用于转换请求中的数据。                            |
| deviceNameExpression        | **SuperAnonDevice**             | 设备名称。                                                                                                                      |
| deviceTypeExpression        | **default**                     | 设备类型。                                                                                                                      |
| extension                   | **CustomRESTUplinkConverter**   | 自定义转换器类的名称。                                                                                                   |
| extension-config            |                                 | 配置，用于自定义转换器（您可以在此处放置任何内容。它将在初始化时传递给转换器对象）。   |
|   key                       | **Totaliser**                   |                                                                                                                                   |
|   datatype                  | **float**                       |                                                                                                                                   |
|   fromByte                  | **0**                           |                                                                                                                                   |
|   toByte                    | **4**                           |                                                                                                                                   |
|   byteorder                 | **big**                         |                                                                                                                                   |
|   signed                    | **true**                        |                                                                                                                                   |
|   multiplier                | **1**                           |                                                                                                                                   |
---

{% capture difference %}
<br>
  
**通常，如果您想从响应中结构不规则的某些设备收集数据，或者在将数据发送到 ThingsBoard 之前需要对数据进行一些处理，则需要自定义转换器。**  
{% endcapture %}  
{% include templates/info-banner.md content=difference %}  

**注意：您放在“converter”部分中的所有内容都将作为配置传递给自定义转换器。**  

配置中的映射子部分如下所示：  

```json
      "converter": {
        "type": "custom",
        "deviceNameExpression": "SuperAnonDevice",
        "deviceTypeExpression": "default",
        "extension": "CustomRestUplinkConverter",
        "extension-config": [
          {
          "key": "Totaliser",
          "datatype": "float",
          "fromByte": 0,
          "toByte": 4,
          "byteorder": "big",
          "signed": true,
          "multiplier": 1
          }]
      }
```