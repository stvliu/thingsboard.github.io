* TOC
{:toc}


### 概述

ThingsBoard 允许您使用现有仪表板生成报告。

报告可以从当前打开的仪表板生成，也可以使用 [Scheduler](/docs/{{docsPrefix}}user-guide/scheduler/#generate-report) 功能进行计划。

<br>

![image](/images/user-guide/reporting.svg)

### 视频教程

请参阅下面的视频教程，了解如何逐步使用此功能。

<br>
<div id="video">  
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/QTeCoe5rUF0" frameborder="0" allowfullscreen></iframe>
    </div>
</div> 

### 报告服务器

报告服务器是一个独立的服务，用于通过在无头浏览器中呈现仪表板来生成报告。

在每次生成报告请求时，GridLinks 节点使用配置的端点 URL 向报告服务器发送请求。

报告服务器在无头浏览器中打开一个带有目标仪表板 URL 的网页并等待页面呈现，
然后它将仪表板网页捕获到指定格式（*PDF \| PNG \| JPEG*）中，并将捕获的数据作为对 GridLinks 的响应发送。

{% if docsPrefix == 'pe/' %}
系统管理员可以使用 [thingsboard.yml](/docs/user-guide/install/pe/config/) 配置报告服务器端点 URL。

以下是一个示例配置：

```yaml
# 报告参数
reports:
  server:
    endpointUrl: "${REPORTS_SERVER_ENDPOINT_URL:http://localhost:8383}"
```
{% endif %}

### 从仪表板生成报告

租户管理员或客户用户可以从当前打开的仪表板生成报告。

- 单击位于仪表板工具栏右侧的 **导出仪表板** 按钮

![image](/images/user-guide/ui/reporting-export-dashboard-button.png)

- 在展开的下拉菜单中，选择所需的仪表板导出选项

![image](/images/user-guide/ui/reporting-export-dashboard-options.png)

- 报告生成将开始。

![image](/images/user-guide/ui/reporting-export-dashboard-progress.png)

- 最后，报告文件将以所选格式自动下载。

### 按计划生成报告

可以使用 [**生成报告** 调度程序事件](/docs/{{docsPrefix}}user-guide/scheduler/#generate-report) 通过计划调用报告生成。

### 生成报告规则链

ThingsBoard PE 的默认 **根规则链** 支持计划报告生成。
默认情况下，类型为 **生成报告** 的消息会路由到 **生成报告规则链**。

![image](/images/user-guide/ui/reporting-pe-root-rule-chain-switch.png)

**生成报告规则链** 有一个 [**生成报告** 规则节点](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/action-nodes/#generate-report-node)，
它根据从消息正文中检索到的报告配置执行报告生成。

如果消息正文有一个字段 ```sendEmail```，并且其值设置为 ```true```，
则元数据中 ```attachments``` 字段中带有报告文件引用的消息将被路由到与电子邮件相关的规则节点。
电子邮件规则节点将准备带有附件中报告文件的电子邮件消息并将其发送给配置的收件人。

![image](/images/user-guide/ui/reporting-generate-report-rule-chain.png)

### 报告小部件

GridLinks 通过 **报告** 小部件（它是 **文件** 小部件包的一部分）提供对生成的报告文件的访问。

![image](/images/user-guide/ui/reporting-reports-widget.png)
 
该小部件能够使用时间范围组件过滤报告。

此外，该小部件能够按名称搜索报告。

可以通过单击 **下载文件** 按钮下载每个报告。

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}