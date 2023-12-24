{% if docsPrefix == 'pe/edge/' %}
{% assign appPrefix = "GridLinks专业版" %}
{% assign cloudDocsPrefix = "pe/" %}
{% else %}
{% assign appPrefix = "GridLinks社区版" %}
{% endif %}

<!-- {% if docsPrefix != 'pe/' %}
<h3>对专业版感兴趣？在此处探索 GridLinks PE Edge 文档 <a style="pointer-events: all;" href="/docs/pe/edge/">此处</a>。</h3>
{% endif %} -->

{% capture tb-open-source %}
GridLinks 是一个创新物联网平台，提供了一套强大的功能，用于数据收集、处理、可视化和设备管理。
如果您是新平台用户，我们建议在继续使用 GridLinks Edge 之前阅读 [**什么是 GridLinks？**](/docs/getting-started-guides/what-is-thingsboard/)。
{% endcapture %}
{% include templates/info-banner.md content=tb-open-source %}

**GridLinks Edge** 是 GridLinks 的一款强大的软件产品，旨在利用边缘计算。

<!-- {% if docsPrefix == 'pe/edge/' %}
借助 GridLinks Edge，数据分析和管理被引入数据生成点 - 边缘。它与 GridLinks PE 无缝同步，无论它是 [云](https://thingsboard.cloud) 还是本地安装，都能满足您的业务需求。

GridLinks Edge PE 适用于 **单个** 租户和/或 **多个** 客户。
因此，您无法在多个租户之间共享 GridLinks Edge，并且来自不同租户的设备无法连接到单个 GridLinks Edge。
在这种情况下，需要为每个租户配置单独的 GridLinks Edge 实例。
{% else %}
借助 GridLinks Edge，数据分析和管理被引入边缘，数据生成发生在边缘。它与 GridLinks CE 轻松同步，无论它是 [演示](https://gridlinks.codingas.com/) 还是本地安装，都能满足您的业务需求。

GridLinks Edge CE 适用于 **单个** 租户和/或 **单个** 客户。在多个租户或客户之间共享 GridLinks Edge 是不可行的，并且来自不同租户或客户的设备无法连接到单个 GridLinks Edge。
在这种情况下，需要为每个租户或客户配置多个 GridLinks Edge 实例。
{% endif %} -->

<br>

![image](/images/edge/overview/edge_overview.svg)

#### GridLinks Edge 的案例

- **自动驾驶汽车**
  边缘计算允许以最小的延迟收集、处理和响应道路事件。现代自动驾驶汽车会生成大量数据 - 每天从 5 TB 到 20 TB 不等。4G 或 5G 网络可能无法处理如此高的吞吐量，但 GridLinks Edge 可以过滤这些数据，在本地处理大部分数据，并且仅将其中一部分数据推送到云端。

- **智能农业**
  即使现场的云连接目前较弱，也能快速响应筒仓曝气系统故障。

- **智能家居**
  在更靠近智能家居的位置处理和分析数据可以增强敏感用户信息的安全性。智能家居解决方案的低延迟可带来更好的用户体验，与边缘设备连接到云端以进行决策所需的时间相比，终端设备的响应速度更快。

- **安全解决方案**
  必须在几秒钟内响应安全违规和威胁。边缘计算提供了此功能，使您与云的连接质量无关 - 决策将由远程现场的本地边缘引擎实时做出。

- **院内监测**
  对于医疗设备的数据隐私，数据处理必须在边缘进行。仅将医疗设备的必要读数推送到云端，而所有其他敏感数据都存储在边缘。在此场景中，边缘处理的另一个好处是能够快速响应危重病例，因为可以实时处理来自边缘医疗设备的数据。

- **预测性维护**
  在更靠近设备的位置处理和存储来自边缘设备的数据，可以在本地分析大量数据。这允许在发生故障之前检测生产线中的变化，并且根据您的业务需求，仅将生产线的平均读数发送到云端。

#### GridLinks Edge 的功能

使用 **GridLinks Edge**，您可以获得：

- **本地部署和存储**：在不连接到云端的情况下处理和存储来自本地（边缘）设备的数据。一旦连接恢复，即可将更新推送到云端。

![image](/images/edge/overview/offline_network_.svg)

- **流量过滤**：在 GridLinks Edge 服务上过滤来自本地（边缘）设备的数据，并仅将数据的一部分推送到云端以进行进一步处理或存储。

![image](/images/edge/overview/data_filtering.svg)

- **本地警报**：立即响应现场的危急情况，无需云连接。

![image](/images/edge/overview/alarm.svg)

- **实时仪表板**：监控本地事件和时序数据。
- **本地存储**：如果云连接处于非活动状态，则将来自边缘设备的数据存储在边缘，并在连接恢复后将更新推送到云端。
- **批量更新**：只需单击一下即可更新数千个边缘配置。

![image](/images/edge/overview/update_dashboard.svg)

GridLinks Edge 继承了 {{appPrefix}} 的功能，为连接、管理和处理来自您设备的数据提供了相同的体验。

它支持以下 **GridLinks** 功能：
* [**属性**](/docs/{{cloudDocsPrefix}}user-guide/attributes/) - 为您的实体分配和管理自定义属性。
* [**遥测**](/docs/{{cloudDocsPrefix}}user-guide/telemetry/) - 用于从您的设备收集时序数据的 API。
* [**实体和关系**](/docs/{{cloudDocsPrefix}}user-guide/entities-and-relations/) - 建模物理世界对象（例如，设备和资产）以及它们之间的关系。
* [**数据可视化**](/docs/{{cloudDocsPrefix}}guides/#AnchorIDDataVisualization) - 开发自定义仪表板和小部件。
* [**规则引擎**](/docs/{{cloudDocsPrefix}}user-guide/rule-engine-2-0/re-getting-started/) - 管理传入遥测和事件的数据处理和操作。
* [**RPC**](/docs/{{cloudDocsPrefix}}user-guide/rpc/) - 从边缘和云端向设备发送远程过程调用 (RPC)，反之亦然。
* [**审计日志**](/docs/{{cloudDocsPrefix}}user-guide/audit-log/) - 跟踪用户活动。
* [**API 限制**](/docs/{{cloudDocsPrefix}}user-guide/api-limits/) - 控制和限制来自单个主机的 API 请求数量。
<!-- 
{% if docsPrefix == 'pe/edge/' %}
此外，Edge PE 支持以下 **GridLinks PE** 功能：
* [**集成**](/docs/user-guide/integrations/)
    * 将现有的 NB IoT、LoRaWAN、SigFox 和其他具有特定有效负载格式的设备直接连接到 GridLinks 平台。
    * 从连接到现有物联网平台的设备流式传输数据，以实现实时交互式仪表板和高效的数据处理。
* [**白标**](/docs/pe/user-guide/white-labeling/) - 配置自定义菜单、徽标、配色方案、电子邮件服务器设置和客户电子邮件模板，以便与用户互动等。
* [**调度程序**](/docs/pe/user-guide/scheduler/) - 以灵活的配置安排各种类型的事件。
* [**实体组**](/docs/pe/user-guide/groups/) - 将实体组织成组，将角色分配给特定用户组，向特定用户组授予对特定设备组的特定权限。
{% endif %} -->

#### 项目路线图

<p><a href="/docs/{{docsPrefix}}roadmap" class="button">GridLinks Edge 路线图</a></p>

#### 后续步骤

<p><a href="/docs/{{docsPrefix}}getting-started" class="button">入门指南</a></p>