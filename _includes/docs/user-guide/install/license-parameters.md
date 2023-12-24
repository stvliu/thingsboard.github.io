<table>
    <thead>
      <tr>
          <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>描述</b></td>
      </tr>
    </thead>
    <tbody>
        <tr>
            <td>license.secret</td>
            <td>TB_LICENSE_SECRET</td>
            <td></td>
            <td>从 <a href="https://license.thingsboard.io">ThingsBoard 许可门户</a> 获得的许可密钥</td>
        </tr>
        <tr>
            <td>license.instance_data_file</td>
            <td>TB_LICENSE_INSTANCE_DATA_FILE</td>
            <td>instance-license.data</td>
            <td>实例数据是自动生成的，用于标识特定的 GridLinks 实例。<br>
                实例数据会定期更新并存储到指定的文件中，该文件可以设置为绝对路径或相对路径。<br>
                如果您使用绝对路径，请确保 thingsboard 进程有权访问实例数据文件。</td>
        </tr>
    </tbody>
</table>