---
layout: docwithnav-pe 
title: ChirpStack 集成 
description: ChirpStack 集成指南 

uplink:
    0:
        image: /images/chirpstack/create-uplink.png
        title: 创建上行转换器

api-keys:
    0:
        image: /images/chirpstack/chirpstack-api-keys.png
        title: 打开 API 密钥
    1:
        image: /images/chirpstack/chirpstack-api-keys-2.png
        title: 创建 API 密钥
    2:
        image: /images/chirpstack/chirpstack-api-keys-3.png
        title: 复制创建的 API 密钥

integration:
    0:
        image: /images/chirpstack/create-integration.png
        title: 创建集成

chirpstack_integration:
    0:
        image: /images/chirpstack/chirpstack-create-integration.png
        title: 创建集成

    1:
        image: /images/chirpstack/chirpstack-integration-created.png
        title: 设置集成名称和端点 URL

uplink_message:
    0:
        image: /images/chirpstack/integration-uplink-message-event.png

device_groups:
    0:
        image: /images/chirpstack/groups-created-device.png
        title: 设备 **Device_1** 已创建 

uplink_events:
    0:
        image: /images/chirpstack/converter-in-event.png
        title: ChirpStack 到转换器的传入数据示例
    1:
        image: /images/chirpstack/converter-out-event.png
        title: 转换器发出的传出数据示例 

downlink:
    0:
        image: /images/chirpstack/create-downlink.png

downlink_rule_chain:
    0:
        image: /images/chirpstack/import-downlink-rule-chain.png
        title: 导入下行规则链 
    1:
        image: /images/chirpstack/imported-rule-chain.png
        title: 按下铅笔打开集成下行规则节点配置
    2:
        image: /images/chirpstack/edit-integration-downlink-rule-node.png
        title: 从列表中选择集成，按下保存规则节点 
    3:
        image: /images/chirpstack/save-rule-chain.png
        title: 按下复选标记保存规则链

root_rule_chain:
    0:
        image: /images/chirpstack/add-check-relation-node.png
        title: 添加检查关系规则节点
    1:
        image: /images/chirpstack/configure-check-relation-node.png
        title: 配置检查关系规则节点
    2:
        image: /images/chirpstack/add-rule-chain-node.png
        title: 添加规则链规则节点，设置新导入的规则链，按下铅笔图标保存
    3:
        image: /images/chirpstack/add-relation-to-rule-chain-node.png
        title: 从检查关系规则节点向规则链节点添加 **“True”** 关系
    4:
        image: /images/chirpstack/save-root-rule-chain.png
        title: 保存根规则链
                                
shared_attributes:
    0:
        image: /images/chirpstack/shared-attribute-downlink.png

downlink_events:
    0:
        image: /images/chirpstack/event_in.png
        title: 下行转换器输入示例
    1:
        image: /images/chirpstack/event_out.png
        title: 下行转换器输出示例

downlink_integration_event:
    0:
        image: /images/chirpstack/downlink-event.png
---
{% assign docsPrefix = "pe/" %}
{% include docs/pe/user-guide/integrations/chirpstack.md %}