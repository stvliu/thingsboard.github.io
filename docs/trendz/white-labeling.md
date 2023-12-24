---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 白标
description: Trendz 白标配置 - 设置颜色方案、徽标和其他品牌设置

trendz-white-labeling-section:
  0:
    image: /images/trendz/trendz-white-labeling-settings.png
    title: 'Trendz 分析设置中的白标部分'

trendz-white-labeling-logo:
  0:
    image: /images/trendz/trendz-white-labeling-logo.png
    title: '更改 Trendz 分析徽标设置'

trendz-white-labeling-title:
  0:
    image: /images/trendz/trendz-white-labeling-title.png
    title: '更改 Trendz 分析选项卡标题'

trendz-white-labeling-url-path:
  0:
    image: /images/trendz/trendz-white-labeling-path-cloud.png
    title: '在自托管安装中更改 Trendz 分析加载 URL 路径'
  1:
    image: /images/trendz/trendz-white-labeling-path-self.png
    title: '在 Trendz Cloud 中更改加载 URL 路径'
---


* TOC
{:toc}

从 Trendz 版本 1.11 开始，您现在可以自定义某些品牌设置。这些选项包括编辑以下界面元素：

* 徽标和 favicon（浏览器选项卡上的图标）。
* 浏览器选项卡的名称。
* URL 路径自定义（域名后面的部分）。

您可以在 **白标** 部分的 Trendz **设置** 页面中配置这些设置。

{% include images-gallery.html imageCollection="trendz-white-labeling-section" %}


## Trendz 徽标和 favicon
支持上传所有主要图像格式。建议大小为 64 x 64 像素。但会支持其他大小。
上传新图像并按下保存按钮后，徽标和 favicon 将发生更改。

{% include images-gallery.html imageCollection="trendz-white-labeling-logo" %}

## 浏览器选项卡的名称
此字段最多可容纳 128 个字符。值得一提的是，虽然大多数浏览器可能无法完全显示所有这些字符。

{% include images-gallery.html imageCollection="trendz-white-labeling-title" %}

## URL 路径自定义

* **自管理：**如果您使用的是自管理选项（Trendz 托管在您自己的服务器上），那么此字段可以包含任意文本。限制 - 128 个字符。请记住，这是 URL 的一部分。因此，为了更正显示单词，您需要用连字符将它们分开。
* **Trendz Cloud** - 您无法设置自定义文本，但可以使用通用词 **analytics**

{% include images-gallery.html imageCollection="trendz-white-labeling-url-path" %}