|---
| **参数**             | **示例值**                            | **说明**                                                                |
|:-|:-|-
| *deviceName*              | **DEVICE_NAME**                              | GridLinks 中的设备名称。                                                    |
| *provisionDeviceKey*      | **PUT_PROVISION_KEY_HERE**                   | プロビジョニング デバイス キー。構成されたデバイス プロファイルから取得する必要があります。    |
| *provisionDeviceSecret*   | **PUT_PROVISION_SECRET_HERE**                | プロビジョニング デバイス シークレット。構成されたデバイス プロファイルから取得する必要があります。 | 
| credentialsType           | **MQTT_BASIC**                               | 資格情報の種類のパラメーター。                                                    |
| username                  | **DEVICE_USERNAME_HERE**                     | ThingsBoard のデバイスのユーザー名。                                            |
| password                  | **DEVICE_PASSWORD_HERE**                     | ThingsBoard のデバイスのパスワード。                                            |
| clientId                  | **DEVICE_CLIENT_ID_HERE**                    | ThingsBoard のデバイスのクライアント ID。                                           |
|---

プロビジョニング要求データの例:
 
```json
{
  "deviceName": "DEVICE_NAME",
  "provisionDeviceKey": "PUT_PROVISION_KEY_HERE",
  "provisionDeviceSecret": "PUT_PROVISION_SECRET_HERE",
  "credentialsType": "MQTT_BASIC",
  "username": "DEVICE_USERNAME_HERE",
  "password": "DEVICE_PASSWORD_HERE",
  "clientId": "DEVICE_CLIENT_ID_HERE"
}
```

プロビジョニング応答の例:

```json
{
  "credentialsType":"MQTT_BASIC",
  "credentialsValue": {
    "clientId":"DEVICE_CLIENT_ID_HERE",
    "userName":"DEVICE_USERNAME_HERE",
    "password":"DEVICE_PASSWORD_HERE"
    },
  "status":"SUCCESS"
}
```


#### サンプル スクリプト

ThingsBoard と通信するには Paho MQTT モジュールを使用するため、インストールする必要があります。

```bash
pip3 install paho-mqtt --user
```
{: .copy-code}

スクリプトのソース コードを以下に示します。ファイルにコピー アンド ペーストできます。たとえば、次のようにします。

```bash
device-provision-example.py
```
{: .copy-code}

これでスクリプトを実行して、内部の手順に従う必要があります。  
Python 3 を使用してスクリプトを起動できます。  

```bash 
python3 device-provision-example.py
```
{: .copy-code}

スクリプトのソース コード: 

