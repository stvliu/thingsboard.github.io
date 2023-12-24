{% assign changeStateAndMode = '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-change-blinking-mode-0.png,
        title: 使用开关小部件将 LED 状态更改为连续照明。
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-change-blinking-mode-1.png,
        title: 使用圆形开关小部件将 LED 状态更改为闪烁模式。
 '
 %}

您可以手动更改 LED 状态并在连续照明和闪烁之间更改模式。
为此，您可以使用仪表板的以下部分：

{% include images-gallery.liquid showListImageTitles="true" imageCollection=changeStateAndMode %}

请注意，只有在禁用闪烁模式时才能更改 LED 状态。

在代码示例中，我们具有处理 [RPC 命令](/docs/{{page.docsPrefix}}user-guide/rpc/#server-side-rpc) 的功能。
为了获得控制设备的能力，我们使用了以下代码部分：

- RPC 请求的回调：

```cpp
...

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

...
{% if hasCamera == "true" %}
const std::array<RPC_Callback, 2U> callbacks = {
  RPC_Callback{ "setLedMode", processSetLedMode },
  RPC_Callback{ "takePicture", processTakePicture }
};
{% else %}
const std::array<RPC_Callback, 1U> callbacks = {
  RPC_Callback{ "setLedMode", processSetLedMode }
};
{% endif %}
...
```

- 订阅 RPC 请求：

```cpp
...
    if (!tb.RPC_Subscribe(callbacks.cbegin(), callbacks.cend())) {
      Serial.println("Failed to subscribe for RPC");
      return;
    }
...
```

{% if hasCamera == "true" %}

{% assign takePictureRPC = '
    ===
        image: /images/devices-library/basic/microcontrollers/dashboard/thingsboard-example-dashboard-take-a-picture.png,
        title: 您可以通过按 GridLinks 仪表板上的按钮从摄像头模块拍摄照片。
'
%}

由于电路板已包含摄像头，因此我们可以拍摄照片并在仪表板上查看。

{% include images-gallery.liquid showListImageTitles="true" imageCollection=takePictureRPC %}

要拍照，我们会向设备发送“takePicture”RPC。

以下代码部分拍摄照片。

```cpp
...

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
...
```

我们无法在 JSON 中发送照片的原始字节数组，因此我们还将字节编码为 Base64：

```cpp
...
void encode(const uint8_t *data, size_t length) {
  size_t size = base64_encode_expected_len(length) + 1;
  base64_encodestate _state;
  base64_init_encodestate(&_state);
  int len = base64_encode_block((char *)&data[0], length, &imageBuffer[0], &_state);
  len = base64_encode_blockend((imageBuffer + len), &_state);
}
...
```

我们的编码图片将在主循环中发送：

```cpp
...
if (sendPicture) {
tb.sendTelemetryData(PICTURE_ATTR, imageBuffer);
sendPicture = false;
}
...
```

{% endif %}

您可以更改代码以实现您的目标并添加对 RPC 命令的处理。