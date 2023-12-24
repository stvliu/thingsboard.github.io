---
layout: docwithnav-paas
title: MQTT 集成
description: MQTT 集成指南
create_dashboard:
    0:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-1-paas.png
        title: '转到仪表板页面并创建一个名为 MQTT RPC 的新仪表板。打开此仪表板；'
    1:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-2-paas.png
        title: '通过单击右上角的实体别名图标添加别名。命名别名（例如，传感器），选择过滤器类型“单个实体”，类型“设备”，然后选择我们的 SN-001 传感器。按添加，然后按保存；'
    2:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-4-paas.png
        title: '现在添加新小部件；'
    3:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-5-paas.png
        title: '从下拉菜单中选择控制小部件；'
    4:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-6-paas.png
        title: '选择旋钮控制小部件；'
    5:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-7-paas.png
        title: '在数据字段中选择创建的别名（传感器）。将小数点后的位数设置为 0；'
    6:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-8-paas.png
        title: '转到高级选项卡，并将最小值设置为 15，最大值设置为 45。其余选项保持默认设置。单击添加以创建小部件；'
    7:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-new-dashboard-9-paas.png
        title: '保存对仪表板所做的更改。'

edit_rule_node:
    0:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-edit-message-type-switch-1-paas.png
    1:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-edit-message-type-switch-2-paas.png
    2:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-create-edit-message-type-switch-3-paas.png

incoming_messages:
    0:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-incoming-messages-2.png
    1:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-incoming-messages-3.png

add_rule_node:
    0:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-integration-downlink-node-1.png
    1:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-integration-downlink-node-2.png
    2:
        image: /images/user-guide/integrations/mqtt/mqtt-integration-integration-downlink-node-3.png

---
{% assign docsPrefix = "paas/" %}
{% include docs/pe/user-guide/integrations/mqtt.md %}