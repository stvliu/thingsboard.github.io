现在是时候对电路板进行编程以连接到 GridLinks。

为此，您可以使用下面的代码。它包含本指南所需的所有功能。


```cpp
#include <WiFi.h>
#include <Arduino_MQTT_Client.h>
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

#define THINGSBOARD_ENABLE_PSRAM 0
#define THINGSBOARD_ENABLE_DYNAMIC 1

#include <ThingsBoard.h>

#ifndef LED_BUILTIN
#define LED_BUILTIN 99
#endif

#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);

constexpr char WIFI_SSID[] = "YOUR_WIFI_SSID";
constexpr char WIFI_PASSWORD[] = "YOUR_WIFI_PASSWORD";

// 请参阅 https://thingsboard.io/docs/getting-started-guides/helloworld/
// 以了解如何获取访问令牌
constexpr char TOKEN[] = "YOUR_ACCESS_TOKEN";

// 我们希望建立连接的 Thingsboard
constexpr char THINGSBOARD_SERVER[] = "{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}thingsboard.cloud{% else %}demo.thingsboard.io{% endif %}";
// 用于与服务器通信的 MQTT 端口，1883 是默认的未加密 MQTT 端口。
constexpr uint16_t THINGSBOARD_PORT = 1883U;

// 底层 MQTT 客户端将发送或接收的最大数据包大小，
// 如果大小太小，则可能不会发送消息或将丢弃接收到的消息
constexpr uint32_t MAX_MESSAGE_SIZE = 1024U;

// 用于调试串行连接的波特率。
// 如果串行输出被破坏，请确保相应地更改监视器速度以适应此变量
constexpr uint32_t SERIAL_DEBUG_BAUD = 115200U;

// 初始化底层客户端，用于建立连接
WiFiClient wifiClient;
// 初始化 Mqtt 客户端实例
Arduino_MQTT_Client mqttClient(wifiClient);
// 使用最大所需缓冲区大小初始化 GridLinks 实例
ThingsBoard tb = ThingsBoard(mqttClient, MAX_MESSAGE_SIZE, false, 1024);

// 用于属性请求和属性更新功能的属性名称

constexpr char BLINKING_INTERVAL_ATTR[] = "blinkingInterval";
constexpr char LED_MODE_ATTR[] = "ledMode";
constexpr char LED_STATE_ATTR[] = "ledState";
constexpr char SCREEN_TEXT_ATTR[] = "screenText";

String screenText;
volatile bool screenTextUpdated;

// 处理 led 状态和模式更改
volatile bool attributesChanged = false;

// LED 模式：0 - 连续状态，1 - 闪烁
volatile int ledMode = 0;

// 当前 led 状态
volatile bool ledState = false;

// 闪烁模式下的间隔设置
constexpr uint16_t BLINKING_INTERVAL_MS_MIN = 10U;
constexpr uint16_t BLINKING_INTERVAL_MS_MAX = 60000U;
volatile uint16_t blinkingInterval = 1000U;

uint32_t previousStateChange;

// 用于遥测
constexpr int16_t telemetrySendInterval = 2000U;
uint32_t previousDataSend;

// 共享属性列表，用于订阅其更新
constexpr std::array<const char *, 3U> SHARED_ATTRIBUTES_LIST = {
  LED_STATE_ATTR,
  BLINKING_INTERVAL_ATTR,
  SCREEN_TEXT_ATTR
};

// 客户端属性列表，用于请求它们（用于初始化设备状态）
constexpr std::array<const char *, 1U> CLIENT_ATTRIBUTES_LIST = {
  LED_MODE_ATTR
};

/// @brief 初始化 WiFi 连接，
// 将无限期延迟，直到成功建立连接
void InitWiFi() {
  Serial.println("Connecting to AP ...");
  // 尝试建立与给定 WiFi 网络的连接
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    // 延迟 500 毫秒，直到成功建立连接
    delay(500);
    Serial.print(".");
  }
  Serial.println("Connected to AP");
}

/// @brief 如果已删除连接，则重新连接 WiFi，使用 InitWiFi
/// @return 一旦重新建立连接，就返回 true
const bool reconnect() {
  // 检查以确保我们尚未连接
  const wl_status_t status = WiFi.status();
  if (status == WL_CONNECTED) {
    return true;
  }

  // 如果我们没有建立与给定 WiFi 网络的新连接
  InitWiFi();
  return true;
}


/// @brief 处理 RPC 调用 "setLedMode" 的函数
/// RPC_Data 是一个 JSON 变体，可以使用运算符 [] 查询
/// 有关更多详细信息，请参阅 https://arduinojson.org/v5/api/jsonvariant/subscript/
/// @param data 包含被调用的 rpc 数据及其当前值的数据
/// @return 应发送到云的响应。对 getMethods 有用
RPC_Response processSetLedMode(const RPC_Data &data) {
  Serial.println("Received the set led state RPC method");

  // 处理数据
  int new_mode = data;

  Serial.print("Mode to change: ");
  Serial.println(new_mode);

  if (new_mode != 0 && new_mode != 1) {
    return RPC_Response("error", "Unknown mode!");
  }

  ledMode = new_mode;

  attributesChanged = true;

  // 返回当前模式
  return RPC_Response("newMode", (int)ledMode);
}


// 可选，改为保持订阅的共享属性为空，
// 然后将为设备上更改的每个共享属性调用回调，
// 而不仅仅是输入的属性
const std::array<RPC_Callback, 1U> callbacks = {
  RPC_Callback{ "setLedMode", processSetLedMode }
};


/// @brief 将在提供的一个共享属性值更改时调用的更新回调，
/// 如果没有提供任何属性，我们改为订阅任何共享属性更改
/// @param data 包含已更改的共享属性及其当前值的数据
void processSharedAttributes(const Shared_Attribute_Data &data) {
  for (auto it = data.begin(); it != data.end(); ++it) {
    if (strcmp(it->key().c_str(), BLINKING_INTERVAL_ATTR) == 0) {
      const uint16_t new_interval = it->value().as<uint16_t>();
      if (new_interval >= BLINKING_INTERVAL_MS_MIN && new_interval <= BLINKING_INTERVAL_MS_MAX) {
        blinkingInterval = new_interval;
        Serial.print("Updated blinking interval to: ");
        Serial.println(new_interval);
      }
    } else if (strcmp(it->key().c_str(), SCREEN_TEXT_ATTR) == 0) {
      screenText = String(it->value().as<const char*>());
      screenText.replace("\\n", "\n");
      screenText.replace("\\t", "    ");
      screenTextUpdated = true;
    } else if(strcmp(it->key().c_str(), LED_STATE_ATTR) == 0) {
      ledState = it->value().as<bool>();
      digitalWrite(LED_BUILTIN, ledState ? HIGH : LOW);
      Serial.print("Updated state to: ");
      Serial.println(ledState);
    }
  }
  attributesChanged = true;
}

void processClientAttributes(const Shared_Attribute_Data &data) {
  for (auto it = data.begin(); it != data.end(); ++it) {
    if (strcmp(it->key().c_str(), LED_MODE_ATTR) == 0) {
      const uint16_t new_mode = it->value().as<uint16_t>();
      ledMode = new_mode;
    }
  }
}

const Shared_Attribute_Callback attributes_callback(&processSharedAttributes, SHARED_ATTRIBUTES_LIST.cbegin(), SHARED_ATTRIBUTES_LIST.cend());
const Attribute_Request_Callback attribute_shared_request_callback(&processSharedAttributes, SHARED_ATTRIBUTES_LIST.cbegin(), SHARED_ATTRIBUTES_LIST.cend());
const Attribute_Request_Callback attribute_client_request_callback(&processClientAttributes, CLIENT_ATTRIBUTES_LIST.cbegin(), CLIENT_ATTRIBUTES_LIST.cend());

void setup() {
  // 初始化用于调试的串行连接
  Serial.begin(115200);
  pinMode(LED_BUILTIN, OUTPUT);
  Wire.begin(5, 4);
  if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C, false, false)) { 
    Serial.println("Cannot initialize screen!");
  }
  delay(2000);
  display.clearDisplay();
  display.display();  
  InitWiFi();
}

void loop() {
  delay(10);

  if (!reconnect()) {
    return;
  }

  if (!tb.connected()) {
    // 连接到 GridLinks
    Serial.print("Connecting to: ");
    Serial.print(THINGSBOARD_SERVER);
    Serial.print(" with token ");
    Serial.println(TOKEN);
    if (!tb.connect(THINGSBOARD_SERVER, TOKEN, THINGSBOARD_PORT)) {
      Serial.println("Failed to connect");
      delay(2000);
      return;
    }
    // 将 MAC 地址作为属性发送
    tb.sendAttributeData("macAddress", WiFi.macAddress().c_str());
    
    Serial.println("Subscribing for RPC...");
    // 执行订阅。所有后续数据处理都将在
    // processSetLedState() 和 processSetLedMode() 函数中进行，
    // 如回调数组所示。
    if (!tb.RPC_Subscribe(callbacks.cbegin(), callbacks.cend())) {
      Serial.println("Failed to subscribe for RPC");
      return;
    }

    if (!tb.Shared_Attributes_Subscribe(attributes_callback)) {
      Serial.println("Failed to subscribe for shared attribute updates");
      return;
    }

    Serial.println("Subscribe done");

    // 请求共享属性的当前状态
    if (!tb.Shared_Attributes_Request(attribute_shared_request_callback)) {
      Serial.println("Failed to request for shared attributes");
      return;
    }

    // 请求客户端属性的当前状态
    if (!tb.Client_Attributes_Request(attribute_client_request_callback)) {
      Serial.println("Failed to request for client attributes");
      return;
    }
  }

  if (screenTextUpdated) {
    screenTextUpdated = false;
    display.clearDisplay();
    display.setTextSize(1);
    display.setTextColor(SSD1306_WHITE);
    display.setCursor(0, 0);
    display.println(screenText);
    display.display();
    Serial.println("Screen updated!");
  }

  if (attributesChanged) {
    attributesChanged = false;
    if (ledMode == 0) {
      previousStateChange = millis();
    }
    tb.sendTelemetryData(LED_MODE_ATTR, ledMode);
    tb.sendTelemetryData(LED_STATE_ATTR, ledState);
    tb.sendAttributeData(LED_MODE_ATTR, ledMode);
    tb.sendAttributeData(LED_STATE_ATTR, ledState);
  }

  if (ledMode == 1 && millis() - previousStateChange > blinkingInterval) {
    previousStateChange = millis();
    ledState = !ledState;
    digitalWrite(LED_BUILTIN, ledState);
    tb.sendTelemetryData(LED_STATE_ATTR, ledState);
    tb.sendAttributeData(LED_STATE_ATTR, ledState);
    if (LED_BUILTIN == 99) {
      Serial.print("LED state changed to: ");
      Serial.println(ledState);
    }
  }

  // 每隔 telemetrySendInterval 时间发送遥测数据
  if (millis() - previousDataSend > telemetrySendInterval) {
    previousDataSend = millis();
    tb.sendTelemetryData("temperature", random(10, 20));
    tb.sendAttributeData("rssi", WiFi.RSSI());
    tb.sendAttributeData("channel", WiFi.channel());
    tb.sendAttributeData("bssid", WiFi.BSSIDstr().c_str());
    tb.sendAttributeData("localIp", WiFi.localIP().toString().c_str());
    tb.sendAttributeData("ssid", WiFi.SSID().c_str());
  }

  tb.loop();
}

```