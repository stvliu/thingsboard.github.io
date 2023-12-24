{% if concept %}<!-- check for this before going any further; if not present, skip to else at bottom -->

## {{concept}}概述

{% if what_is %}

### 什么是{{ concept }}？

{{ what_is }}

{% else %}

{% include templates/_errorthrower.md missing_block='what_is' heading='什么是（概念）？' purpose='解释此概念及其目的。' %}

{% endif %}


{% if when_to_use %}

### 何时使用{{ concept }}

{{ when_to_use }}

{% else %}

{% include templates/_errorthrower.md missing_block='when_to_use' heading='何时使用（概念）' purpose='解释何时使用此对象。' %}

{% endif %}


{% if when_not_to_use %}

### 何时不使用{{ concept }}

{{ when_not_to_use }}

{% else %}

{% include templates/_errorthrower.md missing_block='when_not_to_use' heading='何时不使用（概念）' purpose='解释何时不使用此对象。' %}

{% endif %}


{% if status %}

### {{ concept }}状态

{{ status }}

{% else %}

{% include templates/_errorthrower.md missing_block='status' heading='检索（概念）的状态' purpose='解释如何检索此对象的描述。' %}

{% endif %}


{% if usage %}

#### 用法

{{ usage }}

{% else %}

{% include templates/_errorthrower.md missing_block='usage' heading='用法' purpose='以代码示例、命令等形式展示此对象的简单、常见用例，使用制表符显示多种方法' %}

{% endif %}

<!-- 继续“if concept”if/then： -->

{% else %}

### 错误：您必须定义“concept”变量
{: style="color:red" }

此模板需要一个名为`concept`的变量，它只是您要概述的概念的名称。这将显示在文档的标题中。

要消除此消息并利用此模板，请定义`concept`：

```liquid
{% raw %}{% assign concept="复制控制器" %}{% endraw %}
```

完成此任务，然后我们将引导您准备文档的其余部分。

{% endif %}