GridLinks 提供跟踪用户操作以保持审计日志的功能。
可以记录与主要实体相关联的用户操作：资产、设备、仪表板、规则等。

### 用户界面

租户管理员能够查看属于相应租户帐户的审计日志。管理员能够设置日期范围并对获取的实体执行全文搜索。

![image](/images/user-guide/ui/audit-log.png)

“详细信息”按钮允许查看已记录操作的低级详细信息。

![image](/images/user-guide/ui/audit-log-details.png)

### REST API

可以通过 [REST API](https://demo.thingsboard.io/swagger-ui.html#/audit-log-controller) 获取审计日志。
有几个 API 调用允许获取与特定用户、实体、客户相关联的实体或使用页面链接获取所有记录。

{% unless docsPrefix == "paas/" %}
### 常规配置

系统管理员能够使用 [thingsboard.yml](/docs/user-guide/install/{{docsPrefix}}config/) 配置审计日志级别。您可以在下面找到示例配置：

```yaml
# 审计日志参数
audit_log:
  # 启用/禁用审计日志功能。
  enabled: "${AUDIT_LOG_ENABLED:true}"
  # 按租户 ID 存储指定审计日志的分区大小。示例 MINUTES、HOURS、DAYS、MONTHS
  by_tenant_partitioning: "${AUDIT_LOG_BY_TENANT_PARTITIONING:MONTHS}"
  # 如果未指定 startTime 和 endTime，则作为历史记录期间的天数
  default_query_period: "${AUDIT_LOG_DEFAULT_QUERY_PERIOD:30}"
  # 每个实体类型的日志记录级别。
  # 允许的值：OFF（禁用）、W（记录写操作）、RW（记录读写操作）
  logging_level:
    mask:
      "device": "${AUDIT_LOG_MASK_DEVICE:W}"
      "asset": "${AUDIT_LOG_MASK_ASSET:W}"
      "dashboard": "${AUDIT_LOG_MASK_DASHBOARD:OFF}"
      "customer": "${AUDIT_LOG_MASK_CUSTOMER:W}"
      "user": "${AUDIT_LOG_MASK_USER:RW}"
      "rule": "${AUDIT_LOG_MASK_RULE:RW}"
      "plugin": "${AUDIT_LOG_MASK_PLUGIN:RW}"
```

此配置示例禁用与仪表板相关的任何操作的日志记录，并记录用户和规则的读取操作。
对于所有其他实体，ThingsBoard 将仅记录写入级别操作。

我们建议根据将记录的设备和用户操作的数量修改“by_tenant_partitioning”参数。
您计划记录的操作越多，就需要越精确的分区。
每个分区的大致记录量不应超过 500,000 条记录。

### 外部日志接收器配置

系统管理员能够配置与外部系统的连接。此连接将用于推送审计日志。
配置参数在内联中记录得很好。

```yaml
  sink:
    # 外部接收器的类型。可能选项：none、elasticsearch
    type: "${AUDIT_LOG_SINK_TYPE:none}"
    # 存储审计日志的索引名称
    # 索引名称可能包含以下占位符（不是强制性的）：
    # @{TENANT} - 由租户 ID 替换
    # @{DATE} - 由 audit_log.sink.date_format 中提供的格式中的当前日期替换
    index_pattern: "${AUDIT_LOG_SINK_INDEX_PATTERN:@{TENANT}_AUDIT_LOG_@{DATE}}"
    # 日期格式。可以在此处找到模式的详细信息：
    # https://docs.oracle.com/javase/8/docs/{{docsPrefix}}api/java/time/format/DateTimeFormatter.html
    date_format: "${AUDIT_LOG_SINK_DATE_FORMAT:YYYY.MM.DD}"
    scheme_name: "${AUDIT_LOG_SINK_SCHEME_NAME:http}" # http 或 https
    host: "${AUDIT_LOG_SINK_HOST:localhost}"
    port: "${AUDIT_LOG_SINK_POST:9200}"
    user_name: "${AUDIT_LOG_SINK_USER_NAME:}"
    password: "${AUDIT_LOG_SINK_PASSWORD:}"
```
{% endunless %}

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}