
> reality 已废弃, 各个 public domain 已停止支持

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

PASSWORD=$(openssl rand -base64 24)

echo "PASSWORD=$PASSWORD"
```

You will get something like:

```

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
    "level": "trace",
    "timestamp": true
  },
  "inbounds": [
    {
      "type": "anytls",
      "tag": "anytls-in",
      "listen": "::",
      "listen_port": 443,
      "users": [
        {
          "name": "hsiong",
          "password": "password"
        }
      ],
      "tls": {
        "enabled": true,
        "certificate_path": "/etc/sing-box/server.crt",
        "key_path": "/etc/sing-box/server.key"
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

You are right. Here is the **complete from-zero-to-one client-side guide** for **macOS + Linux + Windows** using **sing-box AnyTLS**.

This client config is for:

```
Client: sing-box
Protocol: AnyTLS
TLS layer: Reality
```

The latest stable sing-box release currently shown on GitHub is **1.13.11**, marked “Latest” on April 23, 2026. AnyTLS outbound exists since sing-box **1.12.0**, and it requires `server`, `server_port`, `password`, and `tls`. 

------

## 0. You need these 4 values from your server

From your server setup, you should already have:

```
VPS_IP=your_vps_ip
PASSWORD=your_anytls_password
```

Example:

```
VPS_IP=1.2.3.4
PASSWORD=abc123456789
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
    "disabled": false,
    "level": "info",
    "output": "./logs/sing-box.log",
    "timestamp": true
  },
  "dns": {
    "servers": [
      {
        "type": "udp",
        "tag": "dns-bootstrap",
        "server": "8.8.8.8",
        "server_port": 53
      }
    ],
    "final": "dns-bootstrap"
  },
  "inbounds": [
    {
      "type": "mixed",
      "tag": "mixed-in",
      "listen": "127.0.0.1",
      "listen_port": 7897
    },
    {
      "type": "tun",
      "tag": "tun-in",
      "address": [
        "172.19.0.1/30"
      ],
      "mtu": 9000,
      "auto_route": true,
      "strict_route": true,
      "stack": "mixed",
      "route_exclude_address": [
        "10.0.0.0/8",
        "172.16.0.0/12",
        "192.168.0.0/16",
        "169.254.0.0/16",
        "fc00::/7",
        "fe80::/10"
      ]
    }
  ],
  "outbounds": [
    {
      "domain_resolver": "dns-bootstrap",
      "type": "anytls",
      "tag": "anytls-out",
      "server": "ip",
      "server_port": 443,
      "password": "pwd",
      "idle_session_check_interval": "30s",
      "idle_session_timeout": "30s",
      "min_idle_session": 2,
      "tls": {
        "enabled": true,
        "server_name": "www.microsoft.com",
        "insecure": true,
        "utls": {
          "enabled": true,
          "fingerprint": "chrome"
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
      "default_domain_resolver": "dns-bootstrap",
    "rule_set": [
      {
        "type": "local",
        "tag": "proxy-rules",
        "format": "source",
        "path": "/home/hsiong/.sing-box/rules/proxy-rules.json"
      },
      {
        "type": "local",
        "tag": "direct-rules",
        "format": "source",
        "path": "/home/hsiong/.sing-box/rules/direct-rules.json"
      }
    ],
    "rules": [
          {
            "rule_set": [
              "proxy-rules"
            ],
            "action": "route",
            "outbound": "anytls-out"
          },
          {
            "rule_set": [
              "direct-rules"
            ],
            "action": "route",
            "outbound": "direct"
          },
          {
            "ip_cidr": [
              "0.0.0.0/0",
              "::/0"
            ],
            "action": "route",
            "outbound": "direct"
          }
        ],
    "final": "anytls-out",
    "auto_detect_interface": true
  }
}
```

` "final": "direct"`  `"final"` is the **default outbound tag** when no route rule matches. 

The `mixed` inbound is a local SOCKS/HTTP proxy, and sing-box supports `set_system_proxy` on Linux, Windows, and macOS. 

## 1.3 Replace values

Example:

```
"server": "1.2.3.4",
"password": "abc123456789"
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
sublime ~/Library/LaunchAgents/com.user.sing-box.plist
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

    <key>WorkingDirectory</key>         
    <string>/Users/xxx/.sing-box</string>

    <key>ProgramArguments</key>
    <array>
      <string>/opt/homebrew/bin/sing-box</string>
      <string>run</string>
      <string>-c</string>
      <string>/Users/xxx/.sing-box/client.json</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

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

> Note: TUN mode could result in high CPU usage.

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



```
command -v sing-box
vim ~/.sing-box/client.json
sing-box check -c ~/.sing-box/client.json

```

### 2. Create service

```
mkdir -p ~/.config/systemd/user
sudo vim /etc/systemd/system/sing-box-client.service
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
WorkingDirectory=/home/hsiong/.sing-box
ExecStart=/usr/bin/sing-box run -c /home/hsiong/.sing-box/client.json
Restart=always
RestartSec=3
LimitNOFILE=1048576

[Install]
WantedBy=multi-user.target
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
sudo systemctl daemon-reload
sudo systemctl enable --now sing-box-client
sudo systemctl status sing-box-client --no-pager
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

if [[ "${EUID}" -ne 0 ]]; then
  exec sudo "$0" "$@"
fi

LABEL="com.user.sing-box"
LOG_FILE="$HOME/.sing-box/logs/sing-box.log"

systemctl stop sing-box-client
systemctl daemon-reload
systemctl enable --now sing-box-client
systemctl restart sing-box-client

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



# Client - IOS

From **zero to one** means you need **two repositories**, not only `sing-box-for-apple`:

```
1. SagerNet/sing-box
   -> builds new Libbox.xcframework with AnyTLS support

2. SagerNet/sing-box-for-apple
   -> iOS/macOS/tvOS Xcode app project, SFI is the iPhone app
```

`sing-box-for-apple` is the Apple GUI/client source. The official repo describes it as an experimental iOS/macOS/tvOS client for sing-box. 
 `AnyTLS` requires sing-box **1.12.0+**, so you must build a new `Libbox.xcframework` from the main `sing-box` repo; otherwise iPhone will still report `unknown outbound type: anytls`. 

Below is the full process.

------

## 0. Install full Xcode first

Right now you do **not** have Xcode:

```
ls -ld /Applications/Xcode.app
# No such file or directory
```

Command Line Tools are not enough. You need full Xcode because this is an iOS Xcode project.

Install **Xcode** from App Store or Apple Developer Downloads. After installation, check:

```
ls -ld /Applications/Xcode.app
```

Expected:

```
/Applications/Xcode.app
```

Then switch to full Xcode:

```
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
sudo xcodebuild -runFirstLaunch
```

Check:

```
xcode-select -p
xcodebuild -version
```

Expected:

```
/Applications/Xcode.app/Contents/Developer
```

Not:

```
/Library/Developer/CommandLineTools
```

------

## 1. Install base tools

Your Go is already okay:

```
go version go1.25.4 darwin/arm64
```

Install other tools:

```
brew install git go jq xcbeautify
```

Check:

```
git --version
go version
xcodebuild -version
```

------

## 2. Directory structure

Use your directory:

```
$HOME/Projects/apple
```

Final structure will be:

```
$HOME/Projects/apple/sing-box
$HOME/Projects/apple/sing-box-for-apple
```

------

## 3. Create one full bootstrap script

```
vim ~/build_sfi_from_zero.sh
```

Paste this:

```
#!/usr/bin/env bash
set -euo pipefail

ROOT="$HOME/Projects/apple"
SING_BOX_DIR="$ROOT/sing-box"
APPLE_DIR="$ROOT/sing-box-for-apple"

echo "=================================================="
echo "1. Check full Xcode"
echo "=================================================="

if [[ ! -d "/Applications/Xcode.app" ]]; then
  echo "ERROR: /Applications/Xcode.app not found."
  echo
  echo "Install full Xcode first:"
  echo "  App Store -> search Xcode -> Install"
  echo
  echo "Command Line Tools are not enough for iOS build."
  exit 1
fi

sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer

echo "xcode-select:"
xcode-select -p

echo
echo "Xcode version:"
xcodebuild -version

echo
echo "Go version:"
go version

echo
echo "=================================================="
echo "2. Prepare root directory"
echo "=================================================="

mkdir -p "$ROOT"
cd "$ROOT"

echo
echo "=================================================="
echo "3. Clone or update sing-box core"
echo "=================================================="

if [[ ! -d "$SING_BOX_DIR/.git" ]]; then
  git clone https://github.com/SagerNet/sing-box.git "$SING_BOX_DIR"
else
  git -C "$SING_BOX_DIR" fetch --all --tags
fi

echo
echo "=================================================="
echo "4. Clone or update sing-box-for-apple"
echo "=================================================="

if [[ ! -d "$APPLE_DIR/.git" ]]; then
  git clone --recurse-submodules https://github.com/SagerNet/sing-box-for-apple.git "$APPLE_DIR"
else
  git -C "$APPLE_DIR" fetch --all
  git -C "$APPLE_DIR" submodule update --init --recursive
fi

echo
echo "=================================================="
echo "5. Select sing-box core version >= 1.12"
echo "=================================================="

cd "$SING_BOX_DIR"

LATEST_TAG="$(
  git tag --sort=-v:refname \
    | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' \
    | head -1
)"

if [[ -z "$LATEST_TAG" ]]; then
  echo "ERROR: no sing-box release tag found."
  exit 1
fi

echo "Using sing-box core tag: $LATEST_TAG"
git checkout "$LATEST_TAG"

echo
echo "Current sing-box core:"
git describe --tags --always

echo
echo "=================================================="
echo "6. Build Libbox.xcframework"
echo "=================================================="

make lib_install
make lib_apple

echo
echo "=================================================="
echo "7. Locate Libbox.xcframework"
echo "=================================================="

FOUND_LIBBOX="$(find "$SING_BOX_DIR" -maxdepth 6 -type d -name 'Libbox.xcframework' | head -1 || true)"

if [[ -z "$FOUND_LIBBOX" ]]; then
  echo "ERROR: Libbox.xcframework not found after make lib_apple."
  echo
  echo "Debug manually:"
  echo "  cd $SING_BOX_DIR"
  echo "  make lib_install"
  echo "  make lib_apple"
  exit 1
fi

echo "Found Libbox:"
echo "$FOUND_LIBBOX"

echo
echo "=================================================="
echo "8. Copy Libbox.xcframework into sing-box-for-apple"
echo "=================================================="

rm -rf "$APPLE_DIR/Libbox.xcframework"
cp -R "$FOUND_LIBBOX" "$APPLE_DIR/Libbox.xcframework"

ls -ld "$APPLE_DIR/Libbox.xcframework"

echo
echo "=================================================="
echo "9. Show Xcode schemes"
echo "=================================================="

cd "$APPLE_DIR"
xcodebuild -list -project sing-box.xcodeproj

echo
echo "=================================================="
echo "DONE"
echo "=================================================="
echo
echo "Next:"
echo "  open $APPLE_DIR/sing-box.xcodeproj"
echo
echo "Then in Xcode:"
echo "  Scheme: SFI"
echo "  Device: your iPhone"
echo "  Set Signing Team"
echo "  Change Bundle IDs"
echo "  Run"
```

Save:

```
:wq
```

Run:

```
chmod +x ~/build_sfi_from_zero.sh
~/build_sfi_from_zero.sh
```

The main `sing-box` Makefile includes `lib_apple`, which builds Libbox for Apple targets, and `sing-box-for-apple` has a Makefile target for iOS using scheme `SFI`. 

------

## 4. Open Xcode

```
open $HOME/Projects/apple/sing-box-for-apple/sing-box.xcodeproj
```

In Xcode:

```
Top scheme selector -> SFI
Device selector -> your iPhone
```

If your iPhone does not show:

```
iPhone Settings
-> Privacy & Security
-> Developer Mode
-> On
-> Restart iPhone
```

Then connect by USB and tap:

```
Trust This Computer
```

------

## 5. Change signing and Bundle IDs

In Xcode left sidebar:

```
sing-box project
-> Targets
```

Set your Apple Team and unique Bundle IDs for all relevant targets.

Use something like:

```
SFI:
  com.vjf.sfi

Extension:
  com.vjf.sfi.Extension

FileProviderExtension:
  com.vjf.sfi.FileProviderExtension

IntentsExtension:
  com.vjf.sfi.IntentsExtension

WidgetExtension:
  com.vjf.sfi.WidgetExtension
```

For each target:

```
Signing & Capabilities
-> Team: your Apple Developer team
-> Automatically manage signing: enabled
```

Important: VPN/Network Extension signing may require a paid Apple Developer account. Apple lists Network Extensions and Personal VPN as capability-controlled items. 

------

## 6. Build and install to iPhone

In Xcode:

```
Product -> Clean Build Folder
Run
```

Or press:

```
Cmd + R
```

If it succeeds, SFI installs on your iPhone.

------

## 7. Minimal AnyTLS iPhone test config

Do **not** import your huge rules first. First confirm AnyTLS works.

```
vim ~/client-ios-anytls-test.json
```

Paste this and replace values:

Save:

```
:wq
```

Send to iPhone:

```
AirDrop client-ios-anytls-test.json
-> Open with SFI
-> Import profile
-> Start
-> Allow VPN permission
```

------

## 8. If it still says `unknown outbound type: anytls`

That means your iPhone app is still linked to old Libbox.

Check core repo:

```
cd $HOME/Projects/apple/sing-box
git describe --tags
```

It must be `v1.12.0` or newer because AnyTLS is only supported since 1.12.0. 

Then rebuild:

```
cd $HOME/Projects/apple/sing-box
make lib_apple

rm -rf $HOME/Projects/apple/sing-box-for-apple/Libbox.xcframework

FOUND_LIBBOX="$(find $HOME/Projects/apple/sing-box -maxdepth 6 -type d -name 'Libbox.xcframework' | head -1)"
cp -R "$FOUND_LIBBOX" $HOME/Projects/apple/sing-box-for-apple/Libbox.xcframework
```

Then in Xcode:

```
Product -> Clean Build Folder
Run
```

------

## 9. If Xcode fails on signing

Common errors:

```
Provisioning profile doesn't include Network Extension
Personal VPN capability missing
Network Extension capability not available
```

That means your Apple account cannot sign the VPN extension. You need:

```
Apple Developer Program account
Network Extension / Personal VPN capability
Correct Bundle IDs for app + extension
```

The code may be correct; signing is the blocker.

------

## 10. Full checklist

Run in this order:

```
# 1. After installing Xcode
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
sudo xcodebuild -runFirstLaunch

# 2. Clone + build Libbox + prepare Apple project
~/build_sfi_from_zero.sh

# 3. Open project
open $HOME/Projects/apple/sing-box-for-apple/sing-box.xcodeproj
```

Then Xcode:

```
Scheme: SFI
Device: iPhone
Signing Team: your team
Bundle IDs: change to your own
Cmd + R
```

This is the complete route: **install Xcode -> clone sing-box -> clone sing-box-for-apple -> build Libbox.xcframework with AnyTLS support -> copy it into Apple project -> sign/build/install SFI to iPhone**.

# Log limit

## macOS

### 1. Install logrotate

```
brew install logrotate
```

Check path:

```
command -v logrotate
```

Usually:

```
/opt/homebrew/sbin/logrotate
```

### 2. Create logrotate config

```
mkdir -p ~/.config/logrotate
vim ~/.config/logrotate/sing-box.conf
```

Paste:

```
/Users/hsiong/.sing-box/logs/*.log {
    size 10M
    rotate 5
    missingok
    notifempty
    copytruncate
    compress
}
```

Meaning:

```
size 10M     -> rotate when file exceeds 10 MB
rotate 5     -> keep 5 old files
copytruncate -> safe for sing-box because it keeps writing to same file
compress     -> gzip old logs
```

### 3. Test manually

```
logrotate -f -v -s ~/.config/logrotate/status ~/.config/logrotate/sing-box.conf
```

Check:

```
ls -lh ~/.sing-box/logs
```

### 4. Auto-run every hour on macOS

```
vim ~/Library/LaunchAgents/com.user.logrotate.sing-box.plist
```

Paste:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.user.logrotate.sing-box</string>

    <key>ProgramArguments</key>
    <array>
      <string>/opt/homebrew/sbin/logrotate</string>
      <string>-s</string>
      <string>/Users/hsiong/.config/logrotate/status</string>
      <string>/Users/hsiong/.config/logrotate/sing-box.conf</string>
    </array>

    <key>StartInterval</key>
    <integer>3600</integer>

    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>
```

If your `command -v logrotate` is not `/opt/homebrew/sbin/logrotate`, replace that path.

Load it:

```
launchctl unload ~/Library/LaunchAgents/com.user.logrotate.sing-box.plist 2>/dev/null || true
launchctl load ~/Library/LaunchAgents/com.user.logrotate.sing-box.plist
launchctl start com.user.logrotate.sing-box
```

Check:

```
launchctl list | grep logrotate
```

------

## Linux

Most Linux distributions already have logrotate.

Check:

```
command -v logrotate
```

If missing:

```
sudo apt update
sudo apt install -y logrotate
```

### 1. Create logrotate config

```
sudo vim /etc/logrotate.d/sing-box
```

Paste:

```
/home/hsiong/.sing-box/logs/*.log {
    size 10M
    rotate 5
    missingok
    notifempty
    copytruncate
    compress
}
```

### 2. Test manually

```
sudo logrotate -f -v /etc/logrotate.d/sing-box
```

Check:

```
ls -lh /home/hsiong/.sing-box/logs
```

### 3. Linux auto-run

Linux usually runs logrotate automatically by systemd timer or cron.

Check systemd timer:

```
systemctl list-timers | grep logrotate
```

Manual check:

```
sudo logrotate -d /etc/logrotate.d/sing-box
```

------

## Important note

`size 10M` does **not** mean logrotate monitors the file every second.

It means:

```
When logrotate runs, if file > 10 MB, rotate it.
```

So:

```
macOS: our LaunchAgent runs every hour
Linux: system logrotate usually runs daily
```

If you want Linux to check hourly too, create a timer, but for sing-box logs, daily is usually enough.

------



# Antigravity

`client.json` -> support `Tun`

```
  "inbounds": [
    {
      "type": "mixed",
      "tag": "mixed-in",
      "listen": "127.0.0.1",
      "listen_port": 7890
    },
    {
      "type": "tun",
      "tag": "tun-in",
      "address": [
        "172.19.0.1/30"
      ],
      "mtu": 9000,
      "auto_route": true,
      "strict_route": true,
      "stack": "mixed"
    }
  ],
```

+ test

```
sudo sing-box run -c ~/.sing-box/client.json
```

## Mac

### 1. Stop old LaunchAgent

```
launchctl stop com.user.sing-box 2>/dev/null || true
launchctl unload ~/Library/LaunchAgents/com.user.sing-box.plist 2>/dev/null || true
launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.user.sing-box.plist 2>/dev/null || true
```

Check:

```
launchctl list | grep sing-box || echo "old LaunchAgent not loaded"
```

### Fix permissions

LaunchDaemon plist must be owned by `root:wheel` and not writable by normal users:

```
sudo mv ~/Library/LaunchAgents/com.user.sing-box.plist /Library/LaunchDaemons/com.user.sing-box.plist
sudo chown root:wheel /Library/LaunchDaemons/com.user.sing-box.plist
sudo chmod 644 /Library/LaunchDaemons/com.user.sing-box.plist
```
