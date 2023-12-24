{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% assign appRepo = "https://github.com/thingsboard/flutter_thingsboard_pe_app.git" %}
{% assign appProject = "flutter_thingsboard_pe_app" %}
{% assign cloudApp = "[ThingsBoard Cloud](https://cloud.codingas.com/signup)" %}
{% assign cloudEndpoint = "https://thingsboard.cloud" %}
{% assign flutterAppVer = site.release.pe_flutter_app_ver %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% assign appRepo = "https://github.com/thingsboard/flutter_thingsboard_app.git" %}
{% assign appProject = "flutter_thingsboard_app" %}
{% assign cloudApp = "[Live Demo](https://gridlinks.codingas.com/signup)" %}
{% assign cloudEndpoint = "https://gridlinks.codingas.com" %}
{% assign flutterAppVer = site.release.ce_flutter_app_ver %}
{% endif %}

* TOC
{:toc}

## 简介

本教程的目的是演示如何将 {{appPrefix}} 移动应用程序与您的 {{appPrefix}} 平台实例进行基本设置。您将学习如何：

* 设置开发环境；
* 获取应用程序项目源代码；
* 将 API 端点配置到您的 {{appPrefix}} 平台实例；
* 构建并运行您的 {{appPrefix}} 移动应用程序版本；

## 步骤 1. 准备开发环境

