# RustDesk 自建服务器 0→1 部署文档

> 适用范围：RustDesk Server OSS（`hbbs` + `hbbr`），部署在 Linux 云服务器上，使用 Docker Compose。
>
> 默认前提：
> - 服务器已经安装 Docker 和 Docker Compose
> - 云服务器有公网 IPv4
> - 已有自己的域名
> - 服务器可以已经安装 Nginx，但普通 RustDesk 客户端并不需要通过 Nginx 转发
>
> 本文所有域名、IP、密钥均为 mock 数据。

---

## 一、整体架构

本文统一使用以下示例：

```text
域名：
rustdesk.example.com

服务器公网 IP：
200.xx.xx.xx

RustDesk 公钥：
MOCK_PUBLIC_KEY_BASE64=
```

整体架构：

```text
                   Internet
                      │
                      │
             rustdesk.example.com
                      │
                  DNS A 记录
                      │
                      ▼
                 200.xx.xx.xx
                      │
         ┌────────────┴────────────┐
         │                         │
       hbbs                      hbbr
  ID / 注册 / 打洞               中继
         │                         │
    TCP 21115                TCP 21117
TCP/UDP 21116
         │                         │
         └────────────┬────────────┘
                      │
               RustDesk 客户端
```

普通 Windows / macOS / Linux / Android / iOS RustDesk 客户端，主要使用：

```text
21115/TCP
21116/TCP
21116/UDP
21117/TCP
```

`21118/TCP` 和 `21119/TCP` 主要是 WebSocket 端口，普通原生客户端一般不需要开放。

---

# 二、域名解析

在你的 DNS 服务商中创建 A 记录：

```text
记录类型：A
主机记录：rustdesk
记录值：200.xx.xx.xx
```

最终效果：

```text
rustdesk.example.com -> 200.xx.xx.xx
```

注意：

DNS 只能把：

```text
域名 -> IP
```

不能直接把：

```text
域名 -> IP:端口
```

所以不存在这种 DNS 配置：

```text
rustdesk.example.com -> 200.xx.xx.xx:21116
```

RustDesk 客户端自己知道要访问哪些端口。

验证 DNS：

```bash
dig +short rustdesk.example.com
```

期望返回：

```text
200.xx.xx.xx
```

---

# 三、服务器有 Nginx 是否冲突

不冲突。

如果你的服务器已经运行 Nginx：

```text
80/TCP    -> nginx
443/TCP   -> nginx

21115/TCP -> RustDesk hbbs
21116/TCP -> RustDesk hbbs
21116/UDP -> RustDesk hbbs
21117/TCP -> RustDesk hbbr
```

因为端口完全不同。

所以：

```text
Nginx 继续负责 80 / 443
RustDesk 直接监听 21115 / 21116 / 21117
```

普通 RustDesk OSS 客户端不需要写这种 HTTP 反向代理：

```nginx
location / {
    proxy_pass ...
}
```

`21116` 和 `21117` 不是普通 HTTP 服务。

---

# 四、统一部署目录

统一使用：

```text
/home/ubuntu/config/rustdesk
```

创建目录：

```bash
mkdir -p /home/ubuntu/config/rustdesk
cd /home/ubuntu/config/rustdesk
```

---

# 五、Docker Compose 配置

创建：

```bash
vim /home/ubuntu/config/rustdesk/compose.yml
```

写入：

```yaml
services:
  hbbs:
    image: rustdesk/rustdesk-server:latest
    container_name: rustdesk-hbbs
    command: hbbs
    volumes:
      - ./data:/root
    network_mode: host
    restart: unless-stopped

  hbbr:
    image: rustdesk/rustdesk-server:latest
    container_name: rustdesk-hbbr
    command: hbbr
    volumes:
      - ./data:/root
    network_mode: host
    restart: unless-stopped
```

启动：

```bash
cd /home/ubuntu/config/rustdesk
docker compose up -d
```

查看状态：

```bash
docker compose ps
```

查看日志：

```bash
docker logs rustdesk-hbbs
docker logs rustdesk-hbbr
```

正常情况下，`hbbs` 会看到类似：

```text
Listening on tcp/udp :21116
Listening on tcp :21115
Listening on websocket :21118
Start
```

`hbbr` 会看到：

```text
Listening on tcp :21117
Listening on websocket :21119
Start
```

---

