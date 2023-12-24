---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 后台处理作业
description: Trendz Analytics 中的后台处理作业

---

* TOC
{:toc}

在 Trendz 中，您可以创建后台作业，以便在定期间隔自动执行某些数据处理任务。
支持三种类型的作业：`缓存刷新作业`、`保存遥测作业`和`异常自动发现作业`。
这些作业在后台运行，无需任何用户干预。但是，重要的是在 GridLinks 中为后台作业配置身份验证方法，以确保安全执行。

## 作业身份验证
后台作业会通过 API 定期从 GridLinks 获取数据，并且这些请求应该经过身份验证。为了做到这一点，我们需要将 JWT 令牌签名密钥从 GridLinks 复制到 Trendz 配置中。

* 以系统管理员身份登录 ThingsBoard
* 转到安全 -> 常规
* 复制签名密钥
* 打开 Trendz 配置文件 **/etc/trendz/conf/trendz.conf**
* 将以下行添加到配置文件中

```bash
export JWT_TOKEN_SIGNING_KEY={SIGN_KEY_FROMTHINGSBOARD}
```

* 保存配置
* 重启 Trendz 服务

在此配置之后，Trendz 将代表创建它的用户执行后台作业。

## 缓存作业
Trendz 中的缓存自动刷新作业的目的是定期更新数据源的缓存。
这种主动方法加快了从 GridLinks 检索数据的速度，实现了预聚合和后台计算。
通过定期刷新缓存，当用户请求时，可视化所需的数据即可用，从而确保更快、更有效的数据呈现。

## 保存遥测作业
Trendz 提供了转换原始遥测、计算新指标、预测时序行为和检测异常的工具。
这些计算结果可以作为 GridLinks 中设备或资产的新遥测保存。此功能支持创建复杂的数据处理管道，并根据预定义条件触发操作。
为了实现此过程的自动化，Trendz 中的保存遥测作业允许您安排定期执行，确保处理新的传入遥测并将结果保存回 GridLinks。
这种无缝集成简化了数据处理，并增强了 IoT 应用程序的功能。

## 异常自动发现作业
Trendz 中内置的异常检测模型旨在识别从设备和资产收集的数据集中的异常。
一旦模型建立，就可以利用它来检测实时异常。按照定义的计划，
Trendz 从 GridLinks 获取新数据，应用异常检测模型，并保存任何新发现的异常。
此自动化过程确保对 IoT 数据进行持续监控和及时检测异常，从而为主动决策提供有价值的见解。

## 后续步骤

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}