https://github.com/hsiong/learning-kubernetes

>  k8s mount nfs

# 所有节点安装 nfs, https://blog.csdn.net/aixiaoyang168/article/details/83782336
+ redhat
sudo yum install -y nfs-utils
+ ubuntu
sudo apt-get install nfs-kernel-server

# 主节点
-- 赋权
sudo chown nobody:nogroup /home/ubuntu/download/file
sudo chmod -R 777 /home/ubuntu/download/file

-- 映射文件夹
vim /etc/exports
> /www/server/dockerData/web/digital_human_2d/digital_human_2d_server/font *(ro,sync,no_subtree_check)
sudo exportfs -r
+ redhat
sudo systemctl restart nfs-server
+ ubuntu
sudo systemctl restart nfs-kernel-server  
sudo systemctl restart rpcbind

> redhat: sudo systemctl status nfs-server 
> ubuntu: sudo systemctl status nfs-kernel-server  
> active (exited), 不影响

-- nfs 依赖服务, 查看映射端口
sudo systemctl status rpcbind
sudo rpcinfo -p

-- 查看映射状态
showmount -e localhost

# 子节点
showmount -e 127.0.0.129

> showmount: Cannot retrieve info from host: xxx: RPC failed:: RPC: Program unavailable
> 防火墙需要放行 tcp/udp 111, 2049, mountd port

-- mountd port 
+ redhat: 20048
+ ubuntu: config
编辑 /etc/services 文件，为mountd和statd服务添加或修改端口号。例如：
mountd          1234/tcp                        # mountd service
mountd          1234/udp                        # mountd service

telnet 127.0.0.129 111
telnet 127.0.0.129 2049
telnet 127.0.0.129 3306

# kubesphere 创建 storageClassName

```
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: nfs
  annotations:
    kubesphere.io/creator: admin
provisioner: kubernetes.io/no-provisioner
reclaimPolicy: Delete
allowVolumeExpansion: false
volumeBindingMode: WaitForFirstConsumer

```
# kubectl 创建 pv

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 3Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Delete
  storageClassName: nfs
  nfs:
    path: /www/server/dockerData/web/digital_human_2d/digital_human_2d_server/font
    server: 127.0.0.129
```
kubectl apply -f pv.yaml   
kubectl get pv

# kubectl 创建 pvc

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  namespace: dh
  name: nfs-pvc
  labels: {}
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
  storageClassName: nfs

```
kubectl apply -f pvc.yaml   
kubectl get pv
> kubectl delete -f pvc.yaml

# k8s pod 绑定 pvc
```
    spec:
      containers:
        name: xxx
        volumeMounts: 
            - name: nfs
              mountPath: /xxxmountPath
      volumes:
        - name: nfs
          persistentVolumeClaim:
            claimName: nfs-pvc
```