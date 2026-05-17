

# 基础

## vps 对比

https://p3terx.com/archives/cheap-and-costeffective-vps-recommended.html
https://topvpsrank.com/vps/kexueshangwangvps/


## 综合教程

https://www.bandwagonhost.net/readme


## IP 检测

https://sites.google.com/view/laofengbilu/%E6%90%AC%E7%93%A6%E5%B7%A5%E6%9C%8D%E5%8A%A1%E5%99%A8ip%E8%A2%AB%E5%B1%8F%E8%94%BD%E4%BA%86%E4%B8%89%E6%8B%9B%E6%95%99%E4%BD%A0%E5%BF%AB%E9%80%9F%E6%A3%80%E6%B5%8B


## 重装整个系统

In KiwiVM left menu, click Install new OS



# singleBox+Anytls+Reality: server

## 1. Server install

Ubuntu / Debian:

```
sudo -i

apt update
apt install -y curl jq openssl ufw

curl -fsSL https://sing-box.app/install.sh | sh

sing-box version
```

The official install docs also show the package-repository method and the install script, and say systemd management is available with `systemctl enable/start/restart sing-box`. 

Open firewall:

```
ufw allow 22/tcp
ufw allow 443/tcp
ufw --force enable
```

------

## 2. Generate keys

Run on the VPS:

```
KEYPAIR=$(sing-box generate reality-keypair)

PRIVATE_KEY=$(echo "$KEYPAIR" | awk '/PrivateKey/ {print $2}')
PUBLIC_KEY=$(echo "$KEYPAIR" | awk '/PublicKey/ {print $2}')
SHORT_ID=$(openssl rand -hex 4)
PASSWORD=$(openssl rand -base64 24)

echo "PRIVATE_KEY=$PRIVATE_KEY"
echo "PUBLIC_KEY=$PUBLIC_KEY"
echo "SHORT_ID=$SHORT_ID"
echo "PASSWORD=$PASSWORD"
```

You will get something like:

```
PRIVATE_KEY=server_private_key
PUBLIC_KEY=client_public_key
SHORT_ID=1a2b3c4d
PASSWORD=random_password
```

Keep these four values.

In sing-box Reality config, **server uses `private_key`**, client uses **`public_key`**, and `short_id` is required. The docs specify that `private_key` is server-only, `public_key` is client-only, and `short_id` is a required hex string of 0–8 digits. 

------

## 3. Choose Reality camouflage domain

Example:

```
www.microsoft.com
```

Test it on the VPS:

```
openssl s_client \
  -connect www.microsoft.com:443 \
  -servername www.microsoft.com \
  -tls1_3 </dev/null
```

Use a normal large HTTPS site that supports TLS 1.3. You do **not** need your own domain or Let’s Encrypt certificate for Reality mode.

------

## 4. Server config

Create config:

```
mkdir -p /etc/sing-box

cp /etc/sing-box/config.json /etc/sing-box/config.json.bak.$(date +%F_%H%M%S) 2>/dev/null || true

nano /etc/sing-box/config.json
```

Paste this:

```
{
  "log": {
    "level": "info",
    "timestamp": true
  },
  "inbounds": [
    {
      "type": "anytls",
      "tag": "anyreality-in",
      "listen": "::",
      "listen_port": 443,
      "users": [
        {
          "name": "user1",
          "password": "REPLACE_WITH_PASSWORD"
        }
      ],
      "padding_scheme": [
        "stop=8",
        "0=30-30",
        "1=100-400",
        "2=400-500,c,500-1000,c,500-1000,c,500-1000,c,500-1000",
        "3=9-9,500-1000",
        "4=500-1000",
        "5=500-1000",
        "6=500-1000",
        "7=500-1000"
      ],
      "tls": {
        "enabled": true,
        "server_name": "www.microsoft.com",
        "reality": {
          "enabled": true,
          "handshake": {
            "server": "www.microsoft.com",
            "server_port": 443
          },
          "private_key": "REPLACE_WITH_PRIVATE_KEY",
          "short_id": [
            "REPLACE_WITH_SHORT_ID"
          ],
          "max_time_difference": "1m"
        }
      }
    }
  ],
  "outbounds": [
    {
      "type": "direct",
      "tag": "direct"
    },
    {
      "type": "block",
      "tag": "block"
    }
  ],
  "route": {
    "final": "direct"
  }
}
```

Replace:

```
REPLACE_WITH_PASSWORD
REPLACE_WITH_PRIVATE_KEY
REPLACE_WITH_SHORT_ID
```

AnyTLS inbound requires `users`, supports `padding_scheme`, and requires TLS config; the default padding scheme shown above is from the official AnyTLS inbound docs. 

Check and start:

```
sing-box check -c /etc/sing-box/config.json

systemctl enable sing-box
systemctl restart sing-box
systemctl status sing-box --no-pager
```

Logs:

```
journalctl -u sing-box --output cat -f
```

Check port:

```
ss -lntp | grep ':443'
```

You are right. Here is the **complete from-zero-to-one client-side guide** for **macOS + Linux + Windows** using **sing-box AnyTLS + Reality**.

This client config is for:

