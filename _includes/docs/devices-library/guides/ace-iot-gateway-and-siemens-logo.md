{% assign deviceName = "ACE MQTT 4G GPS Gateway" %}
{% assign deviceVendorLink = "https://aceautomation.eu/product/ace-gtw-4g-mini-4g-wifi-modbus-gateway-mqtt-to-usb-modbus-rtu-master-gateway/" %}
{% assign controllerName = "Siemens LOGO!" %}
{% assign controllerVendorLink = "https://www.siemens.com/ua/uk/produkty/avtomatyzatsiya-promyslovosti/systemy-avtomatyzatsiyi/systemy-promyslovoyi-avtomatyzatsiyi-simatic/plc-kontrolery-simatic/lohichnyy-modul-logo.html" %}
{% assign prerequisites = '
- <a href="' | append: deviceVendorLink | append: '" target="_blank">' | append: deviceName | append: '</a>
- Modbus Controller (in our case, <a href="' | append: controllerVendorLink | append: '" target="_blank">' | append: controllerName | append: '</a>) '
 %}
{% assign thingsboardInstanceLink = "https://gridlinks.codingas.com" %}
{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
{% assign thingsboardInstanceLink = "https://gridlinks.codingas.com" %}
{% endif %}


## Введение
![{{deviceName}}](/images/devices-library/{{page.deviceImageFileName}}){: style="float: left; max-width: 200px; max-height: 200px; margin: 0px 10px 0px 0px"}
[Шлюз ACE Automation MQTT 4G GPS]({{deviceVendorLink}}){: target="_blank"} — это передовое устройство, которое революционизирует передачу данных и подключение для промышленных и IoT-приложений. Благодаря поддержке 4G этот шлюз обеспечивает надежную и высокоскоростную передачу данных по сотовым сетям, даже в удаленных местах. Он оснащен технологией GPS для отслеживания местоположения в режиме реального времени, что идеально подходит для управления активами и транспортными средствами. Благодаря MQTT в качестве протокола связи обмен данными становится легким и эффективным, что позволяет легко интегрироваться в существующие экосистемы IoT. Его надежная промышленная конструкция гарантирует надежную работу в суровых условиях, что делает его ценным решением для оптимизации операций и использования данных в режиме реального времени. Упростите подключение и управление данными с помощью шлюза ACE Automation MQTT 4G GPS.

## Предварительные условия

Чтобы продолжить работу с этим руководством, нам потребуется следующее:  
{{ prerequisites }}
- [Учетная запись GridLinks]({{thingsboardInstanceLink}}){: target="_blank"}  

## Импорт цепочки правил

Загрузите [цепочку правил ACE]({:target="_blank" download="ace-rule-chain.json"})(/docs/devices-library/resources/dashboards/ready-to-go-devices/ACE-rule-chain.json) и импортируйте ее.

Чтобы импортировать цепочку правил из файла JSON, вам следует:

{% assign importRuleChainPE = '
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-rule-chain-import-1-pe.png,
        title: Перейдите на страницу "Цепочки правил" и нажмите кнопку "+" в правом верхнем углу экрана, а затем выберите опцию "Импортировать цепочку правил". Откроется всплывающее окно импорта на панели инструментов. Загрузите файл JSON и нажмите кнопку "Импорт";
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-rule-chain-import-2-pe.png,
        title: Откроется импортированная цепочка правил. Нажмите кнопку "Применить изменения", чтобы сохранить цепочку правил. Затем вернитесь на главную страницу "Цепочки правил";
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-rule-chain-import-3-pe.png,
        title: Цепочка правил импортирована.
'
%}

{% assign importRuleChainCE = '
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-rule-chain-import-1-ce.png,
        title: Перейдите на страницу "Цепочки правил" и нажмите кнопку "+" в правом верхнем углу экрана, а затем выберите опцию "Импортировать цепочку правил". Откроется всплывающее окно импорта на панели инструментов. Загрузите файл JSON и нажмите кнопку "Импорт";
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-rule-chain-import-2-ce.png,
        title: Откроется импортированная цепочка правил. Нажмите кнопку "Применить изменения", чтобы сохранить цепочку правил. Затем вернитесь на главную страницу "Цепочки правил";
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-rule-chain-import-3-ce.png,
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
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-device-profile-1-pe.png,
		title: Перейдите в раздел **Профили** > **Профили устройств** и нажмите кнопку **"Добавить"** > **"Создать новый профиль устройства"**;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-device-profile-2-pe.png,
		title: Введите в поле **Имя** значение **"ACE routers"** и выберите импортированную цепочку правил **"ACE routers"** из предыдущего шага;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-device-profile-3-pe.png,
		title: Перейдите на вкладку **"Настройка транспорта"**, выберите тип транспорта **MQTT** и измените значение **Фильтр тем телеметрии** с **"v1/devices/me/telemetry"** на **"siemens/+"**, нажмите кнопку **"Добавить"**;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-device-profile-4-pe.png,
		title: Профиль устройства создан.
    '
%}

{% assign createDeviceProfileCE = '
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-device-profile-1-ce.png,
		title: Перейдите в раздел **Профили** > **Профили устройств** и нажмите кнопку **"Добавить"** > **"Создать новый профиль устройства"**;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-device-profile-2-ce.png,
		title: Введите в поле **Имя** значение **"ACE routers"** и выберите импортированную цепочку правил **"ACE routers"** из предыдущего шага;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-device-profile-3-ce.png,
		title: Перейдите на вкладку **"Настройка транспорта"**, выберите тип транспорта **MQTT** и измените значение **Фильтр тем телеметрии** с **"v1/devices/me/telemetry"** на **"siemens/+"**, нажмите кнопку **"Добавить"**;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-device-profile-4-ce.png,
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
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-create-device-1-pe.png,
		title: Откройте страницу **Устройства**. По умолчанию вы переходите в группу устройств **"Все"**. Нажмите значок **"+"** в правом верхнем углу таблицы, а затем выберите **"Добавить новое устройство"**;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-create-device-2-pe.png,
		title: Введите имя устройства. Например, **"ACE Gateway"**. Выберите созданный профиль устройства из предыдущего шага, в нашем случае **"ACE routers"**;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-create-device-3-pe.png,
		title: Перейдите на вкладку **"Учетные данные"**. Установите флажок **"Добавить учетные данные"** и выберите тип учетных данных **"MQTT Basic"**. Нажмите кнопку **"Сгенерировать"** в каждом поле. Нажмите кнопку **"Добавить"**;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-create-device-4-pe.png,
		title: Устройство добавлено.
    '
%}

{% assign provisionDeviceCE = '
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-create-device-1-ce.png,
		title: Откройте страницу **Устройства**. По умолчанию вы переходите в группу устройств **"Все"**. Нажмите значок **"+"** в правом верхнем углу таблицы, а затем выберите **"Добавить новое устройство"**;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-create-device-2-ce.png,
		title: Введите имя устройства. Например, **"ACE Gateway"**. Выберите созданный профиль устройства из предыдущего шага, в нашем случае **"ACE routers"**;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-create-device-3-ce.png,
		title: Перейдите на вкладку **"Учетные данные"**. Установите флажок **"Добавить учетные данные"** и выберите тип учетных данных **"MQTT Basic"**. Нажмите кнопку **"Сгенерировать"** в каждом поле. Нажмите кнопку **"Добавить"**;
    ===
        image: /images/devices-library/ready-to-go-devices/ace-iot-gateway/ace-create-device-4-ce.png,
		title: Устройство добавлено.
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDevicePE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=provisionDeviceCE %}
{% endif %}

## Подключение шлюза

Согласно официальному руководству пользователя и этому руководству, вы можете подключить шлюз к сети и получить доступ к веб-интерфейсу двумя способами:
{% capture readytogodeviceconnectionstogglespec %}
Беспроводное соединение%,%wirelessConnection%,%templates/device-library/ready-to-go-devices/ace-gateway-wireless-connection-block.md%br%
Проводное соединение%,%wiredConnection%,%templates/device-library/ready-to-go-devices/ace-gateway-wired-connection-block.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="readytogodeviceconnectionstogglespec" toggle-spec=readytogodeviceconnectionstogglespec %}