# 六、首次启动后的目录结构

正常情况下：

```text
/home/ubuntu/config/rustdesk/
├── compose.yml
└── data/
    ├── id_ed25519
    ├── id_ed25519.pub
    ├── db_v2.sqlite3
    └── ...
```

其中：

```text
id_ed25519
```

是私钥。

```text
id_ed25519.pub
```

是公钥。

私钥：

```text
id_ed25519
```

不要泄露，不要发给客户端。

客户端需要使用的是：

```text
id_ed25519.pub
```

---

# 七、查看服务器公钥

执行：

```bash
cat /home/ubuntu/config/rustdesk/data/id_ed25519.pub
echo
```

示例：

```text
MOCK_PUBLIC_KEY_BASE64=
```

如果终端显示：

```text
MOCK_PUBLIC_KEY_BASE64=%
```

最后的 `%` 不是密钥内容。

它只是 zsh 表示文件结尾没有换行。

真正的密钥仍然是：

```text
MOCK_PUBLIC_KEY_BASE64=
```

---

# 八、重新生成 RustDesk 密钥

如果要重新生成服务端密钥：

```bash
cd /home/ubuntu/config/rustdesk
docker compose down
```

建议先备份旧密钥：

```bash
mkdir -p data/key-backup

mv data/id_ed25519 \
  data/key-backup/id_ed25519.old

mv data/id_ed25519.pub \
  data/key-backup/id_ed25519.pub.old
```

重新启动：

```bash
docker compose up -d
```

`hbbs` 会自动生成新的：

```text
id_ed25519
id_ed25519.pub
```

查看：

```bash
docker logs rustdesk-hbbs 2>&1 | grep 'Key:'
```

再查看文件：

```bash
cat /home/ubuntu/config/rustdesk/data/id_ed25519.pub
echo
```

两边应该一致。

如果只是重新生成密钥，不需要删除：

```text
db_v2.sqlite3
```

重新生成密钥后，所有客户端都必须改成新的公钥。

---

# 九、云服务器防火墙需要开放哪些端口

最小配置：

```text
TCP 21115
TCP 21116
UDP 21116
TCP 21117
```

云安全组示例：

```text
协议     端口      来源
TCP      21115     0.0.0.0/0
TCP      21116     0.0.0.0/0
UDP      21116     0.0.0.0/0
TCP      21117     0.0.0.0/0
```

普通 RustDesk 原生客户端一般不需要：

```text
21118/TCP
21119/TCP
```

除非你明确要使用 WebSocket / Web Client。

---

# 十、防火墙配置

开启 tcp: 21115-21117

开启 udp: 21116

注意：

```text
云厂商安全组
+
系统 UFW
```

这两层都可能影响端口。

---

# 十一、检查 RustDesk 服务是否监听成功

执行：

```bash
sudo ss -lntup | grep 211
```

至少应该能看到：

```text
21115/TCP
21116/TCP
21116/UDP
21117/TCP
```

另外也可能看到：

```text
21118/TCP
21119/TCP
```

这是正常的。

---

# 十二、客户端测试 TCP 端口

在 macOS / Linux 客户端执行：

```bash
nc -vz rustdesk.example.com 21115
nc -vz rustdesk.example.com 21116
nc -vz rustdesk.example.com 21117
```

正常输出类似：

```text
Connection to rustdesk.example.com port 21115 succeeded!
Connection to rustdesk.example.com port 21116 succeeded!
Connection to rustdesk.example.com port 21117 succeeded!
```

注意：

```bash
nc -vz
```

这里测试的是 TCP。

它不能证明：

```text
21116/UDP
```

是否正常。

---

# 十三、RustDesk 客户端配置

打开：

```text
RustDesk
→ Settings
→ Network
→ Unlock Network Settings
```

推荐配置：

```text
ID Server:
rustdesk.example.com

Relay Server:
留空

API Server:
留空

Key:
MOCK_PUBLIC_KEY_BASE64=
```

如果为了排查问题，也可以显式写端口：

```text
ID Server:
rustdesk.example.com:21116

Relay Server:
rustdesk.example.com:21117

API Server:
留空

Key:
MOCK_PUBLIC_KEY_BASE64=
```

不要写：

```text
http://rustdesk.example.com:21116
```

也不要写：

```text
http://rustdesk.example.com:21117
```

