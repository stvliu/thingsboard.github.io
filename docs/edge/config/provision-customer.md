---
layout: docwithnav-edge
title: 从云端到边缘配置客户
description: 从云端到边缘配置客户

---

![image](/images/coming-soon.jpg)

### 用户访问管理

ThingsBoard Edge 用户访问管理取决于云版本。

#### ThingsBoard CE 用户访问管理

##### 租户管理员用户
一旦 ThingsBoard Edge 连接到 ThingsBoard CE 云，每个租户管理员用户都将被转移到边缘，并且任何这些用户都能够登录到 ThingsBoard Edge UI。

租户管理员用户能够在边缘创建或删除设备。

租户管理员对边缘上可用的所有其他实体具有 **读取** 访问权限。

##### 客户用户
如果 **边缘** 实体已在云端分配给客户，那么每个客户用户实体都将被转移到边缘，并且任何这些用户都能够登录到 ThingsBoard Edge UI。

客户用户能够查看他可以在云端访问的边缘设备。

客户用户对分配给边缘且他在云端具有访问权限的所有其他实体具有 **读取** 访问权限。

### 后续步骤

{% assign currentGuide = "ProvisionCustomerFromCloudToEdge" %}
{% assign docsPrefix = "edge/" %}
{% include templates/edge/guides-banner-edge.md %}