Теперь вы можете настроить шлюз.

После подключения к ACE-GTW-MQTT вы можете изменить его IP-адрес, если хотите:
* **Сеть** > **Интерфейсы**;
* Нажмите **"Изменить"** интерфейс LAN;
* Введите новый IP-адрес, который еще не используется другим устройством в вашей сети.

{% capture info %}
<body>
  <p>
    <b style="color:red">ВНИМАНИЕ:</b>
    <span style="color:black">Не забудьте изменить пароль по умолчанию.</span>
  </p>
</body>
{% endcapture %}
{% include templates/warn-banner.md content=info %}

Теперь мы готовы настроить соединение MQTT, темы для передачи данных и установить соединение Modbus.

Сначала настроим соединение Modbus. Как упоминалось выше, мы используем Siemens LOGO! с модулем AM2 RTD (используется для подключения PT100) - это идеальный выбор для быстрого, простого и компактного решения простых задач управления и регулирования. LOGO! давно зарекомендовал себя как интеллектуальный логический модуль в небольших проектах автоматизации.

Выполните следующие действия:
* Перейдите в раздел **Шлюз** > **Настройка MQTT** > **СПИСОК СТАНЦИЙ ETHERNET** (в разделе MQTT Broker);
* Заполните все обязательные поля правильной информацией о вашем устройстве;
* Нажмите кнопку **"Сохранить и применить"**.

