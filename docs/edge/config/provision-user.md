---
layout: docwithnav-edge
title: 用户访问管理
description: 用户访问管理

---

![image](/images/coming-soon.jpg)

### 用户访问管理

ThingsBoard Edge 用户访问管理取决于云版本。

#### ThingsBoard CE 用户访问管理
##### 租户管理员用户
ThingsBoard Edge 连接到 GridLinks CE 云后，每个租户管理员用户都将被转移到边缘，并且任何这些用户都能够登录到 GridLinks Edge UI。

租户管理员用户能够在边缘创建或删除设备。

租户管理员对边缘上可用的所有其他实体具有 **读取** 访问权限。

##### 客户用户
如果 **Edge** 实体已在云上分配给客户，那么每个客户用户实体都将被转移到边缘，并且任何这些用户都能够登录到 GridLinks Edge UI。

客户用户能够查看他可以在云上访问的边缘设备。

客户用户对分配给边缘的所有其他实体具有 **读取** 访问权限，并且他可以在云上访问这些实体。

### 后续步骤

{% assign currentGuide = "ProvisionUserFromCloudToEdge" %}
{% assign docsPrefix = "edge/" %}
{% include templates/edge/guides-banner-edge.md %}