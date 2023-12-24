---
layout: docwithnav-pe
assignees:
- ashvayka
title: MQTT 基本认证
description: ThingsBoard 基于 MQTT 的认证。
options:
    0:
        image: /images/user-guide/basic-mqtt/client-id.png  
        title: '如果指定正确的客户端 ID，MQTT 客户端将能够使用任何用户名或密码进行连接。'    
    1:
        image: /images/user-guide/basic-mqtt/username-password.png  
        title: '如果指定正确的用户名和密码，MQTT 客户端将能够使用任何客户端 ID 进行连接。'
    2:
        image: /images/user-guide/basic-mqtt/no-password-check.png  
        title: '密码是可选的'
    3:
        image: /images/user-guide/basic-mqtt/client-id-username-password.png  
        title: '如果指定正确的客户端 ID、用户名和密码组合，MQTT 客户端将能够连接'    
---

{% assign docsPrefix = "pe/" %}
{% include docs/user-guide/basic-mqtt.md %}