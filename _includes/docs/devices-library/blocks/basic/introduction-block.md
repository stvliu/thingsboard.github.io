在本指南中，我们将学习如何[在 Thingsboard 上创建设备](#create-device-on-thingsboard)、[安装所需的库和工具](#install-required-libraries-and-tools)。

在此之后，我们将[修改我们的代码并将其上传到设备](#connect-device-to-thingsboard)，并[检查我们的编码结果，并使用导入的仪表板检查 ThingsBoard 上的数据](#check-data-on-thingsboard)。

我们的设备将使用[客户端和共享属性请求功能](#synchronize-device-state-using-client-and-shared-attribute-requests)与 ThingsBoard 同步。

当然，我们将使用提供的功能（如[共享属性](#control-device-using-shared-attributes)或[RPC 请求](#control-device-using-rpc)）来控制我们的设备。

### 先决条件

要继续本指南，我们需要以下内容：

{{ prerequisites }}
{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
- [ThingsBoard 帐户](https://thingsboard.cloud){: target="_blank"}
{% else %}
- [ThingsBoard 帐户](https://demo.thingsboard.io){: target="_blank"}
{% endif %}