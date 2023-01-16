
> Referce: 
+ https://juejin.cn/post/7023751648644169759
+ https://www.ucloud.cn/yun/63313.html

# 域名解析
*.frp A 111.122.233.44(云端服务器ip)

# 服务端
frps.ini
```
[common]
# frp server 绑定的端口
bind_port = 7000 
# 设置 http 访问端口为 8080
vhost_http_port = 8080 
# 设置域名（保证此域名可用）
subdomain_host = frp.域名
```

```shell
./frps -c ./frps.ini  
# 后台启动
nohup ./frps -c frps.ini >/dev/null 2>&1 &
```    

# 客户端
> mac 使用 frp_0.46.0_darwin_arm64
```
[common]
# 上面的公网服务器ip
server_addr = 111.122.233.44(云端服务器ip)
# frp server 绑定的端口，和上面服务端端口相同
server_port = 7000 

[test1]
type = http
# 本地 web server 端口
local_ip = 127.0.0.1
local_port = 8083
# 二级域名名称
subdomain = test1
```

```shell
./frpc -c frpc.ini  
# 后台启动
nohup ./frpc -c frpc.ini >/dev/null 2>&1 &
```    

```
ps aux|grep frp|grep -v grep|awk '{print $2}'|xargs kill
```
