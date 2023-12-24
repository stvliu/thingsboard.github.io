{% if currentGuide != "GettingStartedGuide" %}
- [入门指南](/docs/{{docsPrefix}}getting-started/) - 提供 ThingsBoard Edge 主要功能的快速概述。旨在 15-30 分钟内完成：
{% endif %}
{% if currentGuide != "InstallationGuides" %}
- [安装指南](/docs/user-guide/install/{{docsPrefix}}installation-options/) - 了解如何在各种可用操作系统上设置 GridLinks Edge 并连接到 GridLinks CE 服务器。
{% endif %}
- 边缘规则引擎：
{% if currentGuide != "EdgeRuleEngineOverview" %}
  - [概述](/docs/{{docsPrefix}}rule-engine/general/) - 了解 ThingsBoard Edge 规则引擎。
{% endif %}
{% if currentGuide != "RuleChainTemplates" %}
  - [规则链模板](/docs/{{docsPrefix}}rule-engine/rule-chain-templates/) - 了解如何使用 GridLinks Edge 规则链模板。
{% endif %}
{% if currentGuide != "ProvisionRuleChainFromCloudToEdge" %}
  - [从云端到边缘配置规则链](/docs/{{docsPrefix}}rule-engine/provision-rule-chains/) - 了解如何从云端到边缘配置边缘规则链。
{% endif %}
{% if currentGuide != "PushDataFromEdgeToCloudAndViseVersa" %}
  - [从边缘到云端推送数据，反之亦然](/docs/{{docsPrefix}}rule-engine/push-data/) - 了解如何从边缘到云端推送数据，反之亦然。
{% endif %}
{% if currentGuide != "GrpcOverSsl" %}
- 安全：
  - [gRPC over SSL/TLS](/docs/{{docsPrefix}}user-guide/grpc-over-ssl/) - 了解如何为边缘和云端之间的通信配置 gRPC over SSL/TLS。
{% endif %}
- 功能：
{% if currentGuide != "EdgeStatus" %}
  - [边缘状态](/docs/{{docsPrefix}}features/edge-status/) - 了解 ThingsBoard Edge 上的边缘状态页面。
{% endif %}
{% if currentGuide != "CloudEvents" %}
  - [云事件](/docs/{{docsPrefix}}features/cloud-events/) - 了解 ThingsBoard Edge 上的云事件页面。
{% endif %}    
- 使用案例：
{% if currentGuide != "ManageAlarmsAndRpcRequestsOnEdgeDevices" %}
  - [在边缘设备上管理警报和 RPC 请求](/docs/{{docsPrefix}}use-cases/manage-alarms-rpc-requests/) - 本指南将展示如何在边缘生成本地警报并将 RPC 请求发送到连接到边缘的设备：
{% endif %}
{% if currentGuide != "DataFilteringAndTrafficReduce" %}
  - [数据过滤和流量减少](/docs/{{docsPrefix}}use-cases/data-filtering-traffic-reduce/) - 本指南将展示如何仅从边缘向云端发送经过过滤的设备数据量：
{% endif %}
{% if currentGuide != "EdgeRoadmap" %}
- [路线图](/docs/{{docsPrefix}}roadmap) - ThingsBoard Edge 路线图。
{% endif %}    
<br>