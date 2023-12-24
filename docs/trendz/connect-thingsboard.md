---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 连接到 ThingsBoard
description: 将 Trendz Analytics 平台连接到 ThingsBoard
---

* TOC
{:toc}


## 连接到 ThingsBoard
您可以将 Trendz Analytics 连接到 ThingsBoard Community Edition 或 ThingsBoard Professional Edition。

<br>

默认情况下，Trendz 预期 ThingsBoard 托管在同一实例上，并且可以通过 URL 访问：
 
 - http://localhost:9090
    
如果您的 ThingsBoard 安装托管在另一个实例/端口上 - 您必须使用正确的值更新配置：

打开 Trendz 配置文件：

```
sudo nano /usr/share/trendz/conf/trendz.conf
```
    
并将此属性更新为正确的值：

```yml
export TB_API_URL=http://localhost:9090
```    
    
对于 docker 安装 - 使用正确的值更新环境变量 ``TB_API_URL``。   

## 身份验证和安全性
Trendz 使用 ThingsBoard 作为身份验证服务。任何租户管理员或客户用户都可以使用他们在 ThingsBoard 中用于身份验证的登录名\密码登录 Trendz UI。

在 ThingsBoard 上配置的相同安全限制适用于 Trendz Analytics。

- **租户管理员**可以访问所有设备/资产
- **客户用户**只能访问他们有权查看的那些设备/资产


## 拓扑发现
Trendz 拓扑表示在 ThingsBoard 中创建的设备/资产的业务模型。拓扑定义用于构建可视化和设备/资产之间的关系的维度/字段。以下是 Trendz 拓扑的核心组件：


**业务实体** - 定义具有相同设备类型/资产类型的设备或资产组。每个业务实体都有：

- **标准** - 定义从 ThingsBoard 获取设备/资产的一般属性
- **业务实体字段** - 表示在构建可视化期间使用的字段。字段包含数据类型、标签和从 ThingsBoard 获取数据期间使用的查询参数。
以下是支持的字段列表：
    - 实体名称 - 设备或资产的名称
    - 所有者 - 谁拥有设备（管理员/客户）
    - 属性
    - 遥测
- **关系** - 配置的业务实体及其属性之间的关系。Trendz 关系表示设备和资产之间的 ThingsBoard 关系

#### 首次拓扑发现


在首次登录后，用户应执行初始拓扑发现。在此过程中，Trendz 将分析 ThingsBoard 中可用的所有设备/资产、它们的属性/遥测以及它们之间的所有关系。
结果，Trendz 将提取并保存业务实体的集合。您可以在“设置”页面上查看和修改它们。

![image](/images/trendz/first-discovery.png)

<br>

![image](/images/trendz/discover-results.png)
 
#### 手动拓扑重新发现
业务实体不表示单个设备或资产，而是用于从 ThingsBoard 获取设备/资产的查询。这意味着如果在 ThingsBoard 上添加了具有相同类型的新设备资产，则无需更新拓扑。

当添加了新设备/资产类型或在 ThingsBoard 中创建了具有新密钥的属性/遥测时 - 您应该更新拓扑。


手动拓扑重新发现将再次扫描 ThingsBoard，检测修改并使用所需设置更新业务实体集合。您可以在“设置”页面上按“刷新拓扑”触发此过程。

 
#### 手动修改
更新拓扑的另一种选择是手动修改业务实体属性。您可以拥有任意数量具有相似属性的业务实体。
当同一设备/资产表示业务解决方案的不同方面时，这可能很有用。例如，单个设备可以监控环境并提交调试事件以进行故障排除。
通过将调试事件与环境测量结果分离到孤立的业务实体中，可以更轻松地构建专注于解决方案的单个方面的可视化。


## 后续步骤

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}