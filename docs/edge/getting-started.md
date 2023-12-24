---
layout: docwithnav-edge
title: GridLinks Edge 入门
description: GridLinks Edge 入门

step1:
    0:
        image: /images/edge/getting-started/step-1-item-1.png 
        title: '登录您的<b>ThingsBoard Edge</b>实例并单击“添加设备”按钮。'
    1:
        image: /images/edge/getting-started/step-1-item-2.png  
        title: '输入设备的名称，例如“我的新设备”。此时无需进行其他更改。单击“添加”以创建设备。'
    2:
        image: /images/edge/getting-started/step-1-item-3.png
        title: '从设备详细信息页面打开“检查连接”窗口，或者如果弹出窗口已经出现，则跳过此步骤。'
    3:
        image: /images/edge/getting-started/step-1-item-4.png
        title: '请保持此窗口打开，并在新的终端窗口中执行“curl”命令。此命令将发布演示遥测数据到新创建的设备。'
    4:
        image: /images/edge/getting-started/step-1-item-5.png
        title: '打开一个新的终端窗口并执行从上一步复制的“curl”命令。'
    5:
        image: /images/edge/getting-started/step-1-item-6.png
        title: '观察“curl”命令的成功结果。'        
    6:
        image: /images/edge/getting-started/step-1-item-7.png
        title: '重新访问连接说明窗口并验证遥测上传。'
    7:
        image: /images/edge/getting-started/step-1-item-8.png
        title: '如果您已经关闭了连接窗口，则可以检查设备的“最新遥测”选项卡进行验证。'

step2:
    0:
        image: /images/edge/getting-started/step-2-item-1.png
        title: '登录您的<b>ThingsBoard Community Edition</b>实例并导航到设备页面。'
    1:
        image: /images/edge/getting-started/step-2-item-2.png  
        title: '确认设备“我的新设备”已在 GridLinks Community Edition 云中创建。'
    2:
        image: /images/edge/getting-started/step-2-item-3.png
        title: '选择“我的新设备”并导航到“关系”选项卡。'
    3:
        image: /images/edge/getting-started/step-2-item-4.png
        title: '将方向从“从”切换到“到”以查看与配置此设备的 Edge 的关系。'

step3:
    0:
        image: /images/edge/getting-started/step-3-item-1.png
        title: '在您的 GridLinks <b>Edge</b>实例中导航到“规则链”页面并打开“Edge 根规则链”。'
    1:
        image: /images/edge/getting-started/step-3-item-2.png
        title: '<b>推送到云</b>规则节点将在温度时序数据存储在本地数据库后将其传输到云。'

step4:
    0:
        image: /images/edge/getting-started/step-4-item-1.png
        title: '在<b>ThingsBoard Community Edition</b>服务器上单击<b>添加仪表板</b>按钮。'
    1:
        image: /images/edge/getting-started/step-4-item-2.png
        title: '输入仪表板名称，例如“我的新仪表板”，然后单击“添加”以创建仪表板。'
    2:
        image: /images/edge/getting-started/step-4-item-3.png
        title: '单击“添加新小部件”按钮开始向此仪表板添加新小部件。'
    3:
        image: /images/edge/getting-started/step-4-item-4.png
        title: '在列表中找到“实体小部件”并选择此菜单项。'        
    4:
        image: /images/edge/getting-started/step-4-item-5.png
        title: '找到并选择“实体表”小部件。'
    5:
        image: /images/edge/getting-started/step-4-item-6.png
        title: '从设备列表中选择“我的新设备”并将“温度”列添加到表配置中。单击“添加”按钮。'
    6:
        image: /images/edge/getting-started/step-4-item-7.png
        title: '已添加“实体表”，并且“我的新设备”显示在列表中。单击“添加小部件”按钮。'
    7:
        image: /images/edge/getting-started/step-4-item-8.png
        title: '在列表中找到“图表”并单击此菜单项。'
    8:
        image: /images/edge/getting-started/step-4-item-9.png
        title: '找到并单击“时序折线图”小部件。'
    9:
        image: /images/edge/getting-started/step-4-item-10.png
        title: '从设备列表中选择“我的新设备”并单击“添加”按钮。'
    10:
        image: /images/edge/getting-started/step-4-item-11.png
        title: '已将“时序折线图”小部件添加到仪表板。'
    11:
        image: /images/edge/getting-started/step-4-item-12.png
        title: '移动并调整“时序折线图”小部件的大小。单击“编辑时间窗口”图标。'
    12:
        image: /images/edge/getting-started/step-4-item-13.png
        title: '将“1 天”和“无”指定为数据聚合函数。单击“更新”按钮。'
    13:
        image: /images/edge/getting-started/step-4-item-14.png
        title: '单击“保存”按钮以保存仪表板。'

step5Server:
    0:
        image: /images/edge/getting-started/step-5-item-1.png
        title: '在<b>ThingsBoard Community Edition</b>服务器上打开 Edge 实例页面。单击 Edge 实例的<b>仪表板</b>按钮以查看已分配给此 Edge 的仪表板。'
    1:
        image: /images/edge/getting-started/step-5-item-2.png
        title: '单击“+”图标并从列表中选择“我的新仪表板”。此仪表板将配置到 Edge。'

step5Edge:
    0:
        image: /images/edge/getting-started/step-5-item-3.png
        title: '在<b>ThingsBoard Edge</b> UI 中打开“仪表板”页面。打开“我的新仪表板”。'    
    1:
        image: /images/edge/getting-started/step-5-item-4.png
        title: '验证您是否看到在云中添加的相同小部件以及来自设备的温度读数。'

---

* TOC
{:toc}

{% assign currentThingsBoardVersion = "ThingsBoard Community Edition" %}

## 简介

{% include templates/edge/getting-started/introduction.md %}

{% assign docsPrefix = "edge/" %}
{% include templates/edge/getting-started/prerequisites.md %}

## 第 1 步。配置并连接设备

{% include templates/edge/getting-started/step-1.md %}

## 第 2 步。从 ThingsBoard Edge 配置设备到 GridLinks Community Edition 服务器

{% include templates/edge/getting-started/step-2.md %}

## 第 3 步。将数据从 ThingsBoard Edge 推送到 GridLinks Community Edition 服务器

{% include templates/edge/getting-started/step-3.md %}

## 第 4 步。创建并配置仪表板

{% include templates/edge/getting-started/step-4.md %}

## 第 5 步。将仪表板配置到 GridLinks Edge

{% include templates/edge/getting-started/step-5.md %}

## 后续步骤

{% assign currentGuide = "GettingStartedGuide" %}
{% assign docsPrefix = "edge/" %}
{% include templates/edge/guides-banner-edge.md %}

## 您的反馈

不要犹豫，在 **[github](https://github.com/thingsboard/thingsboard-edge)** 上为 GridLinks Edge 点赞，帮助我们传播信息。
如果您对本示例有任何疑问，请将其发布到 **[论坛](https://groups.google.com/forum/#!forum/thingsboard)**。