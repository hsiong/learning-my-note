- [2. git提示Please use a personal access token instead](#2-git提示please-use-a-personal-access-token-instead)
- [生成 ssh](#生成-ssh)
- [回退 git 版本](#回退-git-版本)

<!-- # 一.常见问题 -->

## 1. git pull/push提示443错误
### 1.1 方法1
首选修改git配置(<b style='color:red'>1080为你的代理端口号</b>)
```
 git config --global https.proxy http://127.0.0.1:1080
 git config --global http.proxy http://127.0.0.1:1080
```

### 1.2 方法2
如未生效
```
git config --global --unset https.proxy
git config --global --unset http.proxy
```
再按照如下方法
[GitHub无法访问、443 Operation timed out的解决办法](https://juejin.cn/post/6844904193170341896)

### 1.3 unset-all-proxy
```
export ALL_PROXY=socks5://127.0.0.1:1080

unset ALL_PROXY ###
```


# 2. git提示Please use a personal access token instead
[[Solved] remote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead](https://exerror.com/remote-support-for-password-authentication-was-removed-on-august-13-2021-please-use-a-personal-access-token-instead/)

> 方法2：在vs-code或idea中，登陆github账户，使用普通的http-github链接即可

# 生成 ssh
 ssh-keygen -m PEM -t rsa -C "email"  

# 回退 git 版本
git reset --soft HEAD~1