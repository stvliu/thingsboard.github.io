* TOC
{:toc}

TBMQ 通过其 Web UI 和 [REST API](/docs/mqtt-broker/mqtt-client-credentials-management/) 提供各种选项来管理 MQTT 客户端凭据。

TBMQ 支持以下类型的客户端凭据来验证客户端连接：
- [基本](/docs/mqtt-broker/security/#basic-authentication) - 基于客户端 ID、用户名和密码组合的基本安全措施。
  - **优点：**简单易行。广泛受应用程序和服务支持。网络开销低。
  - **缺点：**安全性有限。
- [X.509 证书链](/docs/mqtt-broker/security/#tls-authentication) - 基于 X509 证书链的高级安全措施，有助于验证客户端的身份。
  - **优点：**与基本客户端凭据类型相比，安全性增强。使用 SSL 客户端凭据，客户端和 TBMQ 都可以相互验证。SSL 客户端凭据类型在访问控制方面提供了更大的灵活性，因为它允许基于证书主题名称和其他属性制定更细粒度的访问控制策略。
  - **缺点：**复杂且成本增加。设置和管理 SSL 客户端凭据可能更复杂，需要更多专业知识。SSL 加密和解密需要更多计算资源。

在使用上述任何客户端凭据类型之前，请确保已在 TBMQ [配置文件](/docs/mqtt-broker/install/config/) 中启用它们。
- **基本身份验证。**要启用 MQTT 基本凭据，请将 `SECURITY_MQTT_BASIC_ENABLED` 设置为 `true`。
- **X.509 证书链身份验证。**要启用 MQTT SSL 凭据，请将 `SECURITY_MQTT_SSL_ENABLED` 设置为 `true`。

请注意，在 Web UI _主页_上，您可以在配置卡上查看这些参数的当前状态。

![image](/images/mqtt-broker/user-guide/ui/config-card.png)

有关安全问题的更多信息，请参阅本 [指南](/docs/mqtt-broker/security/)。

### 添加 MQTT 客户端凭据

要添加新的客户端凭据，请按照以下步骤操作：

1. 转到 _凭据_页面，然后单击由加号图标表示的添加 _客户端凭据_按钮。
2. 填写名称字段（无需唯一）。
3. 选择适当的 _客户端类型_：
   - **设备。**适用于通常发布大量消息但订阅少量主题且消息速率较低的客户端，即物联网设备。
   - **应用程序。**适用于订阅消息速率高且在客户端离线时需要消息持久性的客户端，例如 **GridLinks、AWS IoT Core** 等应用程序。

有关客户端类型的更多信息，请参阅 [文档](/docs/mqtt-broker/user-guide/mqtt-client-type/)。

4. 选择所需的 _凭据类型_并配置身份验证参数和授权规则。

{% include images-gallery.html imageCollection="add-client-credentials" %}

#### MQTT 基本凭据

##### 身份验证

MQTT 基本身份验证基于客户端 ID、用户名和/或密码的不同组合：
- **客户端 ID** - 验证连接的客户端是否具有指定的 clientId。
- **用户名** - 验证连接的客户端是否具有指定的用户名。
- **客户端 ID 和用户名** - 验证连接的客户端是否具有指定的 clientId 和用户名。
- **用户名和密码** - 验证连接的客户端是否具有指定的用户名和密码。
- **客户端 ID 和密码** - 验证连接的客户端是否具有指定的 clientId 和密码。
- **客户端 ID、用户名和密码** - 验证连接的客户端是否具有指定的 clientId、用户名和密码。

##### 授权规则

授权规则模式允许根据 **正则表达式语法** 控制客户端可以发布/订阅哪些主题：

* **允许特定主题** - 规则 `country/.*` 将允许客户端仅发布/订阅以 `country/` 开头的主题。
* **允许任何主题** - 规则 `.*`（默认）将允许客户端发布/订阅任何主题的消息。
* **禁止所有主题** - 如果规则为 `empty`，则禁止客户端发布/订阅任何主题。

##### 更改 MQTT 基本凭据的密码

代理管理员可以修改 MQTT 基本客户端凭据的密码。为此，请按照以下说明操作：
1. 转到 _客户端凭据_页面。
2. 单击凭据的相应行。
3. 单击 _编辑_按钮。
4. 单击 _更改密码_按钮。输入您的当前密码并设置新密码。
5. 确认更改。

{% include images-gallery.html imageCollection="change-password-basic-credentials" %}

#### SSL 凭据

**X.509 证书链**是一种通过具有公钥证书链的 TLS 进行的安全双向身份验证方法。

##### 身份验证

**证书的公用名 (CN)** 应与客户端的 CN 完全匹配，或者如果存在，则应与父证书 CN 之一匹配。如果链中的任何证书都没有相同的 CN，则身份验证将失败。

![image](/images/mqtt-broker/user-guide/ui/ssl-credentials-1.png)

##### 授权规则

授权规则允许根据以下组合的成功来控制经过身份验证的客户端可以发布/订阅哪些主题：

* **客户端证书 CN 匹配器正则表达式** - 应与客户端证书的 CN 匹配。
* **发布/订阅授权规则模式** - 允许控制具有匹配的客户端证书 CN 匹配器正则表达式的客户端可以发布/订阅哪些主题。

请考虑以下示例：
* 如果客户端证书的 CN 为 `cn_example_1` - 将客户端证书 CN 匹配器正则表达式设置为 `cn_example_1` 或 `example_1` 或 `.*example.*`。
* 如果发布授权规则模式设置为 `pub_topic/one/.*, pub_topic/two/.*` - 客户端将只能发布到以 `pub_topic/one/` 或 `pub_topic/two/` 开头的主题。
* 如果订阅授权规则模式设置为默认值 `.*` - 客户端将能够订阅任何主题。
* 如果发布/订阅授权规则没有规则（字段为空） - 将禁止客户端发布/订阅任何主题。

![image](/images/mqtt-broker/user-guide/ui/ssl-credentials-2.png)

### 删除客户端凭据

代理管理员可以使用 Web UI 或 [REST API](/docs/mqtt-broker/mqtt-client-credentials-management/) 从 TBMQ 系统中删除客户端凭据。

有几种删除客户端凭据的方法：
1. **删除单个。**
   - 单击凭据的相应行中的 _删除_图标并确认操作。
   - 单击凭据行并单击 _删除客户端凭据_按钮。
2. **删除多个。**
   * 通过单击复选框，您可以选择多个项目。然后单击右上角的 _删除_图标并确认操作。

{% include images-gallery.html imageCollection="delete-client-credentials" %}