{% assign deviceName = page.title | remove: "How to connect " | remove: " to ThingsBoard?" %}
{% assign deviceVendorLink = "https://teltonika-networks.com/ua/products/routers/rut955/" %}
{% assign controllerName = "Siemens LOGO!" %}
{% assign controllerVendorLink = "https://www.siemens.com/ua/uk/produkty/avtomatyzatsiya-promyslovosti/systemy-avtomatyzatsiyi/systemy-promyslovoyi-avtomatyzatsiyi-simatic/plc-kontrolery-simatic/lohichnyy-modul-logo.html" %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- Modbus Controller (in our case <a href="' | append: controllerVendorLink | append: '" target="_blank">' | append: controllerName | append: '</a>) '
 %}
{% assign thingsboardInstanceLink = "https://gridlinks.codingas.com" %}
{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
{% assign thingsboardInstanceLink = "https://thingsboard.cloud" %}
{% endif %}


## Введение
![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
[{{deviceName}}]({{deviceVendorLink}}){: target="_blank"} предлагает двухсимочное сотовое соединение, четыре порта Ethernet и Wi-Fi в сочетании с интерфейсами RS232, RS485, USB и вводом-выводом для широкого спектра профессиональных сценариев применения. Этот маршрутизатор оснащен расширенными программными функциями RutOS, такими как поддержка протоколов Modbus, SNMP, TR-069, NTRIP, MQTT и возможностями отслеживания GNSS.
<br><br>

## Предварительные условия

Чтобы продолжить работу с этим руководством, нам понадобятся следующие компоненты:  
{{ prerequisites }}
- [Учетная запись ThingsBoard]({{thingsboardInstanceLink}}){: target="_blank"}

## Импорт цепочки правил

Загрузите [цепочку правил Teltonika] (/docs/devices-library/resources/dashboards/ready-to-go-devices/teltonika-rut-955-rule-chain.json) {:target="_blank" download="teltonika-rut955-rule-chain.json"} и импортируйте ее.

Чтобы импортировать цепочку правил из файла JSON, вам следует:

{% assign importRuleChainPE = '
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/import-rule-chain-1-pe.png,
        title: Перейдите на страницу "Цепочки правил" и нажмите кнопку "+" в правом верхнем углу экрана, а затем выберите опцию "Импортировать цепочку правил". Откроется всплывающее окно импорта панели инструментов. Загрузите файл JSON и нажмите кнопку "Импорт";
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/import-rule-chain-2-pe.png,
        title: Откроется импортированная цепочка правил. Нажмите кнопку "Применить изменения", чтобы сохранить цепочку правил. Затем вернитесь на главную страницу "Цепочки правил";
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/import-rule-chain-3-pe.png,
        title: Цепочка правил импортирована.
'
%}

{% assign importRuleChainCE = '
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-rule-chain-import-1-ce.png,
        title: Перейдите на страницу "Цепочки правил" и нажмите кнопку "+" в правом верхнем углу экрана, а затем выберите опцию "Импортировать цепочку правил". Откроется всплывающее окно импорта панели инструментов. Загрузите файл JSON и нажмите кнопку "Импорт";
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-rule-chain-import-2-ce.png,
        title: Откроется импортированная цепочка правил. Нажмите кнопку "Применить изменения", чтобы сохранить цепочку правил. Затем вернитесь на главную страницу "Цепочки правил";
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-rule-chain-import-3-ce.png,
        title: Цепочка правил импортирована.
'
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importRuleChainPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=importRuleChainCE %}
{% endif %}

## Создание профиля устройства

Теперь мы готовы создать профиль устройства. Для этого выполните следующие действия:

{% assign createDeviceProfilePE = '
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/add-device-profiles-1-pe.png,
        title: Перейдите в раздел **Профили** > **Профили устройств** и нажмите кнопку **"Добавить"** > **"Создать новый профиль устройства"**;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/add-device-profiles-2-pe.png,
        title: Введите в поле **"Имя"** значение **"Teltonika routers"**. Выберите импортированную цепочку правил **"Teltonika routers"** из предыдущего шага;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/add-device-profiles-3-pe.png,
        title: Нажмите на вкладку **"Настройка транспорта"**. Выберите тип транспорта **MQTT** и измените значение **"Фильтр тем телеметрии"** с **"v1/devices/me/telemetry"** на **"RUT/"**. Нажмите кнопку **"Добавить"**;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/add-device-profiles-4-pe.png,
        title: Профиль устройства создан.
    '
%}

{% assign createDeviceProfileCE = '
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-device-profile-1-ce.png,
        title: Перейдите в раздел **Профили** > **Профили устройств** и нажмите кнопку **"Добавить"** > **"Создать новый профиль устройства"**;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-device-profile-2-ce.png,
        title: Введите в поле **"Имя"** значение **"Teltonika routers"**. Выберите импортированную цепочку правил **"Teltonika routers"** из предыдущего шага;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-device-profile-3-ce.png,
        title: Нажмите на вкладку **"Настройка транспорта"**. Выберите тип транспорта **MQTT** и измените значение **"Фильтр тем телеметрии"** с **"v1/devices/me/telemetry"** на **"RUT/"**. Нажмите кнопку **"Добавить"**;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-device-profile-4-ce.png,
        title: Профиль устройства создан.
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=createDeviceProfilePE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=createDeviceProfileCE %}
{% endif %}

## Создание устройства

Для простоты мы предоставим устройство вручную с помощью пользовательского интерфейса:

{% assign provisionDevicePE = '
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/add-device-1-pe.png,
        title: Откройте страницу **Устройства**. По умолчанию вы переходите в группу устройств **"Все"**. Нажмите значок **"+"** в правом верхнем углу таблицы, а затем выберите **"Добавить новое устройство"**;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/add-device-2-pe.png,
        title: Введите имя устройства. Например, **"Teltonika RUT955"**. Выберите созданный профиль устройства из предыдущего шага, в нашем случае **"Teltonika routers"**;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/add-device-3-pe.png,
        title: Нажмите на вкладку **"Учетные данные"**. Установите флажок **"Добавить учетные данные"** и выберите тип учетных данных **"MQTT Basic"**. Нажмите кнопку **"Сгенерировать"** в каждом поле и нажмите кнопку **"Добавить"**;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/add-device-4-pe.png,
        title: Устройство добавлено.
    '
%}

{% assign provisionDeviceCE = '
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-create-device-1-ce.png,
        title: Откройте страницу **Устройства**. По умолчанию вы переходите в группу устройств **"Все"**. Нажмите значок **"+"** в правом верхнем углу таблицы, а затем выберите **"Добавить новое устройство"**;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-create-device-2-ce.png,
        title: Введите имя устройства. Например, **"Teltonika RUT955"**. Выберите созданный профиль устройства из предыдущего шага, в нашем случае **"Teltonika routers"**;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-create-device-3-ce.png,
        title: Нажмите на вкладку **"Учетные данные"**. Установите флажок **"Добавить учетные данные"** и выберите тип учетных данных **"MQTT Basic"**. Нажмите кнопку **"Сгенерировать"** в каждом поле и нажмите кнопку **"Добавить"**;
    ===
        image: /images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-create-device-4-ce.png,
        title: Устройство добавлено.
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDevicePE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDeviceCE %}
{% endif %}

## Подключение шлюза

{% capture infoSettings %}
Убедитесь, что вы включили **"РАСШИРЕННЫЙ"** режим в правом верхнем углу, нажав кнопку под **"Режим"**.
{% endcapture %}
{% include templates/info-banner.md content=infoSettings %}

Согласно официальному руководству пользователя и этому руководству вы можете подключить шлюз к сети и получить доступ к WebUI двумя способами:

{% capture readytogodeviceconnectionstogglespec %}
Беспроводное соединение%,%wirelessConnection%,%templates/device-library/ready-to-go-devices/teltonika-rut955-wireless-connection-block.md%br%
Проводное соединение%,%wiredConnection%,%templates/device-library/ready-to-go-devices/teltonika-rut955-wired-connection-block.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="readytogodeviceconnectionstogglespec" toggle-spec=readytogodeviceconnectionstogglespec %}

Теперь вы можете настроить шлюз.

После подключения к {{deviceName}} вы можете изменить его IP-адрес, если хотите:
- Перейдите в раздел **Интерфейсы** > **Общие**;
- Нажмите кнопку **"Изменить"** в интерфейсе **"lan"**;
- Введите новый IP-адрес, который еще не используется другим устройством в вашей сети.

Теперь мы готовы настроить соединение MQTT и темы как для приема, так и для передачи данных, а также установить соединение Modbus.

Сначала настроим соединение Modbus. Как упоминалось выше, мы используем Siemens LOGO! с модулем AM2 RTD (используется для подключения PT100) - это идеальный выбор для быстрого, простого и компактного решения простых задач управления и регулирования. LOGO! давно зарекомендовал себя как интеллектуальный логический модуль в небольших проектах автоматизации.

В нашем случае в LOGO! Soft Comfort была создана следующая схема для считывания и подготовки данных:
<br><br>
![](/images/devices-library/ready-to-go-devices/teltonika-rut955/siemens-logo-diagram.png)
<br><br>

Не забудьте включить соединение TCP.
<br><br>
![](/images/devices-library/ready-to-go-devices/teltonika-rut955/siemens-logo-tcp-enable.png)
<br><br>

Кроме того, нам нужно добавить конфигурацию ведомого устройства Modbus. Для этого выполните следующие действия:
1. Перейдите в раздел **Сервисы** > **Modbus** > **Modbus TCP Master**;
2. Нажмите кнопку **"ДОБАВИТЬ"**;
3. Заполните все обязательные поля правильной информацией о вашем устройстве;
4. Прокрутите вниз до раздела **"КОНФИГУРАЦИЯ ЗАПРОСОВ"**;
5. Добавьте все регистры, из которых вы хотите считывать данные;
6. Нажмите кнопку **"Сохранить и применить"**.

В нашем случае у нас есть следующие настройки:

![](/images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-modbus-tcp-master.png)

Следующее, что нам нужно сделать, это настроить отправитель данных. Для этого выполните следующие действия:
1. Перейдите в раздел **Сервисы** > **Данные на сервер**;
2. Нажмите кнопку **"ДОБАВИТЬ"**;
3. Заполните все обязательные поля правильными учетными данными и другой информацией для доступа к брокеру;
4. Нажмите кнопку **"Сохранить и применить"**.

В нашем случае у нас есть следующие настройки:

![](/images/devices-library/ready-to-go-devices/teltonika-rut955/teltonika-rut-955-data-sender.png)

Если вы все сделали правильно, вы должны получить следующее сообщение MQTT:
```json
{"data": 299, "reg": 300003, "ts": 1696838802}
```

## Проверка данных на ThingsBoard

{% include /docs/devices-library/blocks/ready-to-go-devices/check-data-on-thingsboard-block.md %}

{% capture readytogodevicestogglespec %}
Импортированная панель инструментов%,%importedDashboard%,%templates/device-library/ready-to-go-devices/teltonika-rut955-imported-dashboard.md%br%
Новая панель инструментов%,%newDashboard%,%templates/device-library/ready-to-go-devices/gateway-new-dashboard.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="minicomputersDashboard" toggle-spec=readytogodevicestogglespec %}

## Заключение

С помощью знаний, изложенных в этом руководстве, вы можете легко подключить свой {{deviceName}} и использовать встроенную интеграцию для получения данных с устройств, подключенных к {{deviceName}}.

После подключения устройств к шлюзу вы сможете видеть и обрабатывать данные, поступающие с устройств, на ThingsBoard.

Изучите [документацию](/docs/{{page.docsPrefix}}){: target="_blank"} платформы, чтобы узнать больше о ключевых концепциях и функциях.