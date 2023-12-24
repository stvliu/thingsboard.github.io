---
layout: docwithnav-mqtt-broker
title: 配置属性
description: TBMQ 配置属性和环境变量

---

* TOC
{:toc}

本指南将帮助您熟悉 TBMQ 配置文件和参数。
我们**强烈建议**使用环境变量配置 TBMQ。
这样，当新平台版本发布时，您无需合并配置文件。

可用的配置参数和相应的环境变量列表可以在 [此处](#configuration-parameters) 找到。

### 如何更改配置参数？

#### 基于 Docker 的部署

如果 TBMQ 安装在 Docker Compose 环境中，您可以编辑脚本并为相应的容器添加环境变量。有关更多详细信息，请参阅 [Docker 文档](https://docs.docker.com/compose/environment-variables/#/the-envfile-configuration-option)。

#### 基于 K8S 的部署

如果 TBMQ 安装在 K8S 环境中，您可以编辑脚本并为相应的部署/有状态集添加环境变量。有关更多详细信息，请参阅 [K8S 文档](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/)。

### 配置参数

配置文件以 YAML 格式编写。所有配置参数都有相应的环境变量名称和默认值。
要更改配置参数，只需修改其默认值即可。例如：

```bash
server:
  address: "${HTTP_BIND_ADDRESS:0.0.0.0}"
```

在这种情况下，*'HTTP_BIND_ADDRESS'* 是环境变量名称，*'0.0.0.0'* 是默认值。

您可以使用以下简单示例添加一个值为 '8084' 的新环境变量 'HTTP_BIND_PORT'。

```bash
...
export HTTP_BIND_PORT=8084
```

这些参数按系统组件分组。该列表包含名称（**thingsboard-mqtt-broker.yml** 文件中的地址）、环境变量、默认值和说明。

{% include docs/mqtt-broker/install/config.md %}