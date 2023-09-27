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