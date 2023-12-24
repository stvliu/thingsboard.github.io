* TOC
{:toc}

## 简介

客户可以是独立的业务实体：个人或购买或使用租户设备和/或资产的组织。客户也可以是租户组织内的部门。

客户用户属于客户，并具有读取权限，可以查看租户管理员分配的仪表板和其他实体。
在 Thingsboard 社区版中，客户用户无法创建自己的客户、用户或子客户。

{% capture difference %}
**重要提示：**
<br>
在 **Thingsboard 专业版** 中，客户用户可以创建其他客户、用户和子客户。
要试用此功能，请使用 [GridLinks Cloud](https://gridlinks.codingas.com/signup) 服务器。
另一种选择是使用此 [安装指南](/docs/user-guide/install/pe/installation-options/) 在本地安装 GridLinks
{% endcapture %}
{% include templates/info-banner.md content=difference %}

[租户管理员](/docs/{{docsPrefix}}user-guide/ui/tenants/) 可以创建客户，并可以通过单击相关选项卡，直接从客户详细信息页面管理其 [资产](/docs/{{docsPrefix}}user-guide/ui/assets/)、[设备](/docs/{{docsPrefix}}user-guide/ui/devices/)、[仪表板](/docs/{{docsPrefix}}user-guide/dashboards/) 和 [边缘](/docs/edge/)。

## 创建新客户

租户管理员可以使用以下步骤添加新客户。

{% include images-gallery.html imageCollection="add-new-customer" showListImageTitles="true" %}

## 创建客户用户

租户管理员可以使用以下步骤添加客户用户。

{% include images-gallery.html imageCollection="add-customer-user" showListImageTitles="true" %}

## 编辑客户

租户管理员可以编辑标题，指定主页仪表板，并编辑客户的其余字段。让我们看看如何做到这一点：

{% include images-gallery.html imageCollection="edit-customer" showListImageTitles="true" %}

此外，您还可以编辑客户用户信息。

步骤与我们编辑客户的方式类似：

{% include images-gallery.html imageCollection="edit-customer-user" showListImageTitles="true" %}

## 删除客户或客户用户

租户管理员可以使用以下方式之一删除客户及其所有客户用户：

第一种方式：

{% include images-gallery.html imageCollection="delete-customer" showListImageTitles="true" %}

第二种方式：

{% include images-gallery.html imageCollection="delete-customer-2" showListImageTitles="true" %}

您还可以一次删除多个客户。

{% include images-gallery.html imageCollection="delete-customer-3" showListImageTitles="true" %}

此外，您还可以从客户中删除任何客户用户。步骤与删除客户时相同。

{% include images-gallery.html imageCollection="delete-customer-user-1" showListImageTitles="true" %}

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}