```
Client: sing-box
Protocol: AnyTLS
TLS layer: Reality
Local proxy: 127.0.0.1:7890
```

Do **not** use Clash Verge for this exact combo. Clash Verge/mihomo does not support **AnyTLS + Reality**. Use sing-box CLI.

The latest stable sing-box release currently shown on GitHub is **1.13.11**, marked “Latest” on April 23, 2026. AnyTLS outbound exists since sing-box **1.12.0**, and it requires `server`, `server_port`, `password`, and `tls`. 

------

## 0. You need these 4 values from your server

From your server setup, you should already have:

```
VPS_IP=your_vps_ip
PASSWORD=your_anytls_password
PUBLIC_KEY=your_reality_public_key
SHORT_ID=your_reality_short_id
```

Example:

```
VPS_IP=1.2.3.4
PASSWORD=abc123456789
PUBLIC_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
SHORT_ID=a1b2c3d4
```

Important mapping:

```
server      = your VPS IP or VPS domain
server_name = Reality camouflage domain, for example www.microsoft.com
public_key  = Reality public key
short_id    = Reality short_id
password    = AnyTLS password
```

------

# Client - Macos



## 1.1 Install sing-box

Recommended:

```
brew install sing-box
sing-box version
```

The official sing-box package-manager page lists Homebrew installation with `brew install sing-box`. 

## 1.2 Create client config

```
mkdir -p ~/.single-box
vim ~/.single-box/client.json
```

In `vim`:

```
i
paste the JSON below
Esc
:wq
```

Paste this full config:

```
{
	"log": {
    "level": "info",
    "timestamp": true
  },
  "inbounds": [
    {
      "type": "mixed",
      "tag": "mixed-in",
      "listen": "127.0.0.1",
      "listen_port": 7890,
      "set_system_proxy": true
    }
  ],
  "outbounds": [
    {
      "type": "anytls",
      "tag": "anyreality-out",
      "server": "YOUR_VPS_IP",
      "server_port": 443,
      "password": "YOUR_PASSWORD",
      "idle_session_check_interval": "30s",
      "idle_session_timeout": "30s",
      "min_idle_session": 5,
      "tls": {
        "enabled": true,
        "server_name": "www.microsoft.com",
        "utls": {
          "enabled": true,
          "fingerprint": "chrome"
        },
        "reality": {
          "enabled": true,
          "public_key": "YOUR_REALITY_PUBLIC_KEY",
          "short_id": "YOUR_SHORT_ID"
        }
      }
    },
    {
      "type": "direct",
      "tag": "direct"
    },
    {
      "type": "block",
      "tag": "block"
    }
  ],
  "route": {
    "rule_set": [
      {
        "type": "local",
        "tag": "proxy-rules",
        "format": "source",
        "path": "./rules/proxy-rules.json"
      },
      {
        "type": "local",
        "tag": "direct-rules",
        "format": "source",
        "path": "./rules/direct-rules.json"
      }
    ],
    "rules": [
      {
        "rule_set": [
          "proxy-rules"
        ],
        "action": "route",
        "outbound": "anyreality-out"
      },
      {
        "rule_set": [
          "direct-rules"
        ],
        "action": "route",
        "outbound": "direct"
      }
    ],
    "final": "direct",
    "auto_detect_interface": true
}
```

` "final": "direct"`  `"final"` is the **default outbound tag** when no route rule matches. 

The `mixed` inbound is a local SOCKS/HTTP proxy, and sing-box supports `set_system_proxy` on Linux, Windows, and macOS. 

## 1.3 Replace values

Example:

```
"server": "1.2.3.4",
"password": "abc123456789",
"public_key": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
"short_id": "a1b2c3d4"
```

Do **not** put the Reality private key in the client.

## 1.4 Check and run

```
sing-box check -c ~/.single-box/client.json
sing-box run -c ~/.single-box/client.json
```

## macOS: LaunchAgent

### 1. Check paths

```
command -v sing-box
echo "$HOME"
sing-box check -c ~/.single-box/client.json
```

Assume:

```
sing-box path: /opt/homebrew/bin/sing-box
home path:     ~
config path:   ~/.single-box/client.json
```

### 2. Create LaunchAgent

StandardErrorPath --- right log path

```
mkdir -p ~/Library/LaunchAgents
vim ~/Library/LaunchAgents/com.user.sing-box.plist
```

Paste:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.user.sing-box</string>

    <key>ProgramArguments</key>
    <array>
      <string>/opt/homebrew/bin/sing-box</string>
      <string>run</string>
      <string>-c</string>
      <string>/Users/vjf/.sing-box/client.json</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>StandardOutPath</key>
    <string>/Users/vjf/.sing-box/logs/sing-box.err.log</string>


    <key>StandardErrorPath</key>
    <string>/Users/vjf/.sing-box/logs/sing-box.log</string>
  </dict>
