* TOC
{:toc}

## 简介
本教程将演示如何使用 Decode DL28 通信处理器将来自区域供热分站 (DHS) 设施的各种信号设置并集成到 GridLinks IoT 平台中。来自数字和模拟 I/O、Modbus RTU 设备和 M-Bus 热量计的信号组合在一个 GridLinks 仪表板中。由于简单起见，只连接了少数信号和设备，但在实际安装中，最多可以使用数百个设备和数千个信号。



![image](/images/user-guide/integrations/decode/Picture0.png)



## 系统图
系统图显示了 DHS 中的一些典型自动化和计量元件：连接到 RS485 通信线路的分站控制器或泵控制器、M-Bus 线路上的热量计以及一些 I/O 扩展，例如用于控制阀门和监控液位开关。



![image](/images/user-guide/integrations/decode/Picture1.png)



Decode [DL28](https://decode.rs/product/dl28/) 设备充当通信和信号集中器，并在安装在 DHS 中的所有控制、监控和测量设备与互联网上的 GridLinks 服务器之间提供桥接功能。此示例中使用了三个信号：两个继电器输出和一个来自热量计的温度。

## 先决条件
- ThingsBoard 上的演示帐户
- 带有以太网连接和网络浏览器的计算机
- Decode DL28 通信控制器
- Decode EXIO I/O 扩展设备
- 至少有一个继电器输出的 Modbus RTU 从站
- 带有 M-Bus 的热量计
- 连接到互联网

## GridLinks 的设置
### 步骤 1. 登录
转到 GridLinks 演示网页 https://demo.thingsboard.io 并使用创建帐户时获得的凭据登录。
### 步骤 2. 添加 DL28 设备
成功登录后，单击左侧菜单中的“设备”条目，然后单击“+”图标。选择“添加新设备”选项，输入“名称”、“设备类型”和“标签”字段，然后单击“添加”按钮。



![image](/images/user-guide/integrations/decode/Picture2.png)



DL28 设备显示在“设备”窗口中。单击 DL28 以打开“设备详细信息”窗口。



![image](/images/user-guide/integrations/decode/Picture3.png)



稍后在 DL28 MQTT 设置菜单中使用的客户端 ID 和访问令牌可以使用“复制设备 ID”和“复制访问令牌”按钮进行复制。

### 步骤 3. 添加仪表板
单击左侧菜单中的“仪表板”条目，然后单击“+”图标。选择“创建新仪表板”选项，输入“名称”和“说明”字段，然后单击“添加”按钮。



![image](/images/user-guide/integrations/decode/Picture4.png)



DL28 仪表板显示在“仪表板”窗口中。

### 步骤 4. 添加小部件
单击 DL28，然后单击“打开仪表板”按钮以打开仪表板。单击铅笔图标以进入“编辑”模式，然后单击“添加新小部件”。从下拉列表中选择“控制小部件”，然后选择“开关控制”。开关控制小部件将用于控制 EXIO 和 Modbus RTU 设备上的继电器。



![image](/images/user-guide/integrations/decode/Picture5.png)



在“添加小部件”窗口中，单击“实体别名”字段并按 ENTER。在“实体别名”列表中添加 DL28 设备。仅对所有小部件执行此操作一次。



![image](/images/user-guide/integrations/decode/Picture6.png)



单击“高级”选项卡并输入以下参数。



![image](/images/user-guide/integrations/decode/Picture7.png)



在“转换值函数”中，输入以下代码以更改开关状态。数据发布到主题 **v1/devices/me/request+**。

```bash
if(value) return { "exio_relay_1": 1 };
else return { "exio_relay_1": 0 };
```



![image](/images/user-guide/integrations/decode/Picture8.png)



单击“添加”按钮将小部件添加到仪表板。使用类似的过程，添加另一个开关小部件，其开关标题为 **GT900 RL1**、属性/时序值键为 **gt900_relay_1**，在“转换值函数”中，开关处于打开状态时为 **{ "gt900_relay_1": 1 }**，开关处于关闭状态时为 **{ "gt900_relay_1": 0 }:**。

使用类似的过程，添加两个 LED 指示器小部件以显示继电器状态，使用 LED 标题 **EXIO LED RL1** 和 **GT900 LED RL1**，以及属性/时序值键 **exio_relay_1** 和 **gt900_relay_1**。



![image](/images/user-guide/integrations/decode/Picture9.png)



使用类似的过程，添加数字仪表小部件以显示来自 M-Bus 热量计的回水温度，添加新的数据源。在“实体时序/属性”字段中输入 **cal_return_temp**，然后单击时序的符号。单击“添加”按钮将仪表添加到仪表板。



![image](/images/user-guide/integrations/decode/Picture10.png)



单击“应用更改”图标以保存更改并退出编辑模式。

## DL28 设备的设置
### 步骤 1. 连接
将计算机和 DL28 设备连接到具有互联网连接的同一计算机网络。网络地址必须相同。使用框图将 EXIO I/O 扩展设备连接到 I2C 端口，将 Modbus RTU 从站连接到 RS485 端口 S6，将热量计连接到 DL28 的 M-Bus 主端口 S4。按照用户手册中的安全程序连接电源，并为所有连接的设备供电。
### 步骤 2 . 登录
在网络浏览器地址栏中输入 DL28 设备的 IP 地址，然后按 ENTER。在弹出窗口中输入用户名和密码。默认 IP 地址、用户名和密码分别为：**192.168.0.67**、**admin**、**admin**。成功登录后，将加载 DL28 网页。如果当前时间无效，请更新设备上的当前时间。如有必要，请在 LAN 设置中更改默认网关地址。
### 步骤 3. 设置 EXIO
在 EXIO 设备菜单中，单击“重新扫描”按钮。检测到 EXIO 设备并将其放在设备列表中。在此示例中，使用 EXIO 类型 3（7xAI、2xDO、2xAO）。单击“保存”按钮。
### 步骤 4. 设置 Modbus RTU
在 Modbus 设置菜单中，选中“Modbus 主”选项，并为轮询间隔和响应超时选择值，例如分别为 5 分钟和 10 秒。单击“保存”按钮。
在 Modbus 轮询列表菜单中添加两个参数。对于继电器开/关控制，使用 ForceSingleCoil，对于继电器状态的读数，使用 ReadCoilStatus。自动分配的寄存器地址为 52000 和 52001。



![image](/images/user-guide/integrations/decode/Picture11.png)



### 步骤 5. 设置 M-Bus
在 Modbus 设置菜单中，选择 M-Bus 主模式、扫描地址范围和轮询间隔。在此示例中，地址范围为 1 到 3，轮询间隔为 3 分钟。单击“保存”按钮。
在 Modbus 从站列表菜单中，单击“重新扫描”按钮以开始检测连接的 M-Bus 设备。将设备添加到列表后，单击“保存”按钮以保存它，然后单击“重新加载”按钮以加载新设备数据。
选择显示/隐藏选项以显示详细的设备数据。来自 M-Bus 的数据值使用 4 字节浮点格式存储在 Modbus 映射中。查找感兴趣的数据字段。在此示例中，选择回水温度，存储在偏移量为 1222 的输入寄存器中。



![image](/images/user-guide/integrations/decode/Picture12.png)



### 步骤 6. 设置 MQTT
在 MQTT 设置菜单中，勾选复选框：启用、清除会话和 JSON 格式。输入 Thingsboard 代理数据：代理：**demo.thingsboard.io**，端口：**1883**，重新连接周期：**10**，保持活动间隔：**60**，客户端 ID：输入从 GridLinks 演示帐户获得的 **设备 ID**，用户名：输入从 GridLinks 演示帐户获得的 **访问令牌**，密码：留空。单击“保存”按钮。
在 MQTT 发布列表菜单中，添加三个参数，两个用于发布继电器状态，一个用于发布来自热量计的回水温度。单击“保存”按钮。



![image](/images/user-guide/integrations/decode/Picture13.png)



输入 MQTT 订阅列表菜单。订阅主题 **v1/devices/me/rpc/request/+**，其中包含关键字 **exio_relay_1** 和 **gt900_relay_1**，并将它们分别引用到 DL28 内部 Modbus 保持寄存器 508 和输入寄存器 52000。
单击“保存”按钮以保存更改，然后单击“重新启动”菜单中的“重新启动应用程序”按钮重新启动应用程序。



![image](/images/user-guide/integrations/decode/Picture14.png)



## 测试
打开 DL28 仪表板。通过单击开关 EXIO RL1 和 GT900 RL1 来控制继电器。指示器显示输出继电器的实际状态，在慢速网络上可能会注意到一些延迟。小部件 CAL_RETURN_TEMP 显示来自热量计的回水温度。



![image](/images/user-guide/integrations/decode/Picture15.png)



## 结论
事实证明，GridLinks 是远程监控和控制区域供热变电站设施的理想平台。该解决方案在增加设备、仪表板和小部件的数量方面具有很强的可扩展性，甚至可以覆盖整个城市的较大配电网络。还证明了在 GridLinks 系统中可以将远程监控和控制与抄表混合使用。

有关所用产品的更多详细信息，请参阅其页面和手册，这些页面和手册可以从下载页面下载。

如果您有任何其他问题，请随时与 Decode 团队联系。
## 另请参阅

浏览其他 [示例](/docs/samples) 或探索与 GridLinks 主要功能相关的指南：

- [设备属性](/docs/{{docsPrefix}}user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/{{docsPrefix}}user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/{{docsPrefix}}user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。
- [数据可视化](/docs/{{docsPrefix}}user-guide/visualization/) - 如何可视化收集的数据。

{% include templates/feedback.md %}

{% include socials.html %}

## 后续步骤

{% assign currentGuide = "HardwareSamples" %}{% include templates/multi-project-guides-banner.md %}