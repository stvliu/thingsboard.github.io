---
layout: docwithnav-paas
assignees:
- ashvayka
title: 入门 GridLinks 云
description: 入门 ThingsBoard 开源物联网平台和模拟物联网设备

step1:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-1-pe.png
        title: '登录到 GridLinks 实例并导航到“实体”部分。然后转到“设备”页面；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-2-pe.png
        title: '默认情况下，您导航到设备组“全部”。单击表右上角的“+”图标，然后选择“添加新设备”；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-3-pe.png
        title: '输入设备名称。例如，“我的新设备”。此时无需进行其他更改。单击“添加”；'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-connectivity-1-pe.png
        title: '设备已创建。将打开一个窗口，您可以在其中检查设备与 GridLinks 的连接。此步骤是可选的。现在让我们关闭此窗口，并在下一步中更详细地返回检查连接；'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-4-pe.png
        title: '您的第一个设备已添加。随着新设备的添加，它们将被添加到表的顶部，因为该表默认情况下使用创建的时间对设备进行排序。'

step11:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-1-1-provision-device-5-pe.png
        title: '您可以通过单击右上角的“铃铛”图标来查看通知。'

step2:
    0:
        image: /images/helloworld/getting-started-pe/check-connectivity-device-1-pe.png
        title: '单击您的设备，然后单击“设备详细信息”窗口中的“检查连接”按钮；'
    1:
        image: /images/helloworld/getting-started-pe/check-connectivity-device-2-pe.png
        title: '在打开的窗口中选择消息传递协议和您的操作系统。安装必要的客户端工具并复制命令；'
    2:
        image: /images/helloworld/getting-started-pe/check-connectivity-device-3-pe.png
        title: '执行先前复制的命令。成功发布“温度”读数后，设备状态应从“不活动”变为“活动”，您应该会看到已发布的“温度”读数。现在，关闭连接窗口。'

step31:
    0:
        image: /images/user-guide/dashboards/overview/create-dashboard-1-pe.png
        title: '登录到您的 GridLinks 实例并通过屏幕左侧的主菜单导航到“仪表板”页面。默认情况下，您导航到仪表板组“全部”；'
    1:
        image: /images/user-guide/dashboards/overview/create-dashboard-2-pe.png
        title: '单击屏幕右上角的“+”号，然后从下拉菜单中选择“创建新仪表板”；'
    2:
        image: /images/helloworld/getting-started-pe/create-dashboard-3-pe.png
        title: '在打开的对话框中，有必要输入仪表板标题，说明是可选的。单击“添加”；'
    3:
        image: /images/user-guide/dashboards/overview/create-dashboard-4-pe.png
        title: '创建仪表板后，它将自动打开，您可以立即开始向其中添加小部件。要保存仪表板，请单击右上角的“保存”按钮；'
    4:
        image: /images/helloworld/getting-started-pe/create-dashboard-5-pe.png
        title: '您的第一个仪表板已成功创建。随着您继续添加新仪表板，它们将出现在列表的顶部。此默认排序基于创建时间戳。'

step32:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-0-pe.png
        title: '进入仪表板编辑模式。只需打开仪表板并单击屏幕右上角的“编辑模式”按钮；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-1-pe.png
        title: '单击屏幕顶部的“添加小部件”按钮或单击屏幕中央的“添加新小部件”大图标（如果这是您在此仪表板上的第一个小部件）；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-2-pe.png
        title: '选择“表格”小部件包；'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-3-pe.png
        title: '选择“实体表”小部件；'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-4-pe.png
        title: '将出现“添加小部件”窗口。在“设备”字段中指定先前创建的设备“我的新设备”。“名称”键已添加到“列”部分，该部分负责包含设备名称的列。您需要添加另一列来显示“温度”键的值。为此，单击“添加列”以添加一个新字段来输入数据键；'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-5-pe.png
        title: '单击新出现的 data key 输入字段。将打开可用数据键的列表。选择“温度”数据键；'
    6:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-6-pe.png
        title: '单击小部件右下角的“添加”按钮以完成添加小部件。'
    7:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-table-widget-7-pe.png
        title: '调整小部件的大小以使其更大一些。只需拖动小部件的右下角。单击“保存”以应用更改。'