ID Server 和 Relay Server 应该写：

```text
host
```

或者：

```text
host:port
```

不是 HTTP URL。

---

# 十四、API Server 应该怎么填

对于普通 RustDesk OSS：

```text
API Server:
留空
```

不要把：

```text
rustdesk.example.com:21117
```

填到 API Server。

`21117` 是 `hbbr` 的中继端口。

也不要因为日志里出现：

```text
21114
```

就去配置 Nginx。

`21114` 主要是 RustDesk Server Pro API / Web Console 相关端口。

普通 OSS 部署：

```text
hbbs + hbbr
```

不依赖 `21114` 才能远程控制。

---

# 十五、为什么客户端日志会出现 21114

可能会看到：

```text
HTTP POST to http://rustdesk.example.com:21114/api/heartbeat failed
```

这并不代表：

```text
你必须配置 Nginx
```

也不代表：

```text
RustDesk OSS 部署失败
```

客户端可能会尝试 API heartbeat，然后 fallback。

真正更重要的错误是：

```text
invalid public key from rendezvous server
```

或者：

```text
register_pk ... due to key not confirmed
```

---

# 十六、排查 invalid public key

如果客户端日志出现：

```text
Handshake failed: invalid public key from rendezvous server
```

说明：

```text
客户端填写的 Key
≠
当前 hbbs 使用的 Key
```

服务端检查：

```bash
docker logs rustdesk-hbbs 2>&1 | grep 'Key:'
```

再执行：

```bash
cat /home/ubuntu/config/rustdesk/data/id_ed25519.pub
echo
```

这两个值必须一致。

然后客户端填写：

```text
Key:
MOCK_PUBLIC_KEY_BASE64=
```

不要把：

```text
%
```

一起复制进去。

修改以后，完全退出 RustDesk 再启动。

macOS：

```bash
pkill -f RustDesk
open -a RustDesk
```

---

# 十七、排查 key not confirmed

如果日志出现：

```text
register_pk of rustdesk due to key not confirmed
```

并且已经没有：

```text
invalid public key
```

下一步重点检查：

```text
UDP 21116
```

因为 TCP 能通，不代表 UDP 能通。

服务器先检查监听：

```bash
sudo ss -lunp | grep 21116
```

然后抓包：

```bash
sudo tcpdump -ni any udp port 21116
```

此时重新启动客户端。

macOS：

```bash
pkill -f RustDesk
open -a RustDesk
```

判断方式：

```text
完全没有 UDP 包
    → 云安全组 / UFW / 客户端配置 / 网络限制问题

能看到客户端 -> 服务器
但没有服务器回复
    → 服务端处理或防火墙问题

双向 UDP 都存在
    → 网络基本正常，继续检查客户端缓存 / 配置 / Key
```

更详细抓包：

```bash
sudo tcpdump -ni any -vv udp port 21116
```

---

# 十八、开启 hbbs DEBUG 日志

默认：

```bash
docker logs -f rustdesk-hbbs
```

可能只看到启动日志，不一定会打印每个客户端注册行为。

如需详细日志：

```bash
vim /home/ubuntu/config/rustdesk/compose.yml
```

给 `hbbs` 增加：

```yaml
environment:
  - RUST_LOG=debug
```

完整示例：

```yaml
services:
  hbbs:
    image: rustdesk/rustdesk-server:latest
    container_name: rustdesk-hbbs
    command: hbbs
    environment:
      - RUST_LOG=debug
    volumes:
      - ./data:/root
    network_mode: host
    restart: unless-stopped
```

重建：

```bash
cd /home/ubuntu/config/rustdesk
docker compose up -d --force-recreate hbbs
```

查看：

```bash
docker logs -f rustdesk-hbbs
```

---

# 十九、macOS 客户端日志

查看：

```bash
tail -f ~/Library/Logs/RustDesk/RustDesk_rCURRENT.log
```

搜索关键字：

```bash
grep -Ei '21116|21117|rendezvous|relay|heartbeat|key|error|fail' \
  ~/Library/Logs/RustDesk/RustDesk_rCURRENT.log
```

搜索自己的服务器域名：

```bash
grep -i 'rustdesk.example.com' \
  ~/Library/Logs/RustDesk/RustDesk_rCURRENT.log
```

---

# 二十、macOS 客户端配置文件

RustDesk 用户配置通常在：

