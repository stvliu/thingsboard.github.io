#### GridLinks 服务参数

<table>
    <thead>
        <tr>
            <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>service.type</td>
            <td>TB_SERVICE_TYPE</td>
            <td>tb-transport</td>
            <td></td>
        </tr>
        <tr>
            <td>service.id</td>
            <td>TB_SERVICE_ID</td>
            <td></td>
            <td>此服务的唯一 ID（如果为空，则自动生成）</td>
        </tr>
    </tbody>
</table>

#### ThingsBoard 指标参数

<table>
    <thead>
        <tr>
            <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>metrics.enabled</td>
            <td>METRICS_ENABLED</td>
            <td>false</td>
            <td>启用/禁用执行器指标</td>
        </tr>
    </tbody>
</table>

#### GridLinks 管理参数

<table>
    <thead>
        <tr>
            <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>management.endpoints.web.exposure.include</td>
            <td>METRICS_ENDPOINTS_EXPOSE</td>
            <td>info</td>
            <td>公开指标端点（使用值“prometheus”启用 prometheus 指标）</td>
        </tr>
    </tbody>
</table>