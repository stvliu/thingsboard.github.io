* TOC
{:toc}

## 概述

自 ThingsBoard 3.4.2 起，租户管理员能够使用资产配置文件为多个资产配置通用设置。
每个资产在某个时间点只有一个配置文件。
有经验的 ThingsBoard 用户可能会注意到资产类型已被弃用，取而代之的是资产配置文件。
更新脚本将根据唯一的资产类型自动创建资产配置文件，并将它们分配给相应的资产。

资产配置文件允许您选择[规则链](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain)和[队列](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/)，以便[规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview)用于处理资产数据。
让我们来看看资产配置文件中可用的设置。

## 创建资产配置文件

要创建资产配置文件，请转到“配置文件”选项卡上的“资产配置文件”，然后单击加号按钮以添加新的资产配置文件。

{% if docsPrefix == null %}
![image](/images/user-guide/asset-profile/asset-profile-add-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/asset-profile/asset-profile-add-1-pe.png)
{% endif %}

## 资产配置文件设置

### 规则链

默认情况下，[根规则链](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#rule-chain)处理任何资产的所有传入消息和事件。
但是，您拥有的不同资产类型越多，根规则链就可能变得越复杂。
许多平台用户创建根规则链的唯一目的是根据资产类型将消息发送到特定规则链。

为了避免这种痛苦且平凡的活动，自 ThingsBoard 3.4.2 起，您可以为您的资产指定自定义规则链。
新的规则链将接收资产属性更新和资产生命周期（创建/更新/删除）事件。
此设置在资产配置文件详细信息中可用。

{% if docsPrefix == null %}
![image](/images/user-guide/asset-profile/asset-profile-rule-chain-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/asset-profile/asset-profile-rule-chain-1-pe.png)
{% endif %}

{% if docsPrefix == null %}
![image](/images/user-guide/asset-profile/asset-profile-rule-chain-2-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/asset-profile/asset-profile-rule-chain-2-pe.png)
{% endif %}

### 队列

默认情况下，[主](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/)队列将用于存储来自任何资产的所有传入事件。
API 层将把消息提交到此队列，规则引擎将轮询队列以获取新消息。
但是，对于多种案例，您可能希望为不同资产使用不同的队列。
例如，您可能希望隔离紧急资产数据和其他资产或设备的数据处理。
这样，即使您的系统因数百万水表而产生峰值负载，每当重要的资产配置发生更改时，都将立即处理。
队列的分离还允许您自定义不同的[提交](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#queue-submit-strategy)和[处理](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/queues/#queue-processing-strategy)策略。

此设置在您创建资产配置文件和资产配置文件详细信息中可用。

{% if docsPrefix == null %}
![image](/images/user-guide/asset-profile/asset-profile-queue-1-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/asset-profile/asset-profile-queue-1-pe.png)
{% endif %}


{% if docsPrefix == null %}
![image](/images/user-guide/asset-profile/asset-profile-queue-2-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/asset-profile/asset-profile-queue-2-pe.png)
{% endif %}

## 相关指南

您可以使用以下链接查看相关指南：

{% if docsPrefix == null %}
 - [规则链](/docs/{{peDocsPrefix}}user-guide/ui/rule-chains/)
 - [队列](/docs/{{peDocsPrefix}}user-guide/rule-engine-2-5/queues/)
 - [资产](/docs/{{peDocsPrefix}}user-guide/ui/assets/)
 - [实体和关系](/docs/{{peDocsPrefix}}user-guide/entities-and-relations/)
  {% endif %}
  {% if docsPrefix == "pe/" %}
 - [规则链](/docs/pe/user-guide/ui/rule-chains/)
 - [队列](/docs/pe/user-guide/rule-engine-2-5/queues/)
 - [资产](/docs/pe/user-guide/ui/assets/)
 - [实体和关系](/docs/pe/user-guide/entities-and-relations/)
  {% endif %}
  {% if docsPrefix == "paas/" %}
 - [规则链](/docs/paas/user-guide/ui/rule-chains/)
 - [资产](/docs/paas/user-guide/ui/assets/)
 - [实体和关系](/docs/paas/user-guide/entities-and-relations/)
  {% endif %}