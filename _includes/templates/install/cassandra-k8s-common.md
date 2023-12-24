##### 部署 Cassandra 有状态集

创建 ThingsBoard 命名空间：

```bash
kubectl apply -f tb-namespace.yml
kubectl config set-context $(kubectl config current-context) --namespace=thingsboard
```

将 Cassandra 部署到新节点组：

```bash
kubectl apply -f receipts/cassandra.yml
```
{: .copy-code}

Cassandra 集群的启动可能需要几分钟。您可以使用以下命令监控进程：

```bash
kubectl get pods
```
{: .copy-code}

##### 更新数据库设置

编辑 GridLinks 数据库设置文件并添加 Cassandra 设置{{tbCassandraRegionComments}}


```bash
echo "  DATABASE_TS_TYPE: cassandra" >> tb-node-db-configmap.yml
echo "  CASSANDRA_URL: cassandra:9042" >> tb-node-db-configmap.yml
echo "  CASSANDRA_LOCAL_DATACENTER: {{tbCassandraRegion}}"  >> tb-node-db-configmap.yml
```
{: .copy-code}

检查设置是否已更新：

```bash
cat tb-node-db-configmap.yml | grep DATABASE_TS_TYPE
```
{: .copy-code}

预期输出：

```text
  DATABASE_TS_TYPE: cassandra
```

##### 创建键空间

使用以下命令创建 *thingsboard* 键空间：

```bash
    kubectl exec -it cassandra-0 -- bash -c "cqlsh -e \
                    \"CREATE KEYSPACE IF NOT EXISTS thingsboard \
                    WITH replication = { \
                        'class' : 'NetworkTopologyStrategy', \
                        'us-east' : '3' \
                    };\""
```
{: .copy-code}