```python

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
    print(" "*10, "\033[1m\033[94mThingsBoard デバイス プロビジョニングの基本認証の例スクリプト。\033[0m", sep="")
    print("="*80, "\n\n", sep="")
    host = input("ThingsBoard の \033[93mホスト\033[0m を入力するか、空白のままにしてデフォルト (thingsboard.cloud) を使用します: ")
    config["host"] = host if host else "mqtt.thingsboard.cloud"
    port = input("ThingsBoard の \033[93mポート\033[0m を入力するか、空白のままにしてデフォルト (1883) を使用します: ")
    config["port"] = int(port) if port else 1883
    config["provision_device_key"] = input(" \033[93mプロビジョニング デバイス キー\033[0m を入力します: ")
    config["provision_device_secret"] = input(" \033[93mプロビジョニング デバイス シークレット\033[0m を入力します: ")
    device_name = input(" \033[93mデバイス名\033[0m を入力するか、空白のままにして生成します: ")
    if device_name:
        config["device_name"] = device_name
    config["clientId"] = input(" \033[93mクライアント ID\033[0m を入力します: ")
    config["username"] = input(" \033[93mユーザー名\033[0m を入力します: ")
    config["password"] = input(" \033[93mパスワード\033[0m を入力します: ")
    print("\n", "="*80, "\n", sep="")
    return config


class ProvisionClient(Client):
    PROVISION_REQUEST_TOPIC = "/provision/request"
    PROVISION_RESPONSE_TOPIC = "/provision/response"

    def __init__(self, host, port, provision_request):
        super().__init__()
        self._host = host
        self._port = port
        self._username = "provision"
        self.on_connect = self.__on_connect
        self.on_message = self.__on_message
        self.__provision_request = provision_request

    def __on_connect(self, client, userdata, flags, rc):  # 接続のコールバック
        if rc == 0:
            print("[プロビジョニング クライアント] ThingsBoard に接続しました ")
            client.subscribe(self.PROVISION_RESPONSE_TOPIC)  # プロビジョニング応答トピックを購読
            provision_request = dumps(self.__provision_request)
            print("[プロビジョニング クライアント] プロビジョニング要求 %s を送信しています" % provision_request)
            client.publish(self.PROVISION_REQUEST_TOPIC, provision_request)  # プロビジョニング要求トピックを公開
        else:
            print("[プロビジョニング クライアント] ThingsBoard に接続できません! 結果: %s" % RESULT_CODES[rc])

    def __on_message(self, client, userdata, msg):
        decoded_payload = msg.payload.decode("UTF-8")
        print("[プロビジョニング クライアント] ThingsBoard からデータを受信しました: %s" % decoded_payload)
        decoded_message = loads(decoded_payload)
        provision_device_status = decoded_message.get("status")
        if provision_device_status == "SUCCESS":
            self.__save_credentials(decoded_message["credentialsValue"])
        else:
            print("[プロビジョニング クライアント] プロビジョニングはステータス %s とメッセージ: %s で失敗しました" % (provision_device_status, decoded_message["errorMsg"]))
        self.disconnect()

    def provision(self):
        print("[プロビジョニング クライアント] ThingsBoard に接続しています (プロビジョニング クライアント)")
        self.__clean_credentials()
        self.connect(self._host, self._port, 60)
        self.loop_forever()

    def get_new_client(self):
        client_credentials = loads(self.__get_credentials())
        new_client = None
        if client_credentials:
            new_client = Client(client_id=client_credentials["clientId"])  # クライアント ID を設定
            new_client.username_pw_set(client_credentials["userName"], client_credentials["password"])  # ThingsBoard クライアントのユーザー名とパスワードを設定
            print("[プロビジョニング クライアント] ファイルから資格情報を取得しました。")
        else:
            print("[プロビジョニング クライアント] ファイルから資格情報を読み取れません!")
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
            credentials_file.write(dumps(credentials))

    @staticmethod
    def __clean_credentials():
        open("credentials", "w").close()


def on_tb_connected(client, userdata, flags, rc):  # 受信した資格情報で接続するためのコールバック
    if rc == 0:
        print("[ThingsBoard クライアント] ユーザー名: %s、パスワード: %s、クライアント ID: %s で ThingsBoard に接続しました" % (client._username.decode(), client._password.decode(), client._client_id.decode()))
    else:
        print("[ThingsBoard クライアント] ThingsBoard に接続できません! 結果: %s" % RESULT_CODES[rc])


if __name__ == '__main__':
    config = collect_required_data()

    THINGSBOARD_HOST = config["host"]  # ThingsBoard インスタンスのホスト
    THINGSBOARD_PORT = config["port"]  # ThingsBoard インスタンスの MQTT ポート

    PROVISION_REQUEST = {"provisionDeviceKey": config["provision_device_key"],
                         # プロビジョニング デバイス キー。この値をデバイス プロファイルの値に置き換えます。
                         "provisionDeviceSecret": config["provision_device_secret"],
                         # プロビジョニング デバイス シークレット。この値をデバイス プロファイルの値に置き換えます。
                         "credentialsType": "MQTT_BASIC",
                         "username": config["username"],
                         "password": config["password"],
                         "clientId": config["clientId"],
                         }
    if config.get("device_name") is not None:
        PROVISION_REQUEST["deviceName"] = config["device_name"]
    provision_client = ProvisionClient(THINGSBOARD_HOST, THINGSBOARD_PORT, PROVISION_REQUEST)
    provision_client.provision()  # プロビジョニングされたデータを要求
    tb_client = provision_client.get_new_client()  # プロビジョニングされたデータでクライアントを取得
    if tb_client:
        tb_client.on_connect = on_tb_connected  # 接続のコールバックを設定
        tb_client.connect(THINGSBOARD_HOST, THINGSBOARD_PORT, 60)
        tb_client.loop_forever()  # 無限ループを開始
    else:
        print("クライアントは作成されませんでした!")
```
{: .copy-code}