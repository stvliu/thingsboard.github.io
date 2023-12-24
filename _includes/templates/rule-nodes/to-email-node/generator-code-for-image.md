_要发送图像，您需要将图像编码为 Base64。为此，您需要找到一些可以执行此操作的服务，并在下一个示例中为 `encodedImage` 设置结果字符串。_

生成器 JS 代码示例
```js
var encodedImage = 'HERE_YOU_BASE_64_ENCODED_IMAGE';
var images = {
    "tb.example.png": encodedImage
};
var metadata = { 
    userEmail: 'info@thingsboard.org', 
    images: JSON.stringify(images), 
    isHtml: true 
};
var msgType = "POST_TELEMETRY_REQUEST";
return { msg: {}, metadata: metadata, msgType: msgType }
```
{% include images-gallery.html imageCollection="image_generator" %}