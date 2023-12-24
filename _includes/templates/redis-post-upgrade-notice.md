{% capture redis-notice %}
如果您使用 Redis 进行缓存，则需要在启动 ThingsBoard 之前刷新所有存储的键。

连接到您的 Redis 实例（或容器/pod，具体取决于您的设置），然后运行命令：

`redis-cli flushall`

请注意，此命令仅适用于您将 Redis 专用于 ThingsBoard 的情况。如果其他应用程序使用 Redis，则需要找到 ThingsBoard 数据库并仅刷新该数据库。默认数据库索引为 0，可通过 REDIS_DB <a style="pointer-events: all;" href="/docs/user-guide/install/config/">ThingsBoard 环境值</a>进行配置。

`redis-cli`

`select 0`

`flushdb`
 
{% endcapture %}
{% include templates/info-banner.md content=redis-notice %}