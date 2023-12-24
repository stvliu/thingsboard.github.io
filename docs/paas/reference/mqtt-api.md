---
layout: docwithnav-paas
assignees:
- ashvayka
title: MQTT 设备 API 参考
description: 物联网设备支持的 MQTT API 参考
redirect_from: "/docs/paas/reference/mqtt-api"

server-side-rpc:
    0:
        image: /images/reference/device-connectivity-apis/server-side-rpc-mqtt-1-paas.png
        title: '使用 RPC 调试终端仪表板'
    1:
        image: /images/reference/device-connectivity-apis/server-side-rpc-mqtt-2-paas.png
        title: '订阅来自服务器的 RPC 命令'
    2:
        image: /images/reference/device-connectivity-apis/server-side-rpc-mqtt-3-paas.png
        title: '向设备发送 RPC 请求“连接”'
    4:
        image: /images/reference/device-connectivity-apis/server-side-rpc-mqtt-4-paas.png
        title: '您应该收到来自设备的响应'

client-side-rpc:
    0:
        image: /images/reference/device-connectivity-apis/client-side-rpc-1-paas.png
        title: '向规则链添加两个节点：“脚本”和“rpc 调用回复”'
    1:
        image: /images/reference/device-connectivity-apis/client-side-rpc-2-paas.png
        title: '在脚本节点中输入函数：return {msg: {time:String(new Date())}, metadata: metadata, msgType: msgType};'
    2:
        image: /images/reference/device-connectivity-apis/client-side-rpc-3-paas.png
    3:
        image: /images/reference/device-connectivity-apis/client-side-rpc-mqtt-4-paas.png
        title: '向服务器发送请求'
    4:
        image: /images/reference/device-connectivity-apis/client-side-rpc-mqtt-5-paas.png
        title: '您应该收到来自服务器的响应'

---

{% assign docsPrefix = "paas/" %}
{% include docs/reference/mqtt-api.md %}