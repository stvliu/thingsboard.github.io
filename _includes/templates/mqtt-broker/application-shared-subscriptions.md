主题名称的构建由将 MQTT 主题过滤器映射到相应的 Kafka 主题来确定。
这种映射是通过遵循特定的命名约定（MQTT 主题过滤器 -> Kafka 主题）来实现的。

```
test/topic -> tbmq.msg.app.shared.test.topic
test/# -> tbmq.msg.app.shared.test.mlw
test/+ -> tbmq.msg.app.shared.test.slw
```

其中
* `tbmq.msg.app.shared.` 添加为前缀
* `/` 替换为 `.`
* `#` 替换为 `mlw`（多级通配符）
* `+` 替换为 `slw`（单级通配符）

如果 MQTT 主题过滤器包含任何前面未提及的特殊字符（字母数字字符除外），
则将利用从主题过滤器派生的哈希来创建 Kafka 主题。
这种方法确保生成的 Kafka 主题保持有效并遵守必要的命名约定。

```
tbmq.msg.app.shared.$TOPIC_FILTER_HASH
```

上述行为可以通过 `TB_APP_PERSISTED_MSG_SHARED_TOPIC_VALIDATION` 属性来调节。
默认情况下，此变量处于启用状态，这意味着验证过程处于活动状态，确保正确创建主题。
但是，如果您选择通过将变量设置为 _false_ 来禁用此验证，
则系统将不再为具有特殊字符的主题过滤器的共享订阅创建 Kafka 主题，
导致无法创建相应的主题。
在配置环境和处理具有特殊字符的客户端 ID 时，这一点很重要。