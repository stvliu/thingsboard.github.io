---
layout: docwithnav
title: 在 Ubuntu 上安装 GridLinks 的 HAProxy 负载均衡器
description: 在 Ubuntu 上安装 GridLinks 的 HAProxy 负载均衡器
hidetoc: "true"
---

本指南介绍如何将 HAProxy 与 Let's Encrypt 一起安装为 ubuntu 服务。如果您将 GridLinks 托管在云中并且为您的实例分配了有效的 DNS 名称，则可以这样做。

* TOC
{:toc}

### 前提条件

Ubuntu 18.04 / Ubuntu 20.04，并为实例分配了有效的 DNS 名称。网络设置应允许在端口 80（HTTP）和 443（HTTPS）上进行连接。

### 步骤 1. 通过 SSH 连接到您的 GridLinks 实例

以下是 AWS 的示例命令供参考：

```bash
$ ssh -i <PRIVATE-KEY> ubuntu@<PUBLIC_DNS_NAME>
```

或咨询您的云供应商以获取不同的选项。

### 步骤 2. 安装 HAProxy 负载均衡器软件包

执行以下命令安装 HAProxy 软件包：

```bash
sudo apt install --no-install-recommends software-properties-common
sudo add-apt-repository ppa:vbernat/haproxy-2.4 -y
sudo apt-get update
sudo apt-get install haproxy=2.4.\* openssl
```

### 步骤 3. 安装 Certbot 软件包

执行以下命令安装 Certbot 软件包：

```bash
sudo apt-get install ca-certificates certbot
```
{: .copy-code}

### 步骤 4. 安装默认自签名证书

执行以下命令安装默认自签名证书：

（复制粘贴命令的全部文本）

```bash
cat <<EOT | sudo tee /usr/bin/haproxy-default-cert
#!/bin/sh

set -e

HA_PROXY_DIR=/usr/share/tb-haproxy
CERTS_D_DIR=\${HA_PROXY_DIR}/certs.d
TEMP_DIR=/tmp

PASSWORD=\$(openssl rand -base64 32)
SUBJ="/C=US/ST=somewhere/L=someplace/O=haproxy/OU=haproxy/CN=haproxy.selfsigned.invalid"

KEY=\${TEMP_DIR}/haproxy_key.pem
CERT=\${TEMP_DIR}/haproxy_cert.pem
CSR=\${TEMP_DIR}/haproxy.csr
DEFAULT_PEM=\${HA_PROXY_DIR}/default.pem

if [ ! -e \${HA_PROXY_DIR} ]; then
  mkdir -p \${HA_PROXY_DIR}
fi

if [ ! -e \${CERTS_D_DIR} ]; then
  mkdir -p \${CERTS_D_DIR}
fi


# 检查是否已创建 default.pem
if [ ! -e \${DEFAULT_PEM} ]; then
  openssl genrsa -des3 -passout pass:\${PASSWORD} -out \${KEY} 2048 &> /dev/null
  sleep 1
  openssl req -new -key \${KEY} -passin pass:\${PASSWORD} -out \${CSR} -subj \${SUBJ} &> /dev/null
  sleep 1
  cp \${KEY} \${KEY}.org &> /dev/null
  openssl rsa -in \${KEY}.org -passin pass:\${PASSWORD} -out \${KEY} &> /dev/null
  sleep 1
  openssl x509 -req -days 3650 -in \${CSR} -signkey \${KEY} -out \${CERT} &> /dev/null
  sleep 1
  cat \${CERT} \${KEY} > \${DEFAULT_PEM}
  echo \${PASSWORD} > \${HA_PROXY_DIR}/password.txt
fi
EOT
```
{: .copy-code}

执行以下命令：

```bash
sudo chmod +x /usr/bin/haproxy-default-cert
touch ~/.rnd
sudo haproxy-default-cert
```

### 步骤 5. 配置 HAProxy 负载均衡器

执行以下命令创建 HAProxy 负载均衡器配置文件：

（复制粘贴命令的全部文本）

