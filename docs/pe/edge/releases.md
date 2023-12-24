---
layout: docwithnav-pe-edge
title: Edge 版本说明
description: ThingsBoard Edge 版本说明

---

* TOC
{:toc}

## v3.6.1（2023 年 11 月 14 日）{#v361}

**次要**版本，包含 [TB Edge v3.6.1](/docs/edge/releases/#v361) 和 [TB PE v3.6.1](/docs/pe/reference/releases/#v361) 中的所有内容。

## v3.6.0（2023 年 9 月 22 日）{#v36}

**主要**版本，包含 [TB Edge v3.6](/docs/edge/releases/#v36) 和 [TB PE v3.6](/docs/pe/reference/releases/#v36) 中的所有内容。

## v3.5.1.1（2023 年 7 月 4 日）{#v3511}

**热修复**版本，修复顺序 ID 偏移量的错误更新：

* [#57](https://github.com/thingsboard/thingsboard-edge/issues/57) ThingsBoard Edge PE 与云断开连接；
* [#60](https://github.com/thingsboard/thingsboard-edge/issues/60) 边缘错误日志；

## v3.5.1（2023 年 6 月 1 日）{#v351}

**次要**版本，包含 [TB Edge v3.5.1](/docs/edge/releases/#v351) 和 [TB PE v3.5.1](/docs/pe/reference/releases/#v351) 中的所有内容。

## v3.5.0（2023 年 5 月 10 日）{#v35}

**主要**版本，包含 [TB Edge v3.5](/docs/edge/releases/#v35) 和 [TB PE v3.5](/docs/pe/reference/releases/#v35) 中的所有内容，并具有以下改进和错误修复：

* 边缘计算支持解决方案模板；

## v3.4.3（2022 年 12 月 22 日）

**次要**版本，包含 [TB Edge v3.4.3](/docs/edge/releases/#v343-december-22-2022) 和 [TB PE v3.4.3](/docs/pe/reference/releases/#v343-december-21-2022) 中的所有内容，并具有以下改进和错误修复：

* 客户层级支持（部分支持 - 仅限边缘所有者的直接父级）；
* 实时同步 WhiteLabeling、LoginWhiteLabeling 和 CustomTranslation 到边缘；
* 修复边缘所有者为客户时同步过程中的 NPE；
* Integration/Converter/Role 构造函数 - 修复附加信息为 null 时出现的空指针异常；

## v3.4.1（2022 年 8 月 19 日）

**次要**版本，包含 [TB Edge v3.4.1](/docs/edge/releases/#v341-august-19-2022) 和 [TB PE v3.4.1](/docs/pe/reference/releases/#v341-august-18-2022) 中的所有内容，并具有以下改进和错误修复：

* 修复 OPC-UA 集成中的启动问题和连接泄漏；

## v3.4（2022 年 7 月 21 日）

包含 [TB Edge v3.4](/docs/edge/releases/#v34-july-21-2022) 和 [TB PE v3.4](/docs/pe/reference/releases/#v34-july-19-2022) 中的所有内容，并具有以下改进和错误修复。

* 集成和转换器支持。

## v3.3.4.1（2022 年 5 月 2 日）

**热修复**版本，具有以下错误修复：
* 核心：
    * 修复仪表板加载小部件期间导致错误的重复系统小部件包问题 [详细信息](https://github.com/thingsboard/thingsboard-edge/issues/5)

## v3.3.4（2022 年 3 月 24 日）

次要版本，具有以下改进和错误修复：

**改进**：
* 支持 3.3.4.1 版本的最新功能
   * CE [3.3.4.1 版本说明](https://thingsboard.io/docs/reference/releases/#v3341-march-22-2022)
   * PE [3.3.4.1 版本说明](https://thingsboard.io/docs/pe/reference/releases/#v3341-march-18-2022)
* 修复在互联网连接缓慢或受限的情况下许可证检查不正确的问题

## v3.3.3（2022 年 1 月 28 日）

次要版本，具有以下改进和错误修复：

**改进**：
 * 支持 3.3.3 版本的最新功能
   * CE [3.3.3 版本说明](https://thingsboard.io/docs/reference/releases/#v333-january-27-2022)
   * PE [3.3.3 版本说明](https://thingsboard.io/docs/pe/reference/releases/#v333-january-27-2022)
 * 边缘使用云上所有者的登录白标配置，而不是系统

**错误修复**：
 * 修复边缘到云的重复属性请求
 * 修复已部署消息的显示不正确
 * 修复边缘客户所有者具有所有资源时的异常
 * 修复边缘上没有可用实体时处理关系的错误
 * 修复从云到边缘的单向/双向 RPC 调用

## v3.3（2021 年 8 月 17 日）

初始版本。