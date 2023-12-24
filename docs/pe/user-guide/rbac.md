---
layout: docwithnav-pe
title: 高级基于角色的访问控制 (RBAC) 用于物联网设备和应用程序
description:
redirect_from: "/docs/user-guide/rbac/"

generic-roles-example-1:
    0:
        image: /images/user-guide/security/rbac/example-generic-roles-1-pe.png
        title: '创建通用角色（资源：全部，操作：全部）；'
    1:
        image: /images/user-guide/security/rbac/example-generic-roles-2-pe.png
        title: '通用角色已创建；'
    2:
        image: /images/user-guide/security/rbac/example-generic-roles-3-pe.png
        title: '转到“用户”页面并导航到“组”选项卡。然后单击租户 A 的“设备管理员”用户组对面的“实体组详细信息”图标；'
    3:
        image: /images/user-guide/security/rbac/example-generic-roles-4-pe.png
        title: '导航到实体组详细信息中的“角色”选项卡，然后单击“加号”图标；'
    4:
        image: /images/user-guide/security/rbac/example-generic-roles-5-pe.png
        title: '选择“通用”角色类型并指定先前创建的通用角色。单击“添加”；'
    5:
        image: /images/user-guide/security/rbac/example-generic-roles-6-pe.png
        title: '该角色已添加到租户 A 的“设备管理员”用户组。'

generic-roles-example-2:
    0:
        image: /images/user-guide/security/rbac/example-generic-roles-7-pe.png
        title: '转到“客户”页面，然后单击客户 B 对面的“管理客户用户”图标；'
    1:
        image: /images/user-guide/security/rbac/example-generic-roles-8-pe.png
        title: '导航到“组”选项卡。然后单击“设备管理员”用户组对面的“实体组详细信息”图标；'
    2:
        image: /images/user-guide/security/rbac/example-generic-roles-9-pe.png
        title: '导航到实体组详细信息中的“角色”选项卡，然后单击“加号”图标；'
    3:
        image: /images/user-guide/security/rbac/example-generic-roles-10-pe.png
        title: '选择“通用”角色类型并指定先前创建的通用角色。单击“添加”；'
    4:
        image: /images/user-guide/security/rbac/example-generic-roles-11-pe.png
        title: '该角色已添加到客户 B 的“设备管理员”用户组。'

generic-roles-example-3:
    0:
        image: /images/user-guide/security/rbac/example-generic-roles-12-pe.png
        title: '转到“用户”页面。单击租户 A 的“设备管理员”组中 Bob 用户帐户旁边的“以租户管理员身份登录”图标；'
    1:
        image: /images/user-guide/security/rbac/example-generic-roles-13-pe.png
        title: '导航到“实体”部分 -> “设备”页面。用户 Bob 可以访问两个设备：“设备 A1”和“设备 B1”。'

generic-roles-example-4:
    0:
        image: /images/user-guide/security/rbac/example-generic-roles-14-pe.png
        title: '转到租户 A 的“客户”页面。然后转到客户 B 的“管理客户用户”页面；'
    1:
        image: /images/user-guide/security/rbac/example-generic-roles-15-pe.png
        title: '单击用户 Alice 帐户对面的“以客户用户身份登录”图标；'
    2:
        image: /images/user-guide/security/rbac/example-generic-roles-16-pe.png
        title: '导航到“实体”部分 -> “设备”页面。用户 Alice 只可以访问一个设备“设备 B1”。'

group-roles-example-1:
    0:
        image: /images/user-guide/security/rbac/example-group-roles-1-pe.png
        title: '您有两个用户组：“楼宇 A 管理员”和“楼宇 B 管理员”；'
    1:
        image: /images/user-guide/security/rbac/example-group-roles-2-pe.png
        title: '您有两个设备组：“楼宇 A”，其中包含设备 A1，以及“楼宇 B”，其中包含设备 B1。'

group-roles-example-2:
    0:
        image: /images/user-guide/security/rbac/example-group-roles-3-pe.png
        title: '创建具有读/写操作的组角色；'
    1:
        image: /images/user-guide/security/rbac/example-group-roles-4-pe.png
        title: '组角色已创建。'

