<table>
    <thead>
      <tr>
          <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
      </tr>
    </thead>
    <tbody>
    <tr>
        <td>transport.coap.bind_address</td>
        <td>COAP_BIND_ADDRESS</td>
        <td>0.0.0.0</td>
        <td>CoAP 绑定地址</td>
    </tr>
    <tr>
        <td>transport.coap.bind_port</td>
        <td>COAP_BIND_PORT</td>
        <td>5683</td>
        <td>CoAP 绑定端口</td>
    </tr>
    <tr>
        <td>transport.coap.timeout</td>
        <td>COAP_TIMEOUT</td>
        <td>10000</td>
        <td>CoaP 处理超时（以毫秒为单位）</td>
    </tr>
    <tr>
        <td>transport.coap.psm_activity_timer</td>
        <td>COAP_PSM_ACTIVITY_TIMER</td>
        <td>10000</td>
        <td>如果设备配置文件中未指定，则为默认 PSM 活动计时器。</td>
    </tr>
    <tr>
        <td>transport.coap.paging_transmission_window</td>
        <td>COAP_PAGING_TRANSMISSION_WINDOW</td>
        <td>10000</td>
        <td>如果设备配置文件中未指定，则为 eDRX 支持的默认寻呼传输窗口。</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.enabled</td>
        <td>COAP_DTLS_ENABLED</td>
        <td>false</td>
        <td>启用/禁用 DTLS 1.2 支持</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.bind_address</td>
        <td>COAP_DTLS_BIND_ADDRESS</td>
        <td>0.0.0.0</td>
        <td>CoAP DTLS 绑定地址</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.bind_port</td>
        <td>COAP_DTLS_BIND_PORT</td>
        <td>5684</td>
        <td>CoAP DTLS 绑定端口</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.credentials.type</td>
        <td>COAP_DTLS_CREDENTIALS_TYPE</td>
        <td>PEM</td>
        <td>服务器凭据类型（PEM - pem 证书文件；KEYSTORE - java 密钥库）</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.credentials.pem.cert_file</td>
        <td>COAP_DTLS_PEM_CERT</td>
        <td>coapserver.pem</td>
        <td>服务器证书文件的路径（保存服务器证书或证书链，可能包括服务器私钥）</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.credentials.pem.key_file</td>
        <td>COAP_DTLS_PEM_KEY</td>
        <td>coapserver_key.pem</td>
        <td>服务器证书私钥文件的路径（可选）</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.credentials.pem.key_password</td>
        <td>COAP_DTLS_PEM_KEY_PASSWORD</td>
        <td>server_key_password</td>
        <td>服务器证书私钥密码（可选）</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.credentials.keystore.type</td>
        <td>COAP_DTLS_KEY_STORE_TYPE</td>
        <td>JKS</td>
        <td>密钥库的类型</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.credentials.keystore.store_file</td>
        <td>COAP_DTLS_KEY_STORE</td>
        <td>coapserver.jks</td>
        <td>保存 SSL 证书的密钥库的路径</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.credentials.keystore.store_password</td>
        <td>COAP_DTLS_KEY_STORE_PASSWORD</td>
        <td>server_ks_password</td>
        <td>用于访问密钥库的密码</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.credentials.keystore.key_alias</td>
        <td>COAP_DTLS_KEY_ALIAS</td>
        <td>serveralias</td>
        <td>密钥别名</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.credentials.keystore.key_password</td>
        <td>COAP_DTLS_KEY_PASSWORD</td>
        <td>server_key_password</td>
        <td>用于访问密钥的密码</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.x509.skip_validity_check_for_client_cert</td>
        <td>TB_COAP_X509_DTLS_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT</td>
        <td>false</td>
        <td>跳过客户端证书有效性检查。</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.x509.dtls_session_inactivity_timeout</td>
        <td>TB_COAP_X509_DTLS_SESSION_INACTIVITY_TIMEOUT</td>
        <td>86400000</td>
        <td>DTLS 会话的不活动超时。用于清理缓存。</td>
    </tr>
    <tr>
        <td>transport.coap.dtls.x509.dtls_session_report_timeout</td>
        <td>TB_COAP_X509_DTLS_SESSION_REPORT_TIMEOUT</td>
        <td>1800000</td>
        <td>定期驱逐超时 DTLS 会话的时间间隔。</td>
    </tr>
    </tbody>
</table>