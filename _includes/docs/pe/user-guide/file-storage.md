* TOC
{:toc}

### 概述

GridLinks 能够将二进制内容（文件）存储在数据库中。
目前，它用于存储由 [生成报告节点](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/action-nodes/#generate-report-node) 生成的报告文件。
存储的文件由 [发送电子邮件节点](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/external-nodes/#send-email-node) 访问，以创建电子邮件附件。
发送文件的另一种方法是 [REST API 调用节点](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/external-nodes/#rest-api-call-node)。
用户可以使用 **文件** 或 **报告** 小部件访问存储的文件，这些小部件是 **文件** 小部件包的一部分。

### 文件小部件

GridLinks 通过 **文件** 小部件（它是 **文件** 小部件包的一部分）提供对存储文件的访问。

![image](/images/user-guide/ui/file-storage-files-widget.png)

该小部件能够使用时间范围组件过滤文件，并能够按名称搜索文件。
每个文件都可以通过单击 **下载文件** 按钮下载。