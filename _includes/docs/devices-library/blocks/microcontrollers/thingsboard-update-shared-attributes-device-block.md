我们还可以使用 [共享属性](/docs/{{page.docsPrefix}}user-guide/attributes/#shared-attributes) 更新功能来更改闪烁周期。

{% assign updateLedBlinkingPeriod = '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-change-blinking-mode-1.png,
        title: 要更改闪烁周期，我们只需要更改仪表板上的值。
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-blinking-interval-change.png,
        title: 通过按复选标记应用后，您将看到一条确认消息。
'
%} 

{% include images-gallery.liquid showListImageTitles="true" imageCollection=updateLedBlinkingPeriod %}

{% assign updateLedState= '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-change-blinking-mode-0.png,
        title: 仅当闪烁模式已禁用时才能执行此操作。
'
%}

为了在禁用闪烁时更改状态，我们可以使用同一个微件中的开关：

{% include images-gallery.liquid showListImageTitles="true" imageCollection=updateLedState %}

{% if boardLedCount == 0 %}

很遗憾，此板没有我们可以控制的内置 LED 指示灯。
因此，您可以使用串行监视器（**工具** -> **串行监视器**）检查共享属性更改的结果，并选择波特率 115200。

{% endif %}

为了实现这一点，我们在代码的以下部分中使用了一个变量“blinkingInterval”：

- 共享属性更新的回调：

```cpp
...

void processSharedAttributes(const Shared_Attribute_Data &data) {
  for (auto it = data.begin(); it != data.end(); ++it) {
    if (strcmp(it->key().c_str(), BLINKING_INTERVAL_ATTR) == 0) {
      const uint16_t new_interval = it->value().as<uint16_t>();
      if (new_interval >= BLINKING_INTERVAL_MS_MIN && new_interval <= BLINKING_INTERVAL_MS_MAX) {
        blinkingInterval = new_interval;
        Serial.print("Updated blinking interval to: ");
        Serial.println(new_interval);
      }
    } else if(strcmp(it->key().c_str(), LED_STATE_ATTR) == 0) {
      ledState = it->value().as<bool>();
      digitalWrite(LED_BUILTIN, ledState ? HIGH : LOW);
      Serial.print("Updated state to: ");
      Serial.println(ledState);
    }
  }
  attributesChanged = true;
}

...
const Shared_Attribute_Callback attributes_callback(SHARED_ATTRIBUTES_LIST.cbegin(), SHARED_ATTRIBUTES_LIST.cend(), &processSharedAttributes);
...
```

- 订阅共享属性更新：

```cpp
...
    if (!tb.Shared_Attributes_Request(attribute_shared_request_callback)) {
      Serial.println("Failed to request for shared attributes");
      return;
    }
...
```

- 闪烁的代码部分：

```cpp
...

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
...
```

{% if boardLedCount == 3 %}

{% assign updateLedColor = '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-change-led-color.png,
        title: 您可以使用 GridLinks 仪表板上的微件更新板上 LED 的颜色。
'
%}

由于该板包含 RGB LED，因此我们可以控制其颜色。

{% include images-gallery.liquid showListImageTitles="true" imageCollection=updateLedColor %}

要控制 LED，我们更改“ledColor”共享属性。它包含以下字符串格式的 RGB 值“R,G,B”。

代码的以下部分用于解析传入的值并保存它们：

```cpp
...
if (strcmp(it->key().c_str(), LED_COLOR_ATTR) == 0) {
  std::string data = it->value().as<std::string>();
  Serial.print("Updated colors: ");
  Serial.println(data.c_str());
  int i = 0;
  bool end = false;
  while (data.length() > 0) {
    int index = data.find(',');
    if (index == -1) {
      end = true;
      index = data.length();
    }
    switch (i) {
      case 0:
        redColor = map(atoi(data.substr(0, index).c_str()), 0, 255, 255, 0);
        break;
      case 1:
        greenColor = map(atoi(data.substr(0, index).c_str()), 0, 255, 255, 0);
        break;
      case 2:
        blueColor = map(atoi(data.substr(0, index).c_str()), 0, 255, 255, 0);
        break;
      default:
        break;
    }
    i++;
    if (end) {
      break;
    } else {
      data = data.substr(index + 1);
    }
  }
  setLedColor();
}
...
```

为了设置 LED 的颜色，我们在代码中使用以下函数：

```cpp
...
void setLedColor() {
  if (redColor < 255 && ledState) {
    analogWrite(LEDR, redColor);
  } else {
    pinMode(LEDR, OUTPUT);
    digitalWrite(LEDR, LOW);
  }
  if (greenColor < 255 && ledState) {
    analogWrite(LEDG, greenColor);
  } else {
    pinMode(LEDG, OUTPUT);
    digitalWrite(LEDG, LOW);
  }
  if (blueColor < 255 && ledState) {
    analogWrite(LEDB, blueColor);
  } else {
    pinMode(LEDB, OUTPUT);
    digitalWrite(LEDB, LOW);
  }
}
...
```

{% endif %}

{% if OLEDInstallationRequired == "true" %}

{% assign updateTextOnDisplay = '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-update-oled-screen.png,
        title: 将文本放入输入框并应用更改。文本还将显示在上面的字段中。
'
%}

此外，您还可以更改显示屏上的文本。为此，您可以更改 **screenText** 共享属性或使用示例仪表板。

{% include images-gallery.liquid showListImageTitles="true" imageCollection=updateTextOnDisplay %}

您可以使用以下特殊符号：

- **\n** - 新行。
- **\t** - 四个空格。

为了连接 OLED 显示屏，我们使用以下代码部分（我们有一条 I2C 线，连接到板上的引脚 **5** 和 **4**）：

```cpp
...
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);
...
Wire.begin(5, 4);
if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C, false, false)) { 
    Serial.println("Cannot initialize screen!");
}
...
```

为了处理传入的文本和处理特殊符号，我们使用以下代码：

```cpp
...
if (strcmp(it->key().c_str(), SCREEN_TEXT_ATTR) == 0) {
    screenText = String(it->value().as<const char*>());
    screenText.replace("\\n", "\n");
    screenText.replace("\\t", "    ");
    screenTextUpdated = true;
}
...
```

为了在显示屏上显示传入的测试，我们使用以下代码部分：

```cpp
...

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
...
```

{% endif %}

您可以更改逻辑以实现您的目标并添加对属性的处理。