---
layout: docwithnav-paas
assignees:
- ashvayka
title: 设备配置文件
description: IoT 设备配置文件
redirect_from: "/docs/paas/user-guide/ui/device-profiles"

mqttTransportSettingExample:
    0:
        image: /images/user-guide/device-profile/device-profile-transport-setting-mqtt-example-1-pe.png
        title: '步骤 1. 在设备配置文件中指定 MQTT 设备主题过滤器。'
    1:
        image: /images/user-guide/device-profile/device-profile-transport-setting-mqtt-example-2-pe.png
        title: '步骤 2. 为设备提供基本 MQTT 凭据，其中客户端 ID 为“c1”，用户名为“t1”，密码为“secret”。'
    2:
        image: /images/user-guide/device-profile/device-profile-transport-setting-mqtt-example-3-pe.png
        title: '步骤 3. 使用终端发布时序数据。'
    3:
        image: /images/user-guide/device-profile/device-profile-transport-setting-mqtt-example-4-pe.png
        title: '步骤 4. 传输的数据将显示在设备的“上次遥测”选项卡中。'

alarmСonditions:
    0:
        image: /images/user-guide/device-profile/alarm-example-1-step-1-pe.png
        title: '步骤 1. 打开设备配置文件并切换编辑模式。'
    1:
        image: /images/user-guide/device-profile/alarm-example-1-step-2-pe.png
        title: '步骤 2. 单击“添加警报规则”按钮。'
    2:
        image: /images/user-guide/device-profile/alarm-example-1-step-3-pe.png
        title: '步骤 3. 输入警报类型，然后单击红色“+”号。'
    3:
        image: /images/user-guide/device-profile/alarm-example-1-step-4-pe.png
        title: '步骤 4. 单击“添加键过滤器”按钮。'
    4:
        image: /images/user-guide/device-profile/alarm-example-1-step-5-pe.png
        title: '步骤 5. 选择“时序”键类型。输入“temperature”键名称。将“值类型”更改为“数字”。单击“添加”按钮。'
    5:
        image: /images/user-guide/device-profile/alarm-example-1-step-6-pe.png
        title: '步骤 6. 选择“大于”运算并输入阈值。单击“添加”。'
    6:
        image: /images/user-guide/device-profile/alarm-example-1-step-7-pe.png
        title: '步骤 7. 单击“保存”按钮。'
    7:
        image: /images/user-guide/device-profile/alarm-example-1-step-8-pe.png
        title: '步骤 8. 最后，应用更改。'

alarmСonditionsWithDuration:
    0:
        image: /images/user-guide/device-profile/alarm-example-2-step-1-pe.png
        title: '步骤 1. 编辑警报条件并将条件类型更改为“持续时间”。指定持续时间值和单位。保存条件。'
    1:
        image: /images/user-guide/device-profile/alarm-example-2-step-2-pe.png
        title: '步骤 2. 应用更改。'

alarmСonditionsWithDuration2:
    0:
        image: /images/user-guide/device-profile/alarm-example-2-step-4-pe.png
        title: '步骤 3. 编辑警报条件。通过按“切换到动态值”按钮转到警报延迟的动态值；'
    1:
        image: /images/user-guide/device-profile/alarm-example-2-step-5-pe.png
        title: '步骤 4. 选择一个值：当前设备、当前客户或当前租户。并指定将从中获取警报阈值值的属性。
        您可以选择勾选“从所有者继承”。继承允许从客户获取阈值，如果它未在设备级别设置。如果属性值未在设备和客户级别设置，规则将从租户属性获取值；'
    2:
        image: /images/user-guide/device-profile/alarm-example-2-step-6-pe.png
        title: '步骤 5. 应用所有更改。'

