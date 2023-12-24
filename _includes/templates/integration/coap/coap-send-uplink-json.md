{% if docsPrefix == "pe/" %}
使用此命令将消息发送到托管在 **localhost** 上的 CoAP 服务器。将 **$YOUR_COAP_ENDPOINT_URL** 替换为相应的值。
{% endif %}
{% if docsPrefix == "paas/" %}
使用此命令将消息发送到托管在 **int.thingsboard.cloud** 上的 CoAP 服务器。将 **$YOUR_COAP_ENDPOINT_URL** 替换为相应的值。
{% endif %}

```shell
echo -e -n '{"deviceName": "SN-001", "deviceType": "default", "temperature": 25.7, "humidity": 69}' | coap-client -m post $YOUR_COAP_ENDPOINT_URL -t application/json -f-
```
{: .copy-code}

{% if docsPrefix == "pe/" %}
![image](/images/user-guide/integrations/coap/terminal-json-pe.png)
{% endif %}
{% if docsPrefix == "paas/" %}
![image](/images/user-guide/integrations/coap/terminal-json-paas.png)
{% endif %}