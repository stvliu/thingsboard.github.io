## 生成 HTTPS 证书
我们使用 HAproxy 将流量代理到容器，默认情况下，我们使用 80 和 443 端口进行 Web UI。要使用具有有效证书的 HTTPS，请执行以下命令：
```
docker exec haproxy-certbot certbot-certonly --domain your_domain --email your_email
docker exec haproxy-certbot haproxy-refresh
```

**注意**：仅在您通过 URL 中的域访问 Web UI 时才使用有效证书。如果您使用 IP 地址访问 UI，则将使用自签名证书。