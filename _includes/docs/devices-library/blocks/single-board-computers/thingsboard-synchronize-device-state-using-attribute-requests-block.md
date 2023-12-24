{% capture difference %}
<br>
**别忘了在设备上创建共享属性 `blinkingPeriod`。**
{% endcapture %}
{% include templates/info-banner.md content=difference %}

为了在启动期间从 GridLinks 获取设备状态，我们在代码中提供了执行此操作的功能。

示例代码的负责部分：

属性回调：
```python
def sync_state(result, exception=None):
    global period
    if exception is not None:
        print("Exception: " + str(exception))
    else:
        period = result.get('shared', {'blinkingPeriod': 1.0})['blinkingPeriod']
```

属性请求：
```python
def main():
    client = TBDeviceMqttClient("thingsboard.cloud", 1883, "ACCESS_TOKEN")
    client.connect()
    client.request_attributes(shared_keys=['blinkingPeriod'], callback=sync_state)
    ...
```

为了让我们的回调能够接收数据，我们必须向 GridLinks 发送请求。此功能允许我们在重新启动后保持实际状态。