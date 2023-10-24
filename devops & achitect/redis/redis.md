# redis-cli 链接远程
$ redis-cli -h host -p port -a password

# redis-cli 本地登录
redis-cli -h 127.0.0.1 -p 6379 -a "mypassword"

# redis docker 重启后链接异常
``` shell
docker exec -it redis /bin/bash
redis-cli -h 127.0.0.1 -p 6379
CONFIG set requirepass "new pwd" 
```

# redis-stream

