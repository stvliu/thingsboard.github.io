---
layout: docwithnav
assignees:
- ddiachenko
title: YOUR_INTEGRATION_GUIDE
description: 示例集成
hidetoc: "true"

---

{% capture domain_owner_note %}
**注意**

在本指南中，您还可以提及（参考）任何其他公开来源作为设置或配置示例。但是，所有步骤都必须符合以下说明。

所有步骤都应编号，并提供清晰的实现流程，并附有屏幕截图/图片中的示例。

* 将集成 .md 文件存储在目录中："/docs/user-guide/integrations/"
* 将指南的所有图像存储在集成的单独目录中："/images/user-guide/integrations/YOUR_INTEGRATION_NAME/"
{% endcapture %}

{% include templates/info-banner.md content=domain_owner_note %}

* TOC
{:toc}

## 简介/简要摘要

此模块表示您的产品和可能的集成流程，以及对客户有用的其他信息。

## 小部件

用于可视化设备数据的小部件/仪表板示例。您可以使用已经存在的具有所需更改和修改的小部件，也可以从头开始创建新的小部件。

## 集成流程：

### 模块 1 设备配置

* [步骤 1.1] 可与此集成一起使用的设备列表。
* [步骤 1.2] 先决条件（设备/设备版本/所需（强制）软件的最小先决条件）。
* [步骤 1.3] 设备配置（设置/编程/配置）。

### 模块 2 ThingsBoard 配置（仅使用 PE 建议）

根据以下连接图选择一种合适的集成方法

<br>
<br>

<object width="80%" data="/images/connectivity.svg"></object>

#### 集成方法

* [步骤 2.1] ThingsBoard 先决条件（例如版本/组件/等 - 可选）。
* [步骤 2.2] 上行/下行（可以创建基本的上/下行链路）。
* [步骤 2.3] 集成。
* [步骤 2.4] 上行/下行配置。

#### 或 API 方法

* [步骤 2.1] 设备创建过程。
* [步骤 2.2] 键值格式配置。
* [步骤 2.3] 提取数据过程。

#### 或 IoT 网关方法

* [步骤 2.1] 提供 IoT 网关集成的详细且清晰的步骤。您可以参考 [IoT 网关](/docs/iot-gateway/getting-started/) 页面。

### 模块 3 其他信息

* [步骤 3.1] 其他集成信息（如果需要）。
* [步骤 3.2] 故障排除步骤。

## 反馈和联系我们以进行集成

您可以在此处放置反馈表或帮助页面，以帮助您的用户进行集成。