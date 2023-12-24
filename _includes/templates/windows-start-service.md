现在让我们启动 ThingsBoard 服务！
以管理员身份打开命令提示符并执行以下命令：

```shell
net start thingsboard
```
{: .copy-code}

预期输出：

```text
ThingsBoard Server Application 服务正在启动。
ThingsBoard Server Application 服务已成功启动。
```

为了重新启动 ThingsBoard 服务，您可以执行以下命令：

```shell
net stop thingsboard
net start thingsboard
```
{: .copy-code}

启动后，您将能够使用以下链接打开 Web UI：

```bash
http://localhost:8080/
```
{: .copy-code}

如果您在执行安装脚本期间指定了 *--loadDemo*，则可以使用以下默认凭据：

- **系统管理员**：sysadmin@thingsboard.org / sysadmin
- **租户管理员**：tenant@thingsboard.org / tenant
- **客户用户**：customer@thingsboard.org / customer

您始终可以在帐户个人资料页面中更改每个帐户的密码。