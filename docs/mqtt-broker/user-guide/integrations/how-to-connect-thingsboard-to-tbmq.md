---
layout: docwithnav-mqtt-broker
assignees:
- stitenko
title: 与 GridLinks 集成
description: TBMQ 与 GridLinks 的集成指南

create-client-credentials:
    0:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-add-client-credentials-1-pe.png
        title: '导航到“凭据”选项卡，单击表格右上角的“加号”图标；'
    1:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-add-client-credentials-2-pe.png
        title: '输入客户端凭据名称，选择客户端类型。启用“基本”身份验证类型。'
    2:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-add-client-credentials-3-pe.png
        title: '使用选定的值输入“用户名”和“密码”。例如，在用户名和密码字段中分别使用 `tb-pe` 和 `secret` 值。单击“添加”以保存凭据。'
    3:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-add-client-credentials-4-pe.png
        title: '创建新的客户端凭据。'

create-uplink-converter:
    0:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-uplink-converter-tbel-1-pe.png

create-integration:
    0:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-integration-add-integration-1-pe.png
        title: '转到“集成中心”部分 -> “集成”页面，然后单击“加号”图标以添加新的集成。将其命名为“MQTT 集成”，选择类型“MQTT”；'
    1:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-integration-add-integration-2-pe.png
        title: '添加最近创建的上行转换器；'
    2:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-integration-add-integration-3-pe.png
        title: '将“下行数据转换器”字段留空。单击“跳过”；'
    3:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-integration-add-integration-4-pe.png
        title: '指定 TBMQ 实例的主机和端口。选择“基本”凭据类型并指定 TBMQ 客户端凭据。添加主题过滤器：“tb/mqtt-integration-tutorial/sensors/+/temperature”，并选择高于 0 的 MQTT QoS 级别；'
    4:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-integration-add-integration-5-pe.png
        title: '现在转到高级设置。取消选中“清除会话”参数，并将客户端 ID 指定为 `tbpeintegration`；'
    5:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-integration-add-integration-6-pe.png
        title: '[可选] 单击检查连接按钮以检查与 TBMQ 的连接。单击添加按钮以创建集成。'

successful-connection-tbmq-to-thingsboard:
    0:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-sessions-1-pe.png
        title: '转到 TBMQ UI 中的“会话”页面。在 GridLinks 与 TBMQ 成功建立连接后，我们将看到一个新的会话及其状态 - “已连接”。'

tbmq-home-page:
    0:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-home-page-1-pe.png
        title: '在“主题”页面中，您将看到 Kafka 主题的名称（对应于 MQTT 集成中指定的客户端 ID）、分区数、复制因子和主题大小。'

tbmq-create-device:
    0:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-create-device-1-pe.png

tbmq-integration-events:
    0:
        image: /images/mqtt-broker/user-guide/integrations/how-to-connect-tbqm-to-thingsboard/tbmq-integration-events-1-pe.png

---

{% include /docs/mqtt-broker/user-guide/integrations/how-to-connect-thingsboard-to-tbmq.md %}