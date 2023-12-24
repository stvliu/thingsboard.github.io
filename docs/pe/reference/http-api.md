---
layout: docwithnav-pe
assignees:
- ashvayka
title: HTTP 设备 API 参考
description: 物联网设备支持的 HTTP API 参考
redirect_from: "/docs/pe/reference/http-api"

server-side-rpc:
    0:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-1-pe.png
        title: '使用 RPC 调试终端仪表板'
    1:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-2-pe.png
        title: '订阅来自服务器的 RPC 命令。为此，在第一个终端窗口中发送带有观察标志的 GET 请求'
    2:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-3-pe.png
        title: '向设备发送 RPC 请求“连接”'
    3:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-4-pe.png
        title: '在第二个终端窗口中模拟从设备向服务器发送响应'
    4:
        image: /images/reference/device-connectivity-apis/server-side-rpc-http-5-pe.png
        title: '您应该收到来自设备的响应：{"result":"ok"}'

client-side-rpc:
    0:
        image: /images/reference/device-connectivity-apis/client-side-rpc-1-pe.png
        title: '向规则链添加两个节点：“脚本”和“rpc 调用回复”'
    1:
        image: /images/reference/device-connectivity-apis/client-side-rpc-2-pe.png
        title: '在脚本节点中输入函数：return {msg: {time:String(new Date())}, metadata: metadata, msgType: msgType};'
    2:
        image: /images/reference/device-connectivity-apis/client-side-rpc-3-pe.png
    3:
        image: /images/reference/device-connectivity-apis/client-side-rpc-http-4-pe.png
        title: '向服务器发送请求'
    4:
        image: /images/reference/device-connectivity-apis/client-side-rpc-http-5-pe.png
        title: '您应该收到来自服务器的响应'

---

{% assign docsPrefix = "pe/" %}
{% include docs/reference/http-api.md %}