alarmСonditionsWithRepeating:
    0:
        image: /images/user-guide/device-profile/alarm-example-3-step-1-pe.png
        title: '步骤 1. 编辑警报条件并将条件类型更改为“重复”。将“事件计数”指定为“3”以触发警报。如果未为设备设置任何属性，将默认使用此值。保存条件。'
    1:
        image: /images/user-guide/device-profile/alarm-example-3-step-2-pe.png
        title: '步骤 2. 应用更改。'

alarmСonditionsWithRepeating2:
    0:
        image: /images/user-guide/device-profile/alarm-example-3-step-3-pe.png
        title: '步骤 4. 通过按“切换到动态值”按钮转到重复警报条件的动态值；'
    1:
        image: /images/user-guide/device-profile/alarm-example-3-step-4-pe.png
        title: '步骤 5. 选择一个值：当前设备、当前客户或当前租户。并指定将从中获取值的属性，阈值必须超过多少次才能触发警报。您可以选择勾选“从所有者继承”。继承允许从客户获取阈值，如果它未在设备级别设置。如果属性值未在设备和客户级别设置，规则将从租户属性获取值；'
    2:
        image: /images/user-guide/device-profile/alarm-example-3-step-5-pe.png
        title: '步骤 6. 应用所有更改。'

alarmСonditionsClear:
    0:
        image: /images/user-guide/device-profile/alarm-example-4-step-1-pe.png
        title: '步骤 1. 打开设备配置文件并切换编辑模式。单击“添加清除条件”按钮。'
    1:
        image: /images/user-guide/device-profile/alarm-example-4-step-2-pe.png
        title: '步骤 2. 单击红色“+”号。'
    2:
        image: /images/user-guide/device-profile/alarm-example-4-step-3-pe.png
        title: '步骤 3. 添加键过滤器。然后单击添加。'
    3:
        image: /images/user-guide/device-profile/alarm-example-4-step-4-pe.png
        title: '步骤 4. 保存警报规则条件。'
    4:
        image: /images/user-guide/device-profile/alarm-example-4-step-5-pe.png
        title: '步骤 4. 最后，应用更改。'

alarmСonditionsSchedule:
    0:
        image: /images/user-guide/device-profile/alarm-example-5-step-1-pe.png
        title: '步骤 1. 编辑警报规则的计划。'
    1:
        image: /images/user-guide/device-profile/alarm-example-5-step-2-pe.png
        title: '步骤 2. 选择时区、日期、时间间隔，然后单击“保存”。'
    2:
        image: /images/user-guide/device-profile/alarm-example-5-step-3-pe.png
        title: '步骤 3. 最后，应用更改。'

alarmСonditionsAdvanced:
    0:
        image: /images/user-guide/device-profile/alarm-example-6-step-1-pe.png  
        title: '步骤 1. 修改温度键过滤器并将值类型更改为动态。'
    1:
        image: /images/user-guide/device-profile/alarm-example-6-step-2-pe.png
        title: '步骤 2. 选择动态源类型并输入 *temperatureAlarmThreshold*，然后单击“更新”。您可以选择勾选“从所有者继承”。继承允许从客户获取阈值，如果它未在设备级别设置。如果属性值未在设备和客户级别设置，规则将从租户属性获取值。'
    2:
        image: /images/user-guide/device-profile/alarm-example-6-step-3-pe.png
        title: '步骤 3. 为 *temperatureAlarmFlag* 添加另一个键过滤器，然后单击“添加”。'
    3:
        image: /images/user-guide/device-profile/alarm-example-6-step-4-pe.png
        title: '步骤 4. 最后，单击“保存”并应用更改。'
    4:
        image: /images/user-guide/device-profile/alarm-example-6-step-5-pe.png
        title: '步骤 5. 手动或通过脚本配置设备属性。'

alarmСonstantFilters:
    0:
        image: /images/user-guide/device-profile/alarm-example-7-step-1-pe.png
        title: '选择常量类型和值，并将其与租户或客户属性的值进行比较。应用所有更改。'
         
---

{% assign docsPrefix = "paas/" %}
{% include docs/user-guide/device-profiles.md %}