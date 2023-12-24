我们将使用此脚本进行数据验证：

```bash
return typeof msg.temperature === 'undefined'
|| (msg.temperature >= -40 && msg.temperature <= 80);
```
{: .copy-code}

{% if docsPrefix == null %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/script-config-java-ce.png)
{% endif %}
{% if (docsPrefix == "pe/") or (docsPrefix == "paas/") %}
![image](/images/user-guide/rule-engine-2-0/tutorials/getting-started/script-config-java-pe.png)
{% endif %}