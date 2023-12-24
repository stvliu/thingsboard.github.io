我们将更新“边缘根规则链”，该链将在边缘保存 10 个传感器读数。
在规则链中，我们添加了规则节点，该节点转换传入的消息，并仅将带有距离读数的消息推送到云消息。
以下是边缘根规则链的最终配置：

{% include images-gallery.html imageCollection="rootRuleChainPreview" %}

在接下来的步骤中，我们将创建 **JavaScript** 节点来过滤数据。
脚本节点的 JavaScript 将创建一个空对象 *newMsg*，添加具有来自“车载监控系统”的相应值的属性“distance”，并将进一步的对象 *newMsg* 作为新消息发送：

{% highlight javascript %}
var newMsg = {};
newMsg.distance = msg.distance;
return { msg: newMsg, metadata: metadata, msgType: msgType }; {% endhighlight %}

如果需要，请在接下来的步骤中使用此代码段。

以下是将默认边缘“根规则链”更新为上述规则链的步骤：

{% include images-gallery.html imageCollection="updateRootRuleChain" showListImageTitles="true" %}

现在，让我们打开 ThingsBoard **Edge** UI 来查看更新的根规则链：

{% include images-gallery.html imageCollection="updateRootRuleChainEdge" showListImageTitles="true" %}