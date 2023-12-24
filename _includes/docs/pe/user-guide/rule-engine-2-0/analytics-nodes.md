{% assign feature = "PE Analytics Nodes" %}{% include templates/pe-feature-banner.md %}

Analytics Nodes 专门用于 ThingsBoard PE。用于分析流式或持久化数据。

* TOC
{:toc}

## 聚合最新节点

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-latest.png)

定期聚合子实体属性或最新时序，以获取指定的一组父实体。

执行从子实体获取的属性或最新时序的聚合，具有可配置的周期。

然后将聚合结果设置为父实体的指定目标时序属性。

为每个父实体和聚合属性生成 **POST_TELEMETRY_REQUEST** 类型的消息。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-latest-config.png)

- **执行周期值/时间单位** - 指定聚合任务的周期。
- **实体** - 指定应执行聚合的一组父实体。可以是：
    - **单个实体** - 一个特定实体。
    - **实体组** - 特定实体组。
    - **关系查询** - 从 **根实体** 开始通过 **关系查询** 找到的一组实体。
- **子实体** - 指定用于从父实体开始查找子实体的 **关系查询**。
仅当为父实体选择 **单个实体** 或 **关系查询** 时才应指定。
在 **实体组** 的情况下，从实体组本身选择子实体。
- **聚合最新映射** - 指定子属性聚合规则的映射配置表。

映射配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-latest-mapping-config.png)

- **最新遥测** - 指定是否应聚合子最新遥测或属性的值。
- **源遥测/属性** - 子最新遥测或属性键名。
- **属性范围** - 在将属性用作源时指定子属性的范围（未选中 **最新遥测**）。
- **默认值** - 在未定义源属性或子实体不存在源属性的情况下默认使用的数值。
- **聚合函数** - 用于子值聚合的数学函数。可以是：
    - **最小值** - 检测所有子实体中的最小属性值。
    - **最大值** - 检测所有子实体中的最大属性值。
    - **总和** - 计算子实体的属性值的总和。
    - **平均值** - 计算子实体的属性值的平均值。
    - **计数** - 执行子实体的计数。在这种情况下，不使用 **源遥测/属性**，并且可以为空。
    - **计数唯一值** - 执行子实体的唯一属性值的计数。
- **目标遥测** - 用于存储聚合结果的父实体的目标遥测键的名称。
- **过滤实体** - 是否在聚合子实体属性值之前执行子实体的过滤。
- **实体过滤器** - 用于过滤子实体的过滤器。它有两个部分：
    1. 应获取并用于 JavaScript 过滤器函数的实体属性/最新时序键列表。
    1. 应将过滤结果作为布尔值返回的 JavaScript 过滤器函数。
    它接收包含获取的属性/最新时序值作为输入参数的 **attributes** 映射。
    获取的属性值使用属性/最新时序键和范围前缀添加到 **attributes** 映射中：
        - 共享属性 -> <code>shared_</code>
        - 客户端属性 -> <code>cs_</code>
        - 服务器属性 -> <code>ss_</code>
        - 遥测 -> 不使用前缀

对于每个父实体，节点将生成并通过 **Success** 链转发新消息，类型为 **POST_TELEMETRY_REQUEST**，父实体本身作为发起者，json 正文包含具有聚合值的 目标遥测。
当某些子属性的聚合失败时，节点将生成失败消息，其中包含失败原因和父实体作为发起者。失败消息通过 **Failure** 链转发。

**自 TB 版本 3.3.3 起**，您可以选择队列名称：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-queue-name.png)

<br>

## 聚合流节点

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-stream.png)

根据传入的数据流计算 MIN/MAX/SUM/AVG/COUNT/UNIQUE。
根据消息的发起者 ID（即特定设备、资产、客户）、**聚合函数**（例如“平均值”、“总和”、“最小值”、“最大值”）、**聚合间隔值**（例如 1 分钟、6 小时）将传入的数据流分组为 **间隔**。


间隔根据 **间隔持久性策略** 和 **间隔检查值** 定期持久化。间隔根据 **间隔 TTL 值** 缓存在内存中。间隔的状态根据 **状态持久性策略** 和 **状态持久性值** 作为时序实体持久化。
如果没有某些实体的数据，则为这些实体生成默认值可能很有用。
要查找这些实体，可以选择 **自动创建间隔** 复选框并配置 **间隔实体**。


生成具有特定间隔聚合结果的 'POST_TELEMETRY_REQUEST' 消息。


下面的配置将计算每小时平均温度，并在每小时间隔结束时在一分钟内将其持久化。
如果某些延迟遥测到达特定间隔，规则节点将从内部缓存或遥测值中查找它。

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-stream-config.png)
    
