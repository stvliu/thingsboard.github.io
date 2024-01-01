---
layout: docwithnav-edge
title: 边缘版本说明
description: GridLinks Edge 版本说明
---

* TOC
{:toc}

## v3.6.1（2023 年 11 月 14 日）{#v361}

**次要**版本，包含 [TB CE v3.6.1](/docs/reference/releases/#v361) 中的所有内容，并具有以下改进和错误修复：

* [#9226](https://github.com/thingsboard/thingsboard/pull/9226) 由 @AndriiLandiak 为 Edge 添加 TB 资源功能支持；
* [#9515](https://github.com/thingsboard/thingsboard/pull/9515) 由 @volodymyr-babak 将 EDGES_SLEEP_BETWEEN_BATCHES 的默认值增加，以处理 2G/3G 连接；

## v3.6.0（2023 年 9 月 22 日）{#v36}

**主要**版本，包含 [TB CE v3.6](/docs/reference/releases/#v36) 中的所有内容，并具有以下改进和错误修复：

* [#9087](https://github.com/thingsboard/thingsboard/pull/9087) 由 @AndriiLandiak 添加在边缘创建资产、仪表板、实体视图、资产配置文件、设备配置文件的可能性；
* [#9062](https://github.com/thingsboard/thingsboard/pull/9062) 由 @AndriiLandiak 将租户和租户配置文件实体推送到边缘；
* [#9052](https://github.com/thingsboard/thingsboard/pull/9052) 由 @AndriiLandiak 引入事件发布/订阅模型，用于检测实体中的更改；
* [#8830](https://github.com/thingsboard/thingsboard/pull/8830) 边缘事件表 - 由 @volodymyr-babak 添加顺序 ID 列，以正确处理重负载和集群案例；
* [#9245](https://github.com/thingsboard/thingsboard/pull/9245) 由 @deaflynx 和 @AndriiLandiak 提供适用于 ubuntu、centos 的边缘说明；

## v3.5.1.1（2023 年 7 月 4 日）{#v3511}

**热修复**版本，用于修复顺序 ID 偏移量的错误更新：

* [#57](https://github.com/thingsboard/thingsboard-edge/issues/57) GridLinks Edge PE 与云断开连接；
* [#60](https://github.com/thingsboard/thingsboard-edge/issues/60) 边缘错误日志；

## v3.5.1（2023 年 6 月 1 日）{#v351}

**次要**版本，包含 [TB CE v3.5.1](/docs/reference/releases/#v351) 中的所有内容。

## v3.5.0（2023 年 5 月 10 日）{#v35}

**主要**版本，包含 [TB CE v3.5](/docs/reference/releases/#v35) 中的所有内容，并具有以下改进和错误修复：

* [#7862](https://github.com/thingsboard/thingsboard/pull/7862) 将最新的时序键值对推送到边缘，以将实体分配给边缘；
* [#7878](https://github.com/thingsboard/thingsboard/pull/7878) 添加适用于 docker 的边缘安装说明；
* [#7914](https://github.com/thingsboard/thingsboard/pull/7914) 向资产/设备配置文件添加默认边缘规则链；
* [#8301](https://github.com/thingsboard/thingsboard/pull/8301) 边缘计算解决方案模板；
* [#8340](https://github.com/thingsboard/thingsboard/pull/8340) 处理超过默认最大消息大小的 gRPC 消息；
* [#8344](https://github.com/thingsboard/thingsboard/pull/8344) 将边缘连接/断开连接事件推送到规则链；
* [#8346](https://github.com/thingsboard/thingsboard/pull/8346) 改进边缘与云之间的保持活动功能，以防止数据丢失；

## v3.4.3（2022 年 12 月 22 日）

**次要**版本，包含 [TB CE v3.4.3](/docs/reference/releases/#v343-december-21-2022) 中的所有内容，并具有以下改进和错误修复：

* [#7093](https://github.com/thingsboard/thingsboard/pull/7093) 边缘同步功能 - 添加集群支持；
* [#7214](https://github.com/thingsboard/thingsboard/pull/7214) 在共享属性从边缘更新的情况下通知设备；
* [#7651](https://github.com/thingsboard/thingsboard/pull/7651) 在同时发生许多事件的情况下，更新边缘与云之间的同步稳定性；
* [#7792](https://github.com/thingsboard/thingsboard/pull/7792) 修复边缘根规则链更新。添加对 USER 实体的支持。将 INACTIVITY_TIMEOUT 推送到边缘；

## v3.4.1（2022 年 8 月 19 日）

**次要**版本，包含 [TB CE v3.4.1](/docs/reference/releases/#v341-august-18-2022) 中的所有内容，并具有以下改进和错误修复：

* [#6953](https://github.com/thingsboard/thingsboard/pull/6953) 在从边缘取消分配规则链期间检查丢失的边缘规则链；
* [#7044](https://github.com/thingsboard/thingsboard/pull/7044) 固件 ID 未从云同步到边缘的设备/设备配置文件；
* [#7095](https://github.com/thingsboard/thingsboard/pull/7095) 在同步完成后启动常规边缘事件进程；

## v3.4（2022 年 7 月 21 日）

包含 [TB CE v3.4](/docs/reference/releases/#v34-july-19-2022) 中的所有内容，并具有以下改进和错误修复：

* [#6781](https://github.com/thingsboard/thingsboard/pull/6781) 边缘 OTA 支持；
* [#6852](https://github.com/thingsboard/thingsboard/pull/6852) 队列 API 支持。

## v3.3.4.1（2022 年 5 月 2 日）

**热修复**版本，具有以下错误修复：
* 核心：
    * 修复仪表板加载小部件期间导致错误的重复系统小部件包的问题 [详细信息](https://github.com/thingsboard/thingsboard-edge/issues/5)

## v3.3.4（2022 年 3 月 24 日）

初始版本。