В нашем случае у нас есть следующие настройки:

![](/images/devices-library/ready-to-go-devices/ace-iot-gateway/modbus-tcp-settings.png)

Чтобы настроить соединение MQTT, выполните следующие действия:
* Перейдите в раздел **Шлюз** > **Настройка MQTT** > **MQTT Broker** (вкладка);
* Заполните все обязательные поля правильными учетными данными и другой информацией для доступа к брокеру;
* Нажмите кнопку **"Сохранить и применить"**.

![](/images/devices-library/ready-to-go-devices/ace-iot-gateway/mqtt-broker-settings.png)

Следующее, что нам нужно сделать, это настроить темы MQTT для приема и отправки данных:
* Перейдите в раздел **Шлюз** > **Настройка MQTT** > **MQTT Broker** (вкладка);
* Прокрутите вниз до раздела **"СПИСОК ТЕМ MQTT: публикация и подписка на темы MQTT"**;
* Добавьте все темы для публикации данных;
* Добавьте все темы подписки для получения данных;
* Нажмите кнопку **"Сохранить и применить"**.

В случае Siemens LOGO! у нас есть следующий список тем:

![](/images/devices-library/ready-to-go-devices/ace-iot-gateway/topic-list.png)

Если вы также используете Siemens LOGO!, вы можете использовать следующую конфигурацию:
{% capture gatewayCode %}
config mqttconfig
	option baudrate '9600'
	option parity 'None'
	option databits '8'
	option stopbits '1'
	option timeout '3'
	option interframe '1'
	option projectname 'ACE'
	option usbport '/dev/ttyACM0'
	option gnssusbport '/dev/ttyUSB1'
	option port_p '1883'
	option optioncertif '0'
	option advancedmqtt '0'
	option loginpassword '1'
	option optiondebugmqtt '0'
	option qos_q '1'
	option host_h 'thingsboard.cloud'
	option username_u 'YOUR_USERNAME'
	option password_P 'YOUR_PASSWORD'
	option clientid 'YOUR_CLIENTID'

config stations
	option station_nb '2'
	option station_ip_address '192.168.0.3'
	option station_ip_port '510'

config topics
	option sub '0'
	option slaveid '1'
	option active '1'
	option station_mbid '2'
	option poll '10'
	option deadband '-1'
	option regtype 'bit'
	option address '8193'
	option payload '@'
	option topic_t 'siemens/Q1'
	option payload_bit '{"Q1": @[OFF;ON]}'

config topics
	option payload '@'
	option sub '0'
	option slaveid '1'
	option active '1'
	option topic_t 'siemens/Q2'
	option payload_bit '{"Q2": @[OFF;ON]}'
	option station_mbid '2'
	option regtype 'bit'
	option address '8194'
	option poll '10'
	option deadband '-1'

config topics
	option payload '@'
	option sub '0'
	option slaveid '1'
	option active '1'
	option topic_t 'siemens/Q3'
	option payload_bit '{"Q3": @[OFF;ON]}'
	option station_mbid '2'
	option regtype 'bit'
	option address '8195'
	option poll '10'
	option deadband '-1'

config topics
	option payload '@'
	option sub '0'
	option slaveid '1'
	option active '1'
	option topic_t 'siemens/Q4'
	option payload_bit '{"Q4": @[OFF;ON]}'
	option station_mbid '2'
	option regtype 'bit'
	option address '8196'
	option poll '10'
	option deadband '-1'
{% endcapture %}
{% include code-toggle.liquid code=gatewayCode params="conf|.copy-code.expandable-20" %}

## Проверка данных на GridLinks

{% include /docs/devices-library/blocks/ready-to-go-devices/check-data-on-thingsboard-block.md %}

{% capture readytogodevicestogglespec %}
Импортированная панель%,%importedDashboard%,%templates/device-library/ready-to-go-devices/ace-gateway-imported-dashboard.md%br%
Новая панель%,%newDashboard%,%templates/device-library/ready-to-go-devices/gateway-new-dashboard.md{% endcapture %}

{% include content-toggle.liquid content-toggle-id="minicomputersDashboard" toggle-spec=readytogodevicestogglespec %}

## Заключение

С помощью знаний, изложенных в этом руководстве, вы можете легко подключить свой шлюз ACE Automation MQTT 4G GPS и использовать встроенную интеграцию для получения данных с устройств, подключенных к шлюзу ACE Automation MQTT 4G GPS.

После подключения устройств к шлюзу вы сможете видеть и обрабатывать данные, поступающие с устройств, на GridLinks.

Изучите [документацию](/docs/{{page.docsPrefix}}){: target="_blank"} платформы, чтобы узнать больше о ключевых концепциях и функциях.