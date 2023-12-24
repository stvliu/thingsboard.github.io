<table>
    <thead>
      <tr>
          <td style="width: 25%"><b>参数</b></td><td style="width: 30%"><b>环境变量</b></td><td style="width: 15%"><b>默认值</b></td><td style="width: 30%"><b>说明</b></td>
      </tr>
    </thead>
    <tbody>
    <tr>
        <td>vc.thread_pool_size</td>
        <td>TB_VC_POOL_SIZE</td>
        <td>2</td>
        <td>用于处理同步任务的线程池大小</td>
    </tr>
    <tr>
        <td>vc.git.io_pool_size</td>
        <td>TB_VC_GIT_POOL_SIZE</td>
        <td>3</td>
        <td>用于处理与 Git 相关的 IO 操作的线程池大小</td>
    </tr>
    <tr>
        <td>vc.git.repositories-folder</td>
        <td>TB_VC_GIT_REPOSITORIES_FOLDER</td>
        <td>${java.io.tmpdir}/repositories</td>
        <td>用于存储 GIT 存储库的文件夹</td>
    </tr>
    </tbody>
</table>