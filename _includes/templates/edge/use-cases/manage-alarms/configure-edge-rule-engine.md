我们将更新“边缘根规则链”，它将处理“DHT22”传感器的**警报创建**事件，并将向“空调”设备发送适当的命令。
以下是边缘根规则链的最终配置：

{% include images-gallery.html imageCollection="rootRuleChainPreview" %}

在接下来的步骤中，我们将创建**JavaScript**节点，以向**空调**设备创建适当的RPC命令。
用于模拟启用空调的脚本节点的JavaScript：

{% highlight javascript %}
var newMsg = {};
newMsg.method = "enabled_air_conditioner";
newMsg.params = {"speed": 1.0};
return { msg: newMsg, metadata: metadata, msgType: msgType }; {% endhighlight %}

如果需要，请在接下来的步骤中使用此代码段。

以下是将默认边缘“根规则链”更新为上述规则链的步骤：

{% include images-gallery.html imageCollection="updateRootRuleChain" showListImageTitles="true" %}

现在，让我们打开ThingsBoard **Edge** UI以查看更新的根规则链：

{% include images-gallery.html imageCollection="updateRootRuleChainEdge" showListImageTitles="true" %}