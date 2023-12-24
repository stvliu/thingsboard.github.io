一种安全配置类型是 accessToken，
要获取它，您应该登录到您的 GridLinks 平台实例，
转到设备选项卡，按加号图标，
填写值并选中“是网关”选项，
打开此设备并按“复制访问令牌”按钮，用您的值替换默认值


|**参数**|**默认值**|**说明**|
|:-|:-|-
| accessToken              | **PUT_YOUR_GW_ACCESS_TOKEN_HERE**                     | 来自 GridLinks 服务器的网关访问令牌。|
|---

配置文件中的安全子部分将如下所示：

```json
...
"security": {
  "accessToken": "YOUR_ACCESS_TOKEN"
},
...
```