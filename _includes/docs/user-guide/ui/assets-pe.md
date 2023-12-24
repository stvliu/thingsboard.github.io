* TOC
{:toc}

## 简介

Thingsboard 支持使用 Web UI 和 [REST API](/docs/{{docsPrefix}}reference/rest-api/) 以下资产管理功能。

{% include images-gallery.html imageCollection="asset-intro-pe" %}

## 添加和删除资产

租户管理员可以注册新资产或从 Thingsboard 中删除它们。
要添加新的资产组，请单击右上角的加号图标。
输入新资产组的名称，设置共享配置，然后单击添加。

要删除资产组，请单击资产旁边的垃圾桶图标并在对话框中确认。

{% include images-gallery.html imageCollection="asset-pe" %}

## 资产 ID

租户管理员和客户用户可以将资产 ID 复制到剪贴板。
打开资产组，然后单击资产名称以打开其详细信息。然后，单击“复制资产 ID”按钮。

{% include images-gallery.html imageCollection="asset-id-pe" %}

## 资产属性

租户管理员和客户用户能够管理资产服务器端 [属性](/docs/{{docsPrefix}}user-guide/attributes/)。
首先，您应该单击资产以打开其详细信息。然后，转到属性选项卡，通过选中资产属性旁边的框，您可以删除它或在小部件上显示它。

{% include images-gallery.html imageCollection="asset-attributes-pe" %}

## 资产警报

租户管理员和客户用户能够浏览资产 [警报](/docs/{{docsPrefix}}user-guide/alarms/)。
要配置警报，您应该从资产创建到设备的关系，添加警报规则并通过终端触发警报。
在执行这些操作后，您可以在资产详细信息中看到触发的警报。

{% include images-gallery.html imageCollection="asset-alarms-pe" %}

## 资产事件

租户管理员和客户用户可以使用“事件”选项卡浏览与特定资产相关的事件。事件有助于跟踪每条消息，以查看资产发生了什么。
错误事件显示可能影响资产工作的主要问题。
生命周期事件显示资产创建的时间以及是否成功。
统计事件显示处理了多少条消息以及有多少错误。
原始数据事件用于调试。

_专门针对事件的文档即将推出。_

{% include images-gallery.html imageCollection="asset-events-pe" %}

## 资产关系

GridLinks 提供用户界面和 REST API 来配置和管理您的 IoT 应用程序中的多个实体类型及其 [关系](/docs/{{docsPrefix}}user-guide/entities-and-relations/)。

{% include images-gallery.html imageCollection="asset-relations-pe" %}

## 审计日志

GridLinks 提供跟踪用户操作的功能，以便保留 [审计日志](/docs/{{docsPrefix}}user-guide/audit-log/)。
可以记录与主要实体相关联的用户操作：资产、设备、仪表板、规则等。

{% include images-gallery.html imageCollection="asset-auditlogs-pe" %}