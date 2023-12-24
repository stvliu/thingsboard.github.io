* TOC
{:toc}

本指南概述了您在根据特定要求和基础设施管理 MQTT 客户端的 **身份验证** 和 **授权** 时拥有的各种选项。

身份验证是指验证连接到代理的 MQTT 客户端的身份的过程。它确保只有经过身份验证的客户端才能访问系统。本指南将探讨不同的身份验证机制，例如基本身份验证和 SSL/TLS 客户端证书身份验证。它将解释如何根据您的安全需求配置和启用这些身份验证方法。

另一方面，授权涉及根据经过身份验证的客户端的权限授予或拒绝对特定资源或操作的访问。您将学习如何向客户端分配主题授权规则以控制其权限并限制其在 MQTT 系统中的操作。

通过理解和实施本指南中概述的身份验证和授权选项，您可以确保安全且受控地访问 MQTT 代理，保护您的基础设施和数据免遭未经授权的访问或滥用。

### MQTT 侦听器

TBMQ 提供了为 TCP 和 SSL/TLS 协议以及 MQTT over WebSockets 配置其侦听功能的灵活性。

#### TCP 侦听器

默认情况下，TBMQ 在端口 `1883` 上启用了 TCP 侦听器。
但是，如果您希望禁用 TCP 侦听器，可以将 `LISTENER_TCP_ENABLED` 环境变量设置为 `false`。

此外，如果您需要更改代理绑定的主机地址或其侦听的端口，您可以分别修改 `LISTENER_TCP_BIND_ADDRESS` 和 `LISTENER_TCP_BIND_PORT` 变量。这使您可以灵活地配置代理以侦听您选择的特定网络接口和端口。

通过调整这些环境变量，您可以自定义 TBMQ 的 TCP 侦听行为以满足您的特定要求。

#### TLS 侦听器

要启用 SSL/TLS 侦听器，请将 `LISTENER_SSL_ENABLED` 环境变量设置为 `true`。默认情况下，代理在 `8883` 端口上侦听。
要更改代理侦听的主机和/或端口，请分别更新 `LISTENER_SSL_BIND_ADDRESS` 和 `LISTENER_SSL_BIND_PORT` 变量。

通过设置 `LISTENER_SSL_CREDENTIALS_TYPE` 参数选择您要使用的凭据类型。目前，支持的选项是 `PEM` 和 `KEYSTORE`。
请注意，您可以在 [配置文档](/docs/mqtt-broker/install/config/) 中找到所有可用属性的列表。

如果您选择 KeyStore 作为凭据类型，则需要配置以下内容：
- 将 `LISTENER_SSL_KEY_STORE` 变量设置为包含服务器证书链的 `.jks` 文件的路径。
- 将 `LISTENER_SSL_KEY_STORE_PASSWORD` 变量设置为用于访问密钥库的密码。
- 将 `LISTENER_SSL_KEY_PASSWORD` 变量设置为服务器证书的密码。

如果您选择 Pem 作为凭据类型，则需要配置以下内容：
- 将 `LISTENER_SSL_PEM_CERT` 变量设置为服务器证书文件的路径。
- 将 `LISTENER_SSL_PEM_KEY` 变量设置为服务器证书私钥文件的路径。
- 将 `LISTENER_SSL_PEM_KEY_PASSWORD` 变量设置为服务器证书私钥的密码。

如果您需要双向 TLS，您还需要通过将受信任的证书/链添加到已配置的 KeyStore/PEM 文件来配置 TrustStore。
有关配置可能性和证书生成的更多信息，请查看以下 GridLinks 安全 [页面](/docs/user-guide/mqtt-over-ssl/)。

#### WS 侦听器

默认情况下，TBMQ 在端口 `8084` 上启用了 WebSocket 侦听器。
但是，如果您想禁用 WS 侦听器，可以将 `LISTENER_WS_ENABLED` 环境变量设置为 `false`。

此外，如果您需要更改代理绑定的主机地址或其侦听的端口，
您可以分别修改 `LISTENER_WS_BIND_ADDRESS` 和 `LISTENER_WS_BIND_PORT` 变量。

WS 侦听器默认配置为通过所有 MQTT 版本进行协商，即 `WS_NETTY_SUB_PROTOCOLS` 设置为 `mqttv3.1,mqtt`。
子协议设置 `mqtt` 代表 MQTT 3.1.1 和 MQTT 5。

