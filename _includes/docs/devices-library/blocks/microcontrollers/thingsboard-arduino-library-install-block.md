要安装 GridLinks Arduino SDK，我们需要执行以下步骤：

{% assign libraryInstallation = '
    ===
        image: /images/devices-library/basic/arduino-ide/tools-manage-libraries.png
        title: 转到“**工具**”选项卡，然后单击“**管理库**”。
    ===
        image: /images/devices-library/basic/arduino-ide/manage-libraries-thingsboard.png
        title: 在搜索框中输入“**ThingsBoard**”，然后按找到的库的“***安装***”按钮。
' 
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=libraryInstallation %}    

{% capture libraryVersion %}

所有提供的代码示例都需要 ThingsBoard 库版本 {% if wifininaInstallationRequired == "true" %}**0.10.2**{% else %}**0.11.1** 或更高版本{% endif %}。  

{% endcapture %}

{% include templates/warn-banner.md content=libraryVersion %}

{% if mbedtlsInstallationRequired == "true" %}

此外，对于基于 ESP8266 芯片的电路板，我们应该安装“mbedtls”库。  

{% assign mbedtlsInstallation='
    ===
        image: /images/devices-library/basic/arduino-ide/install-mbedtls.png,
        title: 在库搜索字段中输入“**mbedtls**”，然后安装库 - “***Seeed_Arduino_mbedtls by Peter Yang***”
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=mbedtlsInstallation %}

{% endif %}

{% if OLEDInstallationRequired == "true" %}

此外，要控制显示，我们应该安装 Adafruit SSD1306 库。  

{% assign oledInstallation='
    ===
        image: /images/devices-library/basic/arduino-ide/install-adafruit-ssd1306.png,
        title: 在库搜索字段中输入“**Adafruit SSD1306**”，然后安装库 - “**Adafruit SSD1306 by Adafruit**”
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=oledInstallation %}

{% endif %}

{% if wifininaInstallationRequired == "true" %}

此外，对于基于 RP2040 芯片的电路板，我们应该安装“WiFiNINA”库。  

{% assign wifininaInstallation='
    ===
        image: /images/devices-library/basic/arduino-ide/install-wifinina.png,
        title: 在库搜索字段中输入“**WiFiNINA**”，然后安装库 - “**WiFiNINA by Arduino**”
'%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=wifininaInstallation %}

{% endif %}

此时，我们已经安装了所有必需的库和工具。