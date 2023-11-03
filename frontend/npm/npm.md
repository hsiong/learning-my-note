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

## npm 升级与降级
1. 降级
举例：降级到6
npm install npm@6 -g（@后跟版本号，若跟的是大版本，则更新到对应大版本最新的小版本）
npm install npm@6.14.14 -g（更新到指定版本）

2. 升级
npm install npm -g（更新到最新版本）

## node 升级与降级
https://www.crmeb.com/ask/thread/24275#:~:text=%E9%99%8D%E4%BD%8Enode%E7%89%88%E6%9C%AC%E7%9A%84%E6%96%B9%E6%B3%95,%E5%AE%89%E8%A3%85%E6%8C%87%E5%AE%9A%E7%89%88%E6%9C%AC%E5%8D%B3%E5%8F%AF%E3%80%82

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

## vite xx 依赖报错

 Rollup failed to resolve import "immer" from "xxxx/_use-immer@0.9.0@use-immer/dist/use-immer.module.js" 

 This is most likely unintended because it can break your application at runtime.

 > 要动脑子, 不能只看提示
 > 优先考虑是不是因为包库依赖缺失导致解析失败, 
 > 其次考虑是不是node版本/npm版本不兼容

 ```

npm install -g npm@xxx
npm install
npm install xxxModule
 ```