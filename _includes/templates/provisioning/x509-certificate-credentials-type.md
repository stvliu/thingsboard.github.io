{% if docsPrefix != 'paas/' %}
{% capture info %}
<br>
**信息：要使用此功能，您应该配置 [GridLinks 中的 MQTT over SSL](/docs/{{docsPrefix}}user-guide/mqtt-over-ssl/)**  
{% endcapture %}
{% include templates/info-banner.md content=info %}
{% endif %}


|---
| **参数**             | **示例值**                            | **说明**                                                                |
|:-|:-|-
| *deviceName*              | **DEVICE_NAME**                              | GridLinks 中的设备名称。                                                    |
| *provisionDeviceKey*      | **PUT_PROVISION_KEY_HERE**                   | Provisioning 设备密钥，您应该从配置的设备配置文件中获取它。    |
| *provisionDeviceSecret*   | **PUT_PROVISION_SECRET_HERE**                | Provisioning 设备密钥，您应该从配置的设备配置文件中获取它。 | 
| credentialsType           | **X509_CERTIFICATE**                         | 凭据类型参数。                                                    |
| hash                      | **MIIB........AQAB**                         | GridLinks 中设备的公钥 X509 哈希。                                |
|---

Provisioning 请求数据示例：
 
```json
{
  "deviceName": "DEVICE_NAME",
  "provisionDeviceKey": "PUT_PROVISION_KEY_HERE",
  "provisionDeviceSecret": "PUT_PROVISION_SECRET_HERE",
  "credentialsType": "X509_CERTIFICATE",
  "hash": "MIIB........AQAB"
}
```

Provisioning 响应示例：

```json
{
  "deviceId":"3b829220-232f-11eb-9d5c-e9ed3235dff8",
  "credentialsType":"X509_CERTIFICATE",
  "credentialsId":"f307a1f717a12b32c27203cf77728d305d29f64694a8311be921070dd1259b3a",
  "credentialsValue":"MIIB........AQAB",
  "provisionDeviceStatus":"SUCCESS"
}
```


### MQTT 示例脚本

要使用此脚本，请将您的 **mqttserver.pub.pem**（服务器的公钥）放入包含脚本的文件夹中。 

