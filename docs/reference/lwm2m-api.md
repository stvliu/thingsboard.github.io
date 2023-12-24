---
layout: docwithnav
assignees:
- nick
title: LWM2M 设备 API 参考
description: 物联网设备支持的 LWM2M API 参考

upload-models:
    0:
        image: /images/lwm2m/upload-ce.png
        title: '登录到 GridLinks 实例并转到系统设置 -> 资源库，然后单击“+”按钮'
    1:
        image: /images/lwm2m/upload-1-ce.png
        title: '上传资源模型文件'
    2:
        image: /images/lwm2m/upload-2-ce.png
        title: '确保您可以在列表中看到新文件'


upload-tenant:
    0:
        image: /images/lwm2m/upload-tenant-0-ce.png
        title: '租户无法删除由系统管理员上传的文件'
    1:
        image: /images/lwm2m/upload-tenant-1-ce.png
        title: '租户可以上传并覆盖由系统管理员为同一资源上传的资源模型文件'
    2:
        image: /images/lwm2m/upload-tenant-2-ce.png
        title: '租户可以删除自己上传的文件'
    3:
        image: /images/lwm2m/upload-tenant-4-ce.png
        title: '当租户删除其文件时，由系统管理员上传的文件仍然存在'

device-profile:
    0:
        image: /images/lwm2m/deviceprofile-ce.png
        title: '转到设备配置文件，单击“+”，输入配置文件名称并选择或创建将处理消息的规则链'
    1:
        image: /images/lwm2m/deviceprofile-1-ce.png
        title: '从下拉菜单中选择“LwM2M”传输类型'
    2:
        image: /images/lwm2m/deviceprofile-2-ce.png
        title: '新配置文件已成功创建'

device-objects:
    0:
        image: /images/lwm2m/device-objects-ce.png
        title: '转到设备配置文件，选择“LWM2M”，转到“传输配置”选项卡，单击“编辑”按钮'
    1:
        image: /images/lwm2m/device-objects-1-ce.png
        title: '从下拉菜单中添加对象。对象应上传到资源库'

data-fetch:
    0:
        image: /images/lwm2m/data-fetch-ce.png
        title: '勾选“属性”以获取设备连接时想要获取的数据，并将其存储为 GridLinks 属性'
    1:
        image: /images/lwm2m/data-fetch-1-ce.png
        title: '如果您希望服务器观察它们并获取更新的值，请勾选遥测和/或观察框'
    2:
        image: /images/lwm2m/data-fetch-3-ce.png
        title: '保存更改'

device-credentials:
    0:
        image: /images/lwm2m/device-credentials-ce.png
        title: '默认是无安全模式'
    1:
        image: /images/lwm2m/device-credentials-1-ce.png
        title: '添加设备凭据：预共享密钥'
    2:
        image: /images/lwm2m/device-credentials-2-ce.png
        title: '添加设备凭据：原始公钥'
    3:
        image: /images/lwm2m/device-credentials-3-ce.png
        title: '添加设备凭据：X.509 证书'

nosecurity-credentials:
    0:
        image: /images/lwm2m/device-credentials-ce.png
        title: '在无安全模式下，端点客户端名称用于识别设备'

wakaama-terminal:
    0:
        image: /images/lwm2m/wakaama-terminal.png
        title: '带有 Wakaama 客户端的终端窗口'
    1:
        image: /images/lwm2m/wakaama-terminal-1-ce.png
        title: '您可以在传输日志部分看到最后一条消息'

device-objects-ce:
    0:
        image: /images/lwm2m/key-name-ce.png
        title: '打开传输配置设置'
    1:
        image: /images/lwm2m/key-name-1-ce.png
        title: '打开 LwM2M 模型设置'

otafirmware-transport:
    0:
        image: /images/lwm2m/otafirmware-transport-ce.png
        title: '打开设备传输配置设置'
    1:
        image: /images/lwm2m/otafirmware-transport-1-ce.png
        title: '选择固件更新策略'

sota:
    0:
        image: /images/lwm2m/sota-ce.png
        title: '从下拉菜单中选择软件更新策略'

object-attributes:
    0:
        image: /images/lwm2m/object-attrib-1-ce.png
        title: '打开设备配置文件配置页面，LwM2M 模型部分'
    1:
        image: /images/lwm2m/object-attrib-2-ce.png
        title: '添加新属性'
    2:
        image: /images/lwm2m/object-attrib-3-ce.png
        title: '单击以打开下拉列表'
    3:
        image: /images/lwm2m/object-attrib-4-ce.png
        title: '从列表中选择属性'
    4:
        image: /images/lwm2m/object-attrib-5-ce.png
        title: '输入值并保存'
    5:
        image: /images/lwm2m/object-attrib-6-ce.png
        title: '保存设备配置文件配置'

---

{% include docs/reference/lwm2m-api.md %}