* TOC
{:toc}

应用程序共享订阅实体提供利用 **应用程序** 客户端的 [共享订阅](/docs/mqtt-broker/user-guide/shared-subscriptions/) 功能的能力。此功能使多个客户端能够订阅和接收来自共享订阅的消息。在创建应用程序共享订阅实体时，将自动创建一个相应的 Kafka 主题。此 Kafka 主题用作与共享订阅相关的所有消息的存储库。

要在系统中创建新的应用程序共享订阅实体，必须以管理员用户身份进行身份验证。

{% include templates/mqtt-broker/authentication.md %}

##### 创建/更新应用程序共享订阅

```bash
curl --location --request POST 'http://localhost:8083/api/app/shared/subs' \
--header "X-Authorization: Bearer $ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "test",
    "partitions": 1,
    "topicFilter": "test/topic"
}'
```
{: .copy-code}

在执行上述请求后，将在 PostgreSQL 数据库中创建一个实体，并将添加名为 `tbmq.msg.app.shared.test.topic` 的 Kafka 主题。Kafka 主题将由单个分区组成。
{% include templates/mqtt-broker/application-shared-subscriptions.md %}

**请注意**，一旦创建实体，便无法更新 _partitions_ 或 _topicFilter_ 字段。因此，在创建实体之前仔细考虑所需的主题过滤器和分区数非常重要。建议创建具有更多分区而不是更少分区的实体。这允许通过在将来将新客户端添加到共享订阅来实现横向扩展。在使用不当的值或配置创建实体的情况下，有必要删除实体，然后使用正确的值创建一个新实体。因此，在初始创建过程中必须谨慎行事并做出明智的决策，以避免需要进行后续修改或重新创建。

例如，如果您预计有一个主题过滤器，其中有 5 个客户端将订阅，则建议将分区数配置为 5 的倍数，例如 5、10 或 15。通过这样做，您可以确保负载在订阅者之间均匀分布，从而促进平衡处理和提高性能。

##### 获取所有应用程序共享订阅实体

```bash
curl --location --request GET 'http://localhost:8083/api/app/shared/subs?pageSize=100&page=0' \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}
**注意**，_pageSize_ 参数等于 100，_page_ 参数等于 0，因此上述请求将获取前 100 个应用程序共享订阅实体。

##### 删除应用程序共享订阅实体

删除应用程序共享订阅实体后，也将删除尊重的 Kafka 主题。**注意**，为此，`TB_KAFKA_ENABLE_TOPIC_DELETION` 环境变量应设置为 `true`。

```bash
curl --location --request DELETE 'http://localhost:8083/api/app/shared/subs/$APP_SHARED_SUBS_ID' \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}

粘贴要删除的应用程序共享订阅实体的实际 ID，而不是 _$APP_SHARED_SUBS_ID_。