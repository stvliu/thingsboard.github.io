{% assign sendRpcCommand = '
    ===
        image: /images/devices-library/ready-to-go-devices/iot-gateway-cell-1024/exxn-rpc-button.png,
        title: 可以向设备发送命令以执行某些任务。方法的参数必须采用 JSON 格式。
'
%}

{% include images-gallery.liquid showListImageTitles="true" imageCollection=sendRpcCommand %} 
要详细了解 RPC 命令，可以阅读 [本文](/docs/{{page.docsPrefix}}user-guide/rpc/#server-side-rpc)。  
可以在 EXXN IoT Gateway 手册中找到可发送到设备的所有命令的说明。