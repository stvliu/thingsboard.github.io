---
layout: docwithnav-paas
assignees:
- ashvayka
title: 计划和计费
description: 通过 GridLinks云服务 的计费选项
subscription:
    0:
        image: /images/cloud/subscription.png
        title: '订阅详情'
    1:
        image: /images/cloud/subscription-plan-usage.png
        title: '计划使用情况'
billingInfo:
    0:
        image: /images/cloud/billing-info.png
updatePaymentMethod:
    0:
        image: /images/cloud/update-payment-method.png
updateBillingInfo:
    0:
        image: /images/cloud/update-billing-info.png
invoices:
    0:
        image: /images/cloud/invoices.png
upcomingInvoice:
    0:
        image: /images/cloud/upcoming-invoice.png
        title: '即将到来的发票预览'
---

* TOC
{:toc}

**ThingsBoard Cloud** 允许客户轻松在线购买订阅计划。在线支付处理由 [Stripe](https://stripe.com/) 保护，它允许使用信用卡和借记卡。ThingsBoard Inc. 无权访问您的卡数据。
您可以轻松在线支付订阅费用，无需手动填写表格。

注意：付款不可退款。

### 订阅

**订阅**选项卡显示有关当前订阅的所有详细信息，包括当前订阅计划、订阅状态、当前订阅期限、应用的折扣。
**计划详细信息**部分显示当前订阅计划限制。还可以通过单击 **显示使用情况** 切换按钮来查看当前计划的使用情况。

{% include images-gallery.html imageCollection="subscription" %}

### 计费信息

**计费信息**选项卡允许管理当前付款方式（信用卡或借记卡详细信息）和用于发票的计费详细信息，例如公司名称和账单地址。

{% include images-gallery.html imageCollection="billingInfo" %}

#### 付款方式

允许管理当前的信用卡或借记卡详细信息。您可以随时单击 **更新** 按钮轻松更新它。
为了用卡支付，应填写 ***所有者姓名***、***国家***、***卡号***、***到期日*** 和 ***CVC***。

{% include images-gallery.html imageCollection="updatePaymentMethod" %}

#### 计费信息

由公司联系方式和账单地址组成，Stripe 使用它来生成发票。您可以通过单击 **更新** 按钮轻松更新此信息。

{% include images-gallery.html imageCollection="updateBillingInfo" %}

### 发票

**发票**选项卡显示自动生成的发票列表。所有发票都可以下载为 PDF 格式。

{% include images-gallery.html imageCollection="invoices" %}

### 即将到来的发票

**即将到来的发票**选项卡显示将在下一个计费周期开始时生成的即将到来的发票预览。

注意：当您查看即将到来的发票时，您只是在查看预览 - 发票尚未创建。

{% include images-gallery.html imageCollection="upcomingInvoice" %}