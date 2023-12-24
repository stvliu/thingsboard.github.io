## 先决条件

{% include templates/edge/install/hardware-requirements.md %}

### 为 ThingsBoard Edge 设置服务器环境

要开始使用 ThingsBoard **Edge**，必须有一个支持 Edge 功能的运行中的 {{appPrefix}} 服务器。

{% if docsPrefix == 'pe/edge/' %}
{% include templates/edge/obtain-pe-cloud.md %}
{% else %}
{% include templates/edge/obtain-ce-cloud.md %}
{% endif %}

### 在服务器上配置新的 Edge 实例

{% if docsPrefix == 'pe/edge/' %}
{% assign addEdge = '
    ===
        image: /images/pe/edge/installation-add-edge-item-1.png,
        title: 登录到您的 ThingsBoard <b>PE</b> 实例并导航到“Edge 管理”->“实例”页面。单击右上角的“+”图标并选择“添加 Edge”。
    ===
        image: /images/pe/edge/installation-add-edge-item-2.png,
        title: 为您的 Edge 输入一个名称。例如，“我的新 Edge”。如有必要，请更新云端点。Edge 应该可以访问此 URL。如果 Edge 在 Docker 容器中运行，则使用“localhost”是<b>不正确</b>的。它必须是 ThingsBoard <b>PE</b> 运行所在机器的 IP 地址，并且 Edge 容器可以访问。如果您使用 ThingsBoard <b>Cloud</b> 服务器来评估 Edge，请保持此设置不变。单击“添加”以创建您的新 Edge。
    ===
        image: /images/pe/edge/installation-add-edge-item-3.png,
        title: 您的新 Edge 现在应该出现在列表顶部，因为默认情况下按创建时间对条目进行排序。
'%}
{% else %}
{% assign addEdge = '
    ===
        image: /images/edge/installation-add-edge-item-1.png,
        title: 登录到您的 ThingsBoard <b>CE</b> 实例并导航到“Edge 管理”->“实例”页面。单击右上角的“+”图标并选择“添加 Edge”。
    ===
        image: /images/edge/installation-add-edge-item-2.png,
        title: 为您的 Edge 输入一个名称。例如，“我的新 Edge”。单击“添加”以确认创建您的新 Edge。
    ===
        image: /images/edge/installation-add-edge-item-3.png,
        title: 您的新 Edge 现在应该出现在列表顶部，因为默认情况下按创建时间对条目进行排序。
'%}
{% endif %}

此外，您需要在服务器上配置 ThingsBoard **Edge**。

{% include images-gallery.liquid imageCollection=addEdge showListImageTitles="true" %}