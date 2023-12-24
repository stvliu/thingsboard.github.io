| **参数** | **默认值** | **说明** |
|:-|:-|-
| deviceName | **Gateway** | 设备名称 |
| deviceType | **default** | 设备类型 |
| type | **serial** | 连接类型可以是 **tcp**、**udp** 或 **serial**。 |
| method | **rtu** | 应用数据单元类型 - **rtu** 或 **ascii** |
| port | **/dev/ttyUSB0** | 用于连接的串口。 |
| baudrate | **19200** | 要用于串行设备的波特率。 |
| byteOrder | **BIG** | 要读取的字节顺序。 |
| unitId | **0** | 设备的单元 ID |
| pollPeriod | **5000** | 检查属性和遥测的毫秒数周期。 |
| sendDataToThingsBoard | **false** | 如果设置为 TRUE，网关会进行自动配置，并且每 <pollPeriod> 毫秒向 ThingsBoard 发送值 |
|---