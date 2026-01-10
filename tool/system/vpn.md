# proxy 
-> idea plugin 
-> maven 
-> brew
-> pacman
-> system proxy
-> chrome 
-> git

# git 代理

## 设置git代理
git config --global https.proxy http://127.0.0.1:1080

git config --global https.proxy https://127.0.0.1:1080

## 取消git代理
git config --global --unset http.proxy

git config --global --unset https.proxy

## 查看git代理
git config --global --get http.proxy
git config --global --get https.proxy


# ubuntu npm
   + 安装 q2ray & v2ray core
   + 设置全局代理 (桌面)
      https://zhuanlan.zhihu.com/p/369356836
   + 设置 npm 代理
      https://freesilo.com/?p=1228
   + 修改 dev-tool 路径
   + npm i & npm run dev

# clash
+ https://senjianlu.com/2021/11/clash-note-04/
+ https://www.codein.icu/clashtutorial/

planb  直接屏蔽公司接口, 在策略中写 direct 直连

# clash-verge 关闭自动更新

Profile -> Edit Profile -> Update Interval -> 0 或者为空;  设置失效 关闭 verge 或 选择其他profile后修改试试

# clash-verge 支持局域网访问
+ `System proxy` 改为 0.0.0.0   
+ 勾选 `allow-lan` - 有风险, 但是 docker 部署需要开启

# rule
mmstat 是aliyun tongyi的进程, 必须从 Reject 改为 Direct
``` 
    - 'DOMAIN-SUFFIX,mmstat.com,DIRECT'   
    - 'DOMAIN-SUFFIX,cdn-apple.com,龙猫云 - TotoroCloud'
    - 'DOMAIN-SUFFIX,apple.com,龙猫云 - TotoroCloud'
    - 'DOMAIN-SUFFIX,apple-cloudkit.com,龙猫云 - TotoroCloud'
    - 'DOMAIN-SUFFIX,apple-mapkit.com,龙猫云 - TotoroCloud'
    - 'DOMAIN-SUFFIX,itunes.apple.com,龙猫云 - TotoroCloud'
    - 'DOMAIN-SUFFIX,microsoft.com,龙猫云 - TotoroCloud'
    - 'DOMAIN-SUFFIX,openai.com,龙猫云 - TotoroCloud'
    - 'DOMAIN-SUFFIX,microsoftonline.com,龙猫云 - TotoroCloud'
    - 'DOMAIN-SUFFIX,azure.com,龙猫云 - TotoroCloud'
    - 'DOMAIN-KEYWORD,openai,龙猫云 - TotoroCloud'
    - 'DOMAIN-KEYWORD,chatgpt,龙猫云 - TotoroCloud'
    - 'DOMAIN-SUFFIX,openai.com,龙猫云 - TotoroCloud'
    - 'DOMAIN-SUFFIX,chatgpt.com,龙猫云 - TotoroCloud'

```