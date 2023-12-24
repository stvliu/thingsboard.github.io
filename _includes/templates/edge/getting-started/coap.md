安装 coap-cli。假设您的 Windows/Linux/MacOS 机器上已安装 Node.js 和 NPM，请执行以下命令：

```bash
npm install coap-cli -g
```
{: .copy-code}

用相应的值替换 $HOST_NAME、$COAP_PORT 和 $ACCESS_TOKEN。如果未指定 $COAP_PORT，则使用默认值 **5683**。

```bash
echo -n '{"temperature": 25}' | coap post coap://$HOST_NAME:$COAP_PORT/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

例如，$HOST_NAME 引用您的本地 ThingsBoard Edge 安装，coap 端口为 **5683**，访问令牌为 **ABC123**：

```bash
echo -n '{"temperature": 25}' | coap post coap://localhost:5683/api/v1/ABC123/telemetry
```
{: .copy-code}

<br>