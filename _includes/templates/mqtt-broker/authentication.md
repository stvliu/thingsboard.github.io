##### 身份验证

要对代理执行管理操作，必须登录系统并获取访问令牌。此访问令牌对于验证和授权您的管理操作至关重要。

要获取访问令牌，您可以执行以下命令：

```bash
curl --location --request POST 'http://localhost:8083/api/auth/login' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username":"sysadmin@gridlinks.com",
    "password":"sysadmin"
}'
```
{: .copy-code}

**请注意**，如果代理安装在远程服务器上，您必须在提供的命令中用服务器的公有 IP 地址或指定域名替换“localhost”。此外，确保端口 8083 可公开访问以建立必要的连接。此外，请记住用特定于您的设置的适当且有效的凭据替换命令中的“username”和“password”值。

成功授权后，响应将包含一个称为 **令牌** 的有价值的信息。将此令牌用于所有后续对 TBMQ 的管理请求至关重要。为了简化流程，您可以将令牌字段的值分配给名为 *ACCESS_TOKEN* 的环境变量，或直接替换本教程中概述的请求中的 *ACCESS_TOKEN* 字符串的出现。

```bash
export ACCESS_TOKEN=PLACE_YOUR_TOKEN_HERE
```
{: .copy-code}