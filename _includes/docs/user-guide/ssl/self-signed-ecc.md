### 自签名证书生成

使用以下说明生成您自己的证书文件。对于测试很有用，但很耗时，不建议用于生产。

#### PEM 证书文件

**注意** 此步骤需要安装了 openssl 的基于 Linux 的操作系统。

要生成服务器自签名 PEM 证书和私钥，请使用以下命令：

```bash
openssl ecparam -out server_key.pem -name secp256r1 -genkey
openssl req -new -key server_key.pem -x509 -nodes -days 365 -out server.pem 
```
{: .copy-code}

如果您不想使用密码短语保护您的私钥，您还可以添加 -nodes（DES 的简称）。否则，它会提示您输入“至少 4 个字符”的密码。

您可以用任何数字替换 **days** 参数（365）以影响到期日期。然后它会提示您输入“国家名称”等信息，但您只需按 Enter 并接受默认值即可。

添加 -subj '/CN=localhost' 以禁止有关证书内容的问题（将 localhost 替换为您所需的域）。

自签名证书不会通过任何第三方进行验证，除非您之前已将它们导入浏览器。如果您需要更高的安全性，您应该使用由证书颁发机构 (CA) 签名的证书。