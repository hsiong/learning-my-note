
# ssh 文件
## 使用SSH从服务器下载或上传文件
从远程服务器下载文件到本地
```
scp <用户名>@<ssh服务器地址>:<文件> <本地文件路径>
scp root@127.20.36.88:~/test.txt ~/Desktop
```

## 从远程服务器下载文件夹到本地
```
scp -r <用户名>@<ssh服务器地址>:<文件夹名> <本地路径>
scp -r root@127.20.36.88:~/test ~/Desktop
```

## 从本地上传文件到服务器上
```
scp <本地文件名> <用户名>@<ssh服务器地址>:<上传保存路径> 
```
## 从本地上传文件夹到服务器上
```
scp  -r <本地文件夹名> <用户名>@<ssh服务器地址>:<上传保存路径> 
```

# ssh 免密登录
https://www.jianshu.com/p/b294e9da09ad