| **参数**             | **示例值**                            | **描述**                                                                |
|:-|:-
| *deviceName*              | **DEVICE_NAME**                              | ThingsBoard 中的设备名称。                                                    |
| *provisionDeviceKey*      | **PUT_PROVISION_KEY_HERE**                   | プロビジョニング デバイス キー。構成されたデバイス プロファイルから取得する必要があります。    |
| *provisionDeviceSecret*   | **PUT_PROVISION_SECRET_HERE**                | プロビジョニング デバイス シークレット。構成されたデバイス プロファイルから取得する必要があります。 | 
|-

プロビジョニング要求データの例:
 
```json
{
  "deviceName": "DEVICE_NAME",
  "provisionDeviceKey": "PUT_PROVISION_KEY_HERE",
  "provisionDeviceSecret": "PUT_PROVISION_SECRET_HERE"
}
```
{: .copy-code}

プロビジョニング応答の例:

```json
{
  "status":"SUCCESS",
  "credentialsType":"ACCESS_TOKEN",
  "credentialsValue":"sLzc0gDAZPkGMzFVTyUY"
}
```
{: .copy-code}


#### サンプル スクリプト

スクリプトのソース コードを以下に示します。ファイルをコピーして貼り付けることができます。たとえば:

```bash
device-provision-example.py
```
{: .copy-code}

これでスクリプトを実行して、内部の手順に従う必要があります。  
python 3 を使用してスクリプトを起動できます:  

```bash 
python3 device-provision-example.py
```
{: .copy-code}

スクリプトのソース コード: 
```python


from requests import post
from json import dumps


def collect_required_data():
    config = {}
    print("\n\n", "="*80, sep="")
    print(" "*10, "\033[1m\033[94mThingsBoard デバイス プロビジョニング (認証なし) の例スクリプト。HTTP API\033[0m", sep="")
    print("="*80, "\n\n", sep="")
    host = input("ThingsBoard の\033[93mホスト\033[0mを入力するか、空白のままにしてデフォルト (https://thingsboard.cloud) を使用します: ")
    config["host"] = host if host else "https://thingsboard.cloud"
    port = input("ThingsBoard の\033[93mHTTP ポート\033[0mを入力するか、空白のままにしてデフォルト (443) を使用します: ")
    config["port"] = int(port) if port else 443
    config["provision_device_key"] = input("\033[93mprovision デバイス キー\033[0mを入力します: ")
    config["provision_device_secret"] = input("\033[93mprovision デバイス シークレット\033[0mを入力します: ")
    device_name = input("\033[93mデバイス名\033[0mを入力するか、空白のままにして生成します: ")
    if device_name:
        config["device_name"] = device_name
    print("\n", "="*80, "\n", sep="")
    return config


# ThingsBoard へのメッセージの例
to_publish = {
  "stringKey": "value1",
  "booleanKey": True,
  "doubleKey": 42.0,
  "longKey": 73,
  "jsonKey": {
    "someNumber": 42,
    "someArray": [1, 2, 3],
    "someNestedObject": {"key": "value"}
  }
}

if __name__ == '__main__':

    config = collect_required_data()

    THINGSBOARD_HOST = config["host"]  # ThingsBoard インスタンスのホスト
    THINGSBOARD_PORT = config["port"]  # ThingsBoard インスタンスの MQTT ポート

    PROVISION_REQUEST = {"provisionDeviceKey": config["provision_device_key"],  # プロビジョニング デバイス キー。この値をデバイス プロファイルの値に置き換えます。
                         "provisionDeviceSecret": config["provision_device_secret"],  # プロビジョニング デバイス シークレット。この値をデバイス プロファイルの値に置き換えます。
                         }
    if config.get("device_name") is not None:
        PROVISION_REQUEST["deviceName"] = config["device_name"]
    response = post("%s:%i/api/v1/provision" % (THINGSBOARD_HOST, THINGSBOARD_PORT), json=PROVISION_REQUEST)
    decoded_response = response.json()
    print("応答を受信しました: ")
    print(decoded_response)
    received_token = decoded_response.get("credentialsValue")
    if received_token is not None:
        response = post('%s:%i/api/v1/%s/telemetry' % (THINGSBOARD_HOST, THINGSBOARD_PORT, received_token,), dumps(to_publish))
        print("[THINGSBOARD クライアント] Thingsboard からの応答コード。")
        print(response.status_code)
    else:
        print("応答からアクセス トークンを取得できませんでした。")
        print(decoded_response.get("errorMsg"))


```
{: .copy-code}