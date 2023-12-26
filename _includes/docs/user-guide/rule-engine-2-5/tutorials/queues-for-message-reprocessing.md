* TOC
{:toc}

## 案例

假设你的设备正在向 ThingsBoard 发送温度和湿度数据。我们将使用 Rest API 调用节点模拟向某个外部服务器发送消息。

在本教程中，我们将配置 GridLinks 规则引擎以使用队列，其中包含重试失败和超时消息处理策略。
尽管此场景是虚构的，但你将学习如何使用队列来允许在发生故障或超时处理错误的情况下重新处理消息，并在实际应用中使用此知识。

## 前提条件

我们假设你已完成以下指南并阅读了下面列出的文章：

  * [入门](/docs/{{docsPrefix}}getting-started-guides/helloworld/) 指南。
  * [规则引擎概述](/docs/{{docsPrefix}}user-guide/rule-engine-2-0/overview/)。

此外，你需要在你的环境中至少预配一个设备。

## 步骤 1：创建规则链

![image](/images/user-guide/rule-engine-2-5/tutorials/reprocessing_rule_chain.png)

我们将添加一个 **“生成器”** 节点来模拟 6 条消息，延迟 1 秒。

![image](/images/user-guide/rule-engine-2-5/tutorials/generator_reprocessing.png)

所有消息都将放入名为 **“HighPriority”** 的队列中。它使用名为 **“RETRY_FAILED_AND_TIMED_OUT”** 的消息处理策略{% unless docsPrefix == "paas/" %}(有关更多详细信息，请参阅 [**配置指南**](/docs/user-guide/install/{{docsPrefix}}config/) ){% endunless %}，这意味着将再次处理失败或超时的消息。

![image](/images/user-guide/rule-engine-2-5/tutorials/checkpoint_reprocessing.png)

最后，消息将被发送到外部服务器。

![image](/images/user-guide/rule-engine-2-5/tutorials/rest_api.png)

## 步骤 2：外部服务器配置

假设我们有一个准备好接收消息的服务器。为此，我们在 Spring Boot 应用程序中创建了一个简单的控制器。
此外，我们模拟每三条消息失败一次。

```java
@RestController
@RequestMapping("/api/v1/test")
@Slf4j
public class Controller {

    private AtomicLong atomicLong = new AtomicLong(0);

    @RequestMapping(value = {"/"}, headers = "Content-Type=application/json", method = {RequestMethod.POST})
    @ResponseStatus(value = HttpStatus.OK)
    public DeferredResult<ResponseEntity> processRequest(@RequestBody JsonNode msg) {
        DeferredResult<ResponseEntity> deferredResult = new DeferredResult<>();

        log.info("Received message: {}", msg);

        long counter = atomicLong.incrementAndGet();
        if (counter % 3 == 0) {
            log.warn("Bad request: {}", msg);
            deferredResult.setResult(new ResponseEntity<>("Bad Request", HttpStatus.BAD_REQUEST));
        } else {
            log.info("Success: {}", msg);
            deferredResult.setResult(new ResponseEntity<>("Ok", HttpStatus.OK));
        }

        return deferredResult;
    }
}
```

## 步骤 3：验证规则链逻辑

让我们通过保存规则链并启动外部服务器来检查我们的逻辑是否正确。生成器将开始生成消息：

**“检查点”** 节点收到六条消息：

![image](/images/user-guide/rule-engine-2-5/tutorials/checkpoint_reprocessing_events.png)

我们可以看到下一个 rest api 调用节点 **“发送请求”** 处理了八条消息。

![image](/images/user-guide/rule-engine-2-5/tutorials/rest_api_events.png)

每三条消息（最初六条消息中的两条）失败。

![image](/images/user-guide/rule-engine-2-5/tutorials/error_event.png)

最后两条消息是需要重新处理的消息（失败的消息）。
这意味着我们的逻辑工作正常。

## 摘要

下载并导入附加的 json [**文件**](/docs/{{docsPrefix}}user-guide/rule-engine-2-5/tutorials/resources/send_request_rule_chain.json) 与本教程中的规则链。
别忘了用你的特定设备填充生成器节点。

## 后续步骤

{% assign currentGuide = "DataProcessing" %}{% include templates/multi-project-guides-banner.md %}