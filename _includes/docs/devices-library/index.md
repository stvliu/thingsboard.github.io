<script type="text/javascript">

    var reportedSearchInputs = [];
    var searchPageCount = 0;

    document.onmousemove = function(e) {
        var event = e || window.event;
        window.mouseX = event.clientX;
        window.mouseY = event.clientY;
        if (checkMouseMoved()) {
            checkSearchInput();
        }
    };

    jqueryDefer(function () {
        $( document ).ready(function() {
            var searchInput = $('#searchGuideInput');
            searchInput.keyup(function () {
                window.typeMouseX = window.mouseX;
                window.typeMouseY = window.mouseY;
                filterGuides();
            });
            searchInput.blur(function () {
                checkSearchInput();
            });
            searchInput.focus(
                function () {
                    $(this).parent('#searchGuideBox').addClass('focused');
                }).blur(
                function () {
                    $(this).parent('#searchGuideBox').removeClass('focused');
                });
            filterGuides();
        });
    });

    function checkMouseMoved () {
        if (typeof window.typeMouseX === "undefined" || typeof window.typeMouseY === "undefined") {
            return false;
        }
        return window.typeMouseX !== window.mouseX && window.typeMouseY !== window.mouseY;
    }

    function filterGuides() {
        $('.device-guides-list').find('.device-guide-container').not('.filtered').removeClass('hidden');
        var guidesBlock = $('.device-guides-block').not('.filtered');
        guidesBlock.removeClass('hidden');
        searchPageCount = 0;
        var searchText = $('#searchGuideInput').val();

        var keywords = searchText.split(' ');
        if (keywords && keywords.length) {
            var keyRegexps = [];
            for (var i=0;i<keywords.length;i++) {
                if (keywords[i].length) {
                    keyRegexps.push(new RegExp(keywords[i].toLowerCase()));
                }
            }
            guidesBlock.each( function() {
                var containers = $( this ).find('.device-guide-container').not('.filtered');
                var total = containers.length;
                containers.each( function() {
                    var paragraphs = $(this).find('p');
                    var text = '';
                    paragraphs.each( function() {
                        text += $(this).html();
                        text += ' ';
                    });
                    var matches = testKeywords(keyRegexps, text.toLowerCase());
                    if (!matches) {
                        $( this ).addClass('hidden');
                        total--;
                    }
                });
                searchPageCount += total;
                if (!total) {
                    $( this ).addClass('hidden');
                }
            });
        }
    }
    
    function testKeywords(keyRegexps, input) {
        var result = true;
        for (var i=0;i<keyRegexps.length;i++) {
            result = result && keyRegexps[i].test(input);
        }
        return result;
    }

    function checkSearchInput() {
        var searchText = $('#searchGuideInput').val().trim();
        if (searchText.length >=3 && reportedSearchInputs.indexOf(searchText) === -1) {
            reportSearchInput(searchText);
            reportedSearchInputs.push(searchText);
        }
    }

    function reportSearchInput(searchText) {

        if (!ga.hasOwnProperty("loaded") || ga.loaded !== true) {
            return;
        }

        ga(
            "send", "event", "Guides", "search",
            searchText, searchPageCount
        );
    }
    
</script>

{% assign devices = '' | split: "," %}
{% assign readyToGoDevicesCategory = "" | split: "," %}
{% assign singleBoardComputersCategory = "" | split: "," %}
{% assign microcontrollersCategory = "" | split: "," %}

{% assign devicesLibraryPagePath = page.path | remove: ".md" | append: '/' %}

{% for sitePage in site.pages %}
{% if sitePage.path contains devicesLibraryPagePath %}
{% unless sitePage contains "guidelines" %}
{% assign possibleTargetPath = sitePage.path | remove: devicesLibraryPagePath %}
{% case sitePage.category %}
    {% when "Single-board computers" %}
        {% assign singleBoardComputersCategory = singleBoardComputersCategory | push: sitePage %}
    {% when "Microcontrollers" %}
        {% assign microcontrollersCategory = microcontrollersCategory | push: sitePage %}
    {% when "Other devices" %}
        {% assign readyToGoDevicesCategory = readyToGoDevicesCategory | push: sitePage %}
{% endcase %}
{% endunless %}
{% endif %}
{% endfor %}

{% assign devices = devices | push: microcontrollersCategory %}
{% assign devices = devices | push: singleBoardComputersCategory %}
{% assign devices = devices | push: readyToGoDevicesCategory %}

<ul id="markdown-toc">
    {% for category in devices %}
    {% if guidesVersion == 'paas' and item.paaspage == 'false' %}
    {% elsif guidesVersion == 'ce' and item.cepage == 'false' %}
    {% elsif guidesVersion == 'pe' and item.pepage == 'false' %}
    {% else %}
        {% if category[0].category %}
        <li>
            <a href="#AnchorID{{ category[0].category | remove: " " }}" id="markdown-toc-AnchorID{{ category[0].category | remove: " " }}">{{ category[0].category }}</a>
        </li>
        {% endif %}
    {% endif %}
    {% endfor %}
</ul>

<h1 style="font-size: 28px;">欢迎来到GridLinks设备库！</h1>

设备库是指南和代码片段的集合，它们解释了如何将流行的物联网**开发板**连接到GridLinks平台。
我们有意专注于可编程设备的代码片段，以提高固件工程师的生产力。
设备库是一个不断扩展的资源。我们鼓励我们的社区成员[贡献](/docs/{{page.docsPrefix}}devices-library/guidelines/)。

如果您希望将现有的**LoRaWAN、NB IoT或SigFox**传感器集成到ThingsBoard中，请参阅[如何连接我的设备？](/docs/{{page.docsPrefix}}getting-started-guides/connectivity/)

<br>

<div class="device-guides">
    <div class="filter-panel">
        <div id="searchGuideBox">
            <input type="text" id="searchGuideInput" placeholder="查找设备...">
            <button class="searchButton"></button>
        </div>
    </div>
    {% include devices.liquid %}
</div>

<br>

<a href="/docs/{{page.docsPrefix}}devices-library/guidelines/" class="n-button add-device">添加您的设备</a>