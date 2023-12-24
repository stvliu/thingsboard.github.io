<table>
    <thead>
      <tr>
          <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
      </tr>
    </thead>
    <tbody>
        <tr>
            <td>transport.sessions.inactivity_timeout</td>
            <td>TB_TRANSPORT_SESSIONS_INACTIVITY_TIMEOUT</td>
            <td>300000</td>
            <td>传输服务中设备会话的不活动超时。如果设备发送任何消息（包括保持活动消息），则设备会话的最后活动时间将更新。</td>
        </tr>
        <tr>
            <td>transport.sessions.report_timeout</td>
            <td>TB_TRANSPORT_SESSIONS_REPORT_TIMEOUT</td>
            <td>3000</td>
            <td>定期检查已过期会话并报告会话最后活动时间更改的间隔。</td>
        </tr>
        <tr>
            <td class="item item-pe">transport.rate_limits.enabled</td>
            <td>TB_TRANSPORT_RATE_LIMITS_ENABLED</td>
            <td>false</td>
            <td></td>
        </tr>
        <tr>
            <td class="item item-pe">transport.rate_limits.tenant</td>
            <td>TB_TRANSPORT_RATE_LIMITS_TENANT</td>
            <td>1000:1,20000:60</td>
            <td></td>
        </tr>
        <tr>
            <td class="item item-pe">transport.rate_limits.device</td>
            <td>TB_TRANSPORT_RATE_LIMITS_DEVICE</td>
            <td>10:1,300:60</td>
            <td></td>
        </tr>
        <tr>
            <td>transport.json.type_cast_enabled</td>
            <td>JSON_TYPE_CAST_ENABLED</td>
            <td>{{JSON_TYPE_CAST_ENABLED_VALUE}}</td>
            <td>在处理遥测/属性 JSON 时，如果可能，将字符串数据类型转换为数字</td>
        </tr>
        <tr>
            <td>transport.json.max_string_value_length</td>
            <td>JSON_MAX_STRING_VALUE_LENGTH</td>
            <td>0</td>
            <td>处理遥测/属性 JSON 时允许的最大字符串值长度（0 值禁用字符串值长度检查）</td>
        </tr>
        <tr>
            <td>transport.client_side_rpc.timeout</td>
            <td>CLIENT_SIDE_RPC_TIMEOUT</td>
            <td>60000</td>
            <td></td>
        </tr>
        <tr>
            <td>transport.api_enabled</td>
            <td>TB_TRANSPORT_API_ENABLED</td>
            <td>true</td>
            <td>启用/禁用 http/mqtt/coap 传输协议（优先级高于某些协议的“enabled”属性）</td>
        </tr>
        <tr>
            <td>transport.log.enabled</td>
            <td>TB_TRANSPORT_LOG_ENABLED</td>
            <td>true</td>
            <td>启用/禁用将传输消息记录到遥测。例如，记录 LwM2M 注册更新。</td>
        </tr>
        <tr>
            <td>transport.log.max_length</td>
            <td>TB_TRANSPORT_LOG_MAX_LENGTH</td>
            <td>1024</td>
            <td>日志消息的最大长度。如有必要，内容将被截断到指定的值。</td>
        </tr>
        <tr>
            <td>transport.stats.enabled</td>
            <td>TB_TRANSPORT_STATS_ENABLED</td>
            <td>true</td>
            <td>启用/禁用传输统计信息的收集</td>
        </tr>
        <tr>
            <td>transport.stats.print-interval-ms</td>
            <td>TB_TRANSPORT_STATS_PRINT_INTERVAL_MS</td>
            <td>60000</td>
            <td>传输统计信息记录的间隔。</td>
        </tr>
    </tbody>
</table>