聚合结果将每分钟持久化一次到数据库。或者，您可以在每条新消息上持久化间隔，以避免在服务器中断的情况下丢失任何数据。
如果某些建筑物的设备没有报告任何温度读数，我们可以通过选择“自动创建间隔”并指定“建筑物”实体组，为每个间隔生成该建筑物的默认值（零）。    

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-aggregate-stream-config-2.png)

**自 TB 版本 3.3.3 起**，您可以选择队列名称：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-queue-name.png)

## 警报计数节点

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 3.2.2 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count.png)

当收到有关新警报的输入消息时，计数警报。输入消息可能是 'ALARM'、'ALARM_ACK'、'ALARM_CLEAR' 或 'ENTITY_CREATED' 和有关警报的 'ENTITY_UPDATED' 消息。
根据警报计数映射和消息的发起者（设备、资产等）执行计数查询

然后将警报计数的结果设置为实体的指定目标时序属性。

为每个实体和警报计数结果生成 **POST_TELEMETRY_REQUEST** 类型的消息。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count-config-new.png)

- **计数传播实体的警报** - 如果启用，不仅会计数警报的发起者，还会计数所有传播实体的警报。
- **警报计数映射** - 指定用于计数警报的规则的映射配置表。

映射配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count-mapping-config.png)

- **目标遥测** - 用于存储警报计数结果的实体的目标遥测键的名称。
- **状态过滤器** - 用于过滤警报的允许警报状态列表。如果未指定，将选择具有任何状态的警报。
- **严重性过滤器** - 用于过滤警报的允许警报严重性列表。如果未指定，将选择具有任何严重性的警报。
- **类型过滤器** - 用于过滤警报的允许警报类型列表。如果未指定，将选择具有任何类型的警报。
- **指定间隔** - 如果选中，则仅选择在指定间隔内创建的警报，否则将选择整个时间的警报。

对于每个选定的实体，节点将生成并通过 **Success** 链转发新消息，类型为 **POST_TELEMETRY_REQUEST**，json 正文包含具有警报计数值的 目标遥测。
当某些实体的警报计数失败时，节点将生成失败消息，其中包含失败原因和实体作为发起者。失败消息通过 **Failure** 链转发。

**自 TB 版本 3.3.3 起**，您可以选择队列名称：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-queue-name.png)

<br>

## 警报计数节点（已弃用）

<table  style="width:250px;">
   <thead>
     <tr>
	 <td style="text-align: center"><strong><em>自 TB 版本 2.1 起</em></strong></td>
     </tr>
   </thead>
</table> 

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count.png)

定期对选定的一组实体进行警报计数。

执行对选定实体的警报计数，包括其子实体（如果指定），具有可配置的周期。

然后将警报计数的结果设置为实体的指定目标时序属性。

为每个实体和警报计数结果生成 **POST_TELEMETRY_REQUEST** 类型的消息。

配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count-config.png)

- **执行周期值/时间单位** - 指定警报计数任务的周期。
- **实体** - 指定应执行警报计数的实体集。可以是：
    - **单个实体** - 一个特定实体。
    - **实体组** - 特定实体组。
    - **关系查询** - 从 **根实体** 开始通过 **关系查询** 找到的实体集。
- **计数子实体的警报** - 是否对每个找到的实体的子实体执行警报计数。    
- **子实体** - 指定从父实体开始用于查找子实体的 **关系查询**。
仅当选中 **计数子实体的警报** 并且为实体选择 **单个实体** 或 **关系查询** 时才应指定。
在 **实体组** 的情况下，子实体从实体组本身选择。
- **警报计数映射** - 指定用于计数警报的规则的映射配置表。

映射配置：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-alarms-count-mapping-config.png)

- **目标遥测** - 用于存储警报计数结果的实体的目标遥测键的名称。
- **状态过滤器** - 用于过滤警报的允许警报状态列表。如果未指定，将选择具有任何状态的警报。
- **严重性过滤器** - 用于过滤警报的允许警报严重性列表。如果未指定，将选择具有任何严重性的警报。
- **类型过滤器** - 用于过滤警报的允许警报类型列表。如果未指定，将选择具有任何类型的警报。
- **指定间隔** - 如果选中，则仅选择在指定间隔内创建的警报，否则将选择整个时间的警报。

对于每个选定的实体，节点将生成并通过 **Success** 链转发新消息，类型为 **POST_TELEMETRY_REQUEST**，json 正文包含具有警报计数值的 目标遥测。
当某些实体的警报计数失败时，节点将生成失败消息，其中包含失败原因和实体作为发起者。失败消息通过 **Failure** 链转发。

**自 TB 版本 3.3.3 起**，您可以选择队列名称：

![image](/images/user-guide/rule-engine-2-0/pe/nodes/analytics-queue-name.png)

<br>