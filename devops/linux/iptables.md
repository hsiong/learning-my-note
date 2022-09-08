# 1. 清除目前所有规则(慎用)
# vnc 登录每次完成后 发送ctrl+alt+del
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --sport 22,53 -j ACCEPT
# 禁止访问除22端口以外的所有端口
iptables -F
# 允许通过tcp协议访问22端口(先配置,否则无法使用ssh连接)


iptables -A INPUT -p tcp --dport 7000 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 5432  -j ACCEPT
iptables -A OUTPUT -p tcp --dport 5432  -j ACCEPT

iptables -I INPUT -p tcp --dport 22  -j ACCEPT
iptables -I OUTPUT -p tcp --dport 22  -j ACCEPT
iptables -I INPUT -p tcp --dport 5432  -j ACCEPT
iptables -I OUTPUT -p tcp --dport 5432  -j ACCEPT

-p tcp -dport 5432


iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

cat << EOF > /etc/docker/daemon.json
{
  "hosts": ["fd://"],
  "dns": ["119.29.29.29", "223.5.5.5"],
  "iptables": true
}
EOF

# show log
**Reference**
https://tecadmin.net/enable-logging-in-iptables-on-linux/
```
iptables -A INPUT -j LOG
iptables -A INPUT -s 192.168.10.0/24 -j LOG --log-level 4 --log-prefix '** SUSPECT **'
tail -f /var/log/kern.log
```

# show dropped log
https://www.thegeekstuff.com/2012/08/iptables-log-packets/ 
**Reference**
```
iptables -N LOGGING
iptables -A INPUT -j LOGGING
iptables -A LOGGING -m limit --limit 2/min -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
iptables -A LOGGING -j DROP
```

# config dns
vim /etc/resolv.conf  

# docker cann't connect to domain
"iptables": false 删除即可