| **参数**             | **示例值**                            | **描述**                                                                |
|:-|:-
| *deviceName*              | **DEVICE_NAME**                              | GridLinks 中的设备名称。                                                    |
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

ThingsBoard と通信するには asyncio と aiocoap モジュールを使用するため、インストールする必要があります。

```bash
pip3 install asyncio aiocoap --user
```
{: .copy-code}

スクリプトのソース コードを以下に示します。ファイルにコピー アンド ペーストできます。たとえば、次のようにします。

```bash
device-provision-example.py
```
{: .copy-code}

これでスクリプトを実行して、内部の手順に従う必要があります。  
python 3 を使用してスクリプトを起動できます。  

```bash 
python3 device-provision-example.py
```
{: .copy-code}

スクリプトのソース コード: 

```python
import logging
import asyncio

from aiocoap import Context, Message, Code
from json import loads, dumps

THINGSBOARD_HOST = ""
THINGSBOARD_PORT = ""

logging.basicConfig(level=logging.INFO)


def collect_required_data():
    config = {}
    print("\n\n", "="*80, sep="")
    print(" "*10, "\033[1m\033[94mThingsBoard デバイス プロビジョニング (認証なし) の例スクリプト。CoAP API\033[0m", sep="")
    print("="*80, "\n\n", sep="")
    host = input("ThingsBoard の\033[93mホスト\033[0mを入力するか、空白のままにしてデフォルト (thingsboard.cloud) を使用します: ")
    config["host"] = host if host else "coap.thingsboard.cloud"
    port = input("ThingsBoard の\033[93mCoAP ポート\033[0mを入力するか、空白のままにしてデフォルト (5683) を使用します: ")
    config["port"] = int(port) if port else 5683
    config["provision_device_key"] = input("プロビジョニング デバイス キーを入力してください: ")
    config["provision_device_secret"] = input("プロビジョニング デバイス シークレットを入力してください: ")
    device_name = input("デバイス名を入力するか、空白のままにして生成します: ")
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


async def process():
    server_address = "coap://" + THINGSBOARD_HOST + ":" + str(THINGSBOARD_PORT)

    client_context = await Context.create_client_context()
    await asyncio.sleep(2)
    try:
        msg = Message(code=Code.POST, payload=str.encode(dumps(PROVISION_REQUEST)), uri=server_address+'/api/v1/provision')
        request = client_context.request(msg)
        try:
            response = await asyncio.wait_for(request.response, 60000)
        except asyncio.TimeoutError:
            raise Exception("要求がタイムアウトしました!")

        if response is None:
            raise Exception("応答が空です!")

        decoded_response = loads(response.payload)
        logging.info("応答を受信しました: %s", decoded_response)
        received_token = decoded_response.get("credentialsValue")
        if received_token is not None:
            msg = Message(code=Code.POST, payload=str.encode(dumps(to_publish)),
                          uri=server_address+('/api/v1/%s/telemetry' % received_token))
            request = client_context.request(msg)
            try:
                response = await asyncio.wait_for(request.response, 60000)
            except asyncio.TimeoutError:
                raise Exception("要求がタイムアウトしました!")

            if response:
                logging.info("[THINGSBOARD クライアント] Thingsboard からの応答。")
                logging.info(response)
            else:
                raise Exception("[THINGSBOARD クライアント] 受信した資格情報でテレメトリを保存できません!")
        else:
            logging.error("応答からアクセス トークンを取得できませんでした。")
            logging.error(decoded_response.get("errorMsg"))
    except Exception as e:
        logging.error(e)
    finally:
        await client_context.shutdown()

if __name__ == '__main__':

    config = collect_required_data()

    THINGSBOARD_HOST = config["host"]  # ThingsBoard インスタンスのホスト
    THINGSBOARD_PORT = config["port"]  # ThingsBoard インスタンスのポート

    PROVISION_REQUEST = {"provisionDeviceKey": config["provision_device_key"],  # プロビジョニング デバイス キー。この値をデバイス プロファイルの値に置き換えます。
                         "provisionDeviceSecret": config["provision_device_secret"],  # プロビジョニング デバイス シークレット。この値をデバイス プロファイルの値に置き換えます。
                         }
    if config.get("device_name") is not None:
        PROVISION_REQUEST["deviceName"] = config["device_name"]

    asyncio.run(process())

```
{: .copy-code}