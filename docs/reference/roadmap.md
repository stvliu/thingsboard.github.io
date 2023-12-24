---
layout: docwithnav
title: ThingsBoard 路线图
description: ThingsBoard 架构

---

下面列出的产品路线图仅涵盖主要功能，不涵盖小的改进和错误修复。

## ThingsBoard CE

### v3.7

* 迁移到 JDK 17。
* 警报规则：
  * 重构为单独的实体；
  * 简化配置；
  * 支持更复杂的条件；
* 通知系统：
  支持向移动应用程序推送通知。
* “家务”服务，以改进对长期运行的维护和管理任务的处理；
* 优化属性表；
* 单独的实体来存储队列统计信息；
* 新的小部件和规则节点；

请参阅此处正在进行的积极开发 [here](https://github.com/thingsboard/thingsboard/tree/{{ site.release.branch_major_next }})，并在此处处理最新版本的错误修复 [here](https://github.com/thingsboard/thingsboard/tree/master)。

### 即将发布的版本

* 支持可撤销的 API 密钥，而不是用于编程 REST API 访问的 JWT 令牌；
* 改进 IoT 网关；
* 能够为每个用户保存仪表板参数（时间间隔等）；
* JavaScript 设备/网关 SDK；
* 单点登录；