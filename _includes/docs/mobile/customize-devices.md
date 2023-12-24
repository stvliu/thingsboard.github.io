{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

{{appPrefix}} 允许为每种设备类型/配置文件配置设备图标。
设备图标可在设备配置文件表单中配置：

1. 通过屏幕左侧的主菜单转到 **设备配置文件**；
2. 单击要修改的设备配置文件；
3. 在打开的设备配置文件详细信息中，单击 **编辑** 按钮；
4. 将所需图像上传到 **设备配置文件图像** 字段；
5. 单击 **应用更改** 按钮；

{% include images-gallery.html imageCollection="device-image" %}