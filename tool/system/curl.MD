***Refer***  
https://www.cnblogs.com/duhuo/p/5695256.html

curl -x xxxx url # 代理
curl -X xxx url # 指定请求类型 GET/POST
curl -H "header:xxx" # 加入 header
curl url >> file.name # 利用重定向保存网页
curl -O url # 下载文件到当前路径
curl -o file url # 下载文件到指定路径
curl -e "www.linux.com" http://mail.linux.com # 伪造referer（盗链）
