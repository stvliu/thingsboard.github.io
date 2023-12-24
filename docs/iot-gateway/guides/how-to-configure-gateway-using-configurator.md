---
layout: docwithnav-gw
title: 如何使用配置器配置 ThingsBoard IoT 网关
description: 如何使用配置器配置 ThingsBoard IoT 网关

---

* TOC
{:toc}

本指南将帮助您使用配置器配置 ThingsBoard IoT 网关，尤其是当您使用 deb 软件包进行安装时。

## 第 1 步 启动配置器

要开始配置网关，您必须启动终端并使用以下命令启动配置器：
```bash
tb-gateway-configurator
```
{: .copy-code}

如果您已正确安装网关，您将看到以下内容：

![](/images/gateway/gateway-cli.png)

## 第 2 步 配置

回答依次显示的问题，使用您的选项（您可以使用输入字段中显示的默认值）。

**注意**：默认值取自 **/etc/thingsboard-gateway/config/tb_gateway.yaml**，您通过 CLI 进行的所有配置都将保存在此处。

![](/images/gateway/gateway-cli-questions.png)

## 第 3 步 启动网关

最后，您可以使用以下命令启动 ThingsBoard IoT 网关：
```bash
thingsboard-gateway
```
{: .copy-code}

## 后续步骤

探索与 ThingsBoard 主要功能相关的指南：

- [数据可视化](/docs/user-guide/visualization/) - 如何可视化收集的数据。
- [设备属性](/docs/user-guide/attributes/) - 如何使用设备属性。
- [遥测数据收集](/docs/user-guide/telemetry/) - 如何收集遥测数据。
- [使用 RPC 功能](/docs/user-guide/rpc/) - 如何向设备发送/从设备接收命令。
- [规则引擎](/docs/user-guide/rule-engine/) - 如何使用规则引擎分析来自设备的数据。