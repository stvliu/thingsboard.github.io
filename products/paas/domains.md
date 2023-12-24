---
layout: docwithnav-paas
assignees:
- ashvayka
title: 域管理
description: 通过 ThingsBoard Cloud 管理域
registerDomain:
    0:
        image: /images/user-guide/domain/domain-register-step-1.png
        title: '转到“设置”页面，然后导航到“域”选项卡。在“域”选项卡上，单击“注册域”按钮；'
    1:
        image: /images/user-guide/domain/domain-register-step-2.png
        title: '在输入字段中输入有效的域名，然后单击“注册”按钮；'
    2:
        image: /images/user-guide/domain/domain-register-step-3.png
        title: '系统将提示您有关 CNAME 的提醒；'
    3:
        image: /images/user-guide/domain/domain-register-step-4.png
        title: '单击“我已添加 CNAME 记录”按钮。确认规范名称已到位后，域验证和证书配置将开始。请耐心等待，此过程可能需要一段时间；'
    4:
        image: /images/user-guide/domain/domain-register-step-5.png
        title: '如果成功，您将在“域”选项卡上看到您的域名。'

white-labeling:
    0:
        image: /images/user-guide/domain/domain-white-labeling-1.png
        title: '转到“白标”页面，然后导航到“登录”选项卡。在相应字段中输入域名和基本 URL。不要忘记选中“禁止使用客户端请求标头中的主机名”复选框。然后保存所有更改；'
    1:
        image: /images/user-guide/domain/domain-login-1.png
        title: '现在，您可以使用您的域名访问 ThingsBoard Cloud Web UI 和服务。尝试通过在浏览器地址栏中输入所选域名来登录。'

domainDetails:
    0:
        image: /images/user-guide/domain/domain-details-step-1.png
        title: '要查看已注册域名的详细信息，请单击“域”选项卡上的“域名详细信息”按钮；'
    1:
        image: /images/user-guide/domain/domain-details-step-2.png
        title: 'ThingsBoard Cloud 会在证书到期前 30 天自动续订证书，除非您更改或删除域 CNAME 记录，否则无需您采取任何操作。'

deleteDomain:
    0:
        image: /images/user-guide/domain/domain-delete-step-1.png
        title: '要删除已注册的域，请单击“域”选项卡上的“删除”按钮；'
    1:
        image: /images/user-guide/domain/domain-delete-step-2.png
        title: '在确认对话框中，如果您确定要删除域，请单击“是”。'

---
* TOC
{:toc}

