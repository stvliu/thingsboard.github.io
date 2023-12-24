```yaml
####  HTTP server parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>Parameter</b></td><td style="width: 30%"><b>Environment Variable</b></td><td style="width: 15%"><b>Default Value</b></td><td style="width: 30%"><b>Description</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>server.shutdown</td>
			<td>SERVER_SHUTDOWN</td>
			<td>graceful</td>
			<td> Shutdown type (graceful or immediate)</td>
		</tr>
		<tr>
			<td>server.address</td>
			<td>HTTP_BIND_ADDRESS</td>
			<td>0.0.0.0</td>
			<td> HTTP Server bind address (has no effect if web-environment is disabled)</td>
		</tr>
		<tr>
			<td>server.port</td>
			<td>HTTP_BIND_PORT</td>
			<td>8083</td>
			<td> HTTP Server bind port (has no effect if web-environment is disabled)</td>
		</tr>
		<tr>
			<td>server.log_controller_error_stack_trace</td>
			<td>HTTP_LOG_CONTROLLER_ERROR_STACK_TRACE</td>
			<td>false</td>
			<td> Log errors with stacktrace when REST API throws exception</td>
		</tr>
		<tr>
			<td>server.ssl.enabled</td>
			<td>SSL_ENABLED</td>
			<td>false</td>
			<td> Enable/disable SSL support</td>
		</tr>
		<tr>
			<td>server.ssl.credentials.type</td>
			<td>SSL_CREDENTIALS_TYPE</td>
			<td>PEM</td>
			<td> Server credentials type (PEM - pem certificate file; KEYSTORE - java keystore)</td>
		</tr>
		<tr>
			<td>server.ssl.credentials.pem.cert_file</td>
			<td>SSL_PEM_CERT</td>
			<td>server.pem</td>
			<td> Path to the server certificate file (holds server certificate or certificate chain, may include server private key)</td>
		</tr>
		<tr>
			<td>server.ssl.credentials.pem.key_file</td>
			<td>SSL_PEM_KEY</td>
			<td>server_key.pem</td>
			<td> Path to the server certificate private key file. Optional by default. Required if the private key is not present in server certificate file</td>
		</tr>
		<tr>
			<td>server.ssl.credentials.pem.key_password</td>
			<td>SSL_PEM_KEY_PASSWORD</td>
			<td>server_key_password</td>
			<td> Server certificate private key password (optional)</td>
		</tr>
		<tr>
			<td>server.ssl.credentials.keystore.type</td>
			<td>SSL_KEY_STORE_TYPE</td>
			<td>PKCS12</td>
			<td> Type of the key store (JKS or PKCS12)</td>
		</tr>
		<tr>
			<td>server.ssl.credentials.keystore.store_file</td>
			<td>SSL_KEY_STORE</td>
			<td>classpath:keystore/keystore.p12</td>
			<td> Path to the key store that holds the SSL certificate</td>
		</tr>
		<tr>
			<td>server.ssl.credentials.keystore.store_password</td>
			<td>SSL_KEY_STORE_PASSWORD</td>
			<td>thingsboard_mqtt_broker</td>
			<td> Password used to access the key store</td>
		</tr>
		<tr>
			<td>server.ssl.credentials.keystore.key_alias</td>
			<td>SSL_KEY_ALIAS</td>
			<td>tomcat</td>
			<td> Key alias</td>
		</tr>
		<tr>
			<td>server.ssl.credentials.keystore.key_password</td>
			<td>SSL_KEY_PASSWORD</td>
			<td>thingsboard_mqtt_broker</td>
			<td> Password used to access the key</td>
		</tr>
	</tbody>
</table>


####  MQTT listeners parameters

<table>
	<thead>
		<tr>
			<td style="width: 25%"><b>Parameter</b></td><td style="width: 30%"><b>Environment Variable</b></td><td style="width: 15%"><b>Default Value</b></td><td style="width: 30%"><b>Description</b></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>listener.tcp.enabled</td>
			<td>LISTENER_TCP_ENABLED</td>
			<td>true</td>
			<td> Enable/disable MQTT TCP port listener</td>
		</tr>
		<tr>
			<td>listener.tcp.bind_address</td>
			<td>LISTENER_TCP_BIND_ADDRESS</td>
			<td>0.0.0.0</td>
			<td> MQTT TCP listener bind address</td>
		</tr>
		<tr>
			<td>listener.tcp.bind_port</td>
			<td>LISTENER_TCP_BIND_PORT</td>
			<td>1883</td>
			<td> MQTT TCP listener bind port</td>
		</tr>
		<tr>
			<td>listener.tcp.netty.leak_detector_level</td>
			<td>TCP_NETTY_LEAK_DETECTOR_LVL</td>
			<td>DISABLED</td>
			<td> Netty leak detector level: DISABLED, SIMPLE, ADVANCED, PARANOID</td>
		</tr>
		<tr>
			<td>listener.tcp.netty.boss_group_thread_count</td>
			<td>TCP_NETTY_BOSS_GROUP_THREADS</td>
			<td>1</td>
			<td> Netty boss group threads count</td>
		</tr>
		<tr>
			<td>listener.tcp.netty.worker_group_thread_count</td>
			<td>TCP_NETTY_WORKER_GROUP_THREADS</td>
			<td>12</td>
			<td> Netty worker group threads count</td>
		</tr>
		<tr>
			<td>listener.tcp.netty.max_payload_size</td>
			<td>TCP_NETTY_MAX_PAYLOAD_SIZE</td>
			<td>65536</td>
			<td> Max payload size in bytes</td>
		</tr>
		<tr>
			<td>listener.tcp.netty.so_keep_alive</td>
			<td>TCP_NETTY_SO_KEEPALIVE</td>
			<td>true</td>
			<td> Enable/disable keep-alive mechanism to periodically probe the other end of a connection</td>
		</tr>
		<tr>
			<td>listener.tcp.netty.shutdown_quiet_period</td>
			<td>TCP_NETTY_SHUTDOWN_QUIET_PERIOD</td>
			<td>0</td>
			<td> Period in seconds in graceful shutdown during which no new tasks are submitted</td>
		</tr>
		<tr>
			<td>listener.tcp.netty.shutdown_timeout</td>
			<td>TCP_NETTY_SHUTDOWN_TIMEOUT</td>
			<td>5</td>
			<td> The max time in seconds to wait until the executor is stopped</td>
		</tr>
		<tr>
			<td>listener.ssl.enabled</td>
			<td>LISTENER_SSL_ENABLED</td>
			<td>false</td>
			<td> Enable/disable MQTT SSL port listener</td>
		</tr>
		<tr>
			<td>listener.ssl.bind_address</td>
			<td>LISTENER_SSL_BIND_ADDRESS</td>
			<td>0.0.0.0</td>
			<td> MQTT SSL listener bind address</td>
		</tr>
		<tr>
			<td>listener.ssl.bind_port</td>
			<td>LISTENER_SSL_BIND_PORT</td>
			<td>8883</td>
			<td> MQTT SSL listener bind port</td>
		</tr>
		<tr>
			<td>listener.ssl.config.protocol</td>
			<td>LISTENER_SSL_PROTOCOL</td>
			<td>TLSv1.2</td>
			<td> SSL protocol: see <a href="https://docs.oracle.com/en/java/javase/17/docs/specs/security/standard-names.html#sslcontext-algorithms">this link</a></td>
		</tr>
		<tr>
			<td>listener.ssl.config.credentials.type</td>
			<td>LISTENER_SSL_CREDENTIALS_TYPE</td>
			<td>PEM</td>
			<td> Server credentials type (PEM - pem certificate file; KEYSTORE - java keystore)</td>
		</tr>
		<tr>
			<td>listener.ssl.config.credentials.pem.cert_file</td>
			<td>LISTENER_SSL_PEM_CERT</td>
			<td>mqttserver.pem</td>
			<td> Path to the server certificate file (holds server certificate or certificate chain, may include server private key)</td>
		</tr>
		<tr>
			<td>listener.ssl.config.credentials.pem.key_file</td>
			<td>LISTENER_SSL_PEM_KEY</td>
			<td>mqttserver_key.pem</td>
			<td> Path to the server certificate private key file. Optional by default. Required if the private key is not present in server certificate file</td>
		</tr>
		<tr>
			<td>listener.ssl.config.credentials.pem.key_password</td>
			<td>LISTENER_SSL_PEM_KEY_PASSWORD</td>
			<td>server_key_password</td>
			<td> Server certificate private key password (optional)</td>
		</tr>
		<tr>
			<td>listener.ssl.config.credentials.keystore.type</td>
			<td>LISTENER_SSL_KEY_STORE_TYPE</td>
			<td>JKS</td>
			<td> Type of the key store (JKS or PKCS12)</td>
		</tr>
		<tr>
			<td>listener.ssl.config.credentials.keystore.store_file</td>
			<td>LISTENER_SSL_KEY_STORE</td>
			<td>mqttserver.jks</td>
			<td> Path to the key store that holds the SSL certificate</td>
		</tr>
		<tr>
			<td>listener.ssl.config.credentials.keystore.store_password</td>
			<td>LISTENER_SSL_KEY_STORE_PASSWORD</td>
			<td>server_ks_password</td>
			<td> Password used to access the key store</td>
		</tr>
		<tr>
			<td>listener.ssl.config.credentials.keystore.key_alias</td>
			<td>LISTENER_SSL_KEY_ALIAS</td>
			<td></td>
			<td> Optional alias of the private key. If not set, the platform will load the first private key from the keystore</td>
		</tr>
		<tr>
			<td>listener.ssl.config.credentials.keystore.key_password</td>
			<td>LISTENER_SSL_KEY_PASSWORD</td>
			<td>server_key_password</td>
			<td> Optional password to access the private key. If not set, the platform will attempt to load the private keys that are not protected with the password</td>
		</tr>
		<tr>
			<td>listener.ssl.netty.leak_detector_level</td>
			<td>SSL_NETTY_LEAK_DETECTOR_LVL</td>
			<td>DISABLED</td>
			<td> Netty leak detector level: DISABLED, SIMPLE, ADVANCED, PARANOID</td>
		</tr>
		<tr>
			<td>listener.ssl.netty.boss_group_thread_count</td>
			<td>SSL_NETTY_BOSS_GROUP_THREADS</td>
			<td>1</td>
			<td> Netty boss group threads count</td>
		</tr>
		<tr>
			<td>listener.ssl.netty.worker_group_thread_count</td>
			<td>SSL_NETTY_WORKER_GROUP_THREADS</td>
			<td>12</td>
			<td> Netty worker group threads count</td>
		</tr>
		<tr>
			<td>listener.ssl.netty.max_payload_size</td>
			<td>SSL_NETTY_MAX_PAYLOAD_SIZE</td>
			<td>65536</td>
			<td> Max payload size in bytes</td>
		</tr>
		<tr>
			<td>listener.ssl.netty.so_keep_alive</td>
			<td>SSL_NETTY_SO_KEEPALIVE</td>
			<td>true</td>
			<td> Enable/disable keep-alive mechanism to periodically probe the other end of a connection</td>
		</tr>
		<tr>
			<td>listener.ssl.netty.shutdown_quiet_period</td>
			<td>SSL_NETTY_SHUTDOWN_QUIET_PERIOD</td>
			<td>0</td>
			<td> Period in seconds in graceful shutdown during which no new tasks are submitted</td>
		</tr>
		<tr>
			<td>listener.ssl.netty.shutdown_timeout</td>
			<td>SSL_NETTY_SHUTDOWN_TIMEOUT</td>
			<td>5</td>
			<td> The max time in seconds to wait until the executor is stopped</td>
		</tr>
		<tr>
			<td>listener.ws.enabled</td>
			<td>LISTENER_WS_ENABLED</td>
			<td>true</td>
			<td> Enable/disable MQTT WS port listener</td>
		</tr>
		<tr>
			<td>listener.ws.bind_address</td>
			<td>LISTENER_WS_BIND_ADDRESS</td>
			<td>0.0.0.0</td>
			<td> MQTT WS listener bind address</td>
		</tr>
		<tr>
			<td>listener.ws.bind_port</td>
			<td>LISTENER_WS_BIND_PORT</td>
			<td>8084</td>
			<td> MQTT WS listener bind port</td>
		</tr>
		<tr>
			<td>listener.ws.netty.sub_protocols</td>
			<td>WS_NETTY_SUB_PROTOCOLS</td>
			<td>mqttv3.1,mqtt</td>
			<td> Comma-separated list of subprotocols that the WebSocket can negotiate. The subprotocol setting `mqtt` represents MQTT 3.1.1 and MQTT 5</td>
		</tr>
		<tr>
			<td>listener.ws.netty.leak_detector_level</td>
			<td>WS_NETTY_LEAK_DETECTOR_LVL</td>
			<td>DISABLED</td>
			<td> Netty leak detector level: DISABLED, SIMPLE, ADVANCED, PARANOID</td>
		</tr>
		<tr>
			<td>listener.ws.netty.boss_group_thread_count</td>
			<td>WS_NETTY_BOSS_GROUP_THREADS</td>
			<td>1</td>
			<td> Netty boss group threads count</td>
		</tr>
		<tr>
			<td>listener.ws.netty.worker_group_thread_count</td>
			<td>WS_NETTY_WORKER_GROUP_THREADS</td>
			<td>12</td>
			<td> Netty worker group threads count</td>
		</tr>
		<tr>
			<td>listener.ws.netty.max_payload_size</td>
			<td>WS_NETTY_MAX_PAYLOAD_SIZE</td>
			<td>65536</td>
			<td> Max payload size in bytes</td>
		</tr>
		<tr>
			<td>listener.ws.netty.so_keep_alive</td>
			<td>WS_NETTY_SO_KEEPALIVE</td>
			<td>true</td>
			<td> Enable/disable keep-alive mechanism to periodically probe the other end of a connection</td>
		</tr>
		<tr>
			<td>listener.ws.netty.shutdown_quiet_period</td>
			<td>WS_NETTY_SHUTDOWN_QUIET_PERIOD</td>
			<td>0</td>
			<td> Period in seconds in graceful shutdown during which no new tasks are submitted</td>
		</tr>
		<tr>
			<td>listener.ws.netty.shutdown_timeout</td>
			<td>WS_NETTY_SHUTDOWN_TIMEOUT</td>
			<td>5</td>
			<td> The max time in seconds to wait until the executor is stopped</td>
		</tr>
		<tr>
			<td>listener.wss.enabled</td>
			<td>LISTENER_WSS_ENABLED</td>
			<td>false</td>
			<td> Enable/disable MQTT WSS port listener</td>
		</tr>
		<tr>
			<td>listener.wss.bind_address</td>
			<td>LISTENER_WSS_BIND_ADDRESS</td>
			<td>0.0.0.0</td>
			<td> MQTT WSS listener bind address</td>
		</tr>
		<tr>
			<td>listener.wss.bind_port</td>
			<td>LISTENER_WSS_BIND_PORT</td>
			<td>8085</td>
			<td> MQTT WSS listener bind port</td>
		</tr>
		<tr>
			<td>listener.wss.config.protocol</td>
			<td>LISTENER_WSS_PROTOCOL</td>
			<td>TLSv1.2</td>
			<td> SSL protocol: see <a href="https://docs.oracle.com/en/java/javase/17/docs/specs/security/standard-names.html#sslcontext-algorithms">this link</a></td>
		</tr>
		<tr>
			<td>listener.wss.config.credentials.type</td>
			<td>LISTENER_WSS_CREDENTIALS_TYPE</td>
			<td>PEM</td>
			<td> Server credentials type (PEM - pem certificate file; KEYSTORE - java keystore)</td>
		</tr>
		<tr>
			<td>listener.wss.config.credentials.pem.cert_file</td>
			<td>LISTENER_WSS_PEM_CERT</td>
			<td>ws_mqtt_server.pem</td>
			<td> Path to the server certificate file (holds server certificate or certificate chain, may include server private key)</td>
		</tr>
		<tr>
			<td>listener.wss.config.credentials.pem.key_file</td>
			<td>LISTENER_WSS_PEM_KEY</td>
			<td>ws_mqtt_server_key.pem</td>
			<td> Path to the server certificate private key file. Optional by default. Required if the private key is not present in server certificate file</td>
		</tr>
		<tr>
			<td>listener.wss.config.credentials.pem.key_password</td>
			<td>LISTENER_WSS_PEM_KEY_PASSWORD</td>
			<td>ws_server_key_password</td>
			<td> Server certificate private key password (optional)</td>
		</tr>
		<tr>
			<td>listener.wss.config.credentials.keystore.type</td>
			<td>LISTENER_WSS_KEY_STORE_TYPE</td>
			<td>JKS</td>
			<td> Type of the key store (JKS or PKCS12)</td>
		</tr>
		<tr>
			<td>listener.wss.config.credentials.keystore.store_file</td>
			<td>LISTENER_WSS_KEY_STORE</td>
			<td>ws_mqtt_server.jks</td>
			<td> Path to the key store that holds the SSL certificate</td>
		</tr>
		<tr>
			<td>listener.wss.config.credentials.keystore.store_password</td>
			<td>LISTENER_WSS_KEY_STORE_PASSWORD</td>
			<td>ws_server_ks_password</td>
			<td> Password used to access the key store</td>
		</tr>
		<tr>
			<td>listener.wss.config.credentials.keystore.key_alias</td>
			<td>LISTENER_WSS_KEY_ALIAS</td>
			<td></td>
			<td> Optional alias of the private key. If not set, the platform will load the first private key from the keystore</td>
		</tr>
		<tr>
			<td>listener.wss.config.credentials.keystore.key_password</td>
			<td>LISTENER_WSS_KEY_PASSWORD</td>
			<td>ws_server_key_password</td>
			<td> Optional password to access the private key. If not set, the platform will attempt to load the private keys that are not protected with the password</td>
		</tr>
		<tr>
			<td>listener.wss.netty.sub_protocols</td>
			<td>WSS_NETTY_SUB_PROTOCOLS</td>
			<td>mqttv3.1,mqtt</td>
			<td> Comma-separated list of subprotocols that the WebSocket can negotiate. The subprotocol setting `mqtt` represents MQTT 3.1.1 and MQTT 5</td>
		</tr>
		<tr>
			<td>listener.wss.netty.leak_detector_level</td>
			<td>WSS_NETTY_LEAK_DETECTOR_LVL</td>
			<td>DISABLED</td>
			<td> Netty leak detector level: DISABLED, SIMPLE, ADVANCED, PARANOID</td>
		</tr>
		<tr>
			<td>listener.wss.netty.boss_group_thread_count</td>
			<td>WSS_NETTY_BOSS_GROUP_THREADS</td>
			<td>1</td>
			<td> Netty boss group threads count</td>
		</tr>
		<tr>
			<td>listener.wss.netty.worker_group_thread_count</td>
			<td>WSS_NETTY_WORKER_GROUP_THREADS</td>
			<td>12</td>
			<td> Netty worker group threads count</td>
		</tr>
		<tr>
			<td>listener.wss.netty.max_payload_size</td>
			<td>WSS_NETTY_MAX_PAYLOAD_SIZE</td>
			<td>65536</td>
			<td> Max payload size in bytes</td>
		</tr>
		<tr>
			<td>listener.wss.netty.so_keep_alive</td>
			<td>WSS_NETTY_SO_KEEPALIVE</td>
			<td>true</td>
			<td> Enable/disable keep-alive mechanism to periodically probe the other end of a connection</td>
		</tr>
		<tr>
			<td>listener.wss.netty.shutdown_quiet_period</td>
			<td>WSS_NETTY_SHUTDOWN_QUIET_PERIOD</td>
			<td>0</td>
			<td> Period in seconds in graceful shutdown during which no new tasks are submitted</td>
		</tr>
		<tr>
			<td>listener.wss.netty.shutdown_timeout</td>
			<td>WSS_NETTY_SHUTDOWN_TIMEOUT</td>
			<td>5</td>
			<td> The max time in seconds to wait until the executor is stopped</td>
		</tr>
	</tbody>
</table>