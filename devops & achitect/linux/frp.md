
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

  
# frp auto-start

```
FRPS server path: /home/ubuntu/config/frp/0_67
FRPS user: ubuntu

FRPC client path: /home/hsiong/code/config/frp_0.67.0_linux_amd64
FRPC user: hsiong
```

## Part 1: FRPS Server

Goal:

```
frps runs as systemd service
logs only go to frps.log
frps.log size is limited by logrotate
frps does NOT auto-start on boot
start/stop scripts write one line into frps.log
```

### 1. Check files

```
cd /home/ubuntu/config/frp/0_67

ls -lh frps frps.toml
chmod +x frps
```

Test manually first:

```
./frps -c ./frps.toml
```

Stop with Ctrl + C after confirming it works.

### 2. Create frps.service

```
sudo tee /etc/systemd/system/frps.service > /dev/null <<'EOF'
[Unit]
Description=FRP Server
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/config/frp/0_67
ExecStart=/home/ubuntu/config/frp/0_67/frps -c /home/ubuntu/config/frp/0_67/frps.toml

StandardOutput=append:/home/ubuntu/config/frp/0_67/frps.log
StandardError=append:/home/ubuntu/config/frp/0_67/frps.log

Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

Reload systemd:

```
sudo systemctl daemon-reload
```

### 3. Start FRPS manually

```
sudo systemctl start frps
```

Check status:

```
sudo systemctl status frps --no-pager -l
```

View FRPS runtime log:

```
tail -f /home/ubuntu/config/frp/0_67/frps.log
```

### 4. Do NOT enable boot auto-start

Do not run this:

```
sudo systemctl enable frps
```

Make sure it is disabled:

```
sudo systemctl disable frps
sudo systemctl daemon-reload
systemctl is-enabled frps
```

Expected:

```
disabled
```

Important:

```
sudo systemctl disable frps
```

only disables boot auto-start. It does not stop the currently running service.

To stop now:

```
sudo systemctl stop frps
```

### 5. Limit frps.log size

Create logrotate config:

```
sudo tee /etc/logrotate.d/frps > /dev/null <<'EOF'
/home/ubuntu/config/frp/0_67/frps.log {
    su ubuntu ubuntu
    size 10M
    rotate 5
    missingok
    notifempty
    compress
    delaycompress
    copytruncate
    create 0644 ubuntu ubuntu
}
EOF
```

Meaning:

```
size 10M       rotate when frps.log reaches 10 MB
rotate 5       keep 5 old files
compress       compress old rotated logs
delaycompress  compress from the second old file onward
copytruncate   no need to restart frps
su ubuntu ubuntu  rotate as ubuntu user/group
```

Test config:

```
sudo logrotate -d /etc/logrotate.d/frps
```

Force rotate once:

```
sudo logrotate -f /etc/logrotate.d/frps
```

Check result:

```
ls -lh /home/ubuntu/config/frp/0_67/frps.log*
```

### 6. Create start script for FRPS

```
cd /home/ubuntu/config/frp/0_67

cat > start-frps.sh <<'EOF'
#!/usr/bin/env bash

LOG_FILE="/home/ubuntu/config/frp/0_67/frps.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Start frps by systemctl" | sudo tee -a "$LOG_FILE" > /dev/null

sudo systemctl start frps

sudo systemctl status frps --no-pager -l

tail -f "$LOG_FILE"
EOF

chmod +x start-frps.sh
```

Run:

```
./start-frps.sh
```

### 7. Create stop script for FRPS

```
cd /home/ubuntu/config/frp/0_67

cat > stop-frps.sh <<'EOF'
#!/usr/bin/env bash

LOG_FILE="/home/ubuntu/config/frp/0_67/frps.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Stop frps by systemctl" | sudo tee -a "$LOG_FILE" > /dev/null

sudo systemctl stop frps

sudo systemctl status frps --no-pager -l
EOF

chmod +x stop-frps.sh
```

Run:

```
./stop-frps.sh
```

### 8. Create restart script for FRPS

```
cd /home/ubuntu/config/frp/0_67

cat > restart-frps.sh <<'EOF'
#!/usr/bin/env bash

LOG_FILE="/home/ubuntu/config/frp/0_67/frps.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Restart frps by systemctl" | sudo tee -a "$LOG_FILE" > /dev/null

sudo systemctl restart frps

sudo systemctl status frps --no-pager -l

tail -f "$LOG_FILE"
EOF

chmod +x restart-frps.sh
```

Run:

```
./restart-frps.sh
```

## Part 2: FRPC Client

Goal:

```
frpc runs as systemd service
frpc starts automatically on boot
logs only go to frpc.log
frpc.log size is limited
start/stop scripts write one line into frpc.log
```

### 1. Check files

```
cd /home/hsiong/code/config/frp_0.67.0_linux_amd64

ls -lh frpc frpc.toml
chmod +x frpc
```

Test manually:

```
./frpc -c ./frpc.toml
```

Stop with Ctrl + C after confirming it works.

### 2. Create frpc.service

```
sudo tee /etc/systemd/system/frpc.service > /dev/null <<'EOF'
[Unit]
Description=FRP Client
After=network.target

[Service]
Type=simple
User=hsiong
WorkingDirectory=/home/hsiong/code/config/frp_0.67.0_linux_amd64
ExecStart=/home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc -c /home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc.toml

