---
layout: docwithnav
assignees:
- ashvayka
title: 演示帐户
description: GridLinks 默认演示帐户

---

* TOC
{:toc}

GridLinks 安装包含用于示例应用程序的单租户帐户，并包含大量预置实体以供演示。

## 系统管理员

默认系统管理员帐户：

- 登录 - **sysadmin@gridlinks.com**。
- 密码 - **sysadmin**。

## 演示租户

默认租户管理员帐户：

- 登录 - **tenant@gridlinks.com**。
- 密码 - **tenant**。

演示租户客户：

- 客户 A 用户 - **customer@gridlinks.com** 或 **customerA@gridlinks.com**。
- 客户 B 用户 - **customerB@gridlinks.com**。
- 客户 C 用户 - **customerC@gridlinks.com**。
- 所有用户都有 **“customer”** 密码。

## 租户设备

- 测试设备 A1、A2、A3 - 属于客户 A。访问令牌：A1_TEST_TOKEN、A2_TEST_TOKEN 和 A3_TEST_TOKEN。
- 测试设备 B1 - 属于客户 B。访问令牌：B1_TEST_TOKEN。
- 测试设备 C1 - 属于客户 C。访问令牌：C1_TEST_TOKEN。

- DHT11 演示设备 - 创建用于温度和湿度上传 [示例应用程序](/docs/samples/nodemcu/temperature/)。
访问令牌：DHT11_DEMO_TOKEN
- Raspberry Pi 演示设备 - 创建用于 GPIO 控制 [示例应用程序](/docs/samples/raspberry/gpio/)。
访问令牌：RASPBERRY_PI_DEMO_TOKEN

## 仪表板

- 温度和湿度演示仪表板 - 创建用于温度和湿度上传 [示例应用程序](/docs/samples/nodemcu/temperature/)。
- Raspberry PI GPIO 演示仪表板 - 创建用于 Raspberry Pi GPIO 控制 [示例应用程序](/docs/samples/raspberry/gpio/)。

## 规则链
有一个预定义的规则链，用于存储所有传入遥测和属性更新。所有其他传入请求都已记录。
有关添加其他规则节点（如发送电子邮件、创建警报等），请阅读相关文章：

- [规则引擎入门](/docs/user-guide/rule-engine-2-0/re-getting-started/)
- [规则引擎概述](/docs/user-guide/rule-engine-2-0/overview/)
- [规则引擎教程](/docs/user-guide/rule-engine-2-0/overview/#tutorials)