group-roles-example-3:
    0:
        image: /images/user-guide/security/rbac/example-group-roles-5-pe.png
        title: '转到“设备”页面并导航到“组”选项卡。然后单击您要向其添加组角色的设备组对面的“实体组详细信息”图标；'
    1:
        image: /images/user-guide/security/rbac/example-group-roles-6-pe.png
        title: '导航到实体组详细信息中的“权限”选项卡，然后单击“加号”图标；'
    2:
        image: /images/user-guide/security/rbac/example-group-roles-7-pe.png
        title: '指定创建的角色、用户组所有者，然后选择您要向其授予对设备组“楼宇 A”的访问权限的用户组。单击“添加”；'
    3:
        image: /images/user-guide/security/rbac/example-group-roles-8-pe.png
        title: '权限已分配。'

group-roles-example-4:
    0:
        image: /images/user-guide/security/rbac/example-group-roles-9-pe.png
        title: '单击您要向其添加角色的设备组“楼宇 B”对面的“实体组详细信息”图标；'
    1:
        image: /images/user-guide/security/rbac/example-group-roles-10-pe.png
        title: '导航到实体组详细信息中的“权限”选项卡，然后单击“加号”图标。指定创建的角色、用户组所有者，然后选择您要向其授予对设备组“楼宇 A”的访问权限的用户组。单击“添加”；'
    2:
        image: /images/user-guide/security/rbac/example-group-roles-11-pe.png
        title: '权限已分配。'

group-roles-example-5:
    0:
        image: /images/user-guide/security/rbac/example-group-roles-12-pe.png
        title: '单击用户 Alice 帐户对面的“以租户管理员身份登录”图标；'
    1:
        image: /images/user-guide/security/rbac/example-group-roles-13-pe.png
        title: '导航到“实体”部分 -> “设备”页面。您将只看到设备组“楼宇 A”，其中包含设备 A1。'

group-roles-example-6:
    0:
        image: /images/user-guide/security/rbac/example-group-roles-14-pe.png
        title: '以用户 Bob 身份登录。单击用户 Bob 帐户对面的“以租户管理员身份登录”图标；'
    1:
        image: /images/user-guide/security/rbac/example-group-roles-15-pe.png
        title: '导航到“实体”部分 -> “设备”页面。您将只看到设备组“楼宇 B”，其中包含设备 B1。'

supervisors-add-dashboard-group:
    0:
        image: /images/user-guide/security/rbac/supervisors-add-dashboard-group-1-pe.png
        title: '导航到“仪表板”页面中的“组”选项卡，然后单击“加号”图标以创建新的仪表板组。输入仪表板组的名称。在我们的案例中，它是“Supervisor Dashboards”。单击“添加”按钮；'
    1:
        image: /images/user-guide/security/rbac/supervisors-add-dashboard-group-2-pe.png
        title: '仪表板组“Supervisor Dashboards”已创建。'

supervisors-create-generic-role:
    0:
        image: /images/user-guide/security/rbac/supervisors-create-two-roles-1-pe.png
        title: '创建新的通用角色。填写所有必填字段，然后单击“添加”；'
    1:
        image: /images/user-guide/security/rbac/supervisors-create-two-roles-2-pe.png
        title: '新的通用角色已创建。'

supervisors-create-group-role:
    0:
        image: /images/user-guide/security/rbac/supervisors-create-two-roles-3-pe.png
        title: '创建新的组角色。填写所有必填字段，然后单击“添加”；'
    1:
        image: /images/user-guide/security/rbac/supervisors-create-two-roles-4-pe.png
        title: '新的组角色已创建。'

supervisors-assign-roles-to-supervisors-group:
    0:
        image: /images/user-guide/security/rbac/supervisors-assign-roles-to-supervisors-group-1-pe.png
        title: '导航到“用户”页面 -> “组”选项卡，然后单击屏幕右上角的加号（添加实体组）。输入名称 - “Supervisors”，然后单击“添加”按钮；'
    1:
        image: /images/user-guide/security/rbac/supervisors-assign-roles-to-supervisors-group-2-pe.png
        title: '用户组“Supervisors”已创建。单击它；'
    2:
        image: /images/user-guide/security/rbac/supervisors-assign-roles-to-supervisors-group-3-pe.png
        title: '单击“铅笔”图标以打开实体组详细信息。导航到“角色”选项卡，然后单击打开的菜单右上角的“加号”图标；'
    3:
        image: /images/user-guide/security/rbac/supervisors-assign-roles-to-supervisors-group-4-pe.png
        title: '选择角色类型 - “通用”，然后选择先前创建的角色 - “All Entities Read-only”。然后，单击“添加”；'
    4:
        image: /images/user-guide/security/rbac/supervisors-assign-roles-to-supervisors-group-5-pe.png
        title: '再次按“+”号。这次选择角色类型 - “组”，然后选择角色 - “实体组管理员”。对于组所有者，选择“租户”，对于实体类型，选择“仪表板”，然后选择实体组 - “Supervisor Dashboard”。单击“添加”；'
    5:
        image: /images/user-guide/security/rbac/supervisors-assign-roles-to-supervisors-group-6-pe.png
        title: '我们已将这些角色分配给 Supervisors 组。'