StandardOutput=append:/home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc.log
StandardError=append:/home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc.log

Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
```

Reload systemd:

```
sudo systemctl daemon-reload
```

### 3. Start FRPC and enable boot auto-start

```
sudo systemctl start frpc
sudo systemctl enable frpc
```

Check:

```
sudo systemctl status frpc --no-pager -l
systemctl is-enabled frpc
```

Expected:

```
enabled
```

View log:

```
tail -f /home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc.log
```

### 4. Limit frpc.log size

```
sudo tee /etc/logrotate.d/frpc > /dev/null <<'EOF'
/home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc.log {
    su hsiong hsiong
    size 10M
    rotate 5
    missingok
    notifempty
    compress
    delaycompress
    copytruncate
    create 0644 hsiong hsiong
}
EOF
```

Test:

```
sudo logrotate -d /etc/logrotate.d/frpc
```

Force rotate once:

```
sudo logrotate -f /etc/logrotate.d/frpc
```

Check:

```
ls -lh /home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc.log*
```

### 5. Create start script for FRPC

```
cd /home/hsiong/code/config/frp_0.67.0_linux_amd64

cat > start-frpc.sh <<'EOF'
#!/usr/bin/env bash

LOG_FILE="/home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Start frpc by systemctl" >> "$LOG_FILE"

sudo systemctl start frpc

sudo systemctl status frpc --no-pager -l

tail -f "$LOG_FILE"
EOF

chmod +x start-frpc.sh
```

Run:

```
./start-frpc.sh
```

### 6. Create stop script for FRPC

```
cd /home/hsiong/code/config/frp_0.67.0_linux_amd64

cat > stop-frpc.sh <<'EOF'
#!/usr/bin/env bash

LOG_FILE="/home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Stop frpc by systemctl" >> "$LOG_FILE"

sudo systemctl stop frpc

sudo systemctl status frpc --no-pager -l
EOF

chmod +x stop-frpc.sh
```

Run:

```
./stop-frpc.sh
```

### 7. Create restart script for FRPC

```
cd /home/hsiong/code/config/frp_0.67.0_linux_amd64

cat > restart-frpc.sh <<'EOF'
#!/usr/bin/env bash

LOG_FILE="/home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Restart frpc by systemctl" >> "$LOG_FILE"

sudo systemctl restart frpc

sudo systemctl status frpc --no-pager -l

tail -f "$LOG_FILE"
EOF

chmod +x restart-frpc.sh
```

Run:

```
./restart-frpc.sh
```

## Important Notes About journalctl

Even if you write FRP output to:

```
frps.log
frpc.log
```

these still exist:

```
journalctl -u frps
journalctl -u frpc
```

You cannot fully remove them when using systemd.

But after using:

```
StandardOutput=append:/path/to/frps.log
StandardError=append:/path/to/frps.log
```

the actual FRP runtime logs go to your own log file.

journalctl will mainly contain systemd-level records like:

```
Started frps.service
Stopped frps.service
Main process exited
Failed with result
```

You can ignore journalctl unless debugging service startup failure.

## Optional: Limit systemd journal size globally

```
sudo mkdir -p /etc/systemd/journald.conf.d

sudo tee /etc/systemd/journald.conf.d/00-size.conf > /dev/null <<'EOF'
[Journal]
SystemMaxUse=100M
SystemMaxFileSize=20M
MaxRetentionSec=3day
RuntimeMaxUse=50M
EOF

sudo systemctl restart systemd-journald
```

Clean old journal logs:

```
sudo journalctl --vacuum-size=100M
```

Check usage:

```
journalctl --disk-usage
```

## Common Commands

### FRPS

```
sudo systemctl start frps
sudo systemctl stop frps
sudo systemctl restart frps
sudo systemctl status frps --no-pager -l
tail -f /home/ubuntu/config/frp/0_67/frps.log
```

Disable boot auto-start:

```
sudo systemctl disable frps
sudo systemctl daemon-reload
systemctl is-enabled frps
```

Expected:

```
disabled
```

### FRPC

```
sudo systemctl start frpc
sudo systemctl stop frpc
sudo systemctl restart frpc
sudo systemctl status frpc --no-pager -l
tail -f /home/hsiong/code/config/frp_0.67.0_linux_amd64/frpc.log
```

Enable boot auto-start:

```
sudo systemctl enable frpc
systemctl is-enabled frpc
```

Expected:

```
enabled
```

Disable boot auto-start:

```
sudo systemctl disable frpc
sudo systemctl daemon-reload
systemctl is-enabled frpc
```

## Permission Fixes

If script execution says:

```
permission denied
```

run:

```
chmod +x start-frps.sh stop-frps.sh restart-frps.sh
chmod +x start-frpc.sh stop-frpc.sh restart-frpc.sh
```

Do not use:

```
chmod -x xxx.sh
```

Because -x removes execute permission.

Correct:

```
chmod +x xxx.sh
```

## Final Recommended Structure

```
/home/ubuntu/config/frp/0_67/
├── frps
├── frps.toml
├── frps.log
├── start-frps.sh
├── stop-frps.sh
└── restart-frps.sh
/home/hsiong/code/config/frp_0.67.0_linux_amd64/
├── frpc
├── frpc.toml
├── frpc.log
├── start-frpc.sh
├── stop-frpc.sh
└── restart-frpc.sh
```

For your case:

```
frps: manual start, no boot auto-start
frpc: systemd background service, boot auto-start
logs: frps.log / frpc.log
log size: controlled by logrotate
```
