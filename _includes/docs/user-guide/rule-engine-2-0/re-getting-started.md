* TOC
{:toc}

## GridLinks 规则引擎是什么？
规则引擎是一个易于使用的框架，用于构建基于事件的工作流。它有 3 个主要组件：

- **消息** - 任何传入事件。它可以是来自设备的传入数据、设备生命周期事件、REST API 事件、RPC 请求等。
- **规则节点** - 在传入消息上执行的函数。有许多不同类型的节点，它们可以过滤、转换或对传入消息执行某些操作。
- **规则链** - 节点通过关系相互连接，因此规则节点的出站消息被发送到下一个连接的规则节点。


## 典型案例
GridLinks 规则引擎是一个高度可定制的复杂事件处理框架。以下是可以通过 GridLinks 规则链配置的一些常见案例：

- 在将数据保存到数据库之前，对传入遥测或属性进行数据验证和修改。
- 将遥测或属性从设备复制到相关资产，以便您可以聚合遥测。例如，来自多个设备的数据可以聚合
在相关资产中。
- 根据定义的条件创建/更新/清除警报。
- 根据设备生命周期事件触发操作。例如，如果设备在线/离线，则创建警报。
- 加载处理所需的额外数据。例如，加载设备客户或租户属性中定义的设备的温度阈值。
- 触发对外部系统的 REST API 调用。
- 当复杂事件发生时发送电子邮件，并在电子邮件模板中使用其他实体的属性。
- 在事件处理期间考虑用户偏好。
- 根据定义的条件进行 RPC 调用。
- 与外部管道集成，如 Kafka、Spark、AWS 服务等。

## Hello-World 示例
假设您的设备使用 DHT22 传感器收集温度并将其推送到 GridLinks。
DHT22 传感器可以测量 -40°C 至 +80°C 的温度。

在本教程中，我们将配置 GridLinks 规则引擎以存储 -40 至 80°C 范围内的所有温度，并将所有其他读数记录到系统日志。

#### 添加温度验证节点
在 Thingsboard UI 中，转到 **规则链** 部分并打开 **根规则链**。

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/initial-root-chain-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/initial-root-chain-pe.png)
{% endif %}

将 **脚本过滤器** 规则节点拖放到链中。将打开节点配置窗口。

{% include templates/tbel-vs-js.md %}

{% capture scriptfunctionfilterconfig %}
TBEL<small>推荐</small>%,%accessToken%,%templates/rule-engine/getting-started/script-function-filter-tbel.md%br%
JavaScript<small></small>%,%anonymous%,%templates/rule-engine/getting-started/script-function-filter-java.md{% endcapture %}

{% include content-toggle.html content-toggle-id="scriptfunctionfilterconfig" toggle-spec=scriptfunctionfilterconfig %}

如果未定义温度属性或温度有效 - 脚本将返回 **True**，否则将返回 **False**。
如果脚本返回 **True**，传入消息将被路由到通过 **True** 关系连接的下一个节点。

现在我们希望所有 **遥测请求** 都通过此验证脚本。我们需要删除 **消息类型开关** 节点和 **保存遥测** 节点之间的现有 **发布遥测** 关系：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/remove-relation-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/remove-relation-pe.png)
{% endif %}

并使用 **发布遥测** 关系将 **消息类型开关** 节点与 **脚本过滤器** 节点连接：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/realtion-window-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/realtion-window-pe.png)
{% endif %}

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/connect-script-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/connect-script-pe.png)
{% endif %}


接下来，我们需要使用 **True** 关系将 **脚本过滤器** 节点与 **保存遥测** 节点连接。因此，所有有效的遥测都将被保存：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/script-to-save-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/script-to-save-pe.png)
{% endif %}

此外，我们将使用 **False** 关系将 **脚本过滤器** 节点与 **日志其他** 节点连接。这样，所有无效的遥测都将记录在系统日志中：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/false-log-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/false-log-pe.png)
{% endif %}

按保存按钮应用更改。

#### 验证结果
为了验证结果，我们需要创建设备并将遥测提交给 Thingsboard。因此，请转到 **设备** 部分并创建新设备：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/create-device-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/create-device-pe.png)
{% endif %}

对于发布设备遥测，我们将使用 [Rest API](/docs/{{docsPrefix}}reference/http-api/#telemetry-upload-api/)。为此，我们需要
从设备 **DHT22** 复制设备访问令牌。

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/copy-access-token-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/copy-access-token-pe.png)
{% endif %}

<br>
使用终端将发送一条温度读数 = 99 的消息。将 **$ACCESS_TOKEN** 替换为实际设备令牌。

{% if docsPrefix == null %}
```bash
curl -v -X POST -d '{"temperature":99}' https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/terminal-demo-2.png)
{% endif %}
{% if docsPrefix == "pe/" %}
```bash
curl -v -X POST -d '{"temperature":99}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/terminal-localhost-2.png)
{% endif %}
{% if docsPrefix == "paas/" %}
```bash
curl -v -X POST -d '{"temperature":99}' https://gridlinks.codingas.com/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/terminal-cloud-2.png)
{% endif %}

我们将看到遥测 **未** 添加到设备 **最新遥测** 部分：

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/empty-telemetry-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/empty-telemetry-pe.png)
{% endif %}

<br>

现在发送一条温度读数 = 24 的消息。

{% if docsPrefix == null %}
```bash
curl -v -X POST -d '{"temperature":24}' https://demo.thingsboard.io/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/terminal-demo-1.png)
{% endif %}
{% if docsPrefix == "pe/" %}
```bash
curl -v -X POST -d '{"temperature":24}' http://localhost:8080/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/terminal-localhost-1.png)
{% endif %}
{% if docsPrefix == "paas/" %}
```bash
curl -v -X POST -d '{"temperature":24}' https://gridlinks.codingas.com/api/v1/$ACCESS_TOKEN/telemetry --header "Content-Type:application/json"
```
{: .copy-code}

![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/terminal-cloud-1.png)
{% endif %}

我们将看到遥测已成功保存。

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/saved-ok-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/saved-ok-pe.png)
{% endif %}


## 另请参阅

您可以使用以下链接了解更多有关 Thingsboard 规则引擎的信息：

- [规则引擎概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)
- [调试节点执行](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/#debugging)
- [验证传入遥测](/docs/user-guide/rule-engine-2-0/tutorials/validate-incoming-telemetry/)
- [转换传入遥测](/docs/user-guide/rule-engine-2-0/tutorials/transform-incoming-telemetry/)
- [使用先前记录转换遥测](/docs/user-guide/rule-engine-2-0/tutorials/transform-telemetry-using-previous-record/)
- [创建和清除警报](/docs/user-guide/rule-engine-2-0/tutorials/create-clear-alarms/)
- [在警报时发送电子邮件](/docs/user-guide/rule-engine-2-0/tutorials/send-email/)
- [设备离线时创建警报](/docs/user-guide/rule-engine-2-0/tutorials/create-inactivity-alarm/)
- [检查实体之间的关系](/docs/user-guide/rule-engine-2-0/tutorials/check-relation-tutorial/)
- [向相关设备发送 RPC 请求](/docs/user-guide/rule-engine-2-0/tutorials/rpc-request-tutorial/)
- [动态地将设备添加到组并从组中删除设备](/docs/user-guide/rule-engine-2-0/tutorials/add-devices-to-group/)
- [聚合传入数据流](/docs/user-guide/rule-engine-2-0/tutorials/aggregate-incoming-data-stream/)

<br>
<br>

## 后续步骤

{% assign currentGuide = "GettingStartedGuides" %}{% include templates/multi-project-guides-banner.md %}