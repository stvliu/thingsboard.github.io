TBMQ 目前提供单层用户角色，即“管理员”。管理员有权创建、修改和删除用户帐户。

可以通过 TBMQ 的 Web UI 或 [REST API](/docs/mqtt-broker/user-management/) 执行用户管理，用户可以通过这些方式修改用户详细信息。

* TOC
{:toc}

### 添加用户

要添加新用户，请按照以下步骤操作：

1. 在左侧菜单中，单击“用户”，然后单击加号图标以创建新用户。
2. 提供用户的电子邮件地址，该地址在系统中必须是唯一的。名字、姓氏和描述字段是可选的。单击“添加”以创建用户。

{% include images-gallery.html imageCollection="add-user-broker" %}

请注意，所有新用户最初都使用默认密码 `sysadmin` 创建。首次登录时，用户将被要求更改默认密码。

### 编辑用户

要编辑现有管理员的详细信息，请按照以下步骤操作：

1. 在“用户”表中找到所需用户，然后单击相应行。
2. 单击“切换编辑模式”按钮以修改用户的姓名、姓氏或描述。
3. 单击“应用更改”按钮以保存所有修改。

{% include images-gallery.html imageCollection="edit-user-broker" %}

请注意，用户只能通过“个人资料”页面更改自己的电子邮件地址。

### 删除用户

已登录用户可以删除其他用户，但不能删除自己。要删除用户，请按照以下步骤操作：

1. 在“管理员”表中找到用户，然后单击相应行。
2. 单击“删除用户”按钮，然后选择“是”确认操作。

{% include images-gallery.html imageCollection="delete-user-broker" %}