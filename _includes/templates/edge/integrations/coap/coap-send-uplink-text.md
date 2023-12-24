```shell
echo -e 'SN-001,default,温度,25.7,湿度,69' | coap-client -m post $YOUR_COAP_ENDPOINT_URL -t text/plain -f-
```
{: .copy-code}