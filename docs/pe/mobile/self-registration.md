---
layout: docwithnav-mobile-pe
title: 在 GridLinks PE 移动应用程序中配置自动注册

self-registration:
 0:
  image: /images/mobile/pe/self-registration-1.png
  title: '选中<b>启用移动应用程序自动注册</b>复选框'
 1:
  image: /images/mobile/pe/self-registration-2.png
  title: '指定您的应用程序包（对于 Android：您自己的唯一应用程序 ID。对于 iOS：产品包标识符。）<br>记住自动生成的<b>应用程序密钥</b>或输入您自己的密钥。'
 2:
  image: /images/mobile/pe/self-registration-3.png
  title: '指定<b>应用程序 URL 架构</b> - 可以是任何短字符串（例如 myappscheme）'
 3:
  image: /images/mobile/pe/self-registration-4.png
  title: '指定<b>应用程序 URL 主机名</b> - 通常是应用程序 ID 的反向顺序（例如 myapp.mydomain.org）'
 4:
  image: /images/mobile/pe/self-registration-5.png
  title: '最后，要应用更改，请单击自动注册表单右下角的<b>保存</b>按钮'

---

ThingsBoard PE 移动应用程序提供自动注册支持。启用了自动注册的移动应用程序提供了一个注册表单，允许注册新的客户用户。
租户管理员用户可以在**自动注册**设置表单中对其进行配置。
请参阅[自动注册](/docs/pe/user-guide/self-registration/)以了解常规自动注册配置。
为了在移动应用程序中启用自动注册，您应该在自动注册设置表单的**移动应用程序自动注册设置**部分中启用并对其进行配置：

1. 作为租户管理员用户，转到**系统设置** -> **自动注册**；
2. 选中**启用移动应用程序自动注册**复选框；
3. 指定您的应用程序包（对于 Android：您自己的唯一应用程序 ID。对于 iOS：产品包标识符。）；
4. 记住自动生成的**应用程序密钥**或输入您自己的密钥；
5. 指定**应用程序 URL 架构** - 可以是任何短字符串（例如 myappscheme）；
6. 指定**应用程序 URL 主机名** - 通常是应用程序 ID 的反向顺序（例如 myapp.mydomain.org）；
7. 最后，要应用更改，请单击自动注册表单右下角的**保存**按钮；

{% include images-gallery.html imageCollection="self-registration" %}

此外，您应该修改您的移动应用程序常量。
在您的编辑器/IDE 中打开**flutter_thingsboard_pe_app**项目。编辑**lib/constants/app_constants.dart**。

将**thingsboardSignUpAppSecret**常量值设置为**应用程序密钥**字段的值：

```dart
abstract class ThingsboardAppConstants {
  ...

  static final thingsboardSignUpAppSecret = 'Your sign up app secret here';
}

```

{% capture self_register_domain %}
**注意：****thingsBoardApiEndpoint**常量中使用的域名应与自动注册设置表单中配置的**域名**匹配。
{% endcapture %}
{% include templates/info-banner.md content=self_register_domain %}

最后，应执行以下更改以允许移动应用程序处理激活链接：

1. 对于 Android：

    编辑**android/app/src/main/AndroidManifest.xml**，查找并设置**MainActivity**的可浏览意图过滤器的架构和主机。
    将**android:scheme**的值设置为**应用程序 URL 架构**字段的值，将**android:host**的值设置为**应用程序 URL 主机名**字段的值：

    ```xml
      ...
        <activity
                android:name=".MainActivity"

                ...

                <intent-filter>
                    <action android:name="android.intent.action.VIEW" />
                    <category android:name="android.intent.category.DEFAULT" />
                    <category android:name="android.intent.category.BROWSABLE" />
                    <data android:scheme="value of Application URL scheme field" android:host="value of Application URL hostname field"/>
                </intent-filter>

        </activity>
      ...
    ```

2. 对于 iOS：

    编辑**ios/Runner/Info-Debug.plist**和**ios/Runner/Info-Release.plist**文件，查找**CFBundleURLTypes**数组属性。
    将**CFBundleURLName**属性的字符串值设置为**应用程序 URL 主机名**字段的值，
    将字符串数组属性**CFBundleURLSchemes**的值设置为**应用程序 URL 架构**字段的值：

    ```xml
      ...
        <key>CFBundleURLTypes</key>
        <array>
            <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLName</key>
            <string>value of Application URL hostname field</string>
            <key>CFBundleURLSchemes</key>
            <array>
            <string>value of Application URL scheme field</string>
            </array>
            </dict>
        </array>
      ...
    ```

要验证您的自动注册设置，请运行移动应用程序。
您应该在登录表单的底部看到**创建帐户**链接。单击**创建帐户**链接后，您应该被定向到注册表单。
如果您的设置正确，您应该能够在手机中单击电子邮件中的激活链接时使用移动应用程序进行注册并激活帐户。

<br>

<div style="display: flex;">
    <div class="mobile-frame ios">
        <div class="phone-shadow right"></div>
        <div class="frame-image">
            <img src="/images/mobile/pe/self-registration-frame.png" alt="self registration frame">
        </div>
        <div class="frame-video">
            <video autoplay loop preload="auto" muted playsinline>
                 <source src="https://video.docs.codingas.com/mobile/pe/self-registration.mp4" type="video/mp4">
                 <source src="https://video.docs.codingas.com/mobile/pe/self-registration.webm" type="video/webm">
            </video>
        </div>
    </div>
</div>