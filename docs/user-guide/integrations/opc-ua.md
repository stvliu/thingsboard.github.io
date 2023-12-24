---
layout: docwithnav-pe
title: OPC-UA 集成
description: OPC-UA 集成指南

create_rule_chain:
    0:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-1.png
        title: '下载 airconditioners.json 文件。转到规则链页面。要导入此 JSON 文件，请单击规则链页面右下角的 + 按钮，然后选择导入规则链。'
    1:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-2.png
        title: '双击集成下行链路节点。'    
    2:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-3.png
        title: '在集成字段中选择 OPC-UA 集成。'
    3:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-4.png
        title: '保存所有更改。'

create_rule_chain_2:
    0:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-5.png
        title: '打开根规则链。'
    1:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-7.png
        title: '查找规则链节点，将其拖放到规则链中。将其命名为空调，选择我们的空调规则链，然后单击添加。'
    2:
        image: /images/user-guide/integrations/opc-ua/opc-ua-rule-chain-8.png
        title: '点击消息类型开关节点的右侧灰色圆圈，并将此圆圈拖动到规则链节点的左侧，此处让我们选择已更新的属性、发布遥测和对设备的 RPC 请求。然后点击添加并保存规则链。'

---
{% assign docsPrefix = "pe/" %}
{% include docs/pe/user-guide/integrations/opc-ua.md %}