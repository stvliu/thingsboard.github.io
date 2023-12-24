---
layout: docwithnav-mqtt-broker
title: MQTT 客户端凭证
description: 创建/更新/删除 MQTT 客户端凭证

---

* TOC
{:toc}

MQTT 客户端凭证提供了配置系统内连接客户端的安全措施的方法。

要在系统内创建新的客户端凭证，首先必须以管理员用户身份进行身份验证。
此授权过程授予您执行管理任务所需的权限和访问权限。

通过以管理员用户身份进行身份验证，您将有权创建和管理客户端凭证，从而能够对连接到系统的客户端实施强大的安全措施。
这种方法确保系统保持安全，并且只有经过授权的客户端才能建立连接并与 TBMQ 交互。

{% include templates/mqtt-broker/authentication.md %}

##### 创建/更新 MQTT 客户端凭证

**MQTT_BASIC** 凭证示例：

```bash
curl --location --request POST 'http://localhost:8083/api/mqtt/client/credentials' \
--header "X-Authorization: Bearer $ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "testCreds",
    "credentialsType":"MQTT_BASIC",
    "credentialsValue":"{ \"clientId\": null, \"userName\": \"test_user\", \"password\": \"test_pass\", \"authRules\": { \"pubAuthRulePatterns\": [\"test\/.*\"], \"subAuthRulePatterns\": [\"my\/.*\"] } }"
}'
```
{: .copy-code}

通过实施上述配置，具有用户名 **test_user** 和密码 **test_pass** 的客户端将能够成功登录系统。
但是，请务必注意，这些客户端将根据指定的话题访问权限拥有受限的权限。

使用这些凭证进行身份验证的客户端将仅限于将消息发布到以 _test/_ 开头的话题。
此外，他们将被允许仅订阅以 _my/_ 开头的话题。
此配置确保客户端的访问权限仅限于特定主题模式，从而维护受控和安全的环境。

**SSL** 凭证示例：

```bash
curl --location --request POST 'http://localhost:8083/api/mqtt/client/credentials' \
--header "X-Authorization: Bearer $ACCESS_TOKEN" \
--header 'Content-Type: application/json' \
--data-raw '{
    "name": "testSSLCreds",
    "credentialsType":"SSL",
    "credentialsValue":"{ \"certCommonName\": \"Root Common Name\", \"authRulesMapping\": { \"test\": { \"pubAuthRulePatterns\": [\"test_ssl\/.*\"], \"subAuthRulePatterns\": [\"test_ssl\/.*\"] } } }"
}'
```
{: .copy-code}

其中：
- **certCommonName** - 证书链中特定证书的通用名称 (CN)。
- **authRulesMapping** - 将从 CN 关键字中提取的映射规则映射到授权规则（以允许客户端仅发布和订阅某些主题）。

通过采用上述配置，使用 SSL 证书链连接的客户端将被允许根据特定条件登录。
SSL 证书链应具有与 _Root Common Name_ 字符串匹配的根证书 CN，并且证书的 CN 应包含字符串 _test_。
使用这些凭证进行身份验证后，客户端将获得对以 _test_ssl/_ 开头的话题的发布和订阅权限的访问权限。

##### 获取所有 MQTT 客户端凭证

```bash
curl --location --request GET 'http://localhost:8083/api/mqtt/client/credentials?pageSize=100&page=0' \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}
**注意**，_pageSize_ 参数等于 100，_page_ 参数等于 0，因此上述请求将获取前 100 个 MQTT 客户端凭证。

##### 删除 MQTT 客户端凭证

```bash
curl --location --request DELETE 'http://localhost:8083/api/mqtt/client/credentials/$CREDENTIALS_ID' \
--header "X-Authorization: Bearer $ACCESS_TOKEN"
```
{: .copy-code}

粘贴要删除的 MQTT 客户端凭证的实际 ID，而不是 _$CREDENTIALS_ID_。