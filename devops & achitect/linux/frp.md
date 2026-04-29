
> Referce: 
+ https://juejin.cn/post/7023751648644169759
+ https://www.ucloud.cn/yun/63313.html



# 服务端配置

## frp 查看版本

客户端与服务端版本需要保持一致。

如果你可以访问 `frps` 的可执行文件，直接运行以下命令可以显示版本信息：

```
./frps -v
```

或在 Windows 上：

```
frps.exe -v
```

## 域名解析

> 前提: 未使用nginx

*.frp A 111.122.233.44(云端服务器ip)

## Nginx 解析



```
# frp
server {
  listen 80;
  server_name *.frp.xxx.com; # frp.域名
  location / {
      # 将 127.0.0.1 改为 Docker 默认的宿主机网桥 IP  
      proxy_pass http://172.17.0.1:7001; 
      # 这个Host的header一定要加，不然转发后frp拿不到通过哪个域名访问的，导致转发失败
      proxy_set_header   Host             $host;
      proxy_set_header   X-Real-IP        $remote_addr;
      proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
  }
}
```



## 服务端
frps.toml
```
# frp server 绑定的端口
bindPort = 7000
# 设置 http 访问端口, 与 Nginx 一致
vhostHTTPPort = 7001
# 设置域名（保证此域名可用）- 不使用域名, 可不设置本处
subDomainHost = "frp.域名"
# 设置秘钥, 与 frpc 一致
auth.method = "token"
auth.token = "Token"
```

```shell
./frps -c ./frps.toml  
# 后台启动
nohup ./frps -c frps.toml >/dev/null 2>&1 &
# 杀死进程
ps aux|grep frp|grep -v grep|awk '{print $2}'|xargs kill
```

# 客户端
> mac 使用 frp_0.46.0_darwin_arm64
>
> ⭐️ 注释不能写在代码后, 必须单独另起一行
```
# 上面的公网服务器ip
serverAddr = 111.122.233.44(云端服务器ip)
# frp server 绑定的端口，和上面服务端 bind_port 端口相同
serverPort = 7000 
auth.method = "token"
auth.token = "Token"

# 端口的方式
[test2]
type = tcp
# 本地 web server 端口
localIp = "127.0.0.1"
localPort = 8083
# 自定义的访问内部ssh端口号
remotePort = 6000      

# domain 的方式
[[proxies]]
type = "http"
# 本地 web server 端口
localIP = "127.0.0.1"
localPort = 8083
# 二级域名名称
name = "test1"
subdomain = "test1"

# 第二个代理：ollama -  domain 的方式
[[proxies]]
name = "ollama1"
type = "http"
localIP = "127.0.0.1"
localPort = 11434
subdomain = "ollama"
# 👇 加上这行魔法代码，让 Ollama 以为是本地人在访问
hostHeaderRewrite = "127.0.0.1"
# disabled
enabled = false
```

+ linux & macbook

  ```
  ./frpc -c frpc.toml 
  # 后台启动
  nohup ./frpc -c frpc.toml >/dev/null 2>&1 &
  # 杀死进程
  ps aux|grep frp|grep -v grep|awk '{print $2}'|xargs kill
  ```

+ windows

  ```
  frpc -c frpc.ini
  ```

  

