---
layout: docwithnav-pe
title: 水表计量解决方案模板
description: 水表计量模板概述
solution-highlights:
    0:
        image: /images/solutions/water_metering/water-metering-1.png
    1:
        image: /images/solutions/water_metering/water-metering-3.png
    2:
        image: /images/solutions/water_metering/water-metering-2.png
    3:
        image: /images/solutions/water_metering/water-metering-4.png
    4:
        image: /images/solutions/water_metering/water-metering-5.png


solution-alarms:
    0:
        image: /images/solutions/water_metering/alarm-rules-src.png
        title: '导航至“设备配置文件”。选择“水表”配置文件。打开“警报规则”选项卡。'
    1:
        image: /images/solutions/water_metering/alarm-settings-btn-src.png
        title: '导航至解决方案仪表板。单击“设置”按钮。'
    2:
        image: /images/solutions/water_metering/alarm-settings-src.png
        title: '启用或禁用警报并定义阈值。打开或关闭电子邮件或短信通知。'

rule-chains:
    0:
        image: /images/solutions/water_metering/rule-chains-1-src.png
        title: '主要解决方案规则链负责数据聚合和警报。有关创建的警报的消息将转发到通知规则链。'
    1:
        image: /images/solutions/water_metering/rule-chains-2-src.png
        title: '租户警报路由通过电子邮件或短信将通知转发给所有租户管理员（如果启用了相应设置）。'
    2:
        image: /images/solutions/water_metering/rule-chains-3-src.png
        title: '客户警报路由通过电子邮件或短信将通知转发给所有客户用户（如果启用了相应设置）。'

---

{% assign docsPrefix = "pe/" %}
{% include docs/pe/solution-templates/water-metering.md %}