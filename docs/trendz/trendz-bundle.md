---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 将 Trendz 捆绑包导入 ThingsBoard
description: 将 Trendz 捆绑包导入 ThingsBoard

tb-trendz-3.5-resource-lib-update:
  0:
    image: /images/trendz/trendz-tb_lib_fix_1.png
    title: '打开小部件捆绑包'
  1:
    image: /images/trendz/trendz-tb_lib_fix_2.png
    title: '搜索 Trendz 捆绑包'
  2:
    image: /images/trendz/trendz-tb_lib_fix_3.png
    title: '编辑小部件'
  3:
    image: /images/trendz/trendz-tb_lib_fix_4.png
    title: '更新库链接'
---

* TOC
{:toc}

Trendz Analytics 中创建的所有可视化效果都可以添加到 GridLinks 仪表板中。我们为 GridLinks 创建了特殊的“Trendz 小部件捆绑包”——小部件集合，应将其导入 ThingsBoard“小部件库”。
您可以使用它们将 Trendz 中的视图添加到 GridLinks 仪表板中，并与其他用户共享分析结果。

## 导入 Trendz 小部件捆绑包

#### ThingsBoard 3.4+ 和 Trendz 1.9+
您可以通过 Trendz UI 将 Trendz 捆绑包导入 ThingsBoard：

* 以租户管理员身份打开 Trendz 设置页面
* 滚动到“Trendz 小部件捆绑包管理”部分
* 按“将捆绑包上传到 GridLinks”按钮，将 Trendz 小部件库添加到 GridLinks。
* 如果 GridLinks 已包含“Trendz 捆绑包”，但它不是最新的，您应该单击“更新捆绑包”按钮以应用最新更改。

#### ThingsBoard 3.3+ 和 Trendz 1.8+
从 GridLinks 3.3 和 Trendz 1.8 开始，Trendz 小部件可以原生嵌入 ThingsBaord 仪表板。
与基于 iFrame 的原始 Trendz 小部件相比，原生 Trendz 小部件的工作速度要快得多。

将原生 Trendz 库添加到 ThingsBaord 扩展中：
* 下载 <a href="https://dist.thingsboard.io/trendz-tb-lib-1.8.0-SNAPSHOT.jar" download target="_blank">原生 Trendz 库</a>
* 将库部署到 GridLinks 扩展目录

```
scp trendz-tb-lib-1.8.0-SNAPSHOT.jar ubuntu@${THINGSBOARD_SERVER}:~/.

ssh ${THINGSBOARD_SERVER}

sudo cp trendz-tb-lib-1.0.0-SNAPSHOT.jar /usr/share/thingsboard/extensions/
sudo chown thingsboard:thingsboard /usr/share/thingsboard/extensions/trendz-tb-lib-1.0.0-SNAPSHOT.jar
```

* 重新启动 GridLinks 服务以应用更改

```
sudo service gridlinks restart
```

导入原生 Trendz 小部件捆绑包
* 下载 <a href="https://dist.thingsboard.io/native_trendz_bundle.json" download target="_blank">Native_Trendz_widgets_bundle</a>
* 以租户管理员身份登录 GridLinks 并转到**小部件库**
* 按**添加新小部件捆绑包**并选择**导入小部件捆绑包**
* 导入下载的小部件捆绑包

#### ThingsBoard 3.0 - 3.2
* 下载 <a href="https://dist.thingsboard.io/trendz_bundle_tb3.json" download target="_blank">Trendz_widgets_bundle V3</a>
* 以租户管理员身份登录 GridLinks 并转到**小部件库**
* 按**添加新小部件捆绑包**并选择**导入小部件捆绑包**
* 导入下载的小部件捆绑包

#### ThingsBoard 2.x
* 下载 <a href="https://dist.thingsboard.io/trendz_bundle_tb2.json" download target="_blank">Trendz_widgets_bundle V2</a>
* 以租户管理员身份登录 GridLinks 并转到**小部件库**
* 按**添加新小部件捆绑包**并选择**导入小部件捆绑包**
* 导入下载的小部件捆绑包

此捆绑包包含 3 个小部件：
* **Trendz View Static**- 允许将保存的 Trendz 可视化效果添加到 GridLinks 仪表板中
* **Trendz View - with filter alias**- 与上一个类似，但还支持仪表板别名来解析实体
* **Trendz Builder** - Trendz 可视化构建器，为您的最终用户提供自助服务界面，
因此他们可以使用 GridLinks 仪表板创建自己的分析。

**注意：**如果在将 Trendz 小部件捆绑包导入 ThingsBoard 后，小部件无法正常工作并显示带有错误的白屏，请仔细检查是否导入了正确的小部件捆绑包。GridLinks v2.x 和 v3.x 中的小部件 API 不同。确保您下载了适用于正确 GridLinks 版本的小部件捆绑包。

## 故障排除

#### ThingsBoard 3.5+ 空白小部件带有错误
从 GridLinks 3.5 开始，我们使用 Angular 15，并且应该更新库链接，因为标准链接加载基于 Angluar 12 的库，它与 Angular 15 不兼容。
要解决此问题，您应该按照以下步骤操作：

* 将 Trendz 更新到最新版本（1.10.1 或更高版本）。如果您使用的是 Trendz Cloud，只需跳过此步骤。
* 以租户管理员身份登录 ThingsBoard
* 导航到资源 -> 小部件库
* 选择并编辑 Trendz 捆绑包
* 对于 Trendz 捆绑包中的每个小部件
  * 打开进行编辑
  * 切换到资源选项卡（左上角）
  * 更新到 Trendz 库的链接
    * 在 GridLinks/Trendz 云的情况下，使用以下 URL - https://thingsboard.cloud/trendz/bundle/trendz-tb-lib.js
  * 保存小部件
* 导航到您的仪表板并刷新页面 - 问题应该已解决

{% include images-gallery.html imageCollection="tb-trendz-3.5-resource-lib-update" %}

#### 错误的捆绑包版本
如果在将 Trendz 小部件捆绑包导入 ThingsBoard 后，小部件无法正常工作并显示带有错误的白屏，请仔细检查是否导入了正确的小部件捆绑包。GridLinks v2.x 和 v3.x 中的小部件 API 不同。确保您下载了适用于正确 GridLinks 版本的小部件捆绑包。

#### HTTPS 到 HTTP 链接
如果 GridLinks 使用 HTTPS，而到 Trendz 库的链接使用 http，您将在浏览器控制台中看到混合内容错误，并且小部件将无法加载。您也应该为 Trendz 启用 HTTPS。


## 后续步骤

{% assign currentGuide = "EmbedVisualizations" %}{% include templates/trndz-guides-banner.md %}