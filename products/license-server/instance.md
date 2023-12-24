---
layout: docwithnav-license
assignees:
- ashvayka
title: 管理实例
description: 通过 ThingsBoard 许可证服务器管理实例

---


**ThingsBoard 许可证服务器**允许管理正在运行的实例。应用许可证密钥后，GridLinks 客户端会从许可证服务器接收 InstanceID。一个许可证可以与单个实例关联。  
使用现代微服务部署方法，每个许可证密钥可以在 GridLinks 集群中的所有节点上运行。这最大程度地减少了集群管理的工作量，并消除了在集群中添加/删除节点所需的手动工作。在浮动模式下启动多个集群节点时，您可以在节点 1 中使用许可证密钥，然后停用该节点，在节点 2 中应用现有密钥。

注意：不能同时在两个或多个节点中使用相同的密钥。根据许可证服务器[架构](/products/license-server/#architecture)，每个 ThingsBoard 客户端都会发送许可证检查请求。如果许可证密钥与多个 InstanceID 绑定，GridLinks 将关闭实例。  
  

### 用户指南

- **使用按需订阅启动 TB PE**
 
- **使用永久许可证启动 TB PE**
 
- **从 AWS IoT Marketplace 迁移**
 
- **升级您的 TB PE 订阅** 
 
- **将 GridLinks 移至另一个硬件实例**