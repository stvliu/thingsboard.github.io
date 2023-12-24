---
layout: integrators
title: 本地合作伙伴
notitle: "true"
description: GridLinks 分销商
---

# GridLinks 分销商
<p id="des">使用地图或查找器选择一个区域</p>

<div style="margin: 0px -254px;"><object id="map" data="/images/partners/map-of-distributors.svg"></object></div>

<div id="distributors">查找我们的本地分销商</div>

<div id="integratorsGrid">
<div id="filterContainer">
查找器
<form class="form" action= "" name="filter">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<p><select class="dropSelector" id="region" name="region">
<option value="0" selected="true" disabled="disabled">-- 区域 --</option>
<option id="Africa" value="1">非洲</option>
<option id="Asia" value="2">亚洲</option>
<option id="Australia and Oceania" value="3">澳大利亚和大洋洲</option>
<option id="Europe" value="4">欧洲</option>
<option id="Middle East" value="5">中东</option>
<option id="North America" value="6">北美</option>
<option id="South America" value="7">南美</option>
</select></p>
<p><select class="dropSelector" id="country" name="country">
<option id="-- Country --">-- 国家 --</option>
</select></p>
<p><input class="buttonSearch" id="Search" type="button" value="查找" onClick="PushIndex(this.form)"></p>
<hr noshade>
<p><input class="buttonRe" id="Search" type="button" value="成为分销商" onClick="window.location.href='/docs/contact-us/'"></p>
</form>
</div>
<div id="integratorsContainer"></div>
</div>
<script>
	{% include integrators.js
        containerId="integratorsContainer" %}
</script>
<script>
	window.onload = Empty();
</script>