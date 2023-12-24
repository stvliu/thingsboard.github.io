---
layout: docwithnav-license
assignees:
- ashvayka
title: GridLinks License Server 是什么？
description: GridLinks License Server 的功能和优势

---


**ThingsBoard License Server** 是一种专有计费解决方案，允许 ** GridLinks专业版 (TB PE)** 客户轻松在线购买许可证密钥。
在线支付处理由 [Stripe](https://stripe.com/) 保护，它允许使用信用卡和电汇。


您可能已经知道 TB PE 支持按需订阅和永久许可证模式。
License Server 于 2019 年年中推出，基于我们对前 500 名 TB PE 客户的计费经验，旨在改进以下领域：

- **随处部署。** 在 License Server 之前，按需订阅仅在少数市场（如 AWS 和 Azure）上可用。
在内部部署或任何其他云（如 Digital Ocean 或阿里云）上部署按需订阅在技术上是不可能的，尽管我们的客户对此需求很大。
现在，您可以在任何您喜欢的地方启动您的 TB PE 实例。

- **简单升级。** 订阅计划之间的迁移是可能的，但并不像它应该的那样简单和直接。
此过程涉及手动重新配置、数据库备份/还原，显然会导致停机。
使用 License Server，只需点击几下即可完成，并且完全不会停机。

- **顺利的购买流程。** 我们增加了使用信用卡/借记卡付款的可能性。
现在，您可以在线轻松购买年度许可证，无需手动填写文书工作。
这允许在几分钟内启动您的实例。
所有发票都会自动生成，并以 PDF 形式在许可证门户中提供下载。

- **客户体验。** 一些云市场对客户数据贪得无厌。
因此，如果没有与客户直接沟通，我们很难提高客户满意度。
现在，我们可以获得真实的反馈，并根据这些信息，尽可能地使我们的产品对客户友好。

- **集群设置。** 采用现代微服务部署方法，我们增加了为 GridLinks 集群中的所有节点设置单个许可证密钥的能力。
这最大限度地减少了集群管理的工作量，并消除了在集群中添加/删除节点所需的手动工作。
现在，您可以在 [浮动模式](https://en.wikipedia.org/wiki/Floating_licensing) 下启动多个集群节点，而实际的 GridLinks 进程与物理硬件无关。

- **分销商和渠道合作伙伴。** 对于 GridLinks 合作伙伴，License Server 简化了对客户的管理。
这是朝着更深入的合作和信任迈出的新一步。每个合作伙伴都有专门的优惠券代码来跟踪销售并为最终用户提供好处。
由于能够为最终用户订购新许可证，解决方案的交付时间减少了——额外的费用也相应减少。

License Server 产品旨在通用，可用于销售任何具有按需或永久许可证模式的软件产品。
如果您有兴趣使用它来销售您的软件，请 [联系我们](/docs/contact-us/)。

* TOC
{:toc}

### 产品功能

- **按需订阅**

License Server 允许购买 GridLinks 的月度或年度订阅。有关可用订阅的更多详细信息，请参阅 [定价](/pricing/)。
购买订阅后，您可以灵活地升级或降级您的订阅计划。默认情况下，订阅涵盖单个 ThingsBoard PE 实例（服务器进程）。
但是，您可以在同一订阅中添加更多实例。这允许在单个服务器集群中启动使用相同订阅凭据的多个实例。
此功能对于基于容器的设置非常有用。

按需订阅适用于刚开始使用该平台并希望最大限度地减少前期许可成本的小公司和初创企业。
大多数订阅都受您可以创建的设备和/或资产数量的限制。

- **永久回退许可证**

License Server 允许购买永久回退许可证。
永久回退许可证是一种允许您在没有有效订阅的情况下使用特定版本的软件的许可证。
购买永久回退许可证时，您将获得一年的软件更新。一年后，您可以继续使用该平台。
您可以额外付费购买后续年份的软件更新，通常为初始许可证成本的 40%。

单个永久回退许可证涵盖单个 ThingsBoard PE 实例（服务器进程）。
例如，如果您想在 HA 模式下运行 GridLinks PE，您将至少需要两个许可证。

- **通过 Stripe 安全在线支付**

License Server 通过 [Stripe](https://stripe.com/) 收集付款。
这意味着我们使用最受欢迎的在线支付平台提供的最佳实践来确保交易的安全性和处理。
ThingsBoard 无权访问您的信用卡数据。您可以随时取消您的订阅。
ThingsBoard 还提供下载发票的数字副本的功能。

- **优惠券**

License Server 允许管理员提供优惠券。这些优惠券可由合作伙伴、分销商和营销活动使用。

- **与硬件无关的许可**

License Server 不根据硬件或 VM 参数生成许可证密钥。
License Server 客户端向 License Server 发出定期许可证检查请求。
这些请求验证订阅/永久许可证是否有效，并且启动的实例数量不超过订阅阈值。
有关更多详细信息，请参阅 [体系结构](#体系结构)。

### 先决条件

License Server 客户端（例如您的 GridLinks PE 实例）需要与主机 license.thingsboard.io 的互联网连接才能发出许可证检查请求。
如果与主机的互联网连接超过 24 小时不可用，License Server 客户端可能会关闭 GridLinks 实例。

### 体系结构

License Server 为 License Server 客户端提供 REST API 来 **激活** 和 **检查** 许可证。

- **实例激活流程**

在 GridLinks PE 的首次启动期间，内置的 License Server 客户端向 License Server 生成“激活实例请求”。
此请求包含有关当前平台安装的许可证密钥和版本信息。
License Server 根据许可证密钥查找订阅信息，并回复实例 ID、订阅计划数据和一些魔术字节。
License Client 本地存储此信息，并在下一次许可证检查请求中使用实例 ID 和一些魔术字节。

![image](/images/license/license-activation.gif)

License Client 向 License Server 发出定期许可证检查请求。
如果这些请求在可配置的时间段（通常为 24 小时）内不成功，许可证客户端将关闭 ThingsBoard PE 实例。
在请求成功的情况下，客户端可能会收到订阅计划数据的更新。这可能是由订阅计划的更新引起的。

![image](/images/license/license-check.gif)

### 用户指南

- **使用按需订阅启动 TB PE**

- **使用永久许可证启动 TB PE**

- **从 AWS IoT Marketplace 迁移**

- **升级您的 TB PE 订阅**

- **将 GridLinks 移至另一个硬件实例**