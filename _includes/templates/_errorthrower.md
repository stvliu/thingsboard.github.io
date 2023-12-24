### 错误：您必须定义一个 <span style="font-family: monospace">`{{ include.missing_block }}`</span> 块
{: style="color:red" }

此模板要求您提供 {{ include.purpose }} 的文本。此块中的文本将显示在标题 **{{ include.heading }}** 下。

要消除此消息并利用此模板，请定义 `{{ include.missing_block }}` 变量并用内容填充它。

```liquid
{% raw %}{%{% endraw %} capture {{ include.missing_block }} {% raw %}%}{% endraw %}
{{ include.purpose }} 的文本。
{% raw %}{%{% endraw %} endcapture {% raw %}%}{% endraw %}
```

<!-- TEMPLATE_ERROR -->