---
layout: docwithnav-gw
title: 如何使用内置 GET/SET RPC 方法
description: 如何使用内置 GET/SET RPC 方法

---

* TOC
{:toc}


本指南将帮助您使用 OPC-UA Connector 示例的内置 GET/SET RPC 方法。


每个遥测和属性参数都开箱即用地具有 **GET** 和 **SET** RPC 方法，因此您无需手动配置它。
例如，如果您有一些遥测参数：
```json
"timeseries": [
  {
    "key": "temperature",
    "path": "${ns=3;i=1001}"
  }
]
```
要获取温度遥测的当前值：
```bash
get ns=3;i=1001
```
响应：
```json
{"get": 25.34, "code": 200}
```

要设置温度遥测值：
```bash
set ns=3;i=1001 23
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-rpc-1.png)
{: refdef}
<br>
要为 **“model”** 属性设置新值 (T3000)，请运行查询：
```bash
set ns=3;i=1008; T3000
```

响应：
```json
{"success":"true","code": 200}
```

{:refdef: style="text-align: left;"}
![image](/images/gateway/gateway-opc-ua-rpc-2.png)
{: refdef}