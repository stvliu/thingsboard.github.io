---
layout: docwithnav-edge
title: LWM2M 设备 API 参考
description: IoT 设备支持的 LwM2M API 参考

started:
    0:
        image: /images/lwm2m/architecture.jpg 
        title: 'LwM2M 架构。'    
    1:
        image: /images/lwm2m/object_model.jpg 
        title: 'LwM2M 对象模型。'       
    2:
        image: /images/lwm2m/procedure_client_initiated_bootstrap.jpg 
        title: 'LwM2M 客户端启动的程序。'    
    3:
        image: /images/lwm2m/client_registration.jpg 
        title: 'LwM2M 客户端注册示例。'    
    4:
        image: /images/lwm2m/relations_access_control_object_other_objects.jpg 
        title: 'LwM2M 访问控制对象。'

addResourcesModel_common:
    0:
        image: /images/lwm2m/resources_model_common_0.png 
        title: '开始导入资源 -> LwM2M 对象模型。'    
    1:
        image: /images/lwm2m/resources_model_common_1.png 
        title: '单击以选择要上传的文件。'       
    2:
        image: /images/lwm2m/resources_model_common_2.png 
        title: '打开资源文件 -> LwM2M 对象模型（xml 格式）。'    
    3:
        image: /images/lwm2m/resources_model_common_3.png 
        title: '选择资源类型“LWM2M 模型”并添加资源 -> LwM2M 对象模型。'    
    4:
        image: /images/lwm2m/resources_model_common_4.png 
        title: '通过资源控制参数 -> LwM2M 对象模型（示例）：<br>* 名称：<b>设备</b><br>* 对象 ID：<b>3</b><br>* 对象版本 <b>1.2</b><br>* 文件名 <b>3_1_2.xml</b>'    

addResourcesModel_tenant:
    0:
        image: /images/lwm2m/resources_model_tenant_0.png 
        title: '开始导入资源 -> LwM2M 对象模型。'    
    1:
        image: /images/lwm2m/resources_model_common_1.png 
        title: '单击以选择要上传的文件。'       
    2:
        image: /images/lwm2m/resources_model_common_2.png 
        title: '打开资源文件 -> LwM2M 对象模型（xml 格式）。'    
    3:
        image: /images/lwm2m/resources_model_common_3.png 
        title: '选择资源类型“LWM2M 模型”并添加资源 -> LwM2M 对象模型。'    
    4:
        image: /images/lwm2m/resources_model_common_4.png 
        title: '通过资源控制参数 -> LwM2M 对象模型（示例）：<br>* 名称：<b>设备</b><br>* 对象 ID：<b>3</b><br>* 对象版本 <b>1.2</b><br>* 文件名 <b>3_1_2.xml</b>'    

profileNoSec_create:
    0:
        image: /images/lwm2m/noSec_profile_create_Step_1.png 
        title: '开始创建 LwM2M 配置文件。'    
    1:
        image: /images/lwm2m/noSec_profile_create_Step_2.png 
        title: '输入设备配置文件的名称（例如：“lwm2mProfileNoSec”）。'       
    2:
        image: /images/lwm2m/noSec_profile_create_Step_3.png 
        title: '转到“传输配置”选项卡并选择设备配置文件的类型。'    
    3:
        image: /images/lwm2m/noSec_profile_create_Step_4.png 
        title: '保存此设备配置文件：单击“添加”按钮。'    


profileNoSec_edit:
    1:
        image: /images/lwm2m/noSec_profile_edit_Step_1.png 
        title: '<i>选择</i>带有要更改配置的<b>设备配置文件</b>的<b>名称</b>的行。'    
    2:
        image: /images/lwm2m/noSec_profile_edit_Step_2_3.png 
        title: '<i>选择</i>带有<b>“传输配置”</b>的选项卡，然后<i>单击</i>按钮<b>“切换编辑模式”</b>。'       

profileNoSec_edit_typeAfterConnect:      
    1:
        image: /images/lwm2m/noSec_profile_edit_Step_3_1.png 
        title: '配置：策略编号<b><font color="#5f9ea0">1 已选择</font></b>。'    
    2:
        image: /images/lwm2m/noSec_profile_edit_Step_3_2.png 
        title: '配置：策略编号<b><font color="#5f9ea0">2 已选择</font></b>。'       

profileNoSec_edit_add_object:      
    1:
        image: /images/lwm2m/noSec_profile_edit_Step_4_1.png 
        title: '<i>选择</i>一个项目<b>从</b><b>所有对象</b>的列表中...'       
    2:
        image: /images/lwm2m/noSec_profile_edit_Step_4_2.png 
        title: '<i>选择</i>对象<b>按对象 ID</b>（仅输入 ID 号）。'    
    3:
        image: /images/lwm2m/noSec_profile_edit_Step_4_3.png 
        title: '<i>选择</i>对象<b>按上下文</b>在对象名称中...'  

