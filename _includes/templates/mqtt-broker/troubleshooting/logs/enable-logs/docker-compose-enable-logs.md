对于 docker-compose 部署，我们将 <code>/config</code> 文件夹映射到您的本地系统（<code>./tb-mqtt-broker/conf</code> 文件夹）。
因此，为了更改日志记录配置，您需要更新 <code>./tb-mqtt-broker/conf/logback.xml</code> 文件。