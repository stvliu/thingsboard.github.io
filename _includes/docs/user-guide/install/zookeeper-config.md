#### Zookeeper 连接参数

<table>
    <thead>
      <tr>
          <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
      </tr>
    </thead>
    <tbody>
        <tr>
          <td>zk.enabled</td>
          <td>ZOOKEEPER_ENABLED</td>
          <td>false</td>
          <td>启用/禁用 zookeeper 发现服务。用于 ThingsBoard 集群</td>
        </tr>
        <tr>
          <td>zk.url</td>
          <td>ZOOKEEPER_URL</td>
          <td>localhost:2181</td>
          <td>Zookeeper 连接字符串</td>
        </tr>
        <tr>
          <td>zk.retry_interval_ms</td>
          <td>ZOOKEEPER_RETRY_INTERVAL_MS</td>
          <td>3000</td>
          <td>Zookeeper 重试间隔（毫秒）</td>
        </tr>
        <tr>
          <td>zk.connection_timeout_ms</td>
          <td>ZOOKEEPER_CONNECTION_TIMEOUT_MS</td>
          <td>3000</td>
          <td>Zookeeper 连接超时（毫秒）</td>
        </tr>
        <tr>
          <td>zk.session_timeout_ms</td>
          <td>ZOOKEEPER_SESSION_TIMEOUT_MS</td>
          <td>3000</td>
          <td>Zookeeper 会话超时（毫秒）</td>
        </tr>
        <tr>
          <td>zk.zk_dir</td>
          <td>ZOOKEEPER_NODES_DIR</td>
          <td>/thingsboard</td>
          <td>Zookeeper '文件系统' 中的目录名称</td>
        </tr>
    </tbody>
</table>