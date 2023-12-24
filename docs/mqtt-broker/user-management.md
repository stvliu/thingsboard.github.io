---
layout: docwithnav-mqtt-broker
title: 用户管理
description: 用户管理指南

---

* TOC
{:toc}

默认情况下，系统最初建立时只有一个管理员用户，用户名为 **sysadmin@gridlinks.com**，密码为 **sysadmin**。

但是，在生产环境中运行时，强烈建议创建一个新的管理员用户，完全删除默认用户或修改上述用户关联的密码。

在整个文档中，所有提供的示例都将使用 **curl** 命令来执行 REST 请求，从而展示 API 交互的实际实现。

{% include templates/mqtt-broker/authentication.md %}

##### 获取所有用户

```bash
curl --location --request GET "http://localhost:8083/api/admin?pageSize=50&page=0" \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}

在系统中，每个用户实体都拥有一个称为 **id** 的独特标识符。此 id 用作参考点，可用于执行诸如 _更新_ 或 _删除_ 用户的操作。

##### 创建/更新用户

```bash
curl --location --request POST 'http://localhost:8083/api/admin' \
--header "X-Authorization: Bearer $ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "id":$USER_ID,
    "email":"test@gmail.com",
    "password":"test",
    "firstName":"test",
    "lastName":"test"
}'
```
{: .copy-code}

如果 _$USER_ID_ 为 _null_ 或请求正文中没有 _id_ 字段，则将创建新的管理员用户，否则将更新具有 _$USER_ID_ 标识符的用户。

##### 删除用户

```bash
curl --location --request DELETE 'http://localhost:8083/api/admin/$USER_ID' \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}

粘贴要删除的用户的实际 ID，而不是 _$USER_ID_。