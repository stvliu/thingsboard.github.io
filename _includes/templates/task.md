{% if overview %}

{{ overview }}

{% else %}

{% include templates/_errorthrower.md missing_block='overview' purpose='说明此文档的用途，一两句话即可' %}

{% endif %}


* 目录
{: toc}


{% if prerequisites %}

### 开始之前

{{ prerequisites }}

{% else %}

{% include templates/_errorthrower.md missing_block='prerequisites' heading='开始之前' purpose='列出操作前提条件和知识前提条件' %}

{% endif %}


{% if steps %}

{{ steps }}

{% else %}

{% include templates/_errorthrower.md missing_block='steps' purpose='列出完成任务的一系列编号步骤。' %}

{% endif %}


{% if discussion %}

{{ discussion }}

{% else %}

{% endif %}


{% if whatsnext %}

### 后续步骤

{{ whatsnext }}

{% endif %}