```text
~/Library/Preferences/com.carriez.RustDesk/
```

检查：

```bash
grep -nE 'rendezvous_server|custom-rendezvous-server|relay-server|api-server|key' \
  ~/Library/Preferences/com.carriez.RustDesk/RustDesk2.toml
```

确认里面的：

```text
rustdesk.example.com
MOCK_PUBLIC_KEY_BASE64=
```

和实际一致。

如果 RustDesk 作为系统服务运行，也可以继续检查：

```bash
sudo grep -nE 'rendezvous_server|custom-rendezvous-server|relay-server|api-server|key' \
  /var/root/Library/Preferences/com.carriez.RustDesk/RustDesk2.toml
```

---

# 二十一、确认客户端是否真的连接到自己的服务器

服务端执行：

```bash
sudo tcpdump -ni any 'port 21116 or port 21117'
```

然后重启客户端。

如果能看到：

```text
客户端公网 IP
    ↔
200.xx.xx.xx:21116
```

说明客户端确实正在访问你自己的 RustDesk 服务。

只看 UDP 注册：

```bash
sudo tcpdump -ni any udp port 21116
```

这个方式比单纯看：

```bash
docker logs -f rustdesk-hbbs
```

更直接。

因为默认 INFO 日志不一定打印每次客户端心跳和注册。

---

# 二十二、正常工作流程

RustDesk 正常工作大概是：

```text
客户端 A
   │
   │ 注册 / rendezvous
   ▼
hbbs :21116
   │
   ├── 尝试 P2P 直连
   │
   └── P2P 失败
          │
          ▼
      hbbr :21117
          │
          ▼
       客户端 B
```

如果 P2P 直连成功：

```text
A <────────────> B
```

服务器主要负责注册和协调。

如果 P2P 失败：

```text
A -> hbbr -> B
```

此时流量会经过你的服务器。

---

# 二十三、推荐最终配置

服务器：

```text
目录：
/home/ubuntu/config/rustdesk

域名：
rustdesk.example.com

公网 IP：
200.xx.xx.xx
```

防火墙：

```text
21115/TCP
21116/TCP
21116/UDP
21117/TCP
```

客户端：

```text
ID Server:
rustdesk.example.com

Relay Server:
留空

API Server:
留空

Key:
MOCK_PUBLIC_KEY_BASE64=
```

排障时可以改成：

```text
ID Server:
rustdesk.example.com:21116

Relay Server:
rustdesk.example.com:21117

API Server:
留空

Key:
MOCK_PUBLIC_KEY_BASE64=
```

---

# 二十四、0→1 最终检查清单

```text
[ ] rustdesk.example.com 已解析到 200.xx.xx.xx

[ ] rustdesk-hbbs 容器正常运行

[ ] rustdesk-hbbr 容器正常运行

[ ] 21115/TCP 已开放

[ ] 21116/TCP 已开放

[ ] 21116/UDP 已开放

[ ] 21117/TCP 已开放

[ ] UFW 如果开启，也已经放行对应端口

[ ] ID Server 填写正确

[ ] Relay Server 留空，或者显式填写 :21117

[ ] API Server 对 OSS 保持空白

[ ] 客户端 Key 与 id_ed25519.pub 完全一致

[ ] nc 测试 21115/21116/21117 TCP 正常

[ ] tcpdump 可以看到 21116 UDP 流量
```

---

# 二十五、常用命令速查

启动：

```bash
cd /home/ubuntu/config/rustdesk
docker compose up -d
```

停止：

```bash
cd /home/ubuntu/config/rustdesk
docker compose down
```

查看状态：

```bash
docker compose ps
```

查看日志：

```bash
docker logs rustdesk-hbbs
docker logs rustdesk-hbbr
```

查看公钥：

```bash
cat /home/ubuntu/config/rustdesk/data/id_ed25519.pub
echo
```

查看监听端口：

```bash
sudo ss -lntup | grep 211
```

查看 UDP：

```bash
sudo tcpdump -ni any udp port 21116
```

客户端测试 TCP：

```bash
nc -vz rustdesk.example.com 21115
nc -vz rustdesk.example.com 21116
nc -vz rustdesk.example.com 21117
```

macOS 查看 RustDesk 日志：

```bash
tail -f ~/Library/Logs/RustDesk/RustDesk_rCURRENT.log
```
