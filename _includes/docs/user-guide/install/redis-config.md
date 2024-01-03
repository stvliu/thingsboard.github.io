<table>
    <thead>
        <tr>
            <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>redis.connection.type</td>
            <td>REDIS_CONNECTION_TYPE</td>
            <td>standalone</td>
            <td>Redis 连接类型 - <b>standalone</b> 或 <b>cluster</b> 或 <b>sentinel</b></td>
        </tr>
        <tr>
            <td>redis.standalone.host</td>
            <td>REDIS_HOST</td>
            <td>localhost</td>
            <td>Redis 连接主机</td>
        </tr>
        <tr>
            <td>redis.standalone.port</td>
            <td>REDIS_PORT</td>
            <td>6379</td>
            <td>Redis 连接端口</td>
        </tr>
        <tr>
            <td>redis.standalone.useDefaultClientConfig</td>
            <td>REDIS_USE_DEFAULT_CLIENT_CONFIG</td>
            <td>true</td>
            <td>Redis 连接端口</td>
        </tr>
        <tr>
            <td>redis.standalone.clientName</td>
            <td>REDIS_CLIENT_NAME</td>
            <td>standalone</td>
            <td>仅当您未使用默认 ClientConfig 时，才可以使用此值</td>
        </tr>
        <tr>
            <td>redis.standalone.connectTimeout</td>
            <td>REDIS_CLIENT_CONNECT_TIMEOUT</td>
            <td>30000</td>
            <td>仅当您未使用默认 ClientConfig 时，才可以使用此值</td>
        </tr>
        <tr>
            <td>redis.standalone.readTimeout</td>
            <td>REDIS_CLIENT_READ_TIMEOUT</td>
            <td>60000</td>
            <td>仅当您未使用默认 ClientConfig 时，才可以使用此值</td>
        </tr>
        <tr>
            <td>redis.standalone.usePoolConfig</td>
            <td>REDIS_CLIENT_USE_POOL_CONFIG</td>
            <td>false</td>
            <td>仅当您未使用默认 ClientConfig 时，才可以使用此值</td>
        </tr>
        <tr>
            <td>redis.cluster.nodes</td>
            <td>REDIS_NODES</td>
            <td></td>
            <td>用于引导的“主机:端口”对的逗号分隔列表</td>
        </tr>
        <tr>
            <td>redis.cluster.max-redirects</td>
            <td>REDIS_MAX_REDIRECTS</td>
            <td>12</td>
            <td>在整个集群中执行命令时要遵循的最大重定向数</td>
        </tr>
        <tr>
            <td>redis.cluster.useDefaultPoolConfig</td>
            <td>REDIS_USE_DEFAULT_POOL_CONFIG</td>
            <td>true</td>
            <td>使用默认 redis 池配置。如果设置为“true”，则将忽略 REDIS_POOL_CONFIG_* 属性。</td>
        </tr>
        <tr>
            <td>redis.sentinel.master</td>
            <td>REDIS_MASTER</td>
            <td></td>
            <td>Redis sentinel 主机名</td>
        </tr>
	    <tr>
            <td>redis.sentinel.sentinels</td>
            <td>REDIS_SENTINELS</td>
            <td></td>
            <td>sentinel 的“主机:端口”对的逗号分隔列表。默认位于 redis 服务器的端口 26379 上。</td>
        </tr>
	    <tr>
            <td>redis.sentinel.password</td>
            <td>REDIS_SENTINEL_PASSWORD</td>
            <td></td>
            <td>用于对此 sentinel 进行身份验证并对其他 sentinel 进行身份验证的密码。</td>
        </tr>
	    <tr>
            <td>redis.sentinel.useDefaultPoolConfig</td>
            <td>REDIS_USE_DEFAULT_POOL_CONFIG</td>
            <td>true</td>
            <td>使用默认 redis 池配置。如果设置为“true”，则将忽略 REDIS_POOL_CONFIG_* 属性。</td>
        </tr>
        <tr>
            <td>redis.db</td>
            <td>REDIS_DB</td>
            <td>0</td>
            <td>Redis 数据库索引</td>
        </tr>
        <tr>
            <td>redis.password</td>
            <td>REDIS_PASSWORD</td>
            <td></td>
            <td>Redis 数据库密码</td>
        </tr>
        <tr>
            <td>redis.pool_config.maxTotal</td>
            <td>REDIS_POOL_CONFIG_MAX_TOTAL</td>
            <td>128</td>
            <td>通用 redis 池设置</td>
        </tr>
        <tr>
            <td>redis.pool_config.maxIdle</td>
            <td>REDIS_POOL_CONFIG_MAX_IDLE</td>
            <td>128</td>
            <td>通用 redis 池设置</td>
        </tr>
        <tr>
            <td>redis.pool_config.minIdle</td>
            <td>REDIS_POOL_CONFIG_MIN_IDLE</td>
            <td>16</td>
            <td>通用 redis 池设置</td>
        </tr>
        <tr>
            <td>redis.pool_config.testOnBorrow</td>
            <td>REDIS_POOL_CONFIG_TEST_ON_BORROW</td>
            <td>true</td>
            <td>通用 redis 池设置</td>
        </tr>
        <tr>
            <td>redis.pool_config.testOnReturn</td>
            <td>REDIS_POOL_CONFIG_TEST_ON_RETURN</td>
            <td>true</td>
            <td>通用 redis 池设置</td>
        </tr>
        <tr>
            <td>redis.pool_config.testWhileIdle</td>
            <td>REDIS_POOL_CONFIG_TEST_WHILE_IDLE</td>
            <td>true</td>
            <td>通用 redis 池设置</td>
        </tr>
        <tr>
            <td>redis.pool_config.minEvictableMs</td>
            <td>REDIS_POOL_CONFIG_MIN_EVICTABLE_MS</td>
            <td>60000</td>
            <td>通用 redis 池设置</td>
        </tr>
        <tr>
            <td>redis.pool_config.evictionRunsMs</td>
            <td>REDIS_POOL_CONFIG_EVICTION_RUNS_MS</td>
            <td>30000</td>
            <td>通用 redis 池设置</td>
        </tr>
        <tr>
            <td>redis.pool_config.maxWaitMills</td>
            <td>REDIS_POOL_CONFIG_MAX_WAIT_MS</td>
            <td>60000</td>
            <td>通用 redis 池设置</td>
        </tr>
        <tr>
            <td>redis.pool_config.numberTestsPerEvictionRun</td>
            <td>REDIS_POOL_CONFIG_NUMBER_TESTS_PER_EVICTION_RUN</td>
            <td>3</td>
            <td>通用 redis 池设置</td>
        </tr>
        <tr>
            <td>redis.pool_config.blockWhenExhausted</td>
            <td>REDIS_POOL_CONFIG_BLOCK_WHEN_EXHAUSTED</td>
            <td>true</td>
            <td>通用 redis 池设置</td>
        </tr>
    </tbody>
</table>