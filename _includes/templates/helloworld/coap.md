安装 coap-cli。假设您的 Windows/Linux/MacOS 机器上已安装 Node.js 和 NPM，请执行以下命令：

```bash
npm install coap-cli -g
```
{: .copy-code}

用相应的值替换 $THINGSBOARD_HOST_NAME 和 $ACCESS_TOKEN。

```bash
echo -n '{"temperature": 25}' | coap post coap://$THINGSBOARD_HOST_NAME/api/v1/$ACCESS_TOKEN/telemetry
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 引用实时演示服务器，$ACCESS_TOKEN 为 ABC123：

```bash
echo -n '{"temperature": 25}' | coap post coap://demo.thingsboard.io/api/v1/ABC123/telemetry
```
{: .copy-code}

例如，$THINGSBOARD_HOST_NAME 引用您的本地安装，$ACCESS_TOKEN 为 ABC123：

```bash
echo -n '{"temperature": 25}' | coap post coap://localhost/api/v1/ABC123/telemetry
```
{: .copy-code}

<br>
<br>