step33:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-1-pe.png
        title: '进入编辑模式并单击屏幕顶部的“添加新小部件”按钮；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-2-pe.png
        title: '选择“图表”小部件包；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-3-pe.png
        title: '选择“时序线图”小部件；'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-4-pe.png
        title: '在“设备”字段中指定先前创建的设备“我的新设备”，并在“系列”部分中指定“温度”数据键。单击“添加”；'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-5-pe.png
        title: '调整小部件大小并应用更改。多次发布不同的遥测值，如步骤 2 中所示。请注意，默认情况下，小部件仅显示一分钟的数据。单击“保存”以应用更改；'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-3-1-add-chart-widget-6-pe.png
        title: '现在打开时间选择窗口。更改间隔和聚合函数。通过单击“更新”按钮更新时间窗口设置。'

step34:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-1-pe.png
        title: '进入编辑模式并单击屏幕顶部的“添加新小部件”按钮；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-2-pe.png
        title: '选择“警报小部件”包；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-3-pe.png
        title: '选择“警报表”小部件；'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-4-pe.png
        title: '在“设备”字段中指定先前创建的设备“我的新设备”，并选择您希望在警报小部件中显示的警报状态和严重性；'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-5-pe.png
        title: '将“时序线图”小部件拖放到仪表板的右上角，为“警报”小部件腾出空间；'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-3-4-add-alarm-widget-6-pe.png
        title: '向下滚动并找到新的“警报”小部件。将警报小部件拖放到可用空间并调整其大小。单击“保存”以应用更改。'

step4:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-2-pe.png
        title: '转到“配置文件”部分，然后单击“设备配置文件”页面。然后单击默认设备配置文件行以打开其详细信息；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-3-pe.png
        title: '导航到“警报规则”选项卡，然后单击“铅笔”按钮以进入编辑模式；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-4-pe.png
        title: '单击“添加警报规则”按钮；'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-5-pe.png
        title: '指定警报类型并单击“+”图标以添加警报规则条件；'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-6-pe.png
        title: '单击“添加键过滤器”按钮以指定条件；'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-7-pe.png
        title: '选择键类型，输入键名称，然后选择值类型。然后，单击“过滤器”部分中的“添加”按钮；'
    6:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-8-pe.png
        title: '选择一个操作并输入一个阈值。单击右下角的“添加”按钮；'
    7:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-9-pe.png
        title: '单击“保存”；'
    8:
        image: /images/helloworld/getting-started-pe/hello-world-4-configure-alarm-rules-10-pe.png
        title: '最后，单击“应用更改”。'

step5:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-5-create-alarm-1-pe.png
        title: '请注意，新的温度遥测会导致新的活动警报；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-5-create-alarm-2-pe.png
        title: '您可以确认并清除警报；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-5-create-alarm-3-pe.png
        title: '当您收到新的警报时，您将在通知中心收到一条消息。您可以通过单击右上角的铃铛图标来查看消息。'

step71:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-2-pe.png
        title: '导航到“客户”页面。默认情况下，您导航到客户组“全部”。单击“+”号添加新客户；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-3-pe.png
        title: '输入客户标题。此外，您可以输入客户的个人详细信息并分配主页仪表板。要完成客户创建，您可以单击“添加”按钮。在这种情况下，新客户将被创建并位于“全部”客户文件夹中。让我们为我们的客户创建一个单独的组。为此，请单击“下一步：所有者和组”按钮；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-4-pe.png
        title: '如果需要，您可以为此客户分配不同的所有者。我们将保持此选项不变。输入新组的名称，然后单击“创建一个新组！”；'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-5-pe.png
        title: '单击“添加”以创建新的客户组；'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-6-pe.png
        title: '现在，单击“添加”以创建新客户；'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-7-pe.png
        title: '客户已创建并位于“我的客户”组中。您可以通过单击其名称导航到此组。'

step72:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-1-pe.png
        title: '打开“设备”页面。选择您的设备以打开其详细信息；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-2-pe.png
        title: '单击“管理所有者和组”按钮；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-3-pe.png
        title: '在“所有者”行中，开始输入客户名称，然后选择客户；'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-4-pe.png
        title: '现在，创建一个设备组。在“组”行中，输入所需的设备组名称。然后，单击“创建一个新组”；'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-5-pe.png
        title: '在下一个窗口中，单击“添加”按钮以创建设备组；'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-6-pe.png
        title: '单击“更新”以更改设备的所有者。您始终可以将所有者更改回租户；'
    6:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-7-pe.png
        title: '默认情况下，常规设备列表显示租户设备和您客户的设备。禁用“包括客户实体”以仅在设备列表中查看租户设备；'
    7:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-8-pe.png
        title: '您的设备列表现在应该为空。'

