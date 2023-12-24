<table>
    <thead>
      <tr>
          <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>描述</b></td>
      </tr>
    </thead>
    <tbody>
    <tr>
        <td>transport.lwm2m.server.id</td>
        <td>LWM2M_SERVER_ID</td>
        <td>123</td>
        <td>LwM2M 服务器 ID</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.bind_address</td>
        <td>LWM2M_BIND_ADDRESS</td>
        <td>0.0.0.0</td>
        <td>LwM2M 服务器绑定地址。默认绑定到所有接口。</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.bind_port</td>
        <td>LWM2M_BIND_PORT</td>
        <td>5685</td>
        <td>LwM2M 服务器绑定端口。</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.bind_address</td>
        <td>LWM2M_SECURITY_BIND_ADDRESS</td>
        <td>0.0.0.0</td>
        <td>LwM2M 服务器绑定地址，用于 DTLS。默认绑定到所有接口。</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.bind_port</td>
        <td>LWM2M_SECURITY_BIND_PORT</td>
        <td>5686</td>
        <td>LwM2M 服务器绑定端口，用于 DTLS。</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.credentials.enabled</td>
        <td>LWM2M_SERVER_CREDENTIALS_ENABLED</td>
        <td>true</td>
        <td>是否启用 LWM2M 服务器 X509 证书/RPK 支持</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.credentials.type</td>
        <td>LWM2M_SERVER_CREDENTIALS_TYPE</td>
        <td>PEM</td>
        <td>服务器凭据类型（PEM - pem 证书文件；KEYSTORE - java 密钥库）</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.credentials.pem.cert_file</td>
        <td>LWM2M_SERVER_PEM_CERT</td>
        <td>lwm2mserver.pem</td>
        <td>服务器证书文件的路径（保存服务器证书或证书链，可能包括服务器私钥）</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.credentials.pem.key_file</td>
        <td>LWM2M_SERVER_PEM_KEY</td>
        <td>lwm2mserver_key.pem</td>
        <td>服务器证书私钥文件的路径（可选）</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.credentials.pem.key_password</td>
        <td>LWM2M_SERVER_PEM_KEY_PASSWORD</td>
        <td>server_key_password</td>
        <td>服务器证书私钥密码（可选）</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.credentials.keystore.type</td>
        <td>LWM2M_SERVER_KEY_STORE_TYPE</td>
        <td>JKS</td>
        <td>密钥库类型</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.credentials.keystore.store_file</td>
        <td>LWM2M_SERVER_KEY_STORE</td>
        <td>lwm2mserver.jks</td>
        <td>保存 SSL 证书的密钥库的路径</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.credentials.keystore.store_password</td>
        <td>LWM2M_SERVER_KEY_STORE_PASSWORD</td>
        <td>server_ks_password</td>
        <td>用于访问密钥库的密码</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.credentials.keystore.key_alias</td>
        <td>LWM2M_SERVER_KEY_ALIAS</td>
        <td>server</td>
        <td>密钥别名</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.credentials.keystore.key_password</td>
        <td>LWM2M_SERVER_KEY_PASSWORD</td>
        <td>server_ks_password</td>
        <td>用于访问密钥的密码</td>
    </tr>
    <tr>
        <td>transport.lwm2m.server.security.skip_validity_check_for_client_cert</td>
        <td>TB_LWM2M_SERVER_SECURITY_SKIP_VALIDITY_CHECK_FOR_CLIENT_CERT</td>
        <td>false</td>
        <td>仅 Certificate_x509</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.enable</td>
        <td>LWM2M_ENABLED_BS</td>
        <td>true</td>
        <td>启用/禁用引导服务器</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.id</td>
        <td>LWM2M_SERVER_ID_BS</td>
        <td>111</td>
        <td>这是：<br>
            * 在引导模式下启动 Lwm2mClient 后，对象“LWM2M 安全”字段的默认值：
            “短服务器 ID”（deviceProfile: Bootstrap.BOOTSTRAP SERVER.Short ID）
        </td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.bind_address</td>
        <td>LWM2M_BS_BIND_ADDRESS</td>
        <td>0.0.0.0</td>
        <td>LwM2M 引导服务器绑定地址。默认绑定到所有接口。</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.bind_port</td>
        <td>LWM2M_BS_BIND_PORT</td>
        <td>5687</td>
        <td>LwM2M 引导服务器绑定端口</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.bind_address</td>
        <td>LWM2M_BS_SECURITY_BIND_ADDRESS</td>
        <td>0.0.0.0</td>
        <td>LwM2M 引导服务器绑定地址，用于 DTLS。默认绑定到所有接口。</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.bind_port</td>
        <td>LWM2M_BS_SECURITY_BIND_PORT</td>
        <td>5688</td>
        <td>LwM2M 引导服务器绑定端口，用于 DTLS。</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.credentials.enabled</td>
        <td>LWM2M_BS_CREDENTIALS_ENABLED</td>
        <td>true</td>
        <td>是否启用 LWM2M 引导服务器 X509 证书/RPK 支持</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.credentials.type</td>
        <td>LWM2M_BS_CREDENTIALS_TYPE</td>
        <td>PEM</td>
        <td>服务器凭据类型（PEM - pem 证书文件；KEYSTORE - java 密钥库）</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.credentials.pem.cert_file</td>
        <td>LWM2M_BS_PEM_CERT</td>
        <td>lwm2mserver.pem</td>
        <td>服务器证书文件的路径（保存服务器证书或证书链，可能包括服务器私钥）</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.credentials.pem.key_file</td>
        <td>LWM2M_BS_PEM_KEY</td>
        <td>lwm2mserver_key.pem</td>
        <td>服务器证书私钥文件的路径（可选）</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.credentials.pem.key_password</td>
        <td>LWM2M_BS_PEM_KEY_PASSWORD</td>
        <td>server_key_password</td>
        <td>服务器证书私钥密码（可选）</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.credentials.keystore.type</td>
        <td>LWM2M_BS_KEY_STORE_TYPE</td>
        <td>JKS</td>
        <td>密钥库类型</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.credentials.keystore.store_file</td>
        <td>LWM2M_BS_KEY_STORE</td>
        <td>lwm2mserver.jks</td>
        <td>保存 SSL 证书的密钥库的路径</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.credentials.keystore.store_password</td>
        <td>LWM2M_BS_KEY_STORE_PASSWORD</td>
        <td>server_ks_password</td>
        <td>用于访问密钥库的密码</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.credentials.keystore.key_alias</td>
        <td>LWM2M_BS_KEY_ALIAS</td>
        <td>bootstrap</td>
        <td>密钥别名</td>
    </tr>
    <tr>
        <td>transport.lwm2m.bootstrap.security.credentials.keystore.key_password</td>
        <td>LWM2M_BS_KEY_PASSWORD</td>
        <td>server_ks_password</td>
        <td>用于访问密钥的密码</td>
    </tr>
    <tr>
        <td>transport.lwm2m.security.trust-credentials.enabled</td>
        <td>LWM2M_TRUST_CREDENTIALS_ENABLED</td>
        <td>true</td>
        <td>是否加载 X509 信任证书</td>
    </tr>
    <tr>
        <td>transport.lwm2m.security.trust-credentials.type</td>
        <td>LWM2M_TRUST_CREDENTIALS_TYPE</td>
        <td>PEM</td>
        <td>信任证书存储类型（PEM - pem 证书文件；KEYSTORE - java 密钥库）</td>
    </tr>
    <tr>
        <td>transport.lwm2m.security.trust-credentials.pem.cert_file</td>
        <td>LWM2M_TRUST_PEM_CERT</td>
        <td>lwm2mserver.pem</td>
        <td>证书文件的路径（保存信任证书）</td>
    </tr>
    <tr>
        <td>transport.lwm2m.security.trust-credentials.keystore.type</td>
        <td>LWM2M_TRUST_KEY_STORE_TYPE</td>
        <td>JKS</td>
        <td>密钥库类型</td>
    </tr>
    <tr>
        <td>transport.lwm2m.security.trust-credentials.keystore.store_file</td>
        <td>LWM2M_TRUST_KEY_STORE</td>
        <td>lwm2mserver.jks</td>
        <td>保存 X509 证书的密钥库的路径</td>
    </tr>
    <tr>
        <td>transport.lwm2m.security.trust-credentials.keystore.store_password</td>
        <td>LWM2M_TRUST_KEY_STORE_PASSWORD</td>
        <td>server_ks_password</td>
        <td>用于访问密钥库的密码</td>
    </tr>
    <tr>
        <td>transport.lwm2m.security.recommended_ciphers</td>
        <td>LWM2M_RECOMMENDED_CIPHERS</td>
        <td>false</td>
        <td>设置推荐的密码套件的使用。<br>
            * 参数 DTLS 连接器配置：<br>
            -- recommendedCipherSuitesOnly = true 仅允许推荐的密码套件，<br>
            -- recommendedCipherSuitesOnly = false，也允许不推荐的密码套件。
        </td>
    </tr>
    <tr>
        <td>transport.lwm2m.security.recommended_supported_groups</td>
        <td>LWM2M_RECOMMENDED_SUPPORTED_GROUPS</td>
        <td>true</td>
        <td>设置推荐的支持组（曲线）的使用。<br>
            * 参数 DTLS 连接器配置：<br>
            -- recommendedSupportedGroupsOnly = true 仅允许推荐的支持组，<br>
            -- recommendedSupportedGroupsOnly = false，也允许不推荐的支持组。默认值为
            true
        </td>
    </tr>
    <tr>
        <td>transport.lwm2m.timeout</td>
        <td>LWM2M_TIMEOUT</td>
        <td>120000</td>
        <td>LwM2M 操作的超时时间</td>
    </tr>
    <tr>
        <td>transport.lwm2m.uplink_pool_size</td>
        <td>LWM2M_UPLINK_POOL_SIZE</td>
        <td>10</td>
        <td>处理 LwM2M 上行链路的线程池大小</td>
    </tr>
    <tr>
        <td>transport.lwm2m.downlink_pool_size</td>
        <td>LWM2M_DOWNLINK_POOL_SIZE</td>
        <td>10</td>
        <td>处理 LwM2M 下行链路的线程池大小</td>
    </tr>
    <tr>
        <td>transport.lwm2m.ota_pool_size</td>
        <td>LWM2M_OTA_POOL_SIZE</td>
        <td>10</td>
        <td>处理 OTA 更新的线程池大小</td>
    </tr>
    <tr>
        <td>transport.lwm2m.clean_period_in_sec</td>
        <td>LWM2M_CLEAN_PERIOD_IN_SEC</td>
        <td>2</td>
        <td>存储中注册的清理周期</td>
    </tr>
    <tr>
        <td>transport.lwm2m.redis.enabled</td>
        <td>LWM2M_REDIS_ENABLED</td>
        <td>false</td>
        <td>启用/禁用 lvm2m 传输的 Redis</td>
    </tr>
    </tbody>
</table>