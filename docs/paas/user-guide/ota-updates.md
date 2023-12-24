---
layout: docwithnav-paas
assignees:
- ashvayka
title: 空中固件和软件更新
description: 物联网设备固件更新
 
createFirmware:
    0:
        image: /images/user-guide/firmware/add-firmware-pe.png  
        title: '您必须输入标题和版本；选择类型和设备配置文件（此字段中，我们定义此固件将可用的设备类型；选择包含固件的文件。可以选择性地添加校验和算法和校验和。'

listFirmware:
    0:
        image: /images/user-guide/firmware/list-firmware-pe.png
        title: ''
    1:
        image: /images/user-guide/firmware/list-firmware-1-pe.png
        title: ''
    2:
        image: /images/user-guide/firmware/list-firmware-2-pe.png
        title: ''
    3:
        image: /images/user-guide/firmware/list-firmware-3-pe.png
        title: ''     


fw-deviceprofile:
    0:
        image: /images/user-guide/firmware/fw-deviceprofile-pe.png
        title: '.'
    1:
        image: /images/user-guide/firmware/fw-deviceprofile-1-pe.png
        title: '.'
    2:
        image: /images/user-guide/firmware/fw-deviceprofile-2-pe.png
        title: '.'
    3:
        image: /images/user-guide/firmware/fw-deviceprofile-3-pe.png
        title: '.'

deviceFirmware:
    0:
        image: /images/user-guide/firmware/device-firmware-pe.png
        title: '转到设备页面并打开所需的设备详细信息以编辑其信息。'
    1:
        image: /images/user-guide/firmware/device-firmware-1-pe.png
        title: "从下拉菜单中选择您要分配给此设备的固件。"
    3:
        image: /images/user-guide/firmware/device-firmware-2-pe.png
        title: '选择固件后，单击页面右上角的橙色复选标记应用更改。'
    4:
        image: /images/user-guide/firmware/device-firmware-3-pe.png
        title: '.'

fw-attributes:
    0:
        image: /images/user-guide/firmware/fw-attributes-pe.png
        title: ''

fw-dashboard:
    0:
        image: /images/user-guide/firmware/fw-dashboard-pe.png
        title: '在固件仪表板中监视和跟踪设备的固件状态。'
    1:
        image: /images/user-guide/firmware/fw-dashboard-1-pe.png
        title: '通过单击设备名称旁边的按钮，了解有关特定设备固件状态的更多信息。'

fw-status:
    0:
        image: /images/user-guide/firmware/fw-status-pe.png
        title: ''
    1:
        image: /images/user-guide/firmware/fw-status-1-pe.png
        title: ''

sw-dashboard:
    0:
        image: /images/user-guide/firmware/sw-dashboard-1-pe.png
        title: '在软件仪表板中监视和跟踪设备的软件状态。'
    1:
        image: /images/user-guide/firmware/sw-dashboard-2-pe.png
        title: '通过单击设备名称旁边的按钮，了解有关特定设备软件状态的更多信息。'

fw-http-updated:
    0:
        image: /images/user-guide/firmware/fw-http-updated.png
        title: ''

fw-mqtt-updated:
    0:
        image: /images/user-guide/firmware/fw-mqtt-updated.png
        title: ''

fw-coap-updated:
    0:
        image: /images/user-guide/firmware/fw-coap-updated.png
        title: ''

fw-devicegroup:
    0:
        image: /images/user-guide/firmware/fw-devicegroup-pe.png
        title: '转到设备配置文件页面并打开所需的设备配置文件详细信息以编辑其信息。'
    1:
        image: /images/user-guide/firmware/fw-devicegroup-1-pe.png
        title: "从下拉菜单中选择您要分配给此设备配置文件的固件。"
    2:
        image: /images/user-guide/firmware/fw-devicegroup-2-pe.png
        title: '选择固件后，单击页面右上角的橙色复选标记应用更改。'
    3:
        image: /images/user-guide/firmware/fw-devicegroup-3-pe.png
        title: ''

fw-scheduler:
    0:
        image: /images/user-guide/firmware/fw-scheduler-pe.png
    1:
        image: /images/user-guide/firmware/fw-scheduler-1-pe.png
    2:
        image: /images/user-guide/firmware/fw-scheduler-2-pe.png

fw-calendar:
    0:
        image: /images/user-guide/firmware/fw-scheduler-3-pe.png


---

{% assign docsPrefix = "paas/" %}
{% include docs/user-guide/ota-updates.md %}

## 将 OTA 软件包分配给设备组

专业版让您有机会将固件/软件分配给特定设备组，以便自动将软件包分发给共享同一组的所有设备。请参阅下面的屏幕截图。

{% include images-gallery.html imageCollection="fw-devicegroup" %}

设备组详细信息仅允许选择兼容的 OTA 更新软件包
（有关更多信息，请参阅 [预配](/docs/{{docsPrefix}}user-guide/ota-updates/#provision-ota-package-to-thingsboard-repository)）。
分配固件/软件会触发 [更新过程](/docs/{{docsPrefix}}user-guide/ota-updates/#update-process)。

专门分配给设备的固件版本将自动覆盖分配给设备组的固件版本。

例如，假设您有设备 A1、A2 和 A3，它们位于同一设备组中，但具有不同的设备配置文件。

* 设备 A1 和 A2 具有兼容的设备配置文件，而设备 A3 具有不兼容的设备配置文件。当您将软件包分配给此设备组时，固件/软件将仅在设备 A1 和 A2 上更新。
* 如果您专门在设备 A2 上更新软件包，设备 A1 将保持不更新状态。

## 调度程序

调度程序允许您设置 OTA 软件包更新的确切日期和时间。
您可以将调度程序事件观察为列表，或在日历视图中查看即将发生的事件。
1. 要安排更新，请单击屏幕右上角的加号以打开一个对话框窗口。

2. 在打开的对话框的 **配置** 选项卡中，输入事件名称，从下拉菜单中选择事件类型（软件/固件更新）并选择更新目标：
* 如果您需要为设备、设备配置文件或设备组安排更新，请从下拉菜单中选择实体和所需的 OTA 软件包。
* 如果您需要为设备组所有者安排更新，请从下拉菜单中选择组的所有者、属于此所有者的特定实体组以及将更新的软件包。

3. 在 **计划** 选项卡中，选择您的时区，设置您希望实体更新的日期和时间。
如果您想使其成为可重复操作，请选中重复框。从出现的下拉菜单中，选择更新将发生的频率。
选择每周更新时，您应该选中您希望更新发生的日期。
基于计时器的更新允许您设置频率：小时、分钟或秒，以及数值。
此外，您需要设置重复完成的时间。

4. 设置配置参数和计划时间后，单击“创建”按钮。
您可以通过单击其名称旁边的相应按钮来编辑创建的调度程序事件或删除它们。
在编辑调度程序事件对话框中，您可以配置方法和参数。

{% include images-gallery.html imageCollection="fw-scheduler" %}

在日历中，您可以通过在下拉菜单中选择首选的视图类型来更改其视图类型。要编辑或删除调度程序事件，请单击它。

{% include images-gallery.html imageCollection="fw-calendar" %}