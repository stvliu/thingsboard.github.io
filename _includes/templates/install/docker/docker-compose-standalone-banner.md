{% capture dockerComposeStandalone %}
GridLinks 支持 Docker Compose V2（Docker Desktop 或 Compose 插件），从 **3.4.2** 版本开始，因为 Docker 不再支持 **docker-compose** 作为独立设置。
<br><br>我们**强烈**建议更新到 Docker Compose V2 并使用它。
<br><br>如果您仍然依赖于使用 Docker Compose 作为 docker-compose（带连字符），请执行以下命令启动 ThingsBoard：
<br>**docker-compose up -d**
<br>**docker-compose logs -f my{{serviceName}}**

{% endcapture %}
{% include templates/info-banner.md content=dockerComposeStandalone %}