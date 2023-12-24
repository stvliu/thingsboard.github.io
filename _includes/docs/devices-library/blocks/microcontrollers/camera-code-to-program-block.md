现在是时候对电路板进行编程以连接到 ThingsBoard。

为此，您可以使用以下代码。它包含此指南所需的所有功能。

{% capture demoExample %}
如果您想使用 [**demo.thingsboard.io**](https://demo.thingsboard.io)，请注意它对 MQTT 消息的大小有限制 - **每条消息 1024 字节**。

在这种情况下，您可以降低分辨率、质量并裁剪编码后的照片。

为此，您可以将变量 **DEMO_MODE** 的值更改为 **1**：

<code>
#define DEMO_MODE 1  
</code>

{% endcapture %}

{% unless page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
{% include templates/warn-banner.md content=demoExample %}
{% endunless %}

```cpp
#include <Arduino_MQTT_Client.h>
#include "esp_camera.h"
#include <WiFi.h>
#include "soc/soc.h"
#include "soc/rtc_cntl_reg.h"

#define THINGSBOARD_ENABLE_DYNAMIC 1

#include <ThingsBoard.h>
#include <esp_heap_caps.h>

extern "C" {
#include "libb64/cencode.h"
}

constexpr char WIFI_SSID[] = "YOUR_WIFI_SSID";
constexpr char WIFI_PASSWORD[] = "YOUR_WIFI_PASSWORD";

// See https://thingsboard.io/docs/getting-started-guides/helloworld/
// to understand how to obtain an access token
constexpr char TOKEN[] = "YOUR_ACCESS_TOKEN";

// Thingsboard we want to establish a connection too
constexpr char THINGSBOARD_SERVER[] = "{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}thingsboard.cloud{% else %}demo.thingsboard.io{% endif %}";
// MQTT port used to communicate with the server, 1883 is the default unencrypted MQTT port.
constexpr uint16_t THINGSBOARD_PORT = 1883U;

// Maximum size packets will ever be sent or received by the underlying MQTT client,
// if the size is to small messages might not be sent or received messages will be discarded
constexpr size_t MAX_MESSAGE_SIZE = 100U * 1024;

// Baud rate for the debugging serial connection.
// If the Serial output is mangled, ensure to change the monitor speed accordingly to this variable
constexpr uint32_t SERIAL_DEBUG_BAUD = 115200U;

// Definitions for camera pins
#define PWDN_GPIO_NUM -1
#define RESET_GPIO_NUM 15
#define XCLK_GPIO_NUM 27
#define SIOD_GPIO_NUM 25
#define SIOC_GPIO_NUM 23
#define Y9_GPIO_NUM 19
#define Y8_GPIO_NUM 36
#define Y7_GPIO_NUM 18
#define Y6_GPIO_NUM 39
#define Y5_GPIO_NUM 5
#define Y4_GPIO_NUM 34
#define Y3_GPIO_NUM 35
#define Y2_GPIO_NUM 32
#define VSYNC_GPIO_NUM 22
#define HREF_GPIO_NUM 26
#define PCLK_GPIO_NUM 21

// Initialize underlying client, used to establish a connection
WiFiClient wifiClient;
// Initalize the Mqtt client instance
Arduino_MQTT_Client mqttClient(wifiClient);
// Initialize ThingsBoard instance with the maximum needed buffer size
ThingsBoard tb(mqttClient, MAX_MESSAGE_SIZE);

// Attribute names for attribute request and attribute updates functionality

constexpr char BLINKING_INTERVAL_ATTR[] = "blinkingInterval";
constexpr char LED_MODE_ATTR[] = "ledMode";
constexpr char LED_STATE_ATTR[] = "ledState";
constexpr char PICTURE_ATTR[] = "photo";

// handle led state and mode changes
volatile bool attributesChanged = false;

// LED modes: 0 - continious state, 1 - blinking
volatile int ledMode = 0;

// Current led state
volatile bool ledState = false;

// Settings for interval in blinking mode
constexpr uint16_t BLINKING_INTERVAL_MS_MIN = 10U;
constexpr uint16_t BLINKING_INTERVAL_MS_MAX = 60000U;
volatile uint16_t blinkingInterval = 1000U;

uint32_t previousStateChange;

// For telemetry
constexpr int16_t telemetrySendInterval = 2000U;
uint32_t previousDataSend;

// Picture buffer
char *imageBuffer;

// Flag to send a picture
volatile bool sendPicture = false;

// List of shared attributes for subscribing to their updates
constexpr std::array<const char *, 2U> SHARED_ATTRIBUTES_LIST = {
  LED_STATE_ATTR,
  BLINKING_INTERVAL_ATTR
};

// List of client attributes for requesting them (Using to initialize device states)
constexpr std::array<const char *, 1U> CLIENT_ATTRIBUTES_LIST = {
  LED_MODE_ATTR
};

/// @brief Initalizes WiFi connection,
// will endlessly delay until a connection has been successfully established
void InitWiFi() {
  Serial.println("Connecting to AP ...");
  // Attempting to establish a connection to the given WiFi network
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    // Delay 500ms until a connection has been succesfully established
    delay(500);
    Serial.println(WiFi.status());
    Serial.println(WL_CONNECTED);
    Serial.println(".");
  }
  Serial.println("Connected to AP");
}

/// @brief Reconnects the WiFi uses InitWiFi if the connection has been removed
/// @return Returns true as soon as a connection has been established again
const bool reconnect() {
  if (WiFi.status() == WL_CONNECTED) {
    return true;
  }

  // If we aren't establish a new connection to the given WiFi network
  InitWiFi();
  return true;
}

bool initCamera() {
  camera_config_t config;
  config.ledc_channel = LEDC_CHANNEL_0;
  config.ledc_timer = LEDC_TIMER_0;
  config.pin_d0 = Y2_GPIO_NUM;
  config.pin_d1 = Y3_GPIO_NUM;
  config.pin_d2 = Y4_GPIO_NUM;
  config.pin_d3 = Y5_GPIO_NUM;
  config.pin_d4 = Y6_GPIO_NUM;
  config.pin_d5 = Y7_GPIO_NUM;
  config.pin_d6 = Y8_GPIO_NUM;
  config.pin_d7 = Y9_GPIO_NUM;
  config.pin_xclk = XCLK_GPIO_NUM;
  config.pin_pclk = PCLK_GPIO_NUM;
  config.pin_vsync = VSYNC_GPIO_NUM;
  config.pin_href = HREF_GPIO_NUM;
  config.pin_sscb_sda = SIOD_GPIO_NUM;
  config.pin_sscb_scl = SIOC_GPIO_NUM;
  config.pin_pwdn = PWDN_GPIO_NUM;
  config.pin_reset = RESET_GPIO_NUM;
  config.xclk_freq_hz = 20000000;
  config.pixel_format = PIXFORMAT_JPEG;
  config.fb_count = 1;{% unless page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
  if (DEMO_MODE == 1) {
    config.frame_size = FRAMESIZE_96X96;
    config.jpeg_quality = 63;
  } else { {% endunless %}
  config.frame_size = FRAMESIZE_240X240;
  config.jpeg_quality = 10;{% unless page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
  }{% endunless %}

  esp_err_t err = esp_camera_init(&config);
  if (err != ESP_OK) {
    Serial.printf("Camera init failed with error 0x%x", err);
    return false;
  }

  sensor_t *s = esp_camera_sensor_get();
  // initial sensors are flipped vertically and colors are a bit saturated
  s->set_vflip(s, 1);        // flip it back
  s->set_brightness(s, 1);   // up the brightness just a bit
  s->set_saturation(s, -2);  // lower the saturation

  return true;
}

bool captureImage() {
  camera_fb_t *fb = NULL;
  fb = esp_camera_fb_get();
  if (!fb) {
    return false;
  }
  encode((uint8_t *)fb->buf, fb->len);
  esp_camera_fb_return(fb);
  return true;
}

void encode(const uint8_t *data, size_t length) { {% unless page.docsPrefix == "pe/" or page.docsPrefix == "paas/" %}
  if (DEMO_MODE == 1) {
    length = 756;
  }{% endunless %} 
  size_t size = base64_encode_expected_len(length) + 1;
  base64_encodestate _state;
  base64_init_encodestate(&_state);
  int len = base64_encode_block((char *)&data[0], length, &imageBuffer[0], &_state);
  len = base64_encode_blockend((imageBuffer + len), &_state);
}

/// @brief Processes function for RPC call "setLedMode"
/// RPC_Data is a JSON variant, that can be queried using operator[]
/// See https://arduinojson.org/v5/api/jsonvariant/subscript/ for more details
/// @param data Data containing the rpc data that was called and its current value
/// @return Response that should be sent to the cloud. Useful for getMethods
RPC_Response processSetLedMode(const RPC_Data &data) {
  Serial.println("Received the set led state RPC method");

  // Process data
  int new_mode = data;

  Serial.print("Mode to change: ");
  Serial.println(new_mode);

  if (new_mode != 0 && new_mode != 1) {
    return RPC_Response("error", "Unknown mode!");
  }

  ledMode = new_mode;

  attributesChanged = true;

  // Returning current mode
  return RPC_Response("newMode", (int)ledMode);
}

/// @brief Processes function for RPC call "setLedMode"
/// RPC_Data is a JSON variant, that can be queried using operator[]
/// See https://arduinojson.org/v5/api/jsonvariant/subscript/ for more details
/// @param data Data containing the rpc data that was called and its current value
/// @return Response that should be sent to the cloud. Useful for getMethods
RPC_Response processTakePicture(const RPC_Data &data) {
  Serial.println("Received the take picture RPC method");

  if (!captureImage()) {
    return RPC_Response("error", "Cannot take a picture!");
  }

  sendPicture = true;

  // Returning current mode
  return RPC_Response("size", strlen(imageBuffer));
}

// Optional, keep subscribed shared attributes empty instead,
// and the callback will be called for every shared attribute changed on the device,
// instead of only the one that were entered instead
const std::array<RPC_Callback, 2U> callbacks = {
  RPC_Callback{ "setLedMode", processSetLedMode },
  RPC_Callback{ "takePicture", processTakePicture }
};

/// @brief Update callback that will be called as soon as one of the provided shared attributes changes value,
/// if none are provided we subscribe to any shared attribute change instead
/// @param data Data containing the shared attributes that were changed and their current value
void processSharedAttributes(const Shared_Attribute_Data &data) {
  for (auto it = data.begin(); it != data.end(); ++it) {
    if (strcmp(it->key().c_str(), BLINKING_INTERVAL_ATTR) == 0) {
      const uint16_t new_interval = it->value().as<uint16_t>();
      if (new_interval >= BLINKING_INTERVAL_MS_MIN && new_interval <= BLINKING_INTERVAL_MS_MAX) {
        blinkingInterval = new_interval;
        Serial.print("Updated blinking interval to: ");
        Serial.println(new_interval);
      }
    } else if (strcmp(it->key().c_str(), LED_STATE_ATTR) == 0) {
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
  WRITE_PERI_REG(RTC_CNTL_BROWN_OUT_REG, 0);
  ledcAttachPin(4, 4);
  ledcSetup(4, 5000, 8);
  
  imageBuffer = (char *)ps_malloc(50U * 1024);
  Serial.begin(SERIAL_DEBUG_BAUD);
  Serial.println("Camera initialization...");
  if (!initCamera()) {
    Serial.println("Camera initialization failed!");
    ESP.restart();
  }

  pinMode(LED_BUILTIN, OUTPUT);
  delay(1000);
  InitWiFi();
  tb.connect(THINGSBOARD_SERVER, TOKEN, THINGSBOARD_PORT);
  tb.RPC_Subscribe(callbacks.cbegin(), callbacks.cend());
  tb.Shared_Attributes_Subscribe(attributes_callback);
  tb.Shared_Attributes_Request(attribute_shared_request_callback);
  tb.Client_Attributes_Request(attribute_client_request_callback);
}

void loop() {
  delay(10);

  if (!reconnect()) {
    return;
  }

  if (!tb.connected()) {
      // Connect to the ThingsBoard
      Serial.print("Connecting to: ");
      Serial.print(THINGSBOARD_SERVER);
      Serial.print(" with token ");
      Serial.println(TOKEN);
    if (!tb.connect(THINGSBOARD_SERVER, TOKEN, THINGSBOARD_PORT)) {
      Serial.println("Failed to connect");
      return;
    }
  Serial.println("Connection to server successful");
  // Sending a MAC address as an attribute
  tb.sendAttributeData("macAddress", WiFi.macAddress().c_str());

  Serial.println("Subscribing for RPC...");
  // Perform a subscription. All consequent data processing will happen in
  // processSetLedState() and processSetLedMode() functions,
  // as denoted by callbacks array.
  if (!tb.RPC_Subscribe(callbacks.cbegin(), callbacks.cend())) {
    Serial.println("Failed to subscribe for RPC");
    return;
  }

  if (!tb.Shared_Attributes_Subscribe(attributes_callback)) {
    Serial.println("Failed to subscribe for shared attribute updates");
    return;
  }

  Serial.println("Subscribe done");

  // Request current states of shared attributes
  if (!tb.Shared_Attributes_Request(attribute_shared_request_callback)) {
    Serial.println("Failed to request for shared attributes");
    return;
  }

  // Request current states of client attributes
  if (!tb.Client_Attributes_Request(attribute_client_request_callback)) {
    Serial.println("Failed to request for client attributes");
    return;
  }
  }

  if (sendPicture) {
    tb.sendTelemetryData(PICTURE_ATTR, imageBuffer);
    sendPicture = false;
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

  // Sending telemetry every telemetrySendInterval time
  if (millis() - previousDataSend > telemetrySendInterval) {
    previousDataSend = millis();
    tb.sendTelemetryData("temperature", random(10, 20));
    tb.sendAttributeData("rssi", WiFi.RSSI());
    tb.sendAttributeData("channel", WiFi.channel());
    tb.sendAttributeData("ssid", WIFI_SSID);
    tb.sendAttributeData("localIp", WiFi.localIP().toString().c_str());
  }

  tb.loop();
}
```