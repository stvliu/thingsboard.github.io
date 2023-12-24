---
layout: docwithnav-paas
assignees:
- ashvayka
title: GridLinks云服务 订阅计划定义
description: 订阅付款模式的功能和优势

---

ThingsBoars Cloud 基于 **按需付费** 模式提供订阅计划。
订阅计划的主要特点是：[实体限制](/docs/user-guide/tenant-profiles/#entity-limits)、[api 限制](/docs/user-guide/tenant-profiles/#api-limits--usage)、[白标](/docs/user-guide/white-labeling/) 和您获得的支持级别。


### 实体限制

请参阅下表比较订阅计划的实体限制。

<table>
  <thead>
      <tr>
          <td><b>参数名称</b></td>
          <td><b>创客</b></td>
          <td><b>原型</b></td>
          <td><b>初创</b></td>
          <td><b>企业</b></td>
          <td><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>设备</td>
          <td>30</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>设备的最大数量</td>
      </tr>
      <tr>
          <td>资产</td>
          <td>30</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>资产的最大数量</td>
      </tr>
      <tr>
          <td>客户</td>
          <td>2</td>
          <td>50</td>
          <td>100</td>
          <td>500</td>
          <td>客户的最大数量</td>
      </tr>
      <tr>
          <td>用户</td>
          <td>5</td>
          <td>50</td>
          <td>100</td>
          <td>500</td>
          <td>用户最大数量</td>
      </tr>
      <tr>
          <td>仪表板</td>
          <td>25</td>
          <td>100</td>
          <td>200</td>
          <td>500</td>
          <td>仪表板的最大数量</td>
      </tr>
      <tr>
          <td>规则链</td>
          <td>5</td>
          <td>20</td>
          <td>50</td>
          <td>100</td>
          <td>规则链的最大数量</td>
      </tr>
      <tr>
          <td>集成</td>
          <td>1</td>
          <td>5</td>
          <td>10</td>
          <td>20</td>
          <td>集成的最大数量</td>
      </tr>
      <tr>
          <td>转换器</td>
          <td>5</td>
          <td>25</td>
          <td>50</td>
          <td>100</td>
          <td>转换器的最大数量</td>
      </tr>
      <tr>
          <td>调度程序事件</td>
          <td>5</td>
          <td>20</td>
          <td>50</td>
          <td>100</td>
          <td>调度程序事件的最大数量</td>
      </tr>            
  </tbody>
</table>


### API 限制

请参阅下表比较订阅计划的 API 限制。除非另有说明，否则这些值是每月 API 限制。

<table>
  <thead>
      <tr>
          <td><b>参数名称</b></td>
          <td><b>创客</b></td>
          <td><b>原型</b></td>
          <td><b>初创</b></td>
          <td><b>企业</b></td>
          <td><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>传输消息</td>
          <td>5M</td>
          <td>50M</td>
          <td>250M</td>
          <td>500M</td>
          <td>任何传输（MQTT、HTTP、CoAP 等）或集成接收的消息总数。</td>
      </tr>
      <tr>
          <td>传输数据点</td>
          <td>10M</td>
          <td>100M</td>
          <td>500M</td>
          <td>1B</td>
          <td>遥测或属性传输消息包含的键值对总数。</td>
      </tr>
      <tr>
          <td>规则引擎执行</td>
          <td>25M</td>
          <td>250M</td>
          <td>1B</td>
          <td>2B</td>
          <td>规则节点的任何执行的总数。<br>处理单个遥测消息可能导致多个规则引擎执行。<br>该平台还将计算由生成器节点等产生的周期性消息。</td>
      </tr>
      <tr>
          <td>JavaScript 执行</td>
          <td>1M</td>
          <td>10M</td>
          <td>50M</td>
          <td>100M</td>
          <td>用户定义函数的任何执行的总数。例如，处理“脚本”过滤器或转换节点、调用数据转换器等。</td>
      </tr>
      <tr>
          <td>默认存储 TTL</td>
          <td>60 天</td>
          <td>180 天</td>
          <td>365 天</td>
          <td>365 天</td>
          <td>用于存储时序数据的“生存时间”参数的默认值。<br>
          您可以在“保存时序”规则节点中覆盖默认值，或使用消息的“TTL”元数据字段。<br>
          这允许您优化存储消耗。TTL 的最大允许值为 5 年。 <br>
          例如，您可以将“原始”数据存储 3 个月，并将聚合数据存储 3 年。
          </td>
      </tr>      
      <tr>
          <td>数据点存储天数</td>
          <td>300M</td>
          <td>10B</td>
          <td>100B</td>
          <td>200B</td>
          <td>数据点存储天数是针对存储到数据库的所有时序数据点计算的。<br>
          平台将数据点数量乘以这些数据点将存储的天数。<br> 
          TTL 参数用于提取存储数据的日期数量。例如，如果您将 1M 个数据点存储 30 天，则这是 30M 个存储数据点天。 </td>
      </tr>
      <tr>
          <td>警报 TTL</td>
          <td>60 天</td>
          <td>180 天</td>
          <td>365 天</td>
          <td>365 天</td>
          <td>在数据库中存储警报的天数。</td>
      </tr>
      <tr>
          <td>RPC TTL</td>
          <td>60 天</td>
          <td>180 天</td>
          <td>365 天</td>
          <td>365 天</td>
          <td>在数据库中存储持久性 RPC 的天数。</td>
      </tr>
      <tr>
          <td>警报</td>
          <td>200</td>
          <td>4K</td>
          <td>20K</td>
          <td>40K</td>
          <td>每月创建的警报总数。</td>
      </tr>
      <tr>
          <td>电子邮件</td>
          <td>100</td>
          <td>2K</td>
          <td>10K</td>
          <td>40K</td>
          <td>发送的电子邮件总数。</td>
      </tr>
      <tr>
          <td>短信</td>
          <td>0</td>
          <td>100</td>
          <td>500</td>
          <td>1000</td>
          <td>发送的短信总数。</td>
      </tr>          
  </tbody>
</table>

其中“**K**”表示 1 千，“**M**”表示 1 百万，“**B**”表示 10 亿。

### 速率限制

<table>
  <thead>
      <tr>
          <td><b>参数名称</b></td>
          <td><b>创客</b></td>
          <td><b>原型</b></td>
          <td><b>初创</b></td>
          <td><b>企业</b></td>
          <td><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td>所有传输消息（租户）</td>
          <td>200/秒<br>但不得超过 6K/分钟<br>但不得超过 140K/小时</td>
          <td>2K/秒<br>但不得超过 60K/分钟<br>但不得超过 1.4M/小时</td>
          <td>10K/秒<br>但不得超过 300K/分钟<br>但不得超过 6M/小时</td>
          <td>20K/秒<br>但不得超过 600K/分钟<br>但不得超过 12M/小时</td>
          <td>租户所属的所有设备的任何传输微服务接收的消息总数</td>
      </tr>
      <tr>
          <td>遥测传输消息（租户）</td>
          <td>100/秒<br>但不得超过 3K/分钟<br>但不得超过 70K/小时</td>
          <td>1K/秒<br>但不得超过 30K/分钟<br>但不得超过 700K/小时</td>
          <td>5K/秒<br>但不得超过 150K/分钟<br>但不得超过 3.5M/小时</td>
          <td>10K/秒<br>但不得超过 300K/分钟<br>但不得超过 7M/小时</td>
          <td>租户所属的所有设备的任何传输微服务接收的遥测消息总数</td>
      </tr>
      <tr>
          <td>遥测传输数据点（租户）</td>
          <td>200/秒<br>但不得超过 6K/分钟<br>但不得超过 140K/小时</td>
          <td>2K/秒<br>但不得超过 60K/分钟<br>但不得超过 1.4M/小时</td>
          <td>10K/秒<br>但不得超过 300K/分钟<br>但不得超过 7M/小时</td>
          <td>20K/秒<br>但不得超过 600K/分钟<br>但不得超过 14M/小时</td>
          <td>租户所属的所有设备的任何传输微服务接收的遥测数据点总数</td>
      </tr>            
      <tr>
          <td>所有传输消息（设备）</td>
          <td>20/秒<br>但不得超过 600/分钟<br>但不得超过 14K/小时</td>
          <td>20/秒<br>但不得超过 600/分钟<br>但不得超过 14K/小时</td>
          <td>20/秒<br>但不得超过 600/分钟<br>但不得超过 14K/小时</td>
          <td>20/秒<br>但不得超过 600/分钟<br>但不得超过 14K/小时</td>
          <td>每个设备分别接收的任何传输微服务接收的消息总数</td>
      </tr>
      <tr>
          <td>遥测传输消息（设备）</td>
          <td>10/秒<br>但不得超过 300/分钟<br>但不得超过 7K/小时</td>
          <td>10/秒<br>但不得超过 300/分钟<br>但不得超过 7K/小时</td>
          <td>10/秒<br>但不得超过 300/分钟<br>但不得超过 7K/小时</td>
          <td>10/秒<br>但不得超过 300/分钟<br>但不得超过 7K/小时</td>
          <td>每个设备分别接收的任何传输微服务接收的遥测消息总数</td>
      </tr>
      <tr>
          <td>遥测传输数据点（设备）</td>
          <td>20/秒<br>但不得超过 600/分钟<br>但不得超过 14K/小时</td>
          <td>20/秒<br>但不得超过 600/分钟<br>但不得超过 14K/小时</td>
          <td>20/秒<br>但不得超过 600/分钟<br>但不得超过 14K/小时</td>
          <td>20/秒<br>但不得超过 600/分钟<br>但不得超过 14K/小时</td>
          <td>每个设备分别接收的任何传输微服务接收的遥测数据点总数</td>
      </tr>
      <tr>
          <td>每条消息的规则引擎执行</td>
          <td>20</td>
          <td>30</td>
          <td>40</td>
          <td>50</td>
          <td>处理特定消息的规则节点执行的最大数量</td>
      </tr>      
  </tbody>
</table>

其中“**K**”表示 1 千，“**M**”表示 1 百万，“**B**”表示 10 亿。

### 白标

ThingsBoard Web 界面允许您在 2 分钟内配置公司或产品徽标和配色方案，无需任何编码工作，也无需重新启动服务。
有关更多详细信息，请参阅功能[文档](/docs/user-guide/white-labeling/)。GridLinks Cloud 扩展了白标功能，可以轻松配置自己的域名。
有关更多详细信息，请参阅[管理域](/products/paas/domains/)。

白标功能适用于**原型**和**初创**订阅计划。