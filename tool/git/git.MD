- [2. git提示Please use a personal access token instead](#2-git提示please-use-a-personal-access-token-instead)
- [生成 ssh](#生成-ssh)
- [回退 git 版本](#回退-git-版本)
- [vscode commit msg](#vscode-commit-msg)
- [GIT push, HTTP code = 502 error](#git-push-http-code--502-error)
- [idea新建项目上传到git](#idea新建项目上传到git)
- [git change user-name](#git-change-user-name)
- [push exist file to new git repo](#push-exist-file-to-new-git-repo)
- [git pr command](#git-pr-command)
- [not a git repository (or any of the parent directories): .git](#not-a-git-repository-or-any-of-the-parent-directories-git)

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

# vscode commit msg
![image](https://user-images.githubusercontent.com/37357447/180382244-bafdc0a8-af43-4cb0-a908-abae03ccdb31.png)

# GIT push, HTTP code = 502 error
考虑 vpn 代理的问题

# idea新建项目上传到git
https://blog.csdn.net/woyizhizaizhaoni/article/details/90436721
+ VCS --> Import into Version Control --> Create Git Repository 
+ GIT-->Remotes-->添加一个git创建好的仓路径
+ pull main repo
+ if error check-out
+ then revert file local change
+ commit to github
+ push ~

# git change user-name
1. show username   
   git config --global user.name
2. change username 
   git config --global user.name "new name" 

# push exist file to new git repo
idea git -> create repostory -> 选择当前项目
项目下加入 .gitignore 文件
项目右键  git -> add

控制台命令(以epes为例)
git commit -m "first commit"
git remote add origin http://192.168.2.12:13000/KMBranch/Proj26-epes.git

idea -> push

# git pr command
idea pull, idea commit

git branch hsiong;
git push origin hsiong;

# not a git repository (or any of the parent directories): .git
If occurred this issue by mistakenly deleting the .git directory, I recommend run the code blow
```shell 
git clone <repo_path>

# then copy the new .git dir to the old repository dir

```