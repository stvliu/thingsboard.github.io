---
layout: docwithnav
title: 在 CentOS/RHEL 上安装 GridLinks 的 HAProxy 负载均衡器
description: 在 CentOS/RHEL 上安装 GridLinks 的 HAProxy 负载均衡器
hidetoc: "true"
---

本指南介绍如何将 HAProxy 与 Let's Encrypt 一起安装为一项服务。如果您将 GridLinks 托管在云中并且为您的实例分配了有效的 DNS 名称，则可以这样做。

* TOC
{:toc}

### 先决条件

RHEL/CentOS 7/8，并为实例分配了有效的 DNS 名称。网络设置应允许在端口 80（HTTP）和 443（HTTPS）上进行连接。

要打开 80 和 443 端口，请执行以下命令：

```bash
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --zone=public --add-port=443/tcp --permanent
sudo firewall-cmd --reload

``` 

### 步骤 1. 通过 SSH 连接到您的 ThingsBoard 实例

以下是 AWS 的示例命令，仅供参考：

```bash
$ ssh -i <PRIVATE-KEY> ubuntu@<PUBLIC_DNS_NAME>
```

或咨询您的云供应商以获取不同的选项。

### 步骤 2. 安装 HAProxy 负载均衡器软件包

- 对于 **RHEL/CentOS 7**，以下命令将确保启用 Cheese 存储库：

```bash
sudo yum -y install http://www.nosuchhost.net/~cheese/fedora/packages/epel-7/x86_64/cheese-release-7-1.noarch.rpm
sudo yum-config-manager --enable cheese

```
{: .copy-code}

- 对于 **RHEL/CentOS 8**，以下命令将确保启用 PowerTools 存储库：

```bash
sudo dnf config-manager --enable powertools

```
{: .copy-code}

执行以下命令以安装 HAProxy 软件包：

```bash
sudo yum install gcc pcre-devel openssl-devel readline-devel systemd-devel tar lua lua-devel make -y
wget http://www.haproxy.org/download/2.4/src/haproxy-2.4.3.tar.gz -O ~/haproxy.tar.gz
mkdir -p ~/haproxy-src
tar xzvf ~/haproxy.tar.gz -C ~/haproxy-src --strip-components=1
rm haproxy.tar.gz
make -C ~/haproxy-src USE_NS=1 USE_TFO=1 USE_OPENSSL=1 USE_ZLIB=1 USE_LUA=1 USE_PCRE=1 USE_SYSTEMD=1 USE_LIBCRYPT=1 USE_THREAD=1 TARGET=linux-glibc
sudo make -C ~/haproxy-src TARGET=linux-glibc install-bin install-man
sudo ln -sf /usr/local/sbin/haproxy /usr/sbin/haproxy
sudo groupadd -g 992 haproxy
sudo useradd -g 992 -u 995 -m -d /var/lib/haproxy -s /sbin/nologin -c haproxy haproxy
sudo mkdir -p /etc/haproxy
rm -rf ~/haproxy-src

```
{: .copy-code}

执行以下命令以创建 haproxy SystemD 单元文件：

（复制粘贴命令的全文，保持原样）

```bash
cat <<'EOT' | sudo tee /etc/systemd/system/haproxy.service
[Unit]
Description=HAProxy 2.4.3
After=syslog.target network.target

[Service]
Type=notify
EnvironmentFile=/etc/sysconfig/haproxy
ExecStart=/usr/local/sbin/haproxy -f $CONFIG_FILE -p $PID_FILE $CLI_OPTIONS
ExecReload=/bin/kill -USR2 $MAINPID
ExecStop=/bin/kill -USR1 $MAINPID

[Install]
WantedBy=multi-user.target
EOT
```
{: .copy-code}

执行以下命令以创建 haproxy SystemD 环境文件：

（复制粘贴命令的全文，保持原样）

```bash
cat <<EOT | sudo tee /etc/sysconfig/haproxy
# 在启动时传递给 HAProxy 的命令行选项
# 默认值为：
CLI_OPTIONS="-Ws"

# 指定备用配置文件。默认值为：
CONFIG_FILE=/etc/haproxy/haproxy.cfg

# 用于跟踪进程 ID 的文件。默认值为：
PID_FILE=/var/run/haproxy.pid
EOT
```
{: .copy-code}

执行以下命令以配置 haproxy 服务：

```bash
sudo systemctl daemon-reload
sudo systemctl enable haproxy

```
{: .copy-code}

### 步骤 3. 安装 Certbot 软件包

**仅限 RHEL 7** - 启用可选频道：

```bash
sudo yum -y install yum-utils
sudo yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
```
{: .copy-code}

执行以下命令以安装 Certbot 软件包：

```bash
sudo yum -y install ca-certificates certbot
```
{: .copy-code}

### 步骤 4. 安装默认自签名证书

执行以下命令以安装默认自签名证书：

（复制粘贴命令的全文，保持原样）

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

执行以下命令以创建 HAProxy 负载均衡器配置文件：

（复制粘贴命令的全文，保持原样）

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

执行以下命令以创建 Certbot 与 Let's Encrypt 配置和帮助程序文件：

（复制粘贴命令的全文，保持原样）

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
tls-sni-01-port = 8443
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

# update certs for HA Proxy
for DOMAIN in \${DOMAINS}
do
 cat \${LE_DIR}/\${DOMAIN}/fullchain.pem \${LE_DIR}/\${DOMAIN}/privkey.pem > \${HA_PROXY_DIR}/certs.d/\${DOMAIN}.pem
done

# restart haproxy
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

执行以下命令以创建证书自动续订 cron 作业：

（复制粘贴命令的全文，保持原样）

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

最后，重新启动 HAProxy 负载均衡器服务，以便更改生效：

```bash
sudo service haproxy restart
```
{: .copy-code}

### 步骤 9. 执行命令以使用 Let's Encrypt 生成证书

别忘了在执行以下命令之前替换 **your_domain** 和 **your_email**：

```bash
sudo certbot-certonly --domain your_domain --email your_email
```

### 步骤 10. 刷新 HAProxy 配置

最后，重新启动 HAProxy：

```bash
sudo haproxy-refresh
```
{: .copy-code}