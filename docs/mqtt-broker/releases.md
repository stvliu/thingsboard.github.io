---
layout: docwithnav-mqtt-broker
title: TBMQ 发行说明
description: TBMQ 发行版

---

* TOC
{:toc}

## v1.2.1（2023 年 12 月 13 日）

次要版本，具有以下功能和改进。

**主要功能：**

* [#84](https://github.com/thingsboard/tbmq/pull/84) MQTT 5：有效负载格式和内容类型；
* [#86](https://github.com/thingsboard/tbmq/pull/86) 客户端会话限制。

**改进：**

* 核心和安装脚本：

  * [#87](https://github.com/thingsboard/tbmq/pull/87) 安装脚本增强。

## v1.2.0（2023 年 11 月 21 日）

次要版本，具有以下功能、改进和错误修复。

**主要功能：**

* [#73](https://github.com/thingsboard/tbmq/pull/73) Redis 缓存支持；
* [#76](https://github.com/thingsboard/tbmq/pull/76) 客户端会话高级过滤；
* [#12aac735e7](https://github.com/thingsboard/tbmq/commit/12aac735e7) MQTT 客户端凭据高级过滤；
* [#80](https://github.com/thingsboard/tbmq/pull/80) 共享订阅管理。

**改进：**

* 核心：

  * [性能改进](/docs/mqtt-broker/reference/3m-throughput-single-node-performance-test/) 用于消息处理。请参阅：
  [#e0c66d3052](https://github.com/thingsboard/tbmq/commit/e0c66d3052)，[#03409f7f18](https://github.com/thingsboard/tbmq/commit/03409f7f18)，[#a1dd722deb](https://github.com/thingsboard/tbmq/commit/a1dd722deb)，
  [#3af40bb504](https://github.com/thingsboard/tbmq/commit/3af40bb504)，[#55ff71bea8](https://github.com/thingsboard/tbmq/commit/55ff71bea8)，
  [#5f11148025](https://github.com/thingsboard/tbmq/commit/5f11148025)，[#79db26751c](https://github.com/thingsboard/tbmq/commit/79db26751c) 提交；
  * [#d437200ba1](https://github.com/thingsboard/tbmq/commit/d437200ba1) 在发送给订阅者之前添加缓冲消息的可能性；
  * [#a091e31963](https://github.com/thingsboard/tbmq/commit/a091e31963) 删除 Kafka 消费者组 API。

* UI：

  * [#78](https://github.com/thingsboard/tbmq/pull/78) 迁移到 Angular 15；
  * [#9231eaafc9](https://github.com/thingsboard/tbmq/commit/9231eaafc9) 添加了 Kafka 管理页面；
  * [#25289016b5](https://github.com/thingsboard/tbmq/commit/25289016b5) 侧边栏菜单优化；
  * [#7a685d5e00](https://github.com/thingsboard/tbmq/commit/7a685d5e00) 添加了断开连接/删除多个客户端会话的选项；
  * [#ed1f9ffd39](https://github.com/thingsboard/tbmq/commit/ed1f9ffd39) 共享订阅的管理；
  * [#06b881694f](https://github.com/thingsboard/tbmq/commit/06b881694f) 共享订阅高级过滤；
  * [#6b1ee03d8d](https://github.com/thingsboard/tbmq/commit/6b1ee03d8d)，[#7a685d5e00](https://github.com/thingsboard/tbmq/commit/7a685d5e00) 客户端会话高级过滤；
  * [#f229a35c5d](https://github.com/thingsboard/tbmq/commit/f229a35c5d)，[#38532959f5](https://github.com/thingsboard/tbmq/commit/38532959f5) MQTT 客户端凭据高级过滤；
  * [#3334cb4666](https://github.com/thingsboard/tbmq/commit/3334cb4666)，[#c42b8f3b63](https://github.com/thingsboard/tbmq/commit/c42b8f3b63) 创建客户端凭据的新表单；
  * [#7ba4996cbe](https://github.com/thingsboard/tbmq/commit/7ba4996cbe) 为会话和客户端凭据添加了主页上的筛选按钮；
  * [#971cdb8b27](https://github.com/thingsboard/tbmq/commit/971cdb8b27)，[#9ff6a349d6](https://github.com/thingsboard/tbmq/commit/9ff6a349d6) 在创建客户端凭据后添加了检查连接窗口；
  * [#702e98b673](https://github.com/thingsboard/tbmq/commit/702e98b673)，[#f7efffbe42](https://github.com/thingsboard/tbmq/commit/f7efffbe42) 主页上的入门指南更新；
  * [#7019da05ff](https://github.com/thingsboard/tbmq/commit/7019da05ff)，[#340853add6](https://github.com/thingsboard/tbmq/commit/340853add6) 监控图表次要更新。

**错误修复：**

* 核心：

  * [#70](https://github.com/thingsboard/tbmq/pull/70) 修复了 QoS 0（“AT_MOST_ONCE”）的共享订阅处理；
  * [#eae45b9781](https://github.com/thingsboard/tbmq/commit/eae45b9781) 开始处理持久性客户端的共享订阅，而无需额外的订阅消息；
  * [#0303a0e3f6](https://github.com/thingsboard/tbmq/commit/0303a0e3f6) 修复了持久性客户端和共享订阅的问题：
  应用程序 - 更正了现有订阅的 qos 更改，设备 - 如果发送订阅，则在客户端连接时停止接收存储的消息两次。

* UI：

  * [#77](https://github.com/thingsboard/tbmq/pull/77) 修复了在点击“跳过”按钮时，在个人资料页面上更改密码时用户注销；
  * [#25108bf9db](https://github.com/thingsboard/tbmq/commit/25108bf9db) 修复了非活动浏览器选项卡的主页中的加载动画；
  * [#7901fedae9](https://github.com/thingsboard/tbmq/commit/7901fedae9)，[#fe01288420](https://github.com/thingsboard/tbmq/commit/fe01288420) MQTT 客户端凭据授权主题规则错误修复。

## v1.1.0（2023 年 9 月 12 日）

次要版本，具有以下功能、改进和错误修复。

**主要功能：**

* [#53](https://github.com/thingsboard/tbmq/pull/53) MQTT over WebSockets；
* [#63](https://github.com/thingsboard/tbmq/pull/63) MQTT 5 消息过期；
* [#66](https://github.com/thingsboard/tbmq/pull/66) MQTT 5 主题别名；
* [#68](https://github.com/thingsboard/tbmq/pull/68) UI：新主页。

**改进：**

* 核心：
  
  * [#57](https://github.com/thingsboard/tbmq/pull/57) 针对实体的额外验证以防止 XSS；
  * 引入了用于处理应用程序共享订阅的专用线程池，更正了活动共享订阅处理器数量的统计信息；
  * 时序控制器 API 调用改进了验证；
  * MQTT 客户端凭据和应用程序共享订阅实体按“包含”搜索。

* UI：

  * 为主页引入了响应式设计；
  * 使用与 WebSocket 侦听器相关的参数扩展了主页上的配置卡；
  * 配置卡上的排序功能；
  * 可以在主页上全屏查看 Kafka 主题和 Kafka 消费者组小部件；
  * 在主页上添加了图表上的最后时间戳；
  * 在主页上添加了升级信息和版本卡链接；
  * 主页上快速链接到文档的新链接；
  * 选项可在首次用户登录时跳过更改默认密码；
  * 服务质量级别显示为相应数字。

**错误修复：**

* 核心：

  * [#52](https://github.com/thingsboard/tbmq/pull/52) Spring CORS 配置问题；
  * 通过 API 拒绝删除自己的 sysadmin 用户。

* UI：
  
  * 修复了主页加载时发出多个相同的获取请求；
  * 修复了监控页面上图表上的工具提示显示；
  * 修复了监控页面上的全屏问题。

## v1.0.1（2023 年 7 月 07 日）

补丁版本，具有以下改进和错误修复。

**改进：**

* 安装：

  * 添加了用于轻松安装和运行单片模式下 TBMQ 的脚本。

* UI：

  * 主页。入门新程序；
  * 主页。工具提示改进；
  * 主页。Kafka 主题和消费者组切换选项卡动画更正；
  * 监控页面。图表图例交互改进；
  * MQTT 客户端凭据表单提示改进；
  * 用户创建时带有默认密码信息的新提示。

**错误修复：**

* 核心：

  * [#41](https://github.com/thingsboard/tbmq/pull/41) 保持活动值为 0 的修复。

* UI：

  * 监控页面。会话和订阅图表在集群模式下不显示值。

## v1.0.0（2023 年 6 月 28 日）

初始版本。有关更多信息，请参阅 [GitHub](https://github.com/thingsboard/tbmq#tbmq)。