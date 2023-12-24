* TOC
{:toc}

## 用户概述

GridLinks 平台上有三个级别的角色。可以在每个级别上创建一个用户。

这些角色如下：

1) **系统管理员**。系统管理员可以创建租户管理员用户。

2) **租户管理员**。租户管理员可以创建客户用户。

3) **客户用户**。客户用户具有读取权限，可以查看租户管理员分配的仪表板和其他实体。客户用户本身不会创建任何客户和子客户。

{% capture difference %}
**重要提示：**
<br>
在 Thingsboard 专业版中，客户可以创建其他客户用户和子客户。
{% endcapture %}
{% include templates/info-banner.md content=difference %}

以下说明概述了在每个级别上添加用户。

### 系统管理员

如果你是 **系统管理员**，你可以通过以下步骤在 [租户](/docs/{{docsPrefix}}user-guide/ui/tenants) 中创建用户。

1. 转到左侧菜单中的租户。导航到租户管理员，然后单击加号图标以添加新用户。

   ![image](/images/user-guide/ui/users/ce/tenant-user-add.png)

2. 在添加用户窗口中填写电子邮件并选择激活方法。
系统管理员还可以选择添加名称和说明。之后，单击添加。

   ![image](/images/user-guide/ui/users/ce/user-add-window.png)

3. 如果你选择了 **激活链接方法**，请单击箭头复制此链接并将其插入浏览器或用户使用的任何信使中。下面提供了一个激活链接的示例。

   ![image](/images/user-guide/ui/users/ce/user-activation-link.png)

4. 如果你选择了发送 **激活邮件选项**，那么你需要检查你的电子邮件信箱并找到有关 Thingsboard 帐户激活的消息。
单击激活你的帐户，然后按照简单的密码创建过程操作。

   ![image](/images/user-guide/ui/users/ce/account-activation-email.png)

{% capture difference %}
**注意：**
<br>
要接收来自 GridLinks 的电子邮件，你应该提前在系统管理员级别设置邮件服务器。
查看 [邮件设置](/docs/{{docsPrefix}}user-guide/ui/mail-settings) 说明。
{% endcapture %}
{% include templates/info-banner.md content=difference %}


创建用户后，系统管理员可以使用租户详细信息页面上的操作选项卡。

它们如下：

1) **禁用用户帐户**。

2) **显示激活链接** 将显示租户管理员用户的激活链接。

3) **重新发送激活** 将重新发送帐户激活电子邮件到用户的电子邮件信箱。

4) **以租户管理员身份登录** 从租户管理员 UI 打开 Thingsboard 平台。

5) 系统管理员还可以从租户用户列表中 **删除** 租户管理员。

   ![image](/images/user-guide/ui/users/ce/user-tenant-tabs.png)

当管理员单击禁用用户帐户时，他将在左上角看到一条消息，指出用户帐户已成功禁用，并且选项卡将更改为启用用户帐户。
请参见下图。

   ![image](/images/user-guide/ui/users/ce/user-account-disabled.png)

如果具有禁用帐户的用户尝试访问平台，他将看到以下错误消息。

   ![image](/images/user-guide/ui/users/ce/error-message.png)

同样，当管理员单击启用用户帐户时，他将在左上角看到一条消息，指出用户帐户已成功启用。选项卡将更改为禁用用户帐户。请参见下图。

   ![image](/images/user-guide/ui/users/ce/user-account-enabled.png)

### 租户管理员

作为 **租户管理员**，你可以使用以下步骤添加新用户。

1. 转到客户。导航到客户用户，然后单击加号图标以添加新用户。

   ![image](/images/user-guide/ui/users/ce/customer-user-add.png)

2. 务必在添加用户窗口中填写电子邮件并选择激活方法。
租户管理员可以选择添加名称和说明。完成后，单击添加。

   ![image](/images/user-guide/ui/users/ce/customer-user-add-window.png)

3. 创建用户后，租户管理员可以使用用户详细信息页面上的操作选项卡。

它们如下：

1) **禁用用户帐户**。上面已经提到如何禁用帐户。

2) **显示激活链接** 将显示客户用户的激活链接。

3) **重新发送激活** 将重新发送帐户激活电子邮件到用户的电子邮件信箱。

4) **以客户用户身份登录** 允许租户管理员从用户 UI 打开 Thingsboard 平台。

5) 租户管理员还可以从客户列表中 **删除客户用户**。


   ![image](/images/user-guide/ui/users/ce/customer-user-account-disable.png)

租户管理员可以选择分配默认仪表板并设置全屏模式，如下图所示。


   ![image](/images/user-guide/ui/users/ce/default-dashboard-assigned.png)

同样，租户管理员可以选择为客户用户分配主页仪表板并隐藏仪表板工具栏，如下图所示。


   ![image](/images/user-guide/ui/users/ce/home-dashboard-assigned.png) 

**重要提示：** 无需同时分配默认仪表板和主页仪表板，因为默认仪表板将是用户登录其帐户时看到的第一个仪表板。

如果出现任何问题，请单击右上角的问号。

### 客户用户 UI

#### 默认仪表板作为主页

当客户用户登录其帐户时，默认仪表板是他看到的第一个仪表板。如果租户管理员设置了全屏默认仪表板，则客户用户将看到没有左侧菜单的仪表板，如下例所示。
仪表板工具栏始终对用户可用，如果分配了另一个仪表板，他可以切换到另一个仪表板，并为自己设置实时范围。
此外，还有一个导出此仪表板的选项。

   ![image](/images/user-guide/ui/users/ce/default-dashboard.png) 


如果未选中全屏模式，客户用户可以在左侧菜单选项卡之间切换以查看租户管理员分配的所有资产、设备、实体、边缘和仪表板。
仪表板示例如下所示。

   ![image](/images/user-guide/ui/users/ce/default-dashboard-not-fullscreen-1.png) 


#### 主页仪表板作为主页

如果租户管理员将仪表板分配为主页仪表板，那么客户用户将在其主页上看到此仪表板。
如果选择了隐藏主页仪表板工具栏，那么客户用户将看到没有工具栏的主页仪表板。
禁用的工具栏的仪表板如下所示。

  ![image](/images/user-guide/ui/users/ce/home-dashboard-no-toolbar.png)    

带有启用工具栏的仪表板如下图所示。用户可以设置实时范围并导出仪表板。


   ![image](/images/user-guide/ui/users/ce/home-dashboard-toolbar.png)

客户用户还可以选择隐藏主页仪表板工具栏或在其个人资料设置中更改主页仪表板。
   
   ![image](/images/user-guide/ui/users/ce/profile-window.png)  

## 后续步骤

{% assign currentGuide = "ConnectYourDevice" %}{% include templates/multi-project-guides-banner.md %}