Flutter {{appPrefix}} 移动应用程序需要从 2.12.0 版本开始的 Flutter SDK。
按照 [这些](https://flutter.dev/docs/get-started/install) 说明设置 Flutter SDK。
为了获得更好的体验，我们建议使用 [这些](https://flutter.dev/docs/get-started/editor) 说明设置编辑器。

Flutter {{appPrefix}} 移动应用程序由从 3.4.0{% if docsPrefix == 'pe/' %}PE{% endif %} 版本开始的 {{appPrefix}} 平台提供服务。
您需要启动并运行 {{appPrefix}} 服务器。最简单的方法是使用 {{cloudApp}}。
另一种选择是使用 [安装指南](/docs/user-guide/install/{{docsPrefix}}installation-options/) 安装 {{appPrefix}}。

## 步骤 2. 获取应用程序源代码

#### Flutter {{appPrefix}} 移动应用程序兼容性表

根据 {{appPrefix}} 的版本确定 Flutter {{appPrefix}} 移动应用程序版本。

{% if docsPrefix != 'pe/' %}

<table>
    <thead>
        <tr>
          <td style="width: 50%"><b>GridLinks 版本</b></td><td style="width: 50%"><b>Flutter GridLinks 移动应用程序</b></td><td style="width: 50%"><b>Dart GridLinks 客户端</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>3.6.0+</td>
            <td>1.0.7</td>
            <td>1.0.7</td>
        </tr>
        <tr>
            <td>3.5.0+</td>
            <td>1.0.6</td>
            <td>1.0.6</td>
        </tr>
        <tr>
            <td>3.4.2+</td>
            <td>1.0.4</td>
            <td>1.0.4</td>
        </tr>
        <tr>
            <td>3.4.0+</td>
            <td>1.0.3</td>
            <td>1.0.3</td>
        </tr>
    </tbody>
</table>

{% else %}

<table>
    <thead>
        <tr>
          <td style="width: 50%"><b>GridLinks PE 版本</b></td><td style="width: 50%"><b>Flutter GridLinks PE 移动应用程序</b></td><td style="width: 50%"><b>Dart GridLinks PE 客户端</b></td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>3.6.0PE+</td>
            <td>1.0.8</td>
            <td>1.0.8</td>
        </tr>
        <tr>
            <td>3.5.0PE+</td>
            <td>1.0.7</td>
            <td>1.0.7</td>
        </tr>
        <tr>
            <td>3.4.2PE+</td>
            <td>1.0.5</td>
            <td>1.0.5</td>
        </tr>
        <tr>
            <td>3.4.0PE+</td>
            <td>1.0.4</td>
            <td>1.0.4</td>
        </tr>
    </tbody>
</table>


{% endif %}

您可以通过从 [github 存储库]({{appRepo}}) 克隆来获取 Flutter {{appPrefix}} 移动应用程序源代码：

```bash
git clone -b release/{{flutterAppVer}} {{appRepo}}
```
{: .copy-code}

## 步骤 3. 配置 {{appPrefix}} API 端点

在您的编辑器/IDE 中打开 **{{appProject}}** 项目。编辑 **lib/constants/app_constants.dart**。

将 **thingsBoardApiEndpoint** 常量值设置为与您的 {{appPrefix}} 服务器实例的 API 端点匹配。<br>
如果是 {{cloudApp}}，请将其设置为 `{{cloudEndpoint}}`。

```dart
abstract class ThingsboardAppConstants {
  static final thingsBoardApiEndpoint = '{{cloudEndpoint}}';
  
  ...
}

```

{% capture local_endpoint_note %}
**注意：** 不要使用 `localhost` 或 `127.0.0.1` 主机名。<br>
如果您使用的是本地 {{appPrefix}} 安装，请使用本地网络中可访问的备用 IP 地址/主机名。<br>
您可以阅读 [将 Flutter 应用程序连接到本地主机](https://medium.com/@podcoder/connecting-flutter-application-to-localhost-a1022df63130){:target="_blank"} 以了解更多信息。
{% endcapture %}
{% include templates/info-banner.md content=local_endpoint_note %}

## 步骤 4. 运行应用程序

按照 [您的 IDE 描述的方式](https://flutter.dev/docs/get-started/test-drive) 运行应用程序。

在使用终端时，使用以下命令运行应用程序：

```bash
flutter run
```
{: .copy-code}

您应该会看到 Android 或 iOS 输出，具体取决于您的设备。

<br>

<div style="display: flex; flex-direction: row;">
    <div style="display: flex; flex-direction: column; align-items: center;">
        <img width="" src="/images/mobile/{{docsPrefix}}android-app-login.png" title="Android 登录屏幕" alt="Android 登录屏幕示例">
        <span style="margin-top: 16px; font-size: 90%; color: #6c757d;">Android</span>
    </div>
    <div style="display: flex; flex-direction: column; align-items: center;">
        <img width="" src="/images/mobile/{{docsPrefix}}ios-app-login.png" title="iOS 登录屏幕" alt="iOS 登录屏幕示例">
        <span style="margin-top: 16px; font-size: 90%; color: #6c757d;">iOS</span>
    </div>
</div>

{% capture run_tip %}
**提示：** 第一次在物理设备上运行时，可能需要一段时间才能加载。
之后，您可以使用热重载进行快速更新。

**保存** 也会在应用程序正在运行时执行热重载。
当使用 `flutter run` 从控制台直接运行应用程序时，输入 `r` 以执行热重载。
{% endcapture %}
{% include templates/info-banner.md content=run_tip %}

{% if docsPrefix != 'pe/' %}
## 实时演示应用程序

为了熟悉常见的应用程序功能，请在 Google Play 和 App Store 上试用我们的 GridLinks Live 移动应用程序。

<br>

<div class="mobile-market-badges">
    <a href="https://play.google.com/store/apps/details?id=org.thingsboard.demo.app&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1" target="_blank">
        <img src="/images/mobile/get-it-on-google-play.png" alt="在 Google Play 上获取图标">
    </a>
    <a href="https://apps.apple.com/us/app/thingsboard-live/id1594355695?itsct=apps_box_badge&amp;itscg=30200" target="_blank">
        <img src="/images/mobile/download-on-the-app-store.png" alt="在 App Store 上下载图标">
    </a>
</div>

{% endif %}

## 后续步骤

- [自定义您的应用程序](/docs/{{docsPrefix}}mobile/customization) - 了解如何自定义您的 {{appPrefix}} 移动应用程序以满足您的要求。
- [发布您的应用程序](/docs/{{docsPrefix}}mobile/release) - 了解如何构建发布版本并将其 {{appPrefix}} 移动应用程序版本发布到 Google Play 或 App Store。