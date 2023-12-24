我们假设您已经选择了订阅计划或决定购买永久许可证。
如果没有，请导航到 [定价](/pricing/) 页面，为您的案例选择最佳许可证选项并获取您的许可证。
有关更多详细信息，请参阅 [如何获取按需订阅](https://www.youtube.com/watch?v=dK-QDFGxWek){:target="_blank"} 或 [如何获取永久许可证](https://www.youtube.com/watch?v=GPe0lHolWek){:target="_blank"}。

使用您的许可证密钥创建 docker 密钥：

```text
export TB_LICENSE_KEY=PUT_YOUR_LICENSE_KEY_HERE 
kubectl create -n thingsboard secret generic tb-license --from-literal=license-key=$TB_LICENSE_KEY
```
{: .copy-code}

{% capture tb_license_key_warn %}
别忘了用您的许可证密钥的值替换 *PUT_YOUR_LICENSE_KEY_HERE*。
{% endcapture %}
{% include templates/info-banner.md content=tb_license_key_warn %}