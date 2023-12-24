---
layout: docwithnav-paas
assignees:
- ashvayka
title: 基于 X.509 证书的身份验证
description: ThingsBoard 基于 X.509 证书的物联网设备和项目身份验证。

---

{% assign docsPrefix = "paas/" %}


X.509 证书用于为 MQTT over TLS 设置[相互](https://en.wikipedia.org/wiki/Mutual_authentication)（双向）身份验证。
它类似于[访问令牌](/docs/{{docsPrefix}}user-guide/access-token/)身份验证，但使用 X.509 证书代替令牌。

以下说明将介绍如何使用 X.509 证书将 MQTT 客户端连接到 ThingsBoard Cloud。

<br>具体来说，有两种策略可用于在客户端和 ThingsBoard 之间建立连接：

- **X.509 证书链** - *推荐*。<br>
  将 ThingsBoard 配置为信任来自特定信任锚点（*中间证书*）的所有客户端证书。
  设备名称会使用可配置的正则表达式从证书公用名中自动发现。
  此功能消除了证书轮换发生时在每个设备上进行手动证书更新的需要。
  此外，如果在配置中启用了*创建新设备*，它还允许通过 MQTT 自动配置新设备。
- **X.509 证书。** <br> 将 ThingsBoard 配置为使用预配置的客户端证书接受来自特定设备的连接。

{% capture contenttogglespecx509 %}
X.509 证书链 <small>(推荐)</small>%,%x509Chain%,%templates/ssl/certificates-chain.md%br%
X.509 证书%,%X509Leaf%,%templates/ssl/certificates-leaf.md%br%{% endcapture %}

{% include content-toggle.html content-toggle-id="ubuntuThingsboardX509" toggle-spec=contenttogglespecx509 %}