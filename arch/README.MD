
- [一. pacman](#一-pacman)
- [安装字体:](#安装字体)
- [KDE桌面环境下konsole，kate等软件无法切换中文输入法](#kde桌面环境下konsolekate等软件无法切换中文输入法)
- [刷新字体缓存](#刷新字体缓存)
- [搜索历史输入过的命令](#搜索历史输入过的命令)
- [arch 设置全局代理](#arch-设置全局代理)
- [kde 预览所有应用](#kde-预览所有应用)
- [linux 清空所有文件](#linux-清空所有文件)

# 一. pacman
pacman -Ss xxx 搜索包
pacman -S xxx 安装
pacman -Syuuuu 升级
pacman -R 卸载
-Rsu xx  卸载组
pacman -Q | grep xxx 查看本地安装的某个包

makepkg --install 安装

makepkg -f 覆盖 --skipchecksums 无视sum校验

# 安装字体: 
https://www.limstash.com/articles/202004/1582
需要从微软官方再下license.rtf arch

yay -S xxxx

 不能加他说的那三个字体, 否则乱码  或者是不能使用 fc-cache -fv

# KDE桌面环境下konsole，kate等软件无法切换中文输入法
> 注意, 更换console可能会导致类似的问题

export XIM_PROGRAM=fcitx
export XIM=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
注意要写在~/.bashrc 等最前面

输入法使用fcitx-libpinyin和cloudpinyin

# 刷新字体缓存
fc-cache
 

# 搜索历史输入过的命令
1. 按ctrl+r，进入搜索界面；
2. 输入关键字，会弹出最近的一条匹配的记录；
3. 若不是预期的命令，继续按ctrl+r查看下一条匹配的记录；
4. 直接按回车，执行命令；
 
# arch 设置全局代理
在环境变量里面给他配了
/etc/profile   export xxxx_proxy=xxxx

source xxx

# kde 预览所有应用
ctrl + f10
ctrl + f12  展示桌面

# linux 清空所有文件
rm -rf ./*
