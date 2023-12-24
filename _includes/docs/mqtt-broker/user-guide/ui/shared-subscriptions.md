* TOC
{:toc}

应用程序共享订阅实体提供利用 [共享订阅](/docs/mqtt-broker/user-guide/shared-subscriptions/) 的功能，适用于 **应用程序** 客户端。此功能使多个客户端能够订阅并接收来自共享订阅的消息。

### 使用说明

在 TBMQ 中，应用程序共享订阅是用于管理共享订阅的实体。

* 如果你计划将共享订阅功能与 [应用程序客户端](/docs/mqtt-broker/user-guide/mqtt-client-type/#application-client) 一起使用，则添加应用程序共享订阅。
* 创建实体后，**主题过滤器** 和 **分区** 字段 **无法更改**。
* 应用程序共享订阅功能 **适用于 MQTT v5 及更早版本**。

代理管理员能够通过 Web UI 或 [REST API](/docs/mqtt-broker/application-shared-subscription/) 管理共享订阅。

### 添加共享订阅

要添加新的共享订阅，请按照以下步骤操作：
1. 打开 _共享订阅_ 页面，然后单击加号图标按钮添加应用程序共享订阅。
2. 在对话框中，请填写以下字段：
   - **名称** - 指示共享订阅名称。可以是您喜欢的任何名称，例如，“应用程序共享订阅”。
   - **主题过滤器** - 这是实际的主题过滤器，可以包括通配符 (#、+)。如果共享订阅主题过滤器是 `$share/group1/city/+/home/#`，则将主题过滤器字段设置为 `city/+/home/#`。
       创建后无法更改，并且必须唯一。
   - **分区** - 建议分区数等于或大于共享订阅的预期客户端数。
     例如，如果 5 个客户端将订阅共享订阅，则将分区设置为 5、10 或 15。
     这将确保订阅者均匀地分配负载。创建后无法更改。
3. 单击 _添加_ 按钮。

{% include images-gallery.html imageCollection="add-shared-subscriptions" %}

执行上述操作后，将添加名为 `tbmq.msg.app.shared.city.slw.home.mlw` 的 Kafka 主题。
{% include templates/mqtt-broker/application-shared-subscriptions.md %}

### 编辑共享订阅

在当前版本的 TBMQ 中，只有共享订阅的名称字段可以在创建后编辑。

要编辑实体，请执行以下步骤：
1. 单击共享订阅表的相应行。
2. 单击右上角带有铅笔图标的 _切换编辑模式_ 按钮。
3. 修改名称。
4. 单击 _应用更改_ 按钮以保存更改。

### 删除共享订阅

可以使用 Web UI 或 [REST API](/docs/mqtt-broker/application-shared-subscription/) 从 TBMQ 系统中删除共享订阅实体。

有几种删除方式：

1. **删除单个**。
   * 单击订阅的相应行中的删除图标并确认操作。
   * 单击该行，然后单击实体详细信息右侧面板中的 _删除应用程序共享订阅_ 按钮。
2. **删除多个**。
   * 通过单击复选框，可以选择多个项目。然后单击右上角的删除图标并确认操作。

{% include images-gallery.html imageCollection="delete-shared-subscriptions" %}

删除应用程序共享订阅实体后，也会删除相应的 Kafka 主题。
**注意**，为此，`TB_KAFKA_ENABLE_TOPIC_DELETION` 环境变量应设置为 `true`。