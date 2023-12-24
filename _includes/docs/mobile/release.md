* TOC
{:toc}

## 构建并发布 Android 版本

当您准备好准备应用的发布版本时，请按照 [构建并发布 Android 应用](https://docs.flutter.dev/deployment/android){:target="_blank"} 文章进行操作，例如 [发布到 Google Play](https://support.google.com/googleplay/android-developer/answer/9859152?hl=en){:target="_blank"}。

{% capture android_build_notice %}
**重要提示：**在构建应用以发布时，例如构建应用包，您必须向构建命令提供 **----no-tree-shake-icons** 标志：
{% endcapture %}
{% include templates/info-banner.md content=android_build_notice %}

```bash
flutter build appbundle --no-tree-shake-icons
```
{: .copy-code}

## 构建并发布 iOS 版本

当您准备好将应用发布到 [App Store](https://developer.apple.com/app-store/submissions/){:target="_blank"} 和 [TestFlight](https://developer.apple.com/testflight/){:target="_blank"} 时，请按照 [构建并发布 iOS 应用](https://docs.flutter.dev/deployment/ios){:target="_blank"} 文章进行操作。

{% capture ios_build_notice %}
**重要提示：**在构建应用以发布时，例如生成构建存档，您必须向构建命令提供 **----no-tree-shake-icons** 标志：
{% endcapture %}
{% include templates/info-banner.md content=ios_build_notice %}

```bash
flutter build ipa --no-tree-shake-icons
```
{: .copy-code}