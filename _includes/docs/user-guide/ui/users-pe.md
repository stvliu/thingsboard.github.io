* TOC
{:toc}

## 简介

用户是能够登录 ThingsBoard Web 界面、执行 REST API 调用、访问设备、资产和其他实体（如果他们有权限这样做）的实体。
用户被分组到用户组中。
默认情况下，有两个自动生成的组：
[租户管理员](/docs/{{docsPrefix}}user-guide/ui/users/#tenant-administrator-user-group) 和 [租户用户](/docs/{{docsPrefix}}user-guide/ui/users/#tenant-user-user-group)。
租户管理员可以直接在自动生成的组中创建新用户，但请注意，他们将拥有创建他们的租户管理员的所有仪表板的访问权限。
此外，还有“全部”用户组。如果用户直接在“全部”组中创建，他将没有任何权限，也看不到任何内容。

{% include images-gallery.html imageCollection="users-intro-pe" showListImageTitles='true' %}

**注意**：必须使用 [系统管理员](/docs/{{docsPrefix}}user-guide/ui/tenants/) 帐户正确配置外发电子邮件设置。这是向新用户发送激活电子邮件所必需的。

## 用户组

用户组是具有相同权限的相同级别的用户组。一个用户可以同时属于多个用户组。

##### “租户管理员”用户组

在租户管理员组中创建的用户具有所有权限，例如查看、添加、编辑和删除实体。
让我们创建一个租户管理员，看看他能做什么。

{% include images-gallery.html imageCollection="user-bob-pe" showListImageTitles='true' %}

##### “租户用户”用户组

租户用户组具有只读权限。让我们创建一个租户用户，看看他能做什么。

{% include images-gallery.html imageCollection="user-alice-pe" showListImageTitles='true' %}

##### 添加新用户组

租户或客户管理员可以创建具有自定义权限的用户组。
创建一个用户组，并在用户组详细信息中的“角色”选项卡中添加先前创建的 [角色](/docs/{{docsPrefix}}user-guide/rbac/#roles)，以在新组中配置用户权限。

{% include images-gallery.html imageCollection="user-groups-pe" showListImageTitles='true' %}

## 编辑用户组

与任何实体组一样，用户组可以轻松自定义和编辑。
要编辑用户组，请单击用户组行以输入有关用户组的详细信息。

{% include images-gallery.html imageCollection="user-edit-pe" showListImageTitles='true' %}

了解有关 [单元格样式函数](/docs/{{docsPrefix}}user-guide/ui/advanced-data-key-configuration/#12-cell-style-function) 的更多信息。

了解有关 [操作](/docs/{{docsPrefix}}user-guide/ui/widget-actions/) 的更多信息。

## 删除用户组

具有足够权限的用户可以删除用户组。
请注意，属于该组的用户不会被删除。单个用户可以是多个用户组的成员，并且始终是特殊组“全部”的成员。

{% include images-gallery.html imageCollection="user-delete-pe" showListImageTitles='true' %}

##### 删除用户

在某些情况下，您在组中创建了多个用户，并且需要删除其中一个用户。

{% include images-gallery.html imageCollection="user-delete-1-pe" showListImageTitles='true' %}