supervisors-add-new-user:
    0:
        image: /images/user-guide/security/rbac/supervisors-add-new-user-1-pe.png
        title: '导航到“客户”页面，然后单击屏幕右上角的“+”号（添加客户）。输入标题“楼宇 A”，然后单击“添加”；'
    1:
        image: /images/user-guide/security/rbac/supervisors-add-new-user-3-pe.png
        title: '单击“楼宇 A”客户对面的“管理客户用户”图标；'
    2:
        image: /images/user-guide/security/rbac/supervisors-add-new-user-4-pe.png
        title: '导航到“组”选项卡，然后单击“客户管理员”用户组；'
    3:
        image: /images/user-guide/security/rbac/supervisors-add-new-user-5-pe.png
        title: '单击屏幕右上角的“+”号。输入电子邮件地址，例如，我们可以使用 janesmith@thingsboard.io，然后单击“添加”；'
    4:
        image: /images/user-guide/security/rbac/supervisors-add-new-user-6-pe.png
        title: '在打开的窗口中，您可以看到用户激活链接，单击“确定”；'
    5:
        image: /images/user-guide/security/rbac/supervisors-add-new-user-7-pe.png
        title: '客户用户 Jane 已创建。'

supervisors-end-users:
    0:
        image: /images/user-guide/security/rbac/supervisors-end-users-1-pe.png
        title: '以客户用户 Jane Smith 身份登录；'
    1:
        image: /images/user-guide/security/rbac/supervisors-end-users-3-pe.png
        title: '转到“仪表板”页面，单击右上角的“加号”图标。选择“创建新仪表板”。输入仪表板名称（例如，“最终用户仪表板”）。单击“添加”以创建仪表板。'
    2:
        image: /images/user-guide/security/rbac/supervisors-end-users-4-pe.png
        title: '打开创建的仪表板并进入编辑模式；'
    3:
        image: /images/user-guide/security/rbac/supervisors-end-users-5-pe.png
        title: '单击“添加新小部件”按钮；'
    4:
        image: /images/user-guide/security/rbac/supervisors-end-users-6-pe.png
        title: '选择“卡片”小部件包；'
    5:
        image: /images/user-guide/security/rbac/supervisors-end-users-7-pe.png
        title: '选择“简单卡片”小部件；'
    6:
        image: /images/user-guide/security/rbac/supervisors-end-users-9-pe.png
        title: '在“数据源”部分中，选择类型为“函数”，键为“随机”。单击“添加”。'
    7:
        image: /images/user-guide/security/rbac/supervisors-end-users-10-pe.png
        title: '小部件已创建。保存仪表板。'

supervisors-create-read-only-user:
    0:
        image: /images/user-guide/security/rbac/supervisors-create-read-only-user-1-pe.png
        title: '在用户 Jane 的“用户”页面的“组”选项卡上选择“客户用户”；'
    1:
        image: /images/user-guide/security/rbac/supervisors-create-read-only-user-2-pe.png
        title: '单击屏幕右上角的“+”以添加新用户。输入电子邮件地址，例如，我们将使用 bob@thingsboard.io，然后单击“添加”；'
    2:
        image: /images/user-guide/security/rbac/supervisors-create-read-only-user-3-pe.png
        title: '在打开的窗口中，您可以看到用户激活链接，单击“确定”；'
    3:
        image: /images/user-guide/security/rbac/supervisors-create-read-only-user-5-pe.png
        title: '现在，单击创建的用户。在屏幕右上角，您将看到“钢笔”图标。单击它以进入编辑模式；'
    4:
        image: /images/user-guide/security/rbac/supervisors-create-read-only-user-6-pe.png
        title: '选中“始终全屏”框，并在“默认仪表板”行中选择“最终用户仪表板”。然后保存更改；'
    5:
        image: /images/user-guide/security/rbac/supervisors-create-read-only-user-7-pe.png
        title: '现在以客户用户 Bob 身份登录；'
    6:
        image: /images/user-guide/security/rbac/supervisors-create-read-only-user-8-pe.png
        title: '仪表板将全屏打开。用户 Bob 将无法访问左侧的管理面板。Bob 不允许执行任何服务器端 API 调用，只能浏览数据。'