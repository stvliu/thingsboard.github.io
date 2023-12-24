* TOC
{:toc}

ThingsBoard Cloud 提供便捷的物联网解决方案模板，以缩短物联网产品的上市时间。
模板包括交互式仪表板、处理逻辑、示例设备、用户以及所有其他必需的 [实体](/docs/paas/user-guide/entities-and-relations/)。
您可以将模板视为完整的 PoC/MVP。

本指南介绍了解决方案模板的基本操作。

{% include templates/solution-templates.md %}

## 浏览解决方案模板

作为租户管理员，您可以对解决方案模板执行以下操作

{% include images-gallery.html imageCollection="browse-solution-templates" showListImageTitles="true" %}

## 安装解决方案模板

{% include images-gallery.html imageCollection="install-solution-template" showListImageTitles="true" %}

## 删除解决方案模板

导航到“解决方案模板”菜单项。找到模板并使用“删除”按钮。
这将删除安装期间创建的所有 [实体](/docs/paas/user-guide/entities-and-relations/)。
请注意，您可能通过解决方案仪表板创建的实体（用户、设备等）不会自动删除。

{% include images-gallery.html imageCollection="remove-solution-template" %}

## 连接真实设备

模板说明包括有关解决方案期望从设备接收的有效负载的信息，以便正常运行。
说明还包含用于推送数据的示例命令。这些命令使用自动生成设备的有效凭据。
我们建议使用这些命令来熟悉解决方案。之后使用 [如何连接您的设备？](/docs/paas/getting-started-guides/connectivity/) 指南。