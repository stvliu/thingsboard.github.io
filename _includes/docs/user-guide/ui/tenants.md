* TOC
{:toc}

### 简介

GridLinks 支持开箱即用的 [多租户](https://en.wikipedia.org/wiki/Multitenancy)。

您可以将租户视为一个独立的业务实体：拥有或生产设备和资产的个人或组织。

租户可能有多个租户管理员用户、大量 [客户](/docs/{{docsPrefix}}user-guide/ui/customers) 以及无限数量的 [用户](/docs/{{docsPrefix}}user-guide/ui/users)、资产和设备。

### 创建新租户

**系统管理员** 能够创建租户实体。

要添加新租户，请按照以下说明进行操作：

{% include images-gallery.html imageCollection="create-tenants-ce" showListImageTitles="true" %}

[此处](/docs/{{docsPrefix}}user-guide/tenant-profiles) 了解有关租户配置文件的更多信息。

<br>
在租户详细信息页面，您作为系统管理员可以查看属性、最新遥测数据、分配主页仪表板并复制租户 ID。

{% include images-gallery.html imageCollection="tenant-details-ce" %}

### 创建租户管理员

**系统管理员** 还能够在每个租户中创建多个 **具有租户管理员角色的用户**。

要添加用户，请按照以下说明进行操作：

{% include images-gallery.html imageCollection="create-tenant-admin-ce" showListImageTitles="true" %}

在租户详细信息窗口中，系统管理员可以使用以下操作选项卡：

1) **禁用用户帐户**。

2) **显示激活链接** 显示租户管理员用户的激活链接。

3) **重新发送激活** 将帐户激活电子邮件重新发送到用户的邮箱。

4) **以租户管理员身份登录** 从租户管理员 UI 打开 Thingsboard 平台。

5) 系统管理员还可以从用户详细信息页面和租户管理员列表中 **删除用户**。

{% include images-gallery.html imageCollection="user-details-ce" %}

### 编辑租户或用户

在租户详细信息中，您可以编辑所有字段。

我们来看看如何做到这一点：

{% include images-gallery.html imageCollection="tenant-edit-ce" showListImageTitles="true" %}

此外，您还可以编辑 **用户**。

步骤与我们编辑租户的方式类似：

{% include images-gallery.html imageCollection="user-edit-ce" showListImageTitles="true" %}

### 删除租户或用户

您可以立即删除 **租户** 及其所有用户。为此，请点击“垃圾箱”图标，然后点击“是”确认删除。

{% include images-gallery.html imageCollection="tenant-delete-1-ce" %}

此外，还可以使用租户详细信息窗口中的操作选项卡删除用户。

{% include images-gallery.html imageCollection="tenant-delete-2-ce" %}

此外，您还可以从租户中删除任何 **用户**。为此，请转到租户，找到您需要的用户并点击“垃圾箱”图标。点击后，将出现一个警告窗口。如果您确定要删除用户，请点击“是”。

{% include images-gallery.html imageCollection="user-delete-ce" %}

此外，还可以使用租户详细信息窗口中的操作选项卡删除租户。

{% include images-gallery.html imageCollection="user-delete-2-ce" %}

### 以租户管理员身份登录

如果您需要以租户身份登录，只需打开租户组并点击用户帐户对面的图标即可以该租户身份登录。

{% include images-gallery.html imageCollection="tenant-login-ce" %}

租户管理员能够执行以下操作：

- 配置和管理 [设备](/docs/{{docsPrefix}}user-guide/ui/devices)。
- 配置和管理 [资产](/docs/{{docsPrefix}}user-guide/ui/assets)。
- 创建和管理 [客户](/docs/{{docsPrefix}}user-guide/ui/customers)。
- 创建和管理 [仪表板](/docs/{{docsPrefix}}user-guide/ui/dashboards)。
- 配置 [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)。
- 使用 [小部件库](/docs/{{docsPrefix}}user-guide/ui/widget-library) 添加或修改默认小部件。

可以使用 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 执行上面列出的所有操作。

### 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}