```bash
cat <<EOT | sudo tee /etc/haproxy/haproxy.cfg
#HA Proxy Config
global
 ulimit-n 500000
 maxconn 99999
 maxpipes 99999
 tune.maxaccept 500

 log 127.0.0.1 local0
 log 127.0.0.1 local1 notice

 ca-base /etc/ssl/certs
 crt-base /etc/ssl/private

 ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS
 ssl-default-bind-options no-sslv3

defaults

 log global

 mode http

 timeout connect 5000ms
 timeout client 50000ms
 timeout server 50000ms
 timeout tunnel  1h    # timeout to use with WebSocket and CONNECT

 default-server init-addr none

listen stats
 bind *:9999
 stats enable
 stats hide-version
 stats uri /stats
 stats auth admin:admin@123

frontend http-in
 bind *:80 alpn h2,http/1.1

 option forwardfor

 http-request add-header "X-Forwarded-Proto" "http"

 acl letsencrypt_http_acl path_beg /.well-known/acme-challenge/

 redirect scheme https if !letsencrypt_http_acl { env(FORCE_HTTPS_REDIRECT) -m str true }

 use_backend letsencrypt_http if letsencrypt_http_acl

 default_backend tb-backend

frontend https_in
  bind *:443 ssl crt /usr/share/tb-haproxy/default.pem crt /usr/share/tb-haproxy/certs.d/ ciphers ECDHE-RSA-AES256-SHA:RC4-SHA:RC4:HIGH:!MD5:!aNULL:!EDH:!AESGCM alpn h2,http/1.1

  option forwardfor

  http-request add-header "X-Forwarded-Proto" "https"

  default_backend tb-backend

backend letsencrypt_http
  server letsencrypt_http_srv 127.0.0.1:8090

backend tb-backend
  balance leastconn
  option tcp-check
  option log-health-checks
  server tb1 127.0.0.1:8080 check inter 5s
  http-request set-header X-Forwarded-Port %[dst_port]
EOT
```
{: .copy-code}

### 步骤 6. 使用 Let's Encrypt 配置 Certbot

执行以下命令创建 Certbot 与 Let's Encrypt 配置和帮助程序文件：

（复制粘贴命令的全部文本）

```bash
sudo mkdir -p /usr/local/etc/letsencrypt \
&& sudo mkdir -p /usr/share/tb-haproxy/letsencrypt \
&& sudo rm -rf /etc/letsencrypt \
&& sudo ln -s /usr/share/tb-haproxy/letsencrypt /etc/letsencrypt
```
{: .copy-code}

```bash
cat <<EOT | sudo tee /usr/local/etc/letsencrypt/cli.ini
authenticator = standalone
agree-tos = True
http-01-port = 8090
non-interactive = True
preferred-challenges = http-01
EOT
```
{: .copy-code}

```bash
cat <<EOT | sudo tee /usr/bin/haproxy-refresh
#!/bin/sh

HA_PROXY_DIR=/usr/share/tb-haproxy
LE_DIR=/usr/share/tb-haproxy/letsencrypt/live
DOMAINS=\$(ls -I README \${LE_DIR})

# 更新 HA Proxy 的证书
for DOMAIN in \${DOMAINS}
do
 cat \${LE_DIR}/\${DOMAIN}/fullchain.pem \${LE_DIR}/\${DOMAIN}/privkey.pem > \${HA_PROXY_DIR}/certs.d/\${DOMAIN}.pem
done

# 重启 haproxy
exec service haproxy restart
EOT
```
{: .copy-code}

```bash
cat <<EOT | sudo tee /usr/bin/certbot-certonly
#!/bin/sh

/usr/bin/certbot certonly -c /usr/local/etc/letsencrypt/cli.ini "\$@"
EOT
```
{: .copy-code}

```bash
cat <<EOT | sudo tee /usr/bin/certbot-renew
#!/bin/sh

/usr/bin/certbot -c /usr/local/etc/letsencrypt/cli.ini renew "\$@"
EOT
```
{: .copy-code}

```bash
sudo chmod +x /usr/bin/haproxy-refresh /usr/bin/certbot-certonly /usr/bin/certbot-renew
```
{: .copy-code}

### 步骤 7. 安装证书自动续订 cron 作业

执行以下命令创建证书自动续订 cron 作业：

（复制粘贴命令的全部文本）

```bash
cat <<EOT | sudo tee /etc/cron.d/certbot
# /etc/cron.d/certbot: crontab entries for the certbot package
#
# Upstream recommends attempting renewal twice a day
#
# Eventually, this will be an opportunity to validate certificates
# haven't been revoked, etc.  Renewal will only occur if expiration
# is within 30 days.
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

0 */12 * * * root test -x /usr/bin/certbot && perl -e 'sleep int(rand(3600))' && certbot -c /usr/local/etc/letsencrypt/cli.ini -q renew && haproxy-refresh
EOT
```
{: .copy-code}

### 步骤 8. 重启 HAProxy 负载均衡器

最后，重启 HAProxy 负载均衡器服务，以便更改生效：

```bash
sudo service haproxy restart
```
{: .copy-code}

### 步骤 9. 执行命令使用 Let's Encrypt 生成证书

不要忘记在执行以下命令之前替换 **your_domain** 和 **your_email**：

```bash
sudo certbot-certonly --domain your_domain --email your_email
```

### 步骤 10. 刷新 HAProxy 配置

最后，重启 HAProxy：

```bash
sudo haproxy-refresh
```
{: .copy-code}