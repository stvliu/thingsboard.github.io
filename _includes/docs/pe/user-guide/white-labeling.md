{% assign feature = "品牌定制" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

## 简介

GridLinks Web 界面允许您通过单击几下配置您的公司或产品徽标和配色方案，而无需任何编码工作，也不需要重新启动服务。

{% if docsPrefix == "pe/" %}
系统管理员、租户和客户管理员可以配置配色方案、图标、网站图标以及系统组件和最终用户仪表板元素的自定义翻译。
但只有系统和租户管理员才能设置客户电子邮件模板以与用户互动。

默认情况下，租户继承系统管理员 UI 配置，客户继承租户 UI 配置。但租户和客户管理员能够设置他们自己的品牌定制配置。
{% endif %}
{% if docsPrefix == "paas/" %}
租户和客户管理员可以配置配色方案、图标、网站图标以及系统组件和最终用户仪表板元素的自定义翻译。
但只有租户管理员才能设置客户电子邮件模板以与用户互动。

默认情况下，客户继承租户 UI 配置。但客户管理员能够设置他们自己的品牌定制配置。
{% endif %}

## 品牌定制设置

要配置您的公司或产品徽标和配色方案，请转到“品牌定制”页面。

{% include images-gallery.html imageCollection="white-labeling-default" %}

在“常规”选项卡中，您可以设置或更改以下选项：

- 应用程序标题 - 您可以指定自定义页面标题，该标题显示在浏览器选项卡中；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/white-labeling/application-title.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/white-labeling/application-title-paas.png)
{% endif %}

- 网站图标（网站图标） - 您可以将默认网站图标更改为您自己的图标；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/white-labeling/website-icon.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/white-labeling/website-icon-paas.png)
{% endif %}

- 徽标 - 您可以将左上角的标准徽标更改为您的公司徽标；

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/white-labeling/logo.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/white-labeling/logo-paas.png)
{% endif %}

- 徽标高度 - 您可以调整徽标大小；
- 主调色板 - 您可以通过选择建议的 UI 设计选项之一或自定义现有选项来自定义背景颜色和字体颜色；

![image](/images/user-guide/white-labeling/primary-palette.png)

- 强调色调色板 - 您可以自定义某些元素的颜色，例如切换按钮；

![image](/images/user-guide/white-labeling/accent-palette.png)

- 高级 CSS - 您可以根据需要设置 GridLinks 用户界面的任何元素的样式。我们将在 [下面](#高级-css) 详细介绍此功能；
- 显示/隐藏平台名称和版本 - 选中此选项后，平台名称及其当前版本将显示在左下角。

![image](/images/user-guide/white-labeling/show-platform-name-and-version.png)

自定义用户界面的最终外观：

{% include images-gallery.html imageCollection="white-labeling-custom" %}

## 高级 CSS

使用 CSS，您可以根据需要设置 GridLinks 用户界面的任何元素的样式。此类元素可以是背景、图标、字体等。

要在 UI 设计中使用 CSS，请执行以下操作：

{% include images-gallery.html imageCollection="advanced-css-1" showListImageTitles="true" %}

自定义图标颜色和滚动颜色的 CSS 代码示例：

```css
/*icon color*/

.mat-icon.notranslate.material-icons.mat-ligature-font.mat-icon-no-color.ng-star-inserted{
    fill: #a60062;
    color: #a60062;
}
.mat-icon.notranslate.mat-icon-no-color.ng-star-inserted{
    fill: #a60062;
}

/*scroll color*/

mat-toolbar::-webkit-scrollbar-thumb,
div::-webkit-scrollbar-thumb,
ng-component::-webkit-scrollbar-thumb {
    background-color: #c526a5 !important;
    background-image: linear-gradient(#e72c83, #a742c6);
    border-radius: 200px/300px !important;
    border: 0.1rem linear-gradient(#e72c83, #a742c6);
}

.mat-mdc-button.mat-mdc-button-base.tb-active{
    color: #ffffff;
}
```
{: .copy-code}

<br>
我们还为左侧菜单添加一个渐变。

{% include images-gallery.html imageCollection="advanced-css-2" showListImageTitles="true" %}

自定义侧边栏菜单外观的 CSS 代码示例：

```css
/*menu gradient*/

.tb-side-menu {
    background: linear-gradient(44deg, #9d9d9d, #ffffff, #9f9f9f);
}
```
{: .copy-code}

使用本说明文档中描述的功能，您可以根据自己的喜好自定义 GridLinks UI 的外观。

## 视频教程

观看详细的视频教程，其中包含有关如何配置品牌定制以满足您需求的示例。

<br>
<div id="video">  
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/VSNZWl1NjWU" frameborder="0" allowfullscreen></iframe>
    </div>
</div> 

<br>
[联系我们](/docs/contact-us/) 以建议您案例中缺少的功能。

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}