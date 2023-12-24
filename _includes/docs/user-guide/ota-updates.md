* TOC
{:toc}

## 概述

自 ThingsBoard 3.3 起，ThingsBoard 允许您上传并通过无线 (OTA) 更新分发给设备。
作为租户管理员，您可以将固件或软件包上传到 OTA 存储库。
上传后，您可以将它们分配给 [设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/) 或 [设备](/docs/{{docsPrefix}}user-guide/ui/devices/)。
ThingsBoard 会通知设备有关可用更新的信息，并提供特定于协议的 API 来下载固件。
该平台会跟踪更新状态并存储更新历史记录。
作为平台用户，您可以使用仪表板监控更新过程。
<br>
<object data="/images/user-guide/firmware/firmware-anim3.svg"></object>
<br>

## 向 ThingsBoard 存储库提供 OTA 包

导航到“OTA 更新”菜单项以列出并上传 OTA 更新包。每个包包括：

* 标题 - 包的名称。您可以对生产和调试固件/软件使用不同的名称。
* 版本 - 包的版本。标题和版本的组合在租户范围内必须是唯一的。
* 设备配置文件 - 每个包与一个设备配置文件兼容。我们跟踪兼容性以防止意外更新具有不兼容固件/软件的设备。
  链接到设备配置文件意味着使用此配置文件的设备*可能*被更新到当前包。
  但是，在用户或脚本将包分配给设备配置文件或设备之前，不会触发更新。
* 类型 - 可以是 *固件* 或 *软件*。
* 校验和算法 - 可选参数，它是要使用的校验和算法的简称。
* 校验和 - 可选参数，它是文件校验和的值。如果用户未提供校验和，服务器将自动使用 SHA-256 算法。
* 说明 - 固件的可选文本说明。

{% include images-gallery.html imageCollection="createFirmware" %}

您可以浏览已配置的包以及按标题搜索它们。此外，您还可以下载和删除包。
要打开包详细信息，请单击表格行。包详细信息允许您复制包 ID 和校验和。
此外，[审计日志](/docs/{{docsPrefix}}user-guide/audit-log/) 会跟踪有关配置固件的用户的信息。

{% include images-gallery.html imageCollection="listFirmware" %}

所有列出的操作也可通过 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 获得。

## 固件与软件

ThingsBoard 内核中 FOTA 和 SOTA 实现之间存在非常细微的差异。许多用例和应用程序只需要使用 FOTA。
但是，[LwM2M](/docs/{{docsPrefix}}reference/lwm2m-api/) 设备以不同的方式处理 FOTA 和 SOTA 更新。

## 将 OTA 包分配给设备配置文件

您可以将固件/软件分配给设备配置文件，以便自动将包分发给共享相同配置文件的所有设备。请参阅下面的屏幕截图。

{% include images-gallery.html imageCollection="fw-deviceprofile" %}

