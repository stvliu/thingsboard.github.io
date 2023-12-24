{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% endif %}

* TOC
{:toc}

## 概述

{{appPrefix}} 允许配置仪表板列表在移动应用程序主屏幕中的显示方式。
所有与移动应用程序相关的配置选项均可在仪表板详细信息表单中找到。

## 仪表板图像

您可以在仪表板详细信息表单中为移动应用程序配置仪表板图像：

{% if docsPrefix == 'pe/' %}
1. 通过屏幕左侧的主菜单转到 **仪表板组**；
2. 打开目标仪表板组；
{% else %}
1. 通过屏幕左侧的主菜单转到 **仪表板**；
{% endif %}
2. 单击要修改的仪表板；
3. 在打开的仪表板详细信息中，单击 **编辑** 按钮；
4. 将所需图像上传到 **仪表板图像** 字段；
5. 单击 **应用更改** 按钮；

{% include images-gallery.html imageCollection="dashboard-image" %}

## 仪表板顺序

您可以在移动应用程序主屏幕中配置仪表板顺序：

{% if docsPrefix == 'pe/' %}
1. 通过屏幕左侧的主菜单转到 **仪表板组**；
2. 打开目标仪表板组；
{% else %}
1. 通过屏幕左侧的主菜单转到 **仪表板**；
{% endif %}
2. 单击要修改的仪表板；
3. 在打开的仪表板详细信息中，单击 **编辑** 按钮；
4. 在 **移动应用程序中的仪表板顺序** 字段中输入所需的顺序；
5. 单击 **应用更改** 按钮；

{% include images-gallery.html imageCollection="dashboard-order" %}

## 在移动应用程序中隐藏仪表板

您可以从移动应用程序主屏幕中隐藏特定仪表板：

{% if docsPrefix == 'pe/' %}
1. 通过屏幕左侧的主菜单转到 **仪表板组**；
2. 打开目标仪表板组；
{% else %}
1. 通过屏幕左侧的主菜单转到 **仪表板**；
{% endif %}
2. 单击要修改的仪表板；
3. 在打开的仪表板详细信息中，单击 **编辑** 按钮；
4. 选中 **在移动应用程序中隐藏仪表板** 复选框；
5. 单击 **应用更改** 按钮；

{% include images-gallery.html imageCollection="hide-dashboard" %}