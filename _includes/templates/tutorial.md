{% if overview %}

{{ overview }}

{% else %}

{% include templates/_errorthrower.md missing_block='overview' purpose='说明此文档的目的是什么，用一两句话即可' %}

{% endif %}


* 目录
{: toc}


{% if objectives %}

### 目标

{{ objectives }}

{% else %}

{% include templates/_errorthrower.md missing_block='objectives' heading='目标' purpose='列出本教程的目标。' %}

{% endif %}


{% if prerequisites %}

### 开始之前

{{ prerequisites }}

{% else %}

{% include templates/_errorthrower.md missing_block='prerequisites' heading='开始之前' purpose='列出操作先决条件和知识先决条件' %}

{% endif %}


{% if lessoncontent %}

{{ lessoncontent }}

{% else %}

{% include templates/_errorthrower.md missing_block='lessoncontent' purpose='提供本教程的课程内容。' %}

{% endif %}


{% if cleanup %}

### 清理

{{ cleanup }}

{% endif %}


{% if whatsnext %}

### 后续步骤

{{ whatsnext }}

{% endif %}