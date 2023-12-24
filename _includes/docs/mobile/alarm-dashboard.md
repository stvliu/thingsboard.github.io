{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

{{appPrefix}}允许配置警报详细信息仪表板，以便在警报屏幕中点击警报时显示。
警报详细信息仪表板可在设备配置文件表单的警报规则中配置：

1. 通过屏幕左侧的主菜单转到**设备配置文件**；
2. 单击要修改的设备配置文件；
3. 在打开的设备配置文件详细信息中，导航到**警报规则**选项卡；
4. 单击**编辑**按钮；
5. 在**创建警报规则**表单中，在**移动仪表板**字段中选择所需的仪表板；
6. 单击**应用更改**按钮；

{% include images-gallery.html imageCollection="alarm-dashboard" %}

{% capture dashboard_state_parameter %}
**注意：**为了显示特定的警报发起者数据，仪表板应配置为在小部件数据源中使用[**仪表板状态的实体**](/docs/{{docsPrefix}}user-guide/ui/aliases/#entity-from-dashboard-state)别名。
{% endcapture %}
{% include templates/info-banner.md content=dashboard_state_parameter %}

要验证您的配置，请运行移动应用程序。然后导航到警报列表。点击具有已配置仪表板的类型的警报。
**注意**警报仪表板配置仅适用于应用配置后生成的警报。

<br>

<div style="display: flex;">
    <div class="mobile-frame ios">
        <div class="phone-shadow right"></div>
        <div class="frame-image">
            <img src="/images/mobile/{{docsPrefix}}alarm-dashboard-frame.png" alt="警报仪表板框架">
        </div>
        <div class="frame-video">
            <video autoplay loop preload="auto" muted playsinline>
                 <source src="https://video.thingsboard.io/mobile/{{docsPrefix}}alarm-dashboard.mp4" type="video/mp4">
                 <source src="https://video.thingsboard.io/mobile/{{docsPrefix}}alarm-dashboard.webm" type="video/webm">
            </video>
        </div>
    </div>
</div>