{% assign feature = "自定义翻译" %}{% include templates/pe-feature-banner.md %}

* TOC
{:toc}

GridLinks 自定义翻译功能允许您上传现有语言翻译的替代翻译，并将翻译扩展到仪表板上的特定 GUI 元素。

请记住：平台的内部化意味着有多种语言的自定义翻译映射可用。
否则，将显示翻译 {i18n} 结构，而不是翻译。

### 使用语言环境文件
语言环境文件包含基本翻译列表。其列表不断扩展。

{% include images-gallery.html imageCollection="usingLocaleFiles" showListImageTitles="true"%}

### 自定义菜单

{% include images-gallery.html imageCollection="customMenuItems" showListImageTitles="true"%}

<b>自定义翻译映射示例：</b>
```json
{
  "home": {
    "home": "Pagina principale di un sito web"
  },

  "custom": {
    "group":{
      "office":"Clienti di Office 1"
    },
    "my-dashboard": {
      "title": "Dashboard per esempi"
    },
    "my-widget": {
      "name":"Widget per dispositivo sensore",
      "label-text": "Etichetta per dispositivo sensore",
      "temperature": "Etichetta della temperatura",
      "low-temperature": "Bassa temperatura",
      "high-temperature": "Alta temperatura",
      "normal-temperature": "Temperatura normale"
    }
  }
}
```
{: .copy-code}


### 仪表板

{% include images-gallery.html imageCollection="customTranslationForDashboard"  showListImageTitles="true"%}

### 小部件

#### 通用用法

<b>标题：</b>

{% include images-gallery.html imageCollection="customWidgetTitleAndWidgetLabel" showListImageTitles="true"%}

<b>工具提示：</b>

{% include images-gallery.html imageCollection="tooltips" showListImageTitles="true"%}


#### 在单元格内容函数中使用

{% include images-gallery.html imageCollection="usageInCellContentFunction" showListImageTitles="true"%}

<b>单元格内容函数的 JavaScript 代码示例</b>
```javascript
if(value>70){
    return "{i18n:custom.my-widget.high-temperature}";
}else if(value<20){
    return "{i18n:custom.my-widget.low-temperature}";
}else{
    return "{i18n:custom.my-widget.normal-temperature}";
}
```
{: .copy-code}

#### 在 HTML 值卡中使用

{% include images-gallery.html imageCollection="usageInHTMLValueCard" showListImageTitles="true"%}

<b>在 HTML 值卡中使用自定义翻译的示例：</b>
```html
<script>
    var description = document.getElementsByClassName('description')[0];
    var temperature = ${temperature};
    if(temperature>70){
        description.innerText = "{i18n:custom.my-widget.high-temperature}";
    }else if(temperature<20){
        description.innerText  = "{i18n:custom.my-widget.low-temperature}";
    }else{
        description.innerText = "{i18n:custom.my-widget.normal-temperature}"
    }

</script>

<div class='card'>
    <div class='content'>
        <div class='column'>
            <h1>Thermostat Device</h1>
            <div class='value'>
                Temperature: ${temperature:0} °C
            </div>
            <div class='description'>
            </div>
        </div>
        <img height="80px" src="http://icons.iconarchive.com/icons/iconsmind/outline/512/Temperature-icon.png" alt="Temperature icon">
    </div>
</div>
```
{: .copy-code}



#### 其他地方

{% include images-gallery.html imageCollection="otherPlaces" showListImageTitles="true"%}

{% capture peFeatureContent %}
目前，自定义翻译在 HTML 卡、控制小部件、文件小部件、日期小部件、网关小部件、调度小部件中不可用。
{% endcapture %}
{% include templates/info-banner.md content=peFeatureContent %}


### 视频教程

请参阅下面的视频教程，了解如何逐步使用此功能。

<br>
<div id="video">
    <div id="video_wrapper">
        <iframe src="https://www.youtube.com/embed/VSNZWl1NjWU" frameborder="0" allowfullscreen></iframe>
    </div>
</div>

## 后续步骤

{% assign currentGuide = "AdvancedFeatures" %}{% include templates/multi-project-guides-banner.md %}