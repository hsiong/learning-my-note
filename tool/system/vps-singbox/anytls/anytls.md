anytls



```

openssl req -x509 -newkey rsa:2048 \
  -keyout /etc/sing-box/server.key \
  -out /etc/sing-box/server.crt \
  -days 3650 -nodes \
  -subj "/CN=www.microsoft.com"

chmod 600 /etc/sing-box/server.key
```



```
vim /etc/sing-box/config.json
systemctl restart sing-box && journalctl -u sing-box -f
```







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







client

```
{
  "log": {
    "level": "trace",
    "timestamp": true
  },
  "dns": {
    "servers": [
      {
        "type": "udp",
        "tag": "dns-bootstrap",
        "server": "223.5.5.5",
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
      "listen_port": 7890
    }
  ],
  "outbounds": [
    {
      "type": "anytls",
      "tag": "anytls-out",
      "server": "server_ip",
      "server_port": 443,
      "password": "password",
      "min_idle_session": 0,
      "tls": {
        "enabled": true,
        "server_name": "www.microsoft.com",
        "insecure": true,
        "utls": {
          "enabled": true,
          "fingerprint": "chrome"
        }
      }
    }
  ],
  "route": {
    "final": "anytls-out"
  }
}
```

