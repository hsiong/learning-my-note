# 查看 npm 配置
`npm config ls -l `

关键参数: 
> **prefix** 存储路径
> **https-proxy** 代理
> **registry** 仓库地址

# 手动设置
`npm config set xxx xxx`

# 重置
```
echo "" > $(npm config get userconfig)
npm config edit
echo "" > $(npm config get globalconfig)
npm config --global edit
```

If you need sudo then run this instead:
`sudo sh -c 'echo "" > $(npm config get globalconfig)'`

# 安装 
```
npm install [-g] xxx
```


# 报错处理
## sudo 正常  不加 sudo 无法执行
查看日志发现
```
x:node_modules/ $ npm install -g eslint                                                                    [18:30:48]
npm ERR! code ECONNRESET
npm ERR! syscall read
npm ERR! errno -54
npm ERR! network read ECONNRESET
npm ERR! network This is a problem related to network connectivity.
npm ERR! network In most cases you are behind a proxy or have bad network settings.
npm ERR! network 
npm ERR! network If you are behind a proxy, please make sure that the
npm ERR! network 'proxy' config is set properly.  See: 'npm help config'

npm ERR! A complete log of this run can be found in:
npm ERR!     /Users/x/.npm/_logs/2022-05-24T10_30_53_153Z-debug-0.log
x:node_modules/ $ sublime /Users/x/.npm/_logs/2022-05-24T10_30_53_153Z-debug-0.log    
```

```
# 读取失败
466 verbose stack Error: read ECONNRESET
```


```
# 尝试使用755, 报错依然, 使用777解决
x:lib/ $ chmod -R 755 node_modules                                  
x:lib/ $ chmod -R 777 node_modules          
```