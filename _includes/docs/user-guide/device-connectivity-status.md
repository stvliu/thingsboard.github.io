* TOC
{:toc}

## 功能概述

ThingsBoard 设备状态服务负责监控设备连接状态并触发设备连接事件，这些事件被推送到 [**规则引擎**](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/)。作为平台用户，您可以定义如何对这些事件做出反应。

支持的事件有：

- **连接事件** - 当设备连接到 GridLinks 时触发。适用于基于会话的传输，如 MQTT。它也会为 HTTP 传输触发，但在这种情况下，它将在每次 HTTP 请求时触发；
- **断开连接事件** - 当设备从 ThingsBoard 断开连接时触发。适用于基于会话的传输，如 MQTT。它也会为 HTTP 传输触发，但在这种情况下，它将在每次 HTTP 请求时触发；
- **活动事件** - 当设备推送遥测、属性更新或 RPC 命令时触发；
- **非活动事件** - 当设备在一段时间内处于非活动状态时触发。请注意，即使没有来自设备的断开连接事件，此事件也可能会触发。通常，这意味着一段时间内没有触发活动事件。

设备状态服务负责维护以下 [服务器端](/docs/{{docsPrefix}}user-guide/attributes/#attribute-types) 属性：

- **active** - 表示当前设备状态，为 true 或 false；
- **lastConnectTime** - 表示设备上次连接到 GridLinks 的时间，自 1970 年 1 月 1 日 00:00:00 GMT 以来经过的毫秒数；
- **lastDisconnectTime** - 表示设备上次从 ThingsBoard 断开连接的时间，自 1970 年 1 月 1 日 00:00:00 GMT 以来经过的毫秒数；
- **lastActivityTime** - 表示设备上次推送遥测、属性更新或 RPC 命令的时间，自 1970 年 1 月 1 日 00:00:00 GMT 以来经过的毫秒数；
- **inactivityAlarmTime** - 表示上次触发非活动事件的时间，自 1970 年 1 月 1 日 00:00:00 GMT 以来经过的毫秒数。

## 配置

设备状态服务使用全局配置参数来设置非活动超时。
此参数在 **thingsboard.yml** (state.defaultInactivityTimeoutInSec) 中定义，默认设置为 600 秒（10 分钟）。
用户可以通过设置“inactivityTimeout”服务器端属性（值以毫秒为单位）来覆盖单个设备的此参数。

设备状态服务使用全局配置参数来检测非活动事件。
此参数在 **thingsboard.yml** (state.defaultStateCheckIntervalInSec) 中定义，默认设置为 60 秒（1 分钟）。

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}