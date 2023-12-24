ThingsBoard 允许您从服务器端应用程序向设备发送 [远程过程调用 (RPC)](/docs/{{page.docsPrefix}}user-guide/rpc/#server-side-rpc)，反之亦然。
基本上，此功能将使您能够向设备发送/从设备接收命令并接收命令执行结果。

在本指南中，我们将配置 RPC 命令以立即获取 OrangePI 遥测数据。如果您使用导入的仪表板，则无需配置任何内容，因为在您的仪表板中可以看到以下小部件：

![](/images/devices-library/basic/single-board-computers/one-way-rpc-widget.png)

<aside>
💡 如果您创建新的仪表板，则可以使用位于“控制小部件”包中的“RPC 按钮”小部件进行单向 RPC。

</aside>

现在，我们准备编写代码。首先，我们需要创建一个 `rpc_callback` 函数，当我们从服务器获取 RPC 时，该函数将调用。并且与共享属性的示例一样，我们需要在 `main` 函数中将我们的 rpc 回调函数与订阅者绑定。

```python
client = None

...

# 当我们发送 RPC 时调用的回调函数
def rpc_callback(id, request_body):
    # 请求正文包含方法和其他参数
    print(request_body)
    method = request_body.get('method')
    if method == 'getTelemetry':
        attributes, telemetry = get_data()
        client.send_attributes(attributes)
        client.send_telemetry(telemetry)
    else:
        print('Unknown method: ' + method)

...

def main():
    ...

    # 现在 rpc_request_response 将处理来自服务器的 rpc 请求
    client.set_server_side_rpc_request_handler(rpc_callback)

    ...
```

最后，让我们尝试按下按钮并强制获取 OrangePI 数据：
![](/images/devices-library/basic/single-board-computers/timeseries-rpc-widget.png)

此外，如果您做对了所有事情，您应该会看到以下控制台输出：

`{'method': 'getTelemetry', 'params': {}}`