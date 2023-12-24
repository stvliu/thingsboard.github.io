---
layout: docwithnav-pe
assignees:
- ashvayka
title: 租户配置文件
description: IoT 租户配置文件
redirect_from: "/docs/pe/user-guide/ui/tenant-profiles"
entityLimits:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-pe-tenant-profiles-entity-limits.png  

apiLimitsDashboard:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-pe-tenant-profiles-api-limits-dashboard.png  

rateLimits:
    0:
        image: /images/user-guide/tenant-profile/thingsboard-pe-rate-limits.png  

isolatedQueueConfiguration:
    0:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-1-pe.png
        title: '步骤 1. 打开租户配置文件菜单并添加新的租户配置文件。单击“隔离的 GridLinks RuleEngine”框，默认添加主队列，且无法重命名或删除。'
    1:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-2-pe.png
        title: '步骤 2. 如果需要添加新的自定义队列，请单击“添加队列”。'
    2:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-3-pe.png
        title: '步骤 3. 配置提交和处理设置。'
    3:
        image: /images/user-guide/tenant-profile/queue-tenant-profile-4-pe.png
        title: '步骤 4. 现在，租户配置文件已准备好为特定租户分配。'
---

{% assign docsPrefix = "pe/" %}
{% include docs/user-guide/tenant-profiles.md %}