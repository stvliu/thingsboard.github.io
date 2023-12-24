---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: Trendz 配置属性
description: Trendz 配置属性说明
---


## 配置属性

<table>
  <thead>
      <tr>
          <td><b>属性</b></td><td><b>环境变量</b></td><td><b>默认值</b></td><td><b>说明</b></td>
      </tr>
  </thead>
  <tbody>
      <tr>
          <td colspan="4"><span style="font-weight: bold; font-size: 24px;">HTTP 服务器参数</span></td>
      </tr>  
      <tr>
          <td>server.address</td>
          <td>HTTP_BIND_ADDRESS</td>
          <td>0.0.0.0</td>
          <td>HTTP 服务器绑定地址</td>
      </tr>
      <tr>
          <td>server.port</td>
          <td>HTTP_BIND_PORT</td>
          <td>8888</td>
          <td>HTTP 服务器绑定端口</td>
      </tr>
      <tr>
            <td>tb.api.url</td>
            <td>TB_API_URL</td>
            <td>http://localhost:9090</td>
            <td>ThingsBoard 集群 REST API URL</td>
        </tr>
      <tr>
          <td>ratelimit.duration.sec</td>
          <td>RATELIMIT_DURATION_SEC</td>
          <td>1</td>
          <td>控制每个持续时间内的 API 调用量</td>
      </tr>
      <tr>
          <td>ratelimit.max_reqeusts_per_duration</td>
          <td>RATELIMIT_MAX_REQUESTS</td>
          <td>5000</td>
          <td>每个配置持续时间内允许的最大 API 调用次数</td>
      </tr>
      <tr>
          <td>ratelimit.max_concurent_requests</td>
          <td>RATELIMIT_CONCURRENT_REQUESTS</td>
          <td>8</td>
          <td>最大并发 API 调用次数。覆盖 RATELIMIT_MAX_REQUESTS 限制</td>
      </tr>          
        <tr>
          <td>spring.datasource.url</td>
          <td>SPRING_DATASOURCE_URL</td>
          <td>jdbc:postgresql://localhost:5432/trendz</td>
          <td>Trendz 数据库的连接 URL</td>
        </tr>
        <tr>
            <td>spring.datasource.username</td>
            <td>SPRING_DATASOURCE_USERNAME</td>
            <td>postgres</td>
            <td>数据库用户名</td>
        </tr> 
        <tr>
            <td>spring.datasource.password</td>
            <td>SPRING_DATASOURCE_PASSWORD</td>
            <td>postgres</td>
            <td>数据库密码</td>
        </tr> 
        <tr>
            <td>spring.datasource.hikari.maximumPoolSize</td>
            <td>SPRING_DATASOURCE_MAXIMUM_POOL_SIZE</td>
            <td>5</td>
            <td>数据库连接池大小</td>
        </tr> 
        <tr>
            <td>cache.type</td>
            <td>CACHE_TYPE</td>
            <td>caffeine</td>
            <td>应用程序缓存提供程序</td>
        </tr> 
        <tr>
            <td>cache.report.enabled</td>
            <td>CACHE_REPORT_ENABLED</td>
            <td>true</td>
            <td>启用/禁用系统级别的视图报告缓存</td>
        </tr> 
        <tr>
            <td>cache.report.sessionDurationInMinutes</td>
            <td>CACHE_REPORT_SESSION_DURATION_MINUTES</td>
            <td>10</td>
            <td>缓存视图报告的过期时间</td>
        </tr> 
        <tr>
            <td>executors.uiBuild</td>
            <td>UI_BUILD_THREAD_COUNT</td>
            <td>2</td>
            <td>从 UI 触发并行视图配置执行的数量</td>
        </tr> 
        <tr>
            <td>executors.modelBuild</td>
            <td>MODEL_BUILD_THREAD_COUNT</td>
            <td>1</td>
            <td>并行模型构建进程的数量</td>
        </tr>      
        <tr>
            <td>executors.taskService</td>
            <td>CONCURRENT_TASK_EXECUTION_COUNT</td>
            <td>1</td>
            <td>并行任务执行的数量</td>
        </tr> 
        <tr>
            <td>executors.scheduledTaskService</td>
            <td>SCHEDULED_TASK_EXECUTOR_THREAD_COUNT</td>
            <td>3</td>
            <td>并行计划任务执行的数量</td>
        </tr> 
        <tr>
            <td>executors.simpleApiRateLimiter.queueCapacity</td>
            <td>SIMPLE_API_RATE_LIMITER_QUEUE_CAPACITY</td>
            <td>10</td>
            <td>等待执行的排队请求的最大数量</td>
        </tr> 
        <tr>
            <td>executors.simpleApiRateLimiter.threadPoolSize</td>
            <td>SIMPLE_API_RATE_LIMITER_THREAD_POOL_SIZE</td>
            <td>10</td>
            <td>并行执行的请求数量</td>
        </tr> 
        <tr>
            <td>authentication.login</td>
            <td>ADMIN_LOGIN</td>
            <td> </td>
            <td>用于对 ThingsBoard 的后台请求进行身份验证的用户名</td>
        </tr> 
        <tr>
            <td>authentication.password</td>
            <td>ADMIN_PASSWORD</td>
            <td> </td>
            <td>用于对 ThingsBoard 的后台请求进行身份验证的密码</td>
        </tr>         
                                                  
                               
  </tbody>
</table>

## 后续步骤

{% assign currentGuide = "InstallationOptions" %}{% include templates/trndz-guides-banner.md %}