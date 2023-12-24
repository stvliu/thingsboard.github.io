* TOC
{:toc}

## 用例说明

作为设备制造商或固件开发人员，我希望我的设备能够在 GridLinks 中自动配置自身。
在自动配置期间，设备可以生成唯一凭据或要求服务器为设备提供唯一凭据。

从 3.5 版本开始，ThingsBoard 允许使用 [X.509 证书链](/docs/{{docsPrefix}}user-guide/certificates/) 通过 MQTT 上的认证自动配置新设备。

## 工作原理

<object width="80%" data="/images/user-guide/device-provisioning/flow.svg"></object>

设备可以向 ThingsBoard 发送设备配置请求（请求）。请求应始终包含配置密钥和密钥。
请求可以选择性地包括设备名称和设备生成的凭据。
如果这些凭据不存在，服务器将生成设备要使用的访问令牌。

配置请求示例：

```json
{
  "deviceName": "DEVICE_NAME",
  "provisionDeviceKey": "YOUR_PROVISION_KEY_HERE",
  "provisionDeviceSecret": "YOUR_PROVISION_SECRET_HERE"
}
```
{: .copy-code}

ThingsBoard 验证请求并回复设备配置响应（响应）。
成功的响应包含设备 ID、凭据类型和正文。
如果验证不成功，响应将仅包含状态。

配置响应示例：

```json
{
  "provisionDeviceStatus":"SUCCESS",
  "credentialsType":"ACCESS_TOKEN",
  "accessToken":"sLzc0gDAZPkGMzFVTyUY"
}
```
{: .copy-code}

在验证请求期间，ThingsBoard 将首先检查提供的 *provisionDeviceKey* 和 *provisionDeviceSecret* 以找到相应的 [设备配置文件](/docs/{{docsPrefix}}user-guide/device-profiles/)。
找到配置文件后，平台将使用配置的配置策略来验证设备名称。
有两种可用的配置策略：

* **允许创建新设备** - 检查具有相同名称的设备尚未在 GridLinks 中注册。
当您在制造期间不知道唯一设备名称（MAC 地址等）的列表，但设备本身在固件中可以访问此信息时，此策略非常有用。
它更容易实现，但不如第二种策略安全。
* **检查预配置设备** - 检查具有相同名称的设备已在 GridLinks 中创建，但尚未配置。
当您只想允许对特定设备列表进行配置时，此策略非常有用。假设您在制造期间收集了唯一 ID（MAC 地址等）的列表。
您可以使用 [批量配置](/docs/{{docsPrefix}}user-guide/bulk-provisioning/) 将此列表上传到 GridLinks。现在，列表中的设备可以发出配置请求，其他设备将无法自行配置。

配置完成后，ThingsBoard 将更新设备的 *provisionState* 服务器属性，并将其设置为 *provisioned* 值。

## 设备配置文件配置

您应该配置设备配置文件以启用配置功能，收集配置设备密钥和配置设备密钥。

{% include images-gallery.html imageCollection="deviceProfileConfiguration" showListImageTitles="true" %}

## 配置设备 API

#### MQTT 设备 API

您可以使用 [MQTT API](/docs/{{docsPrefix}}reference/mqtt-api/#device-provisioning) 参考来开发将执行配置请求的设备固件。
如前所述，设备可以在注册过程中请求服务器生成凭据或提供其自己的凭据。
请参阅以下每个选项的请求/响应和代码示例：

{% capture mqttcredentialstogglespec %}
GridLinks 服务器生成的凭据%,%without%,%templates/provisioning/mqtt-without-credentials-type.md%br%
设备提供<br>访问令牌%,%access-token%,%templates/provisioning/mqtt-access-token-credentials-type.md%br%
设备提供<br>基本 MQTT 凭据%,%mqtt-basic%,%templates/provisioning/mqtt-basic-credentials-type.md%br%
设备提供<br>X.509 证书%,%x509-certificate%,%templates/provisioning/x509-certificate-credentials-type.md{% endcapture %}
{% include content-toggle.html content-toggle-id="mqttprovisioning" toggle-spec=mqttcredentialstogglespec %}

#### HTTP 设备 API

您可以使用 [HTTP API](/docs/{{docsPrefix}}reference/http-api/#device-provisioning) 参考来开发将执行配置请求的设备固件。
如前所述，设备可以在注册过程中请求服务器生成凭据或提供其自己的凭据。
请参阅以下每个选项的请求/响应和代码示例：

{% capture httpcredentialstogglespec %}
GridLinks 服务器生成的凭据%,%without%,%templates/provisioning/http-without-credentials-type.md%br%
设备提供<br>访问令牌%,%access-token%,%templates/provisioning/http-access-token-credentials-type.md%br%{% endcapture %}
{% include content-toggle.html content-toggle-id="httpprovisioning" toggle-spec=httpcredentialstogglespec %}

#### CoAP 设备 API

您可以使用 [CoAP API](/docs/{{docsPrefix}}reference/coap-api/#device-provisioning) 参考来开发将执行配置请求的设备固件。
如前所述，设备可以在注册过程中请求服务器生成凭据或提供其自己的凭据。
请参阅以下每个选项的请求/响应和代码示例：

{% capture coapcredentialstogglespec %}
GridLinks 服务器生成的凭据%,%without%,%templates/provisioning/coap-without-credentials-type.md%br%
设备提供<br>访问令牌%,%access-token%,%templates/provisioning/coap-access-token-credentials-type.md%br%{% endcapture %}
{% include content-toggle.html content-toggle-id="coapprovisioning" toggle-spec=coapcredentialstogglespec %}

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}