</plist>
```

If your `command -v sing-box` is different, replace:

```
<string>/opt/homebrew/bin/sing-box</string>
```

### 3. Start and auto-start

```
launchctl stop com.user.sing-box
launchctl list | grep sing-box
launchctl unload ~/Library/LaunchAgents/com.user.sing-box.plist 2>/dev/null || true
launchctl load ~/Library/LaunchAgents/com.user.sing-box.plist
launchctl start com.user.sing-box
tail -f ~/.sing-box/logs/sing-box.log
```

### 4. Check

```
launchctl list | grep sing-box
tail -f ~/.sing-box/logs/sing-box.log
```

Test:

```
curl -x socks5h://127.0.0.1:7890 https://ifconfig.me
```

### 5. Restart / stop

```
launchctl stop com.user.sing-box
launchctl start com.user.sing-box
tail -f ~/.sing-box/logs/sing-box.log
```

Disable:

```
launchctl unload ~/Library/LaunchAgents/com.user.sing-box.plist
```

------

### Restart sh

```
vim ~/.sing-box/sing-box-restart.sh
```

Paste this into `vim`:

```
#!/usr/bin/env bash

set -e

PLIST="$HOME/Library/LaunchAgents/com.user.sing-box.plist"
LABEL="com.user.sing-box"
LOG_FILE="$HOME/.sing-box/logs/sing-box.log"

echo "[1/5] stopping $LABEL ..."
launchctl stop "$LABEL" 2>/dev/null || true

echo "[2/5] current launchctl status:"
launchctl list | grep sing-box || true

echo "[3/5] unloading $PLIST ..."
launchctl unload "$PLIST" 2>/dev/null || true

echo "[4/5] loading $PLIST ..."
launchctl load "$PLIST"

echo "[5/5] starting $LABEL ..."
launchctl start "$LABEL"

echo
echo "Current status:"
launchctl list | grep sing-box || true

echo
echo "Following log:"
echo "$LOG_FILE"
echo

tail -f "$LOG_FILE"
```

Save in vim:

```
:wq
```

Give execute permission:

```
chmod +x ~/.sing-box/sing-box-restart.sh
```

Since your `sing-box` is here:

```
/opt/homebrew/bin/sing-box
```

Put `sing-box-restart` into the same default command directory:

```
chmod +x ~/.sing-box/sing-box-restart.sh
ln -sf ~/.sing-box/sing-box-restart.sh /opt/homebrew/bin/sing-box-restart
```

Then refresh shell command cache:

```
hash -r
```

# Client - Linux

## 2.1 Install sing-box

For Ubuntu / Debian / Fedora / Arch / OpenWrt style systems:

```
curl -fsSL https://sing-box.app/install.sh | sh
sing-box version
```

## 2.2 Create client config

```
mkdir -p ~/.single-box
vim ~/.single-box/client.json
```

## Linux: user system service Autostart

Use this for desktop Linux.

### 1. Check config

+ log -> client.json

  ```
    "log": {
      "disabled": false,
      "level": "info",
      "output": "/home/hsiong/.sing-box/logs/sing-box.log",
      "timestamp": true
    },
  ```

  

```
command -v sing-box
vim ~/.sing-box/client.json
sing-box check -c ~/.sing-box/client.json

```

### 2. Create service

```
mkdir -p ~/.config/systemd/user
vim ~/.config/systemd/user/sing-box-client.service
```

Paste:

```
[Unit]
Description=sing-box client
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
WorkingDirectory=%h/.sing-box
ExecStart=/usr/bin/sing-box run -c %h/.sing-box/client.json
Restart=always
RestartSec=3
LimitNOFILE=1048576

[Install]
WantedBy=default.target
```

If your path is not `/usr/bin/sing-box`, replace it with:

```
command -v sing-box
```

For example:

```
ExecStart=/usr/local/bin/sing-box run -c %h/sing-box/client.json
```

### 3. Start and auto-start

```
systemctl --user daemon-reload
systemctl --user enable --now sing-box-client
systemctl --user status sing-box-client --no-pager
```

### 5. Logs / restart / stop

```
journalctl --user -u sing-box-client -o cat -f
```

Restart:

```
systemctl --user restart sing-box-client
```

Stop:

```
systemctl --user stop sing-box-client
```

Disable:

```
systemctl --user disable sing-box-client
```

### restart - sh

```
#!/usr/bin/env bash

set -e

LABEL="com.user.sing-box"
LOG_FILE="$HOME/.sing-box/logs/sing-box.log"

systemctl --user stop sing-box-client
systemctl --user daemon-reload
systemctl --user enable --now sing-box-client
systemctl --user restart sing-box-client

tail -f "$LOG_FILE"
```



```
sudo ln -sf ~/.sing-box/sing-box-restart.sh /usr/local/bin/sing-box-restart
hash -r
```



# Client - Windows

## 3.1 Install sing-box

Open **PowerShell as Administrator**.

Use winget:

```
winget install sing-box
```

Official sing-box docs list Windows installation through `winget install sing-box`, `scoop install sing-box`, or `choco install sing-box`. 

Optional: install Vim on Windows:

```
winget install Vim.Vim
```

Close and reopen PowerShell after installing Vim if `vim` is not found.

## 3.2 Create config folder

```
mkdir "$env:USERPROFILE\sing-box"
vim "$env:USERPROFILE\sing-box\client.json"
```
