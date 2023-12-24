一种安全配置类型是令牌。
授权将使用令牌，，在此部分的 config 中提供。


|**参数**|**默认值**|**说明**|
|:-|:-|-
| 类型               | **令牌**                      | 授权类型。      |
| 令牌             | **["Bearer ACCESS_TOKEN"]**    | 允许的令牌列表。     |
|---

配置文件中的安全子部分将如下所示：

```yaml
    "security": [
      "type": "token",
      "tokens": [
        "Bearer ACCESS_TOKEN"
      ]
    ]
```