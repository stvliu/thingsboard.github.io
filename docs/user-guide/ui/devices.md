---
layout: docwithnav
assignees:
- ashvayka
title: 设备
description: GridLinks IoT 设备管理

add-device:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-1-ce.png
        title: '登录到 GridLinks 实例并导航到“实体”部分。然后转到“设备”页面；'
    1:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-2-ce.png
        title: '单击表格右上角的“+”图标，然后选择“添加新设备”；'
    2:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-3-ce.png
        title: '输入设备名称。例如，“我的新设备”。此时无需进行其他更改。单击“添加”；'
    3:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-connectivity-1-ce.png
        title: '设备已创建。将打开一个窗口，您可以在其中检查设备与 GridLinks 的连接。此步骤是可选的。现在让我们关闭此窗口，并在下一步中更详细地返回检查连接；'
    4:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-4-ce.png
        title: '您的第一个设备已添加。随着新设备的添加，它们将被添加到表格的顶部，因为表格默认情况下按创建的时间对设备进行排序。'

add-device-notification:
    0:
        image: /images/helloworld/getting-started-ce/hello-world-1-1-provision-device-5-ce.png
        title: '添加新设备时，您将收到通知。您可以通过单击右上角的“铃铛”图标来查看它。'

device-details:
    0:
        image: /images/user-guide/ui/devices/ce/device-details-1-ce.png
        title: '单击设备行以打开其详细信息，然后单击对话框右上角的“铅笔”图标；'
    1:
        image: /images/user-guide/ui/devices/ce/device-details-2-ce.png
        title: '如有必要，更改设备名称及其配置文件。此外，您可以输入标签和说明，或选中“是网关”框。编辑后，单击橙色复选标记以保存所有应用的更改。'

device-delete-1:
    0:
        image: /images/user-guide/ui/devices/ce/device-delete-1-ce.png
        title: '单击要删除的设备名称对面的“垃圾桶”图标。'
    1:
        image: /images/user-guide/ui/devices/ce/device-delete-2-ce.png
        title: '在对话框中确认删除设备。'

device-delete-2:
    0:
        image: /images/user-guide/ui/devices/ce/device-delete-3-ce.png
        title: '单击要删除的设备。在设备详细信息窗口中，单击“删除设备”按钮；'
    1:
        image: /images/user-guide/ui/devices/ce/device-delete-4-ce.png
        title: '在对话框中确认删除设备。'

manage-device-credentials:
    0:
        image: /images/user-guide/ui/devices/ce/manage-device-credentials-1-ce.png
        title: '打开“设备详细信息”窗口并单击“管理凭据”按钮；'
    1:
        image: /images/user-guide/ui/devices/ce/manage-device-credentials-2-ce.png
        title: '选择您喜欢的凭据类型，在字段中生成必要的数据，然后单击“保存”。'

make-device-public:
    0:
        image: /images/user-guide/ui/devices/ce/make-device-public-1-ce.png
        title: '打开“设备详细信息”窗口并单击“公开设备”按钮；'
    1:
        image: /images/user-guide/ui/devices/ce/make-device-public-2-ce.png
        title: '在对话框中确认操作；'

make-device-private: 
    0:
        image: /images/user-guide/ui/devices/ce/make-device-public-4-ce.png
        title: '打开“设备详细信息”窗口并单击“私有设备”按钮；'
    1:
        image: /images/user-guide/ui/devices/ce/make-device-public-5-ce.png
        title: '在对话框中确认操作。'

assign-device-to-customer:
    0:
        image: /images/user-guide/ui/devices/ce/assign-device-to-customer-1-ce.png
        title: '打开“设备详细信息”窗口并单击“将设备分配给客户”按钮；'
    1:
        image: /images/user-guide/ui/devices/ce/assign-device-to-customer-2-ce.png
        title: '选择要分配设备的客户。然后单击“分配”；'
    2:
        image: /images/user-guide/ui/devices/ce/assign-device-to-customer-3-ce.png
        title: '设备已分配给选定的客户。'

check-connectivity:
    0:
        image: /images/user-guide/ui/devices/ce/check-connectivity-1-ce.png
        title: '打开“设备详细信息”窗口并单击“检查连接”按钮；'
    1:
        image: /images/user-guide/ui/devices/ce/check-connectivity-2-ce.png
        title: '选择消息传递协议和您的操作系统，然后复制命令；'
    2:
        image: /images/user-guide/ui/devices/ce/check-connectivity-3-ce.png
        title: '通过终端执行命令，代表设备向 ThingsBoard 实例发送遥测数据。设备状态应从“不活动”变为“活动”，您应该看到已发布的“温度”读数。'

copy-device-id:
    0:
        image: /images/user-guide/ui/devices/ce/copy-device-id-1-ce.png
        title: '使用“复制设备 ID”按钮将设备 ID 复制到剪贴板。'

copy-access-token:
    0:
        image: /images/user-guide/ui/devices/ce/copy-access-token-1-ce.png
        title: '要复制设备凭据，请单击“复制访问令牌”或“复制 MQTT 凭据”按钮（取决于您选择的设备凭据类型）。'

attributes:
    0:
        image: /images/user-guide/ui/devices/ce/device-attributes-1-ce.png
        title: '此选项卡显示设备的客户端、服务器和共享属性。例如，序列号、型号和固件版本。'

telemetry:
    0:
        image: /images/user-guide/ui/devices/ce/device-telemetry-1-ce.png
        title: '此选项卡显示设备实时发送的遥测数据，例如传感器读数、状态和其他可测量变量。'

telemetry-add-manually:
    0:
        image: /images/user-guide/ui/devices/ce/device-telemetry-add-manually-1-ce.png
        title: '单击窗口右上角的“加号”图标。在新窗口中，输入键名，选择值类型，然后输入值。单击“添加”按钮。'
    1:
        image: /images/user-guide/ui/devices/ce/device-telemetry-add-manually-2-ce.png
        title: '已添加遥测数据。'

telemetry-delete:
    0:
        image: /images/user-guide/ui/devices/ce/device-telemetry-delete-1-ce.png
        title: '要删除遥测数据，请单击要删除的遥测键名称旁边的“垃圾桶”图标；'
    1:
        image: /images/user-guide/ui/devices/ce/device-telemetry-delete-2-ce.png
        title: '选择您具体要删除的内容：删除所有数据、删除除最新值之外的所有数据、删除最新值、删除一段时间内所有数据。通过单击“应用”按钮确认删除。'

alarms:
    0:
        image: /images/user-guide/ui/devices/ce/device-alarms-1-ce.png
        title: '此选项卡显示识别设备问题的事件（警报）。'

events:
    0:
        image: /images/user-guide/ui/devices/ce/device-events-1-ce.png
        title: '此处显示与设备相关的事件，包括系统日志、错误、警告以及设备生命周期中的其他重要时刻。'

relations:
    0:
        image: /images/user-guide/ui/devices/ce/device-relations-1-ce.png
        title: '此选项卡显示此设备与 ThingsBoard 系统中的其他设备、仪表板、资产和其他实体的关系。'

audit-logs:
    0:
        image: /images/user-guide/ui/devices/ce/device-audit-logs-1-ce.png
        title: 'GridLinks 提供跟踪用户操作以保留审计日志的功能。可以记录与主要实体相关联的用户操作：资产、设备、仪表板、规则等。'

version-control:
    0:
        image: /images/user-guide/ui/devices/ce/device-version-control-1-ce.png
        title: 'ThingsBoard 版本控制服务提供使用 Git 导出和还原 ThingsBoard 实体的功能。'