```python

import ssl
from datetime import datetime, timedelta
from cryptography import x509
from cryptography.x509.oid import NameOID
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from paho.mqtt.client import Client
from json import dumps, loads

RESULT_CODES = {
    1: "incorrect protocol version",
    2: "invalid client identifier",
    3: "server unavailable",
    4: "bad username or password",
    5: "not authorised",
    }


def collect_required_data():
    config = {}
    print("\n\n", "="*80, sep="")
    print(" "*10, "\033[1m\033[94mThingsBoard 设备 Provisioning 带有 X509 证书授权示例脚本。MQTT API\033[0m", sep="")
    print("="*80, "\n\n", sep="")
    host = input("请写下您的 GridLinks \033[93mhost\033[0m 或留空以使用默认值 (thingsboard.cloud): ")
    config["host"] = host if host else "mqtt.thingsboard.cloud"
    port = input("请写下您的 GridLinks \033[93mSSL 端口\033[0m 或留空以使用默认值 (8883): ")
    config["port"] = int(port) if port else 8883
    config["provision_device_key"] = input("请写下 \033[93mprovision 设备密钥\033[0m: ")
    config["provision_device_secret"] = input("请写下 \033[93mprovision 设备密钥\033[0m: ")
    device_name = input("请写下 \033[93m设备名称\033[0m 或留空以生成: ")
    if device_name:
        config["device_name"] = device_name
    print("\n", "="*80, "\n", sep="")
    return config

def generate_certs(ca_certfile="mqttserver.pub.pem"):
    root_cert = None
    try:
        with open(ca_certfile, "r") as ca_file:
            root_cert = x509.load_pem_x509_certificate(str.encode(ca_file.read()), default_backend())
    except Exception as e:
        print("无法加载 CA 证书: %r" % e)
    if root_cert is not None:
        private_key = rsa.generate_private_key(
            public_exponent=65537, key_size=2048, backend=default_backend()
            )
        new_subject = x509.Name([
        x509.NameAttribute(NameOID.COMMON_NAME, "localhost")
    ])
        certificate = (
            x509.CertificateBuilder()
            .subject_name(new_subject)
            .issuer_name(new_subject)
            .public_key(private_key.public_key())
            .serial_number(x509.random_serial_number())
            .not_valid_before(datetime.utcnow())
            .not_valid_after(datetime.utcnow() + timedelta(days=365*10))
            .add_extension(x509.BasicConstraints(ca=True, path_length=None), critical=True)
            .sign(private_key=private_key, algorithm=hashes.SHA256(), backend=default_backend())
        )

        with open("cert.pem", "wb") as cert_file:
            cert_file.write(certificate.public_bytes(encoding=serialization.Encoding.PEM))

        with open("key.pem", "wb") as key_file:
            key_file.write(private_key.private_bytes(encoding=serialization.Encoding.PEM,
                                                     format=serialization.PrivateFormat.TraditionalOpenSSL,
                                                     encryption_algorithm=serialization.NoEncryption(),
                                                ))


def read_cert():
    cert = None
    key = None
    try:
        with open("cert.pem", "r") as cert_file:
            cert = cert_file.read()
        with open("key.pem", "r") as key_file:
            key = key_file.read()
    except Exception as e:
        print("无法读取证书，错误: %r" % e)
    return cert, key


class ProvisionClient(Client):
    PROVISION_REQUEST_TOPIC = "/provision/request"
    PROVISION_RESPONSE_TOPIC = "/provision/response"

    def __init__(self, host, port, provision_request):
        super().__init__()
        self._host = host
        self._port = port
        self._username = "provision"
        self.tls_set(ca_certs="mqttserver.pub.pem", tls_version=ssl.PROTOCOL_TLSv1_2)
        self.on_connect = self.__on_connect
        self.on_message = self.__on_message
        self.__provision_request = provision_request

    def __on_connect(self, client, userdata, flags, rc):  # 连接回调
        if rc == 0:
            print("[Provisioning 客户端] 已连接到 GridLinks ")
            client.subscribe(self.PROVISION_RESPONSE_TOPIC)  # 订阅 Provisioning 响应主题
            provision_request = dumps(self.__provision_request)
            print("[Provisioning 客户端] 发送 Provisioning 请求 %s" % provision_request)
            client.publish(self.PROVISION_REQUEST_TOPIC, provision_request)  # 发布 Provisioning 请求主题
        else:
            print("[Provisioning 客户端] 无法连接到 GridLinks！结果: %s" % RESULT_CODES[rc])

    def __on_message(self, client, userdata, msg):
        decoded_payload = msg.payload.decode("UTF-8")
        print("[Provisioning 客户端] 从 GridLinks 收到数据: %s" % decoded_payload)
        decoded_message = loads(decoded_payload)
        provision_device_status = decoded_message.get("status")
        if provision_device_status == "SUCCESS":
            if decoded_message["credentialsValue"] == cert.replace("-----BEGIN CERTIFICATE-----\n", "")\
                                                          .replace("-----END CERTIFICATE-----\n", "")\
                                                          .replace("\n", ""):
                print("[Provisioning 客户端] Provisioning 成功！证书已保存。")
                self.__save_credentials(cert)
            else:
                print("[Provisioning 客户端] 返回的证书与发送的证书不一致。")
        else:
            print("[Provisioning 客户端] Provisioning 失败，状态 %s，消息: %s" % (provision_device_status, decoded_message["errorMsg"]))
        self.disconnect()

    def provision(self):
        print("[Provisioning 客户端] 正在连接到 GridLinks (provisioning 客户端)")
        self.__clean_credentials()
        self.connect(self._host, self._port, 60)
        self.loop_forever()

    def get_new_client(self):
        client_credentials = self.__get_credentials()
        new_client = None
        if client_credentials:
            new_client = Client()
            new_client.tls_set(ca_certs="mqttserver.pub.pem", certfile="cert.pem", keyfile="key.pem", cert_reqs=ssl.CERT_REQUIRED,
                               tls_version=ssl.PROTOCOL_TLSv1_2, ciphers=None)
            new_client.tls_insecure_set(False)
            print("[Provisioning 客户端] 从文件中读取凭据。")
        else:
            print("[Provisioning 客户端] 无法从文件中读取凭据！")
        return new_client

    @staticmethod
    def __get_credentials():
        new_credentials = None
        try:
            with open("credentials", "r") as credentials_file:
                new_credentials = credentials_file.read()
        except Exception as e:
            print(e)
        return new_credentials

    @staticmethod
    def __save_credentials(credentials):
        with open("credentials", "w") as credentials_file:
            credentials_file.write(credentials)

    @staticmethod
    def __clean_credentials():
        open("credentials", "w").close()


def on_tb_connected(client, userdata, flags, rc):  # 使用接收到的凭据连接的回调
    if rc == 0:
        print("[ThingsBoard 客户端] 已使用凭据连接到 GridLinks：用户名: %s，密码: %s，客户端 ID: %s" % (client._username, client._password, client._client_id))
    else:
        print("[ThingsBoard 客户端] 无法连接到 GridLinks！结果: %s" % RESULT_CODES[rc])


if __name__ == '__main__':

    config = collect_required_data()

    THINGSBOARD_HOST = config["host"]  # GridLinks 实例 host
    THINGSBOARD_PORT = config["port"]  # GridLinks 实例 MQTT 端口

    PROVISION_REQUEST = {"provisionDeviceKey": config["provision_device_key"],  # Provision 设备密钥，用设备配置文件中的值替换此值。
                         "provisionDeviceSecret": config["provision_device_secret"],  # Provision 设备密钥，用设备配置文件中的值替换此值。
                         "credentialsType": "X509_CERTIFICATE",
                         }
    if config.get("device_name") is not None:
        PROVISION_REQUEST["deviceName"] = config["device_name"]
    generate_certs()  # 生成证书和密钥
    cert, key = read_cert()  # 读取证书和密钥
    PROVISION_REQUEST["hash"] = cert
    if PROVISION_REQUEST.get("hash") is not None:
        provision_client = ProvisionClient(THINGSBOARD_HOST, THINGSBOARD_PORT, PROVISION_REQUEST)
        provision_client.provision()  # 请求 provisioned 数据
        tb_client = provision_client.get_new_client()  # 获取具有 provisioned 数据的客户端
        if tb_client:
            tb_client.on_connect = on_tb_connected  # 设置连接回调
            tb_client.connect(THINGSBOARD_HOST, THINGSBOARD_PORT, 60)
            tb_client.loop_forever()  # 启动无限循环
        else:
            print("未创建客户端！")
    else:
        print("无法读取证书。")
```