profileNoSec_edit_add_instance:
    1:
        image: /images/lwm2m/noSec_profile_edit_Step_4_4.png 
        title: '<i>对象</i>支持<b>多个实例</b>'    
    2:
        image: /images/lwm2m/noSec_profile_edit_Step_4_5.png
        title: '<b>开始</b>添加...'    
    3:
        image: /images/lwm2m/noSec_profile_edit_Step_4_6.png
        title: '<b>输入</b>新实例的 ID'     
    4:
        image: /images/lwm2m/noSec_profile_edit_Step_4_7.png
        title: '<b>删除</b> ID 实例'

profileNoSec_edit_observe:
    1:
        image: /images/lwm2m/noSec_profile_edit_Step_4_8.png 
        title: '对于实例中的<b>观察</b>资源：标记选中 <font color="blue">“观察”</font> <u>与</u> <font color="red">“属性”</font> <u>不带</u> <font color="blue">“遥测”</font> <u>不</u>更改<b>“键名”</b>'       
    2:
        image: /images/lwm2m/noSec_profile_edit_Step_4_9.png 
        title: '对于实例中的<b>观察</b>资源：标记选中 <font color="blue">“观察”</font> <u>不带</u> <font color="red">“属性”</font> <u>带</u> <font color="blue">“遥测”</font> <u>不</u>更改<b>“键名”</b>'       
    3:
        image: /images/lwm2m/noSec_profile_edit_Step_4_10.png 
        title: '对于实例中的<b>观察</b>资源：标记选中 <font color="blue">“观察”</font> <u>带</u> <font color="red">“属性”</font> <u>带</u> <font color="blue">“遥测”</font> <u>不</u>更改<b>“键名”</b>'       
    4:
        image: /images/lwm2m/noSec_profile_edit_Step_4_11.png 
        title: '对于实例中的<b>观察</b>资源：标记选中 <font color="blue">“观察”</font> <u>带</u> <font color="red">“属性”</font> <u>带</u> <font color="blue">“遥测”</font> <u>更改</u><b>“键名”</b>'       

profileNoSec_edit_bootstrap:      
    1:
        image: /images/lwm2m/noSec_profile_edit_Step_5_1.png 
        title: '升级后客户端连接到<b>新 LwM2M 服务器</b>的<b>设置</b>：<p></p> - 短标识符，<p></p> - 最短周期...，<p></p> - 生存期...，<p></p> - 绑定（默认 UDP），<p></p> - 通知存储...'       
    2:
        image: /images/lwm2m/noSec_profile_edit_Step_5_2.png 
        title: '升级后配置客户端连接到<b>新引导服务器</b>：<p></p> - 安全模式，<p></p> - 主机，<p></p> - 端口，<p></p> - 短标识符，<p></p> - 延迟时间，<p></p> - 超时后的帐户'    
    3:
        image: /images/lwm2m/noSec_profile_edit_Step_5_3.png 
        title: '升级后配置客户端连接到<b>新 LwM2M 服务器</b>：<p></p> - 安全模式，<p></p> - 主机，<p></p> - 端口，<p></p> - 短标识符，<p></p> - 延迟时间，<p></p> - 超时后的帐户'    

deviceNoSec_create:
    0:
        image: /images/lwm2m/noSec_device_create_Step_1.png
        title: '<b> - 开始：</b>单击 <+> 按钮，<p></p><b> - 输入</b>设备的名称（例如：“LwNoSec00000000”），<p></p><b> - 选择传输类型：</b>“LWM2M”，<p></p><b> - 选择现有设备配置文件</b>（例如：“lwm2mProfileNoSec”）。'       
    1:
        image: /images/lwm2m/noSec_device_create_Step_2.png
        title: '<b>添加凭据</b>：<p></p>- <b>标记</b>选中 <font color="red">“添加凭据”</font><p></p>- <b>选择</b>凭据类型（<b>“LwM2M 凭据”</b>）<p></p>- <b>输入</b> <b><font color="blue">“LwM2M 安全配置密钥”</font></b>（LwM2M 客户端的<b>端点</b>/LwM2M 客户端的 PSK 标识（<b>“公钥或标识”</b>））<p></p> - <b>编辑</b>“LwM2M 安全<b>配置</b>”'    

deviceNoSec_create_security_config:
    0:
        image: /images/lwm2m/noSec_device_create_security_Step_1.png
        title: '<b>- 编辑</b>：<b>“客户端安全配置”</b>。'    
    1:
        image: /images/lwm2m/noSec_device_create_security_Step_2.png
        title: '<b>- 编辑</b>：<b>“引导客户端”</b>：<font color="blue">引导服务器</font>。'       
    2:
        image: /images/lwm2m/noSec_device_create_security_Step_3.png
        title: '- <b>编辑</b>：<b>“引导客户端”</b>：<font color="blue">LWM2M 服务器</font>，<p></p> - <b><font color="blue">保存</font></b>：<i>安全配置信息</i>编辑完成后。'

deviceNoSec_create_save:
    0:
        image: /images/lwm2m/noSec_device_create_Step_3.png
        title: '- 单击 <font color="blue">“添加”</font> 按钮。'