设备配置文件详细信息将允许您仅选择兼容的 OTA 更新包（有关更多信息，请参阅 [配置](#provision-ota-package-to-thingsboard-repository)）。
设备配置文件可能被数千个设备使用。分配固件/软件会触发 [更新过程](#update-process)。


## 将 OTA 包分配给设备

您还可以将固件/软件分配给特定设备。请参阅下面的屏幕截图。

{% include images-gallery.html imageCollection="deviceFirmware" %}

分配给设备的固件版本将自动覆盖分配给设备配置文件的固件版本。

例如，假设您有属于配置文件 P1 的设备 D1 和 D2：

* 如果您将包 F1 分配给配置文件 P1（通过 [配置文件详细信息 UI](/docs/{{docsPrefix}}user-guide/ota-updates/#assign-ota-package-to-device-profile) 或 REST API），设备 D1 和 D2 将更新为 F1。
* 如果您将包 F2 分配给设备 D1（通过 [设备详细信息 UI](/docs/{{docsPrefix}}user-guide/ota-updates/#assign-ota-package-to-device) 或 REST API），设备 D1 将更新为 F2。
* 随后将包 F3 分配给配置文件 P1 将仅影响 D2，因为它在设备级别没有分配特定的固件版本。
因此，D2 将更新为 F3，而 D1 将继续使用 F2。


客户可以选择可用的固件并将其分配给他们所属的设备。但是，客户无法配置或管理固件包。

{% capture delete_restrictions %}
禁止删除已分配给至少一个设备或设备配置文件的固件包。
{% endcapture %}
{% include templates/info-banner.md content=delete_restrictions %}

## 更新过程

将固件/软件分配给设备或设备配置文件会触发更新过程。
ThingsBoard 会跟踪更新的进度并将其持久保存到设备属性。

更新进度可能具有以下状态之一。更新状态存储为设备的属性，并用于在 [仪表板](#dashboard) 上可视化更新过程。

### 排队状态

固件/软件更新的第一个状态。
表示有关新固件/软件的通知已排队，但尚未推送到设备。
ThingsBoard 会对更新通知排队以避免峰值负载。队列以恒定速度处理。
默认情况下，它被配置为每分钟通知多达 100 个设备。有关更多详细信息，请参阅 [配置属性](/docs/{{docsPrefix}}user-guide/ota-updates/#queue-processing-pace)。

### 已启动状态

表示从队列中获取有关固件/软件的通知并推送到设备。
在底层，ThingsBoard 将通知转换为以下 [共享属性](/docs/{{docsPrefix}}user-guide/attributes/#shared-attributes) 的更新：

- fw(sf)_title - 固件（软件）的名称。
- fw(sf)_version - 固件（软件）的版本。
- fw(sf)_size - 固件（软件）文件的大小（以字节为单位）。
- fw(sf)_checksum - 用于验证接收文件完整性的属性。
- fw(sf)_checksum_algorithm - 用于计算文件校验和的算法。

{% include images-gallery.html imageCollection="fw-attributes" %}

设备能够使用 [MQTT](/docs/{{docsPrefix}}reference/mqtt-api/)、
[HTTP](/docs/{{docsPrefix}}reference/http-api/)、[CoAP](/docs/{{docsPrefix}}reference/coap-api/) 或 [LwM2M](/docs/{{docsPrefix}}reference/lwm2m-api/) API 订阅共享属性更新。

### 设备报告的更新状态

剩余状态由当前正在处理更新的设备固件/软件报告。
我们准备了这些状态的说明以及使用 python 编写的最流行协议的示例应用程序。
示例应用程序模拟设备固件/软件的行为，可用作实现的参考。

* 下载中 - 收到有关新固件/软件更新的通知，设备开始下载更新包。
* 已下载 - 设备已完成更新包的下载。
* 已验证 - 设备验证了下载的包的校验和。
* 正在更新 - 设备已启动固件/软件更新。通常在设备重新启动或服务重新启动之前发送。
* 已更新 - 固件已成功更新到下一个版本。
* 失败 - 校验和未验证，或设备更新失败。有关更多详细信息，请参阅固件仪表板上的“设备失败”选项卡。


固件/软件更新后，ThingsBoard 预计设备发送以下遥测：

对于固件：
```json
{"current_fw_title": "myFirmware", "current_fw_version": "1.2.3", "fw_state": "UPDATED"}
```

对于软件：
```json
{"current_sw_title": "mySoftware", "current_sw_version": "1.2.3", "sw_state": "UPDATED"}
```

如果固件/软件更新失败，ThingsBoard 预计设备发送以下遥测：

对于固件：
```json
{"fw_state": "FAILED", "fw_error":  "the human readable message about the cause of the error"}
```

对于软件：
```json
{"sw_state": "FAILED", "sw_error":  "the human readable message about the cause of the error"}
```

{% capture contenttogglespec %}
HTTP<br>%,%http%,%templates/install/http-firmware.md%br%
MQTT<br>%,%mqtt%,%templates/install/mqtt-firmware.md%br%
CoAP<br>%,%aws%,%templates/install/coap-firmware.md%br%{% endcapture %}
{% include content-toggle.html content-toggle-id="remoteintegrationdockerinstall" toggle-spec=contenttogglespec %}

## 仪表板

GridLinks 提供固件/软件更新的摘要，以监控和跟踪设备的固件/软件更新状态，例如哪些设备正在更新、任何启动问题以及哪些设备已更新。

### 固件更新监控仪表板

仪表板会自动为添加到 GridLinks 的每个新租户创建。
您还可以下载仪表板 JSON [此处](https://github.com/thingsboard/thingsboard/blob/master/application/src/main/data/json/demo/dashboards/firmware.json) 并将其导入现有租户。

在那里，您可以看到所有设备的列表，其中包含有关其固件的完整信息。

{% include images-gallery.html imageCollection="fw-dashboard" %}

单击设备名称旁边的“固件更新历史记录”按钮以了解特定设备的固件更新状态。

{% include images-gallery.html imageCollection="fw-status" %}

### 软件更新监控仪表板

仪表板会自动为添加到 GridLinks 的每个新租户创建。
您还可以下载仪表板 JSON [此处](https://github.com/thingsboard/thingsboard/blob/master/application/src/main/data/json/demo/dashboards/software.json) 并将其导入现有租户。

在那里，您可以看到所有设备的列表，其中包含有关其软件的完整信息。

{% include images-gallery.html imageCollection="sw-dashboard" %}

{% if docsPrefix != 'paas/' %}

### 配置

##### 队列处理速度

要使用以下 [配置](/docs/user-guide/install/{{docsPrefix}}config/) 属性设置在所选时间段内将通知的最大设备数：

```bash
export TB_QUEUE_CORE_FW_PACK_INTERVAL_MS=60000
export TB_QUEUE_CORE_FW_PACK_SIZE=100
```
{: .copy-code}

##### 最大尺寸设置

默认情况下，我们可以在数据库中保存的最大固件大小为 2 gb。它无法配置。

{% endif %}