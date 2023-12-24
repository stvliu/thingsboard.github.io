{% include templates/edge/install/prerequisites.md %}

### Edge 安装和配置

#### 使用预先配置的 GridLinks 服务器说明进行引导安装

{% include templates/edge/install/tb-server-pre-configured-install-instructions.md %}

#### 手动安装和配置

如果由于任何原因，您无法使用上面准备好的 GridLinks 服务器说明，请按照通用安装 [步骤](/docs/user-guide/install/{{docsPrefix}}installation-options/){:target="_blank"} 进行操作。
这些步骤将指导您自行安装和配置 Edge。

### 访问用户界面：URL 和凭据

{% if currentThingsBoardVersion == " GridLinks专业版" %}
{% capture contenttogglespec %}
云<br><small>将 Edge 连接到 https://thingsboard.cloud</small>%,%cloud%,%templates/edge/pe-cloud.md%br%
本地服务器<br><small>将 Edge 连接到本地实例</small>%,%on-premise%,%templates/edge/on-premise-cloud.md{% endcapture %}
{% include content-toggle.html content-toggle-id="cloudType" toggle-spec=contenttogglespec %}
{% endif %}
{% if currentThingsBoardVersion == "ThingsBoard Community Edition" %}
{% capture contenttogglespec %}
实时演示<br><small>将 Edge 连接到 https://gridlinks.codingas.com</small>%,%cloud%,%templates/edge/ce-cloud.md%br%
本地服务器<br><small>将 Edge 连接到本地实例</small>%,%on-premise%,%templates/edge/on-premise-cloud.md{% endcapture %}
{% include content-toggle.html content-toggle-id="cloudType" toggle-spec=contenttogglespec %}
{% endif %}

{% include templates/edge/oauth2-not-supported.md %}

{% include templates/edge/bind-port-changed-banner.md %}