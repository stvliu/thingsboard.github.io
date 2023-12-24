### 创建新仪表板
我们将创建一个仪表板并添加最受欢迎的小部件。请参阅以下说明。


{% assign creatingDashboardCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-dashboard-1-ce.png,
        title: 打开仪表板页面。单击右上角的“+”图标。选择“创建新仪表板”；
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-dashboard-2-ce.png,
        title: 输入仪表板名称。例如，“我的新仪表板”。单击“添加”以添加仪表板；
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-dashboard-3-ce.png,
        title: 您的仪表板应首先列出，因为默认情况下，表格按创建时间对仪表板进行排序。单击“打开仪表板”图标。
    '
%}

{% assign creatingDashboardPE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-dashboard-1-pe.png,
        title: 打开仪表板页面。单击右上角的“+”图标。选择“创建新仪表板”；
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-dashboard-2-pe.png,
        title: 输入仪表板名称。例如，“我的新仪表板”。单击“添加”以添加仪表板；
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-dashboard-3-pe.png,
        title: 您的仪表板应首先列出，因为默认情况下，表格按创建时间对仪表板进行排序。单击“打开仪表板”图标。
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingDashboardPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingDashboardCE %}
{% endif %}

### 添加实体别名

别名是对小部件中使用的单个实体或实体组的引用。别名可以是静态的或动态的。我们将使用“单个实体”别名，它引用单个实体。在本例中，为“{{deviceName}}”。可以配置引用多个设备的别名。例如，某种类型的设备或与某个资产相关的设备。您可以在此处了解有关不同别名的更多信息。

{% assign creatingEntityAliasPE = '
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-1-pe.png,
        title: 进入编辑模式。单击右下角的铅笔按钮；
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-2-pe.png,
        title: 单击屏幕右上角的“实体别名”图标。您将看到一个空的实体别名列表；
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-3-pe.png,
        title: 单击“添加别名”；
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-4-pe.png,
        title: 输入别名。选择“单个实体”作为过滤器类型，为类型选择“设备”，然后开始键入“我的新”以触发自动完成建议；
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-5-pe.png,
        title: 单击“添加”，然后单击“保存”；
    ===
        image: /images/helloworld/getting-started-pe/hello-world-3-1-create-empty-alias-6-pe.png,
        title: 最后，单击仪表板编辑器中的“应用更改”以保存更改。然后，您应该再次进入编辑模式。
    '
%}

{% assign creatingEntityAliasCE = '
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-1-ce.png,
        title: 进入编辑模式。单击右下角的铅笔按钮；
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-2-ce.png,
        title: 单击屏幕右上角的“实体别名”图标。您将看到一个空的实体别名列表；
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-3-ce.png,
        title: 单击“添加别名”；
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-4-ce.png,
        title: 输入别名。选择“单个实体”作为过滤器类型，为类型选择“设备”，然后开始键入“我的新”以触发自动完成建议；
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-5-ce.png,
        title: 单击“添加”，然后单击“保存”；
    ===
        image: /images/helloworld/getting-started-ce/hello-world-3-1-create-empty-alias-6-ce.png,
        title: 最后，单击仪表板编辑器中的“应用更改”以保存更改。然后，您应该再次进入编辑模式。
    '
%}

{% if page.docsPrefix == "pe/" or page.docsPrefix == "paas/" or docsPrefix == "pe/" or docsPrefix == "paas/" %}
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingEntityAliasPE %}
{% else %}  
    {% include images-gallery.liquid showListImageTitles="true" imageCollection=creatingEntityAliasCE %}
{% endif %}

要添加新小部件，我们需要从小部件库中选择它。小部件被分组到小部件包中。每个小部件都有一个数据源。这就是小部件“知道”要显示什么数据的方式。