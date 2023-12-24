执行以下命令以部署第三方组件（zookeeper、kafka、redis）和主要的 ThingsBoard 微服务：*tb-node*、*tb-web-ui* 和 *js-executors*：

```
./k8s-deploy-resources.sh
```
{: .copy-code}

几分钟后，您可以调用 `kubectl get pods`。如果一切顺利，您应该能够在 `READY` 状态下看到 `tb-node-0` pod。

您还应该部署传输微服务。省略您不使用的协议以节省资源：

##### HTTP 传输（可选）

```
kubectl apply -f transports/tb-http-transport.yml
```
{: .copy-code}

##### MQTT 传输（可选）

```
kubectl apply -f transports/tb-mqtt-transport.yml
```
{: .copy-code}

##### CoAP 传输（可选）

```
kubectl apply -f transports/tb-coap-transport.yml
```
{: .copy-code}

##### LwM2M 传输（可选）

```
kubectl apply -f transports/tb-lwm2m-transport.yml
```
{: .copy-code}

##### SNMP 传输（可选）

```
kubectl apply -f transports/tb-snmp-transport.yml
```
{: .copy-code}