{% assign integrationType = include.integration-type %}
{% assign converterFilePath = "/docs/devices-library/blocks/integrations/converters/basic/" | append: integrationType | append: "-uplink-converter.js" %}

{% capture converterCode %}
{% include {{ converterFilePath }} %}
{% endcapture %}

{% capture customDecodingCodeCapture %}
{% assign customDecodingCodeFilePath = "/docs/devices-library/blocks/integrations/converters/custom-decoding/" | append: page.name | replace: ".md", ".js" %}
{% include {{ customDecodingCodeFilePath }} %}
{% endcapture %}

{% capture wholeConverterCodeBlock %}
{% assign converterCode = converterCode | replace: "// Custom decoding placeholder", customDecodingCodeCapture %}
{% include code-toggle.liquid code=converterCode params="javascript|.copy-code.expandable-15" %}
{% endcapture %}

{% capture customDecodingCodeBlock %}
{% include code-toggle.liquid code=customDecodingCodeCapture params="javascript|.copy-code.expandable-10" %}
{% endcapture %}

### ThingsBoard 集成中的上行转换器

例如，我们已经连接了网关并配置了集成 - 我们需要修改转换器并添加解析来自设备的传入有效负载的功能。

为此，您可以在“*解码块*”中添加代码，它位于转换器中的注释“*// --- 解码代码 --- //*”之间，如果您使用的是默认转换器（适用于 ThingsBoard v3.5.2 或更高版本）。

{{ customDecodingCodeBlock }}

或者，您可以复制转换器的整个代码并将其粘贴到您的转换器中：

{{ wholeConverterCodeBlock }}