step72_1:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-9-pe.png
        title: '导航到“客户”页面。在客户列表中找到您的客户，然后单击“管理客户设备”图标；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-10-pe.png
        title: '您的设备归客户所有，并位于客户的设备组“我的设备”中。'

step72_2:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-11-pe.png
        title: '单击表右上角的“+”图标。输入设备名称（例如，“恒温器”）并导航到“所有者和组”选项卡；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-12-pe.png
        title: '选择新所有者并单击“添加”；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-71-assign-device-to-customer-13-pe.png
        title: '设备已创建，并且立即属于您的客户。'

step73:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-3-pe.png
        title: '打开“仪表板”页面，转到“组”选项卡，然后单击“全部”仪表板组的“共享”图标；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-4-pe.png
        title: '选择客户并指定权限 - “读取”。单击“共享”。'

step73_1:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-5-pe.png
        title: '单击表右上角的“+”图标。输入仪表板名称（例如，“恒温器”）并导航到“所有者和组”选项卡；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-6-pe.png
        title: '让我们为他们创建一个单独的组。输入新组的名称（例如，“恒温器组”），然后单击“创建一个新组！”；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-7-pe.png
        title: '单击“下一步：共享实体组”按钮；'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-8-pe.png
        title: '勾选“共享实体组”复选框，然后选择您要与之共享仪表板的客户并指定权限。单击“添加”；'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-9-pe.png
        title: '单击“添加”仪表板；'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-71-share-the-dashboard-10-pe.png
        title: '仪表板已创建并位于“恒温器组”组中。您可以通过单击其名称导航到此组。'

step74:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-1-pe.png
        title: '导航到“客户”页面。在客户列表中找到您的客户，然后单击“管理客户用户”图标；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-2-pe.png
        title: '导航到“组”选项卡并选择“客户用户”组；'
    2:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-3-pe.png
        title: '单击右上角的“加号”图标以添加新用户；'
    3:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-4-pe.png
        title: '指定电子邮件、姓氏和名字。单击“添加”；'
    4:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-5-pe.png
        title: '复制激活链接并将其保存在安全的地方。然后单击“确定”；'
    5:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-6-pe.png
        title: '单击创建的用户以打开详细信息。单击“铅笔”图标以进入编辑模式；'
    6:
        image: /images/helloworld/getting-started-pe/hello-world-7-create-customer-user-7-pe.png
        title: '选择默认仪表板并启用“始终全屏”模式。应用更改。'

step75:
    0:
        image: /images/helloworld/getting-started-pe/hello-world-7-5-activate-customer-user-1-pe.png
        title: '将先前复制的链接粘贴到新的浏览器选项卡中，然后按 Enter。想出并输入密码两次，然后按“创建密码”。您将自动登录为客户用户；'
    1:
        image: /images/helloworld/getting-started-pe/hello-world-7-5-activate-customer-user-2-pe.png
        title: '您已登录为客户用户。您可以浏览数据并确认/清除警报。'


mqttWindows:
    0:
        image: /images/helloworld/hello-world-pe-step-3-item-1.png
        title: 'Create new MQTT Client with the properties listed in screenshots below;'
    1:
        image: /images/helloworld/hello-world-pe-step-3-item-2.png
        title: 'Populate the topic name and payload. Make sure the payload is a valid JSON document. Click "Publish" button.'

mosquitto-windows:
    0:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-1.png
        title: 'Press the Win + X, then select "System". Then click on the "System" page;'
    1:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-2.png
        title: 'Navigate to the "About" section, then click "Advanced system settings";'
    2:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-3.png
        title: 'In the "System Properties" pop-up window, click "Environment Variables" button on the "Advanced" tab;'
    3:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-4.png
        title: 'In the "Environment Variables" pop-up window, select the "Path", then click on the "Edit" button;'
    4:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-5.png
        title: 'In the "Edit environment variable" pop-up window click on the "New" button and add the path to the directory containing &#39;mosquitto_pub.exe&#39; and &#39;mosquitto_sub.exe&#39; (&#39;C:\Program Files\mosquitto&#39; by default). Click "OK";'
    5:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-6.png
        title: 'Click "OK" button to save changes in the environment variables;'
    6:
        image: /images/helloworld/getting-started-pe/mosquitto-windows-7.png
        title: 'Finally, click "OK" button to apply all changes in the system properties.'