#### WSS 侦听器

要启用 WebSocket 安全侦听器，请将 `LISTENER_WSS_ENABLED` 环境变量设置为 `true`。默认情况下，代理在 `8085` 端口上侦听。
要更改代理侦听的主机和/或端口，请分别更新 `LISTENER_WSS_BIND_ADDRESS` 和 `LISTENER_WSS_BIND_PORT` 变量。

通过设置 `LISTENER_WSS_CREDENTIALS_TYPE` 参数选择您要使用的凭据类型。
支持的选项与 [TLS](#tls-listener) 侦听器相同。

如果您选择 KeyStore 作为凭据类型，则需要配置以下内容：
- 将 `LISTENER_WSS_KEY_STORE` 变量设置为包含服务器证书链的 `.jks` 文件的路径。
- 将 `LISTENER_WSS_KEY_STORE_PASSWORD` 变量设置为用于访问密钥库的密码。
- 将 `LISTENER_WSS_KEY_PASSWORD` 变量设置为服务器证书的密码。

如果您选择 Pem 作为凭据类型，则需要配置以下内容：
- 将 `LISTENER_WSS_PEM_CERT` 变量设置为服务器证书文件的路径。
- 将 `LISTENER_WSS_PEM_KEY` 变量设置为服务器证书私钥文件的路径。
- 将 `LISTENER_WSS_PEM_KEY_PASSWORD` 变量设置为服务器证书私钥的密码。

如果您需要双向 TLS，请不要忘记通过添加受信任的证书/链来配置 TrustStore。
WSS 侦听器设置为与 [WS](#ws-listener) 侦听器相同的协商子协议。如果您需要更改此默认行为，请相应地更新 `WSS_NETTY_SUB_PROTOCOLS` 参数。

### 身份验证

#### 基本身份验证

要在您的系统中启用基于 **用户名、密码和 clientId** 的基本身份验证，请按照以下步骤操作：

1. 将 `SECURITY_MQTT_BASIC_ENABLED` 环境变量设置为 `true`。
2. 使用 [Web UI 指南](/docs/mqtt-broker/user-guide/ui/mqtt-client-credentials/) 或 [REST API 指南](/docs/mqtt-broker/mqtt-client-credentials-management/) 创建类型为 `Basic` 的 MQTT 客户端凭据。
3. 创建凭据后，`credentialsId` 字段会自动生成。有关更多信息，请参见下文。

##### 凭据匹配

以下是 **可能的组合** 的 `Basic` 凭据匹配器：
- **clientId** - 检查连接的客户端是否指定了 clientId。
- **username** - 检查连接的客户端是否指定了用户名。
- **clientId 和 username** - 检查连接的客户端是否同时指定了 clientId 和 username。
- **username 和 password** - 检查连接的客户端是否同时指定了 username 和 password。
- **clientId 和 password** - 检查连接的客户端是否同时指定了 clientId 和 password。
- **clientId、username 和 password** - 检查连接的客户端是否指定了 clientId、username 和 password。

##### 凭据 ID

当客户端连接时，`CONNECT` 数据包中的用户名、密码和 clientId 的组合与持久凭据匹配以对客户端进行身份验证。
匹配基于 MQTT 客户端凭据中自动生成的 `credentialsId` 字段。

`credentialsId` 的生成方式如下：

- 当仅存在用户名时，credentialsId = `username|$CLIENT_USERNAME`；
- 当仅存在客户端 ID 时，credentialsId = `client_id|$CLIENT_ID`；
- 当同时存在用户名和客户端 ID 时，credentialsId = `mixed|$CLIENT_USERNAME|$CLIENT_ID`。

其中 `$CLIENT_USERNAME` 指的是指定的用户名，`$CLIENT_ID` 指的是 `CONNECT` 数据包中指定的客户端 ID。

#### TLS 身份验证

TBMQ 支持使用 TLS 进行身份验证。
要启用 TLS 身份验证，您必须首先 [启用 TLS 侦听器](/docs/mqtt-broker/security/#tls-listener) 以便客户端的证书链参与身份验证过程。

启用 TLS 侦听器后，您需要执行以下操作来启用 TLS 身份验证：

1. 将 `SECURITY_MQTT_SSL_ENABLED` 环境变量设置为 `true`。
2. 使用 [Web UI 指南](/docs/mqtt-broker/user-guide/ui/mqtt-client-credentials/) 或 [REST API 指南](/docs/mqtt-broker/mqtt-client-credentials-management/) 创建类型为 `X.509 Certificate Chain` 的 MQTT 客户端凭据。
3. 创建凭据后，`credentialsId` 字段会自动生成。有关更多信息，请参见下文。

##### 凭据匹配

启用身份验证后，只有使用与持久通用名称 (CN) 匹配的通用名称 (CN) 的证书连接的客户端才会被身份验证。
此匹配过程通过将链中每个证书的 CN 与持久凭据的 CN 进行比较来完成。

##### 凭据 ID

`credentialsId` 的生成方式如下：

- credentialsId = `ssl|$CERTIFICATE_COMMON_NAME`。

其中 `$CERTIFICATE_COMMON_NAME` 是链中证书的通用名称。

{% include images-gallery.html imageCollection="security-authentication" %}

#### 策略

TBMQ 允许通过设置环境变量 `SECURITY_MQTT_AUTH_STRATEGY` 来设置身份验证策略，该变量有两个可能的值：

1. **BOTH**（默认）。当基本身份验证和 TLS 身份验证都启用时，
MQTT 代理将优先考虑 `Basic` 身份验证。
这意味着如果客户端使用基本凭据成功进行身份验证，系统将不会尝试使用 `TLS` 身份验证对其进行身份验证。
但是，如果 `Basic` 身份验证失败，系统将继续使用 `TLS` 进行身份验证过程。
如果禁用其中一种身份验证类型，则将使用另一种类型。
2. **SINGLE**。代理将仅使用一种身份验证类型，具体取决于客户端连接到的侦听器。
例如，如果客户端连接到 TCP 侦听器，则仅使用 `Basic` 身份验证。
另一方面，如果客户端连接到 TLS 侦听器，则仅使用 `TLS` 身份验证。

### 授权

用户经过身份验证后，可以限制客户端访问他们可以发布或订阅的主题，以进行 TLS 和基本身份验证。

为了灵活控制授权规则，TBMQ 使用正则表达式。

例如，要 **允许客户端发布或订阅所有以 **city/** 开头的主题**，应创建一个授权规则，其值为 **city/.***。

#### 基本

对于基本类型，授权是通过相应 MQTT 客户端凭据的 **pubAuthRulePatterns** 和 **subAuthRulePatterns** 配置的。
因此，对于每个基本 MQTT 客户端凭据，您可以配置这些客户端可以访问的主题的授权规则。

**pubAuthRulePatterns** 和 **subAuthRulePatterns** 基于正则表达式语法。例如，
```
{
    "pubAuthRulePatterns": ["country/.*"],
    "subAuthRulePatterns": ["city/.*"]
}
```
{: .copy-code}
以下配置允许客户端将消息发布到以 **country/** 开头的主题，并订阅以 **city/** 开头的主题。

#### TLS

对于 TLS 类型，授权是使用相应 MQTT 客户端凭据的 **authRulesMapping** 字段配置的。
以下是凭据值模型：

```
{
    "certCommonName": $certCommonName,
    "authRulesMapping": $authRulesMapping
}
```
{: .copy-code}

其中：
- $certCommonName - 应存在于证书链中的通用名称。
- $authRulesMapping - 用于配置不同关键字的访问限制的映射。
例如，
```
  {
      "example_1": {
	      "pubAuthRulePatterns": ["example_pub_topic/.*"],
	      "subAuthRulePatterns": ["example_sub_topic/.*"]
	  },
	  "example_2": {
          "pubAuthRulePatterns": [".*"],
		  "subAuthRulePatterns": [".*"]
      }
  }
  ```
  {: .copy-code}

这允许客户端使用其 CN 中包含 **example_1** 的证书仅发布到以 **example_pub_topic/** 开头的主题，
并订阅以 **example_sub_topic/** 开头的主题。具有包含 **example_2** 的证书的客户端可以发布和订阅任何主题。

**注意**，如果 **pubAuthRulePatterns** 或 **subAuthRulePatterns** 设置为 `null` 或空列表 (`[]`)，则客户端将无法发布或订阅任何主题。

{% include images-gallery.html imageCollection="security-authorization" %}