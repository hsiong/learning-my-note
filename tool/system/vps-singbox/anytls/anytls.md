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

