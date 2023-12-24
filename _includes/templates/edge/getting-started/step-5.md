要将仪表板配置到 Edge，我们需要在 **{{currentThingsBoardVersion}}** 服务器上打开 Edge 仪表板并分配新创建的仪表板。
一旦分配了此仪表板，我们将打开 ThingsBoard **Edge** UI，以便在 Edge 上看到相同的仪表板。

请使用 URL **SERVER_URL** 打开 **{{currentThingsBoardVersion}}**。

{% include images-gallery.html imageCollection="step5Server" showListImageTitles="true" %}

让我们使用 URL **EDGE_URL** 打开 ThingsBoard **Edge** UI，以验证仪表板是否已配置。

{% include images-gallery.html imageCollection="step5Edge" showListImageTitles="true" %}

恭喜！仪表板已配置到 Edge。现在，您可以发送新的遥测读数，它将立即显示在 Edge 上的图表中。