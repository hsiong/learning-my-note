#!/bin/bash -ex

# -- 使用之前, 需实现 ssh 免密登录
# 	-- 查看本地公钥 cat ~/.ssh/id_rsa_pub
# 	-- 将公钥复制到远程服务器authorized_keys中 vim ~/.ssh/authorized_keys


# -- 本地jar路径 需要替换
export localFilePath='/local/auth.jar'

scp -r $localFilePath $remoteUser@$remoteAddress:$remoteFilePath
ssh $remoteUser@$remoteAddress << remotessh

# auth服务, 最后注册
sh /path/start.sh

exit
remotessh

