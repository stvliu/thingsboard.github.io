{% if docsPrefix == 'pe/' %}
{% assign appPrefix = "ThingsBoard PE" %}
{% assign appProject = "flutter_thingsboard_pe_app" %}
{% else %}
{% assign appPrefix = "ThingsBoard" %}
{% assign appProject = "flutter_thingsboard_app" %}
{% endif %}

{{appPrefix}} 移动应用程序提供 OAuth 2.0 支持。启用 OAuth 2.0 后，移动应用程序将在登录屏幕上显示其他登录按钮，允许用户使用配置的 OAuth 2.0 提供程序进行身份验证。
系统管理员用户可以在 **OAuth2** 设置表单中对其进行配置。
请参阅 [OAuth 2.0 支持](/docs/{{docsPrefix}}user-guide/oauth-2-support/) 以了解通用 OAuth 配置。
为了在移动应用程序中启用 OAuth，您应该在 OAuth 设置表单的 **移动应用程序** 选项卡中注册它：

1. 作为系统管理员用户，转到 **系统设置** -> **OAuth2**；
2. 展开域面板；
3. 打开 **移动应用程序** 选项卡，然后单击 **添加应用程序**；
4. 指定您的应用程序包（对于 Android：您自己的唯一应用程序 ID。对于 iOS：产品包标识符）；
5. 记下自动生成的 **应用程序密钥** 或输入您自己的密钥；
6. 最后，要应用更改，请单击 OAuth 表单右下角的 **保存** 按钮；

{% include images-gallery.html imageCollection="oauth2" %}

此外，您应该修改您的移动应用程序常量。
在您的编辑器/IDE 中打开 **{{appProject}}** 项目。编辑 **lib/constants/app_constants.dart**。

将 **thingsboardOAuth2AppSecret** 常量值设置为 **应用程序密钥** 字段的值。
将 **thingsboardOAuth2CallbackUrlScheme** 常量值更改为一些唯一的 pkg 名称，例如，您可以使用带有 **auth** 后缀的应用程序包（例如 org.mycompany.myapp.auth）：

```dart
abstract class ThingsboardAppConstants {
  ...

  static final thingsboardOAuth2CallbackUrlScheme = 'Your callback url scheme here';

  static final thingsboardOAuth2AppSecret = 'Your app secret here';
}

```

{% capture oauth_2_domain %}
**注意：** **thingsBoardApiEndpoint** 常量中使用的域名应与 OAuth 设置表单中配置的某个域名匹配。
{% endcapture %}
{% include templates/info-banner.md content=oauth_2_domain %}

编辑 **android/app/src/main/AndroidManifest.xml**，找到并设置 **TbWebCallbackActivity** 的方案与 **thingsboardOAuth2CallbackUrlScheme** 常量相同：

```xml
  ...
        <activity android:name=".TbWebCallbackActivity" >
            <intent-filter android:label="tb_web_auth">
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="Your callback url scheme here" />
            </intent-filter>
        </activity>
  ...
```

要验证您的 OAuth 2.0 设置，请运行移动应用程序。
您应该在登录表单顶部看到其他 OAuth 2.0 登录按钮。
如果您的设置正确，您应该能够仅通过 OAuth 2.0 登录按钮为现有用户执行登录到应用程序。

{% include images-gallery.html imageCollection="oauth2-login-buttons" %}