* TOC
{:toc}

### 简介

ThingsBoard 开箱即用，支持 [多租户](https://en.wikipedia.org/wiki/Multitenancy)。

您可以将 ThingsBoard 租户视为一个独立的业务实体。这是拥有或制造设备和资产的个人或组织。

{% if docsPrefix == "pe/" %}
租户可能有多个租户管理员用户、大量 [客户](/docs/{{docsPrefix}}user-guide/ui/customers) 以及无限数量的 [用户](/docs/{{docsPrefix}}user-guide/ui/users)、资产和设备。
{% endif %}
{% if docsPrefix == "paas/" %}
租户可能有多个 [客户](/docs/{{docsPrefix}}user-guide/ui/customers) 和大量 [用户](/docs/{{docsPrefix}}user-guide/ui/users)、设备和资产。
{% endif %}

{% if docsPrefix == "pe/" %}
### 创建新租户

**系统管理员** 能够创建租户实体。

要添加新租户，您应该：

{% include images-gallery.html imageCollection="tenants-pe" showListImageTitles="true" %}

在此 [处](/docs/{{docsPrefix}}user-guide/tenant-profiles) 了解有关租户配置文件的更多信息。

### 创建租户管理员

系统管理员可以为每个租户创建多个 **具有租户管理员角色的用户**。

要添加用户，您应该：

{% include images-gallery.html imageCollection="tenant-new-pe" showListImageTitles="true" %}

租户可以有多个用户。

{% include images-gallery.html imageCollection="multiple-users-pe" %}

### 编辑租户或用户

在租户详细信息中，您可以编辑所有字段。

让我们看看如何做到这一点：

{% include images-gallery.html imageCollection="tenant-edit-pe" showListImageTitles="true" %}

此外，您还可以编辑 **用户**。

步骤与我们编辑租户的方式类似：

{% include images-gallery.html imageCollection="user-edit-pe" showListImageTitles="true" %}

### 删除租户或用户

您可以一次删除 **租户** 及其所有用户。为此，请单击“垃圾箱”图标，然后单击“是”确认删除。

{% include images-gallery.html imageCollection="tenant-delete-pe" %}

此外，您还可以从租户中删除任何 **用户**。为此，请转到租户，找到您需要的用户，然后单击“垃圾箱”图标。单击后，将出现一个警告窗口。如果您确定要删除用户，请单击“是”。

{% include images-gallery.html imageCollection="user-delete-pe" %}

### 以租户管理员身份登录

如果您需要以租户身份登录，只需打开租户组，然后单击用户帐户对面的图标即可以该租户身份登录。

{% include images-gallery.html imageCollection="tenant-login-pe" %}
{% endif %}

<br>
租户管理员能够执行以下操作：

- 配置和管理 [设备](/docs/{{docsPrefix}}user-guide/ui/devices/)。
- 配置和管理 [资产](/docs/{{docsPrefix}}user-guide/ui/assets/)。
- 创建和管理 [客户](/docs/{{docsPrefix}}user-guide/ui/customers/)。
- 创建和管理 [仪表板](/docs/{{docsPrefix}}user-guide/ui/dashboards/)。
- 配置 [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)。
- 使用 [小部件库](/docs/{{docsPrefix}}user-guide/ui/widget-library/) 添加或修改默认小部件。

可以使用 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 执行上面列出的所有操作。