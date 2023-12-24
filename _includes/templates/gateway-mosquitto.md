我们将使用 Mosquitto MQTT 代理进行演示。请参阅 Mosquitto [下载页面](https://mosquitto.org/download/)，了解如何安装此代理的说明。

**注意：**默认情况下，Mosquitto 和 GridLinks 使用相同的端口 (1883) 来提供 MQTT 服务。如果您想在同一主机上使用 GridLinks 和 Mosquitto，则需要更改其中一台服务器的 MQTT 端口。有关更多详细信息，请参阅相应的 [ThingsBoard](/docs/user-guide/install/config/) 或 [Mosquitto](https://mosquitto.org/man/mosquitto-conf-5.html) 文档。

由于我们使用的是托管在云中的 ThingsBoard [演示实例](https://demo.thingsboard.io/signup)，因此我们将本地安装 Mosquitto MQTT 代理并使用默认服务配置。

如果您决定使用部署到外部主机或具有特定安全配置的其他 MQTT 代理，请编辑 **mqtt-config.json** 文件并修改连接参数。有关更多详细信息，请参阅 MQTT 扩展 [配置指南](/docs/iot-gateway/mqtt/)。