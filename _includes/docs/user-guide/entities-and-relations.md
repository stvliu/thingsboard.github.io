* TOC
{:toc}

## 实体概述

ThingsBoard 提供用户界面和 REST API 来配置和管理多个实体类型及其在 IoT 应用程序中的关系。
支持的实体有：

- **[租户](/docs/{{docsPrefix}}user-guide/ui/tenants/)** - 您可以将租户视为一个独立的业务实体：它是拥有或生产设备和资产的个人或组织；
租户可能有多个租户管理员用户和数百万的客户、设备和资产；
- **[客户](/docs/{{docsPrefix}}user-guide/ui/customers/)** - 客户也是一个独立的业务实体：购买或使用租户设备和/或资产的个人或组织；
客户可能有多个用户和数百万的设备和/或资产；
- **[用户](/docs/{{docsPrefix}}user-guide/ui/users/)** - 用户能够浏览仪表板并管理实体；
- **[设备](/docs/{{docsPrefix}}user-guide/ui/devices/)** - 可能产生遥测数据并处理 RPC 命令的基本 IoT 实体。例如，传感器、执行器、开关；
- **[资产](/docs/{{docsPrefix}}user-guide/ui/assets/)** - 可能与其他设备和资产相关的抽象 IoT 实体。例如，工厂、现场、车辆；
- **[实体视图](/docs/{{docsPrefix}}user-guide/entity-views/)** - 如果您只想向客户共享部分设备或资产数据，则很有用；
- **[警报](/docs/{{docsPrefix}}user-guide/alarms/)** - 识别您的资产、设备或其他实体问题的事件；
- **[仪表板](/docs/{{docsPrefix}}user-guide/dashboards/)** - 可视化您的 IoT 数据并通过用户界面控制特定设备的能力；
- **规则节点** - 用于处理传入消息、实体生命周期事件等的处理单元；
- **规则链** - 定义 [规则引擎](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) 中的处理流程。可能包含许多规则节点和指向其他规则链的链接；

每个实体支持：

- **[属性](/docs/{{docsPrefix}}user-guide/attributes/)** - 与实体关联的静态和半静态键值对。例如序列号、型号、固件版本；
- **[时序数据](/docs/{{docsPrefix}}user-guide/telemetry/)** - 可用于存储、查询和可视化的时序数据点。例如温度、湿度、电池电量；
- **[关系](#relations)** - 与其他实体的定向连接。例如包含、管理、拥有、生产。

某些实体支持配置文件：

- **[租户配置文件](/docs/{{docsPrefix}}user-guide/tenant-profiles/)** - 包含多个租户的常见设置：实体、API 和速率限制等。每个租户在单个时间点只有一个配置文件。
- **[设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/)** - 包含多个设备的常见设置：处理和传输配置等。每个设备在单个时间点只有一个配置文件。
- **[资产配置文件](/docs/{{docsPrefix}}user-guide/asset-profiles/)** - 包含多个资产的常见设置：处理配置等。每个资产在单个时间点只有一个配置文件。

{% if docsPrefix == "pe/" %}
**[实体组](/docs/pe/user-guide/groups/)**：

ThingsBoard Professional Edition 允许您为客户、用户、设备、资产、实体视图和仪表板配置实体组。
每个实体可以同时属于多个组。实体组始终有一个所有者 - 特定的租户或客户。
组中的所有实体必须具有相同的实体类型（即您不能将设备和资产放入一个组中）。
实体组对于仪表板和数据处理很有用，但它们存在的主要原因是为了支持 IoT 的高级基于角色的访问控制 ([RBAC](/docs/pe/user-guide/rbac/))。

**[集成](/docs/user-guide/integrations/)** 和 **[数据转换器](/docs/user-guide/integrations/#data-converters)**：

ThingsBoard 平台集成功能专为两个主要用例/部署选项而设计：

- 将具有特定有效负载格式的现有 NB IoT、LoRaWAN、SigFox 和其他设备直接连接到 ThingsBoard 平台。
- 从连接到现有 IoT 平台的设备流式传输数据，以实现实时交互式仪表板和高效的数据处理。

数据转换器是平台集成功能的一部分。它们的目的是将设备的原始有效负载转换为 ThingsBoard 使用的格式，反之亦然。

{% endif %}

本指南概述了上面列出的功能、获取更多详细信息的一些有用链接以及它们的使用示例。

## 关系

实体关系定义属于同一 [租户](/docs/{{docsPrefix}}user-guide/ui/tenants/) 的两个 ThingsBoard 实体之间的连接。
关系具有任意类型：包含、管理、支持等。关系也是方向性的。
您可以将 ThingsBoard 关系视为面向对象编程中的 [Has-a](https://en.wikipedia.org/wiki/Has-a) 关系。

关系有助于在 ThingsBoard 中建模物理世界对象。了解它们的最简单方法是使用示例。
假设我们要构建一个应用程序，从土壤湿度和温度传感器收集数据，将此数据可视化到仪表板上，检测问题、发出警报并控制灌溉。
我们还假设我们要支持具有数百个传感器的多个字段。字段也可以分组到地理区域中。

下图解释了如何在 ThingsBoard 中配置和存储这些实体：

![image](/images/user-guide/entities-and-relations.svg)


请参阅 [“添加和删除资产”](/docs/pe/user-guide/ui/assets/#add-and-delete-assets) 和 [“管理资产关系”](/docs/pe/user-guide/ui/assets/#manage-asset-relations)
以了解如何通过管理 UI 配置这些实体。您还可以使用 [REST API](/docs/reference/rest-client/) 以编程方式创建实体和关系。

## 后续步骤

**将属性分配给资产和设备**

ThingsBoard 提供了将属性分配给实体并管理它们的功能。
欢迎您在此处了解如何操作：
<p><a href="/docs/{{docsPrefix}}user-guide/attributes" class="button">使用设备属性</a></p>


**从设备上传遥测数据**

ThingsBoard 提供了处理设备和其他实体的遥测数据的功能。
欢迎您在此处了解如何操作：
<p><a href="/docs/{{docsPrefix}}user-guide/telemetry" class="button">使用遥测数据</a></p>

**为警报创建规则**

ThingsBoard 提供了使用规则引擎为设备和其他实体发出警报的功能。
欢迎您在此处了解如何操作：
<p><a href="/docs/{{docsPrefix}}user-guide/alarms" class="button">使用警报</a></p>

**设计您的仪表板**

请 [导入](/docs/{{docsPrefix}}user-guide/ui/dashboards/#dashboard-import) 以下 [**仪表板**](/docs/{{docsPrefix}}user-guide/resources/region_fields_dashboard.json)，该仪表板演示了地图、警报、实体表和图表小部件。