[ThingsBoard Cloud](https://thingsboard.cloud/signup) 允许您注册自定义域，以便为用户访问、链接等提供所需的主机名。
当您注册有效的域时，ThingsBoard Cloud 会自动向 [Let's Encrypt](https://letsencrypt.org/) 申请后者的 SSL 证书，并管理进一步的证书续订。
域注册后，您的租户和应用程序可以通过您的域名使用安全 (HTTPS) 连接访问。
与 Web UI 一样，所有其他 ThingsBoard Cloud 服务（例如 MQTT/HTTP/CoAP 传输或 HTTP 集成）都可以通过您的自定义域名访问。

### 域注册

{% capture domain_owner_note %}
**注意**
<br>
您必须是您正在注册的域的所有者。
{% endcapture %}
{% include templates/info-banner.md content=domain_owner_note %}

为了使用您自己的主机名而不是 **thingsboard.cloud**，您必须先注册它。按照以下步骤操作：

* 在您的 DNS 提供商网站上，您必须为您的域添加一个规范记录，以将其与 **thingsboard.cloud** 映射。有关详细信息，请参阅 [如何为您的域创建 CNAME 记录](#如何为您的域创建-cname-记录)。完成后，您可以开始注册过程；
* 转到“设置”页面，然后导航到“域”选项卡。在“域”选项卡上，单击“注册域”按钮；
* 在输入字段中输入有效的域名，然后单击“注册”按钮。
* 系统将提示您有关 CNAME 的提醒；
* 单击“我已添加 CNAME 记录”按钮。确认规范名称已到位后，域验证和证书配置将开始。请耐心等待，此过程可能需要一段时间；
* 如果成功，您将在“域”选项卡上看到您的域名。

{% include images-gallery.html imageCollection="registerDomain" %}

### 自定义登录页面 URL

要自定义 Web UI 访问，请转到白标部分。您需要登录选项卡。输入最近注册的域名。建议填写基本 URL 字段并防止使用请求标头中的主机名。

{% include images-gallery.html imageCollection="white-labeling" %}

现在，您可以使用您的域名访问 ThingsBoard Cloud Web UI 和服务。尝试通过在浏览器地址栏中输入所选域名来登录。

继续进一步自定义登录页面以完成平台重新品牌化。

### 域详细信息

要查看已注册域名的详细信息，请单击“域”选项卡上的“域名详细信息”按钮。
域名详细信息对话框显示有关已注册域 CNAME 记录和已颁发“SSL 证书”详细信息的信息，包括当前有效期（*之前* 和 *之后*）。
证书有效期为 90 天。请注意，ThingsBoard Cloud 会在证书到期前 30 天自动续订证书，除非您更改或删除域 CNAME 记录，否则无需您采取任何操作。

{% include images-gallery.html imageCollection="domainDetails" %}

### 删除域

要删除已注册的域，请单击“域”选项卡上的“删除”按钮。在确认对话框中，如果您确定要删除域，请单击“是”。
确认后，域信息和关联的 SSL 证书将被删除，您将无法使用该域访问 ThingsBoard Cloud Web 界面和服务。请注意，您始终可以使用 [域注册](#域注册) 程序重新注册相同或不同的域。

{% include images-gallery.html imageCollection="deleteDomain" %}

### 如何为您的域创建 CNAME 记录 {#如何为您的域创建-cname-记录}

将 CNAME 记录添加到 DNS 数据库的过程取决于您的 DNS 服务提供商。以下是针对一些流行 DNS 提供商的说明列表：

* [Amazon Route 53](https://aws.amazon.com/premiumsupport/knowledge-center/route-53-create-alias-records/){:target="_blank"}
* [GoDaddy](https://www.godaddy.com/help/add-a-cname-record-19236){:target="_blank"}
* [Cloudflare](https://community.cloudflare.com/t/how-do-i-add-a-cname-record/59){:target="_blank"}
* [ClouDNS](https://www.cloudns.net/wiki/article/13/){:target="_blank"}
* [Google Cloud DNS](https://cloud.google.com/dns/docs/records){:target="_blank"}
* [Name.com](https://www.name.com/support/articles/115004895548-adding-a-cname-record-for-your-domain){:target="_blank"}
* [easyDNS](https://kb.easydns.com/knowledge/how-to-make-a-dns-entry/){:target="_blank"}
* [DNSimple](https://support.dnsimple.com/articles/manage-cname-record/#adding-a-cname-record){:target="_blank"}  
* [DNSMadeEasy](https://support.dnsmadeeasy.com/support/solutions/articles/47001001393-cname-record){:target="_blank"}
* [No-IP.com](https://www.noip.com/support/knowledgebase/how-to-configure-your-no-ip-hostname/){:target="_blank"}
* [Infoblox NIOS](https://docs.infoblox.com/display/BloxOneDDI/Creating+a+CNAME+Record){:target="_blank"}
* [Namecheap](https://www.namecheap.com/support/knowledgebase/article.aspx/9646/2237/how-to-create-a-cname-record-for-your-domain){:target="_blank"}

如果您订购服务的 DNS 提供商不在上述列表中，请尝试在提供商网站上获取此信息或联系其支持部门。

### 故障排除

首先，您需要检查是否已将 CNAME 正确添加到您的域：

如果您的操作系统是 Linux，请使用 [Google Admin Toolbox](https://toolbox.googleapps.com/apps/dig/){:target="_blank"} 或“dig”命令：
```bash
dig $YOUR_DOMAIN_NAME any
```
{: .copy-code}

将 $YOUR_DOMAIN_NAME 替换为您的域值。

例如，$YOUR_DOMAIN_NAME 是 `mydomain.thingsboard.online`：
```bash
dig mydomain.thingsboard.online any
```

Linux 中的“dig”命令用于收集 DNS 信息。它代表域名信息探测器，它收集有关域名服务器的数据。“dig”命令有助于诊断 DNS 问题，但也用于显示 DNS 信息。

“dig”命令的输出可能因您的域设置而异。
例如：
```bash
$ dig mydomain.thingsboard.online any

; <<>> DiG 9.16.1-Ubuntu <<>> mydomain.thingsboard.online any
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 27275
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;mydomain.thingsboard.online.	IN	ANY

;; ANSWER SECTION:
mydomain.thingsboard.online. 3600 IN	HINFO	"RFC8482" ""

;; Query time: 36 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: чт чер 29 15:36:44 EEST 2023
;; MSG SIZE  rcvd: 77
```

此输出显示没有 CNAME 添加到 mydomain.thingsboard.online 域（“ANSWER SECTION”块）。

正确的输出应如下所示：
```bash
...
;; ANSWER SECTION:
mydomain.thingsboard.online. 3600 IN	CNAME	thingsboard.cloud
...
```

如果所有事情都正确，但仍然存在一些问题 - 请 [联系我们](https://thingsboard.io/docs/contact-us/) 以获得进一步的支持。