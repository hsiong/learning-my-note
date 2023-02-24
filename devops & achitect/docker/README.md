# docker-practice
This is a proj from Docker base learning to Docker practice.

- [docker-practice](#docker-practice)
- [序言](#序言)
  - [安装 Docker](#安装-docker)
    - [mac OS 安装 Docker](#mac-os-安装-docker)
    - [arch 安装 Docker](#arch-安装-docker)
    - [unbuntu install docker](#unbuntu-install-docker)
    - [修改 Docker 配置 (镜像路径, DNS, 硬盘占用)](#修改-docker-配置-镜像路径-dns-硬盘占用)
- [第一章 Docker容器操作](#第一章-docker容器操作)
  - [1.1 Docker Hello World](#11-docker-hello-world)
  - [1.2 Docker 初始化](#12-docker-初始化)
  - [1.3 其他操作](#13-其他操作)
    - [1.3.1 容器互联](#131-容器互联)
  - [1.4 常见问题](#14-常见问题)
- [第二章 Docker镜像操作](#第二章-docker镜像操作)
  - [2.1 管理和使用本地镜像](#21-管理和使用本地镜像)
  - [2.2 查找和操作镜像](#22-查找和操作镜像)
  - [2.3 创建个人镜像](#23-创建个人镜像)
    - [2.3.1 通过更新镜像创建个人镜像](#231-通过更新镜像创建个人镜像)
  - [2.3.2 通过 Dockerfile 构建一个全新的镜像, 详见第三章](#232-通过-dockerfile-构建一个全新的镜像-详见第三章)
- [第三章 Dockerfile详解](#第三章-dockerfile详解)
  - [3.1 新建 Dockerfile](#31-新建-dockerfile)
  - [3.2 构建对象](#32-构建对象)
  - [3.3 复制文件或者目录到容器里指定路径](#33-复制文件或者目录到容器里指定路径)
  - [3.4 ADD指令](#34-add指令)
- [第四章 Docker仓库管理](#第四章-docker仓库管理)
  - [4.1 推送镜像至 Docker 仓库或者阿里云仓库](#41-推送镜像至-docker-仓库或者阿里云仓库)
  - [4.2 搭建本地私有 Docker 仓库](#42-搭建本地私有-docker-仓库)
- [x](#x)
  - [x.1 Docker 部署 redis](#x1-docker-部署-redis)
  - [x.2 Docker 部署 postgres](#x2-docker-部署-postgres)
  - [x.x Docker 部署 nginx](#xx-docker-部署-nginx)
- [配置守护进程](#配置守护进程)
- [修改 docker 存储路径](#修改-docker-存储路径)
- [SpringBoot 使用SSH 通过A服务器跳板机 连接B服务器Mysql(安全策略)](#springboot-使用ssh-通过a服务器跳板机-连接b服务器mysql安全策略)
  - [Reference:](#reference)
  - [添加和修改 docker 容器端口映射的方法](#添加和修改-docker-容器端口映射的方法)
  - [不使用sudo运行docker](#不使用sudo运行docker)
  - [修复 docker postgres 重启后密码错误](#修复-docker-postgres-重启后密码错误)
  - [Docker容器互访三种方式](#docker容器互访三种方式)
  - [Docker 指定时区](#docker-指定时区)
  - [docker 网桥](#docker-网桥)
  - [docker 修改国内源](#docker-修改国内源)
  - [](#)

# 序言
本项目为个人的 Docker 笔记, 为学习 k8s 做铺垫.
主要参考资料: 
1. [Docker — 从入门到实践](https://yeasy.gitbook.io/docker_practice/)
2. [Postgres with Docker and Docker compose a step-by-step guide for beginners](https://geshan.com.np/blog/2021/12/docker-postgres/)
3. [Dockerfile 指令详解](http://www.ityouknow.com/docker/2018/03/15/docker-dockerfile-command-introduction.html)

## 安装 Docker
### mac OS 安装 Docker
```
brew install --cask --appdir=/Applications docker
```

使用```docker --version```检查是否安装成功

### arch 安装 Docker
1. 验证本地是否安装 Docker
```
pacman -Q | grep docker
```

2. 安装 Docker
```
sudo pacman -Ss docker
```

3. 设置开机启动
```
sudo systemctl start docker.service && sudo systemctl enable docker.service
```

4. 更改 docker 缓存路径  
[修改Docker数据目录位置，包含镜像位置](https://blog.51cto.com/u_15061951/3975869)

### unbuntu install docker
> 阿里云安装 docker
```
# 更新 apt
sudo apt-get update
# 安装必要的 ca 工具
sudo apt-get install ca-certificates curl gnupg lsb-release
# 添加GPG密钥
curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# 添加docker软件源
sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
# 下载并安装docker
sudo apt install docker-ce
# 配置docker-mirror为阿里源
sudo touch /etc/docker/daemon.json
sudo echo '{ "registry-mirrors": ["https://ra9q5uam.mirror.aliyuncs.com"] }' > /etc/docker/daemon.json
# 重启docker服务
sudo service docker restart
```

### 修改 Docker 配置 (镜像路径, DNS, 硬盘占用) 
```
vim /etc/docker/daemon.json

{
  "registry-mirrors": ["http://hub-mirror.c.163.com"],
  "builder": {
    "gc": {
      "defaultKeepStorage": "1GB",
      "enabled": true
    }
  },
  "features": {
    "buildkit": true
  },
  "experimental": false,
  "dns": ["119.29.29.29", "223.5.5.5"]
}
```

> 注意: 请不要配置 iptables: FALSE 等, 配置防火墙会导致容器网络异常  
> 其他平台配置参考: [https://www.runoob.com/docker/docker-mirror-acceleration.html](https://www.runoob.com/docker/docker-mirror-acceleration.html)


# 第一章 Docker容器操作
## 1.1 Docker Hello World
```
docker run ubuntu:15.10 /bin/echo "Hello world"
```
> Docker 允许您在容器内运行应用程序, 使用 docker run 命令来在容器内运行一个应用程序。
> + docker: Docker 的执行文件。
> + docker run: 运行一个容器。
> + ubuntu:15.10 指定要运行的镜像，Docker 首先从本地主机上查找镜像是否存在，如果不存在，Docker 就会从镜像仓库 Docker Hub 下载公共镜像。如果你不指定一个镜像的版本标签，例如你只使用 ubuntu，docker 将默认使用 ubuntu:latest 镜像。
> + /bin/echo "Hello world": 在启动的容器里执行的命令

+ `**root@8829940xxxxxxxxx:/#**`, 说明进入了系统的容器, 可以键入一些常用命令, 例如```ls``` ```pwd```等进行测试, 使用```exit```退出容器

## 1.2 Docker 初始化 
+ `docker pull xxxContainer` 拉取远程镜像
+ `docker run xxxContainer xxxCommand` 启动容器
  + `run -d` 后台运行容器  (-it 在 `exec` 中使用)
  + `-p ActualPort:ContainerPort` 将指定的主机端口绑定到容器内部端口, 注意 -P 大写是随机端口, -p 小写是指定端口, 使用同一端口即可
  + `-v severPath: ContainerPath` 配置将指定的主机路径绑定到容器内部端口路径映射, 可以是一个文件夹, 也可以是某个具体的文件
  + `-e` 配置启动参数
  + `--name `标识来命名容器
  + `-h HOSTNAME 或者 --hostname=HOSTNAME` 设定容器的主机名, 写到容器内的 /etc/hostname 和 /etc/hosts 
  + `--dns=ip` 指定某容器的DNS, 如果在容器启动时没有指定 --dns 和 --dns-search，Docker 会默认用宿主主机上的 /etc/resolv.conf 来配置容器的 DNS
+ `docker start ContainerID`启动已停止运行的容器
   + `docker ps`这个命令, 展示所有存活的容器; 
   + `docker ps -a`, 展示所有的容器, 包括已停止的
      + CONTAINER ID: 容器 ID。
      + IMAGE: 使用的镜像。
      + COMMAND: 启动容器时运行的命令。
      + CREATED: 容器的创建时间。
      + STATUS: 容器状态。状态有7种：
        + created（已创建）
        + restarting（重启中）
        + running 或 Up（运行中）
        + removing（迁移中）
        + paused（暂停）
        + exited（停止）
        + dead（死亡）
      + PORTS: 容器的端口信息和使用的连接类型（tcp\udp）。
      + NAMES: 分配的容器名称。

+ `docker exec ContainerId` 进入容器
  + 推荐使用`exec`进入容器, 退出终端也不会导致容器停止. 容器停止会导致事故. 
    + `-it xxx` 进入容器并执行命令
    + `-u xxx` 以 xxx 用户登录
  + `attach` 会导致生产事故, 严禁使用

在实际使用中, 常使用 `docker run -d` 初始化容器, `docker exec -it ContainerID /bin/bash` 进入容器进行具体的配置;   

所有支持 `ContainerId` 的操作, 也支持 `ContainerName`

## 1.3 其他操作
+ `docker export ContainerID > ExportPath/filename.tar` 导出容器
+ `docker import Url/ImportPathFileName newContainerName:newVersion` 导入容器
+ `docker inspect ContainerID` 查看容器配置
+ `docker stop ContainerID` 停止容器
+ `docker rm -f ContainerID` 删除容器
  + 注意: 在 Linux 系统中删除容器, 需要先停止容器再删除
+ `docker restart ContainerId` 重启容器
+ `docker port containerID` 查看某个容器的端口映射
+ `docker top containerID` 查看容器内部的进程
+ `docker logs ContainerId` 查看容器标准输出
+ `docker` 查看帮助, 或`docker xxxCommand --help`来查看某条命令的帮助

###  1.3.1 容器互联
端口映射并不是唯一把 docker 连接到另一个容器的方法。  
docker 有一个连接系统`允许将多个容器连接在一起`，共享连接信息。创建一个父子关系，其中父容器可以看到子容器的信息。  
步骤如下: 

1. 新建网络 test-net `$ docker network create -d bridge test-net`
> 参数说明：
> + -d：参数指定 Docker 网络类型，有 bridge、overlay。其中 overlay 网络类型用于 Swarm mode，目前可以忽略它。

2. 连接容器
+ 运行一个容器并连接到新建的 test-net 网络:  
```
$ docker run -d --name test1 --network test-net ubuntu
```

+ 再运行一个容器并加入到 test-net 网络:
```
$ docker run -d --name test2 --network test-net ubuntu
```

3. 通过 ping 测试 test1 容器和 test2 容器建立了互联关系。
```
docker exec -it test1 ping test2  
docker exec -it test2 ping test1  
```

+  如果 test1、test2 容器内中无 ping 命令，则在容器内执行以下命令安装 ping。参考 [2.2 创建个人镜像](#22-创建个人镜像) 在一个容器里安装好 ping 指令，提交容器到镜像，再以新的镜像运行多个容器, 避免重复安装
```
apt-get update & apt install iputils-ping
```

> 实际开发中, 如果有多个容器之间需要互相连接，推荐使用 Docker Compose

## 1.4 常见问题
1. 修改运行中容器的端口映射
+ 老版mac: https://www.xihrni.com/post/macos-yi-yun-xing-de-docker-rong-qi-tian-jia-xiu-gai-duan-kou-ying-she/
+ 新版mac(高于 Big Sur 11.3): 参考 https://www.xihrni.com/post/macos-yi-yun-xing-de-docker-rong-qi-tian-jia-xiu-gai-duan-kou-ying-she/ 中的 <b>如果出现没有 tty 文件无法登陆到容器</b>
> 注意: 修改运行中容器的端口代价非常高, 强烈建议您在镜像运行时即使用 `-p macPort:containerPort` 来指定端口

# 第二章 Docker镜像操作
镜像作为 Docker 交流的介质, 镜像操作是重中之重。
## 2.1 管理和使用本地镜像
1. 使用`docker images`列出本地镜像
> 各选项说明:
> + REPOSITORY：表示镜像的仓库源
> + TAG：镜像的标签
> + IMAGE ID：镜像ID
> + CREATED：镜像创建时间
> + SIZE：镜像大小
+ `docker image ls ContainId[:Version]` 根据仓库名列出镜像
+ `docker image ls `还支持强大的过滤器参数 --filter，或者简写 -f。之前我们已经看到了使用过滤器来列出虚悬镜像的用法，它还有更多的用法。比如，我们希望看到在 mongo:3.2 之后建立的镜像，可以用下面的命令：
```
$ docker image ls -f since=mongo:3.2
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
redis               latest              5f515359c7f8        5 days ago          183 MB
nginx               latest              05a60462f8ba        5 days ago          181 MB

# 想查看某个位置之前的镜像也可以，只需要把 since 换成 before 即可。
```
+ `docker image ls -q` 以特定格式显示, --filter 配合 -q 产生出指定范围的 ID 列表，然后送给另一个 docker 命令作为参数，从而针对这组实体成批的进行某种操作的做法在 Docker 命令行使用过程中非常常见，不仅仅是镜像，将来我们会在各个命令中看到这类搭配以完成很强大的功能。因此每次在文档看到过滤器后，可以多注意一下它们的用法。
+ `docker image ls --format` 对表格的结构不满意，希望自己组织列；或者不希望有标题，这样方便其它程序解析结果等，这就用到了 Go 的模板语法。
```
$ docker image ls --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}"
IMAGE ID            REPOSITORY          TAG
5f515359c7f8        redis               latest
05a60462f8ba        nginx               latest
fe9198c04d62        mongo               3.2
00285df0df87        <none>              <none>
329ed837d508        ubuntu              18.04
329ed837d508        ubuntu              bionic
```

## 2.2 查找和操作镜像
1. 查找镜像
+ 使用网址搜索: [https://hub.docker.com/search?type=image](https://hub.docker.com/search?type=image) 
+ `docker search ImageName` 使用命令
  + 参数说明
  + NAME: 镜像仓库源的名称
  + DESCRIPTION: 镜像的描述
  + OFFICIAL: 是否 docker 官方发布
  + stars: 类似 Github 的 star
  + AUTOMATED: 自动构建。

2. 拉取镜像`docker pull ImageName:Version`
3. 删除镜像`docker image rm ImageId` 或 `docker rmi ImageId`
  + 注意: 删除容器是`docker rm ContainerId`
  + 我们可以用镜像的完整 ID，也称为 长 ID，来删除镜像。使用脚本的时候可能会用长 ID，但是人工输入就太累了，所以更多的时候是用 短 ID 来删除镜像。docker image ls 默认列出的就已经是短 ID 了，一般取前3个字符以上，只要足够区分于别的镜像就可以了。 
  + 比如，我们需要删除所有仓库名为 redis 的镜像：`$ docker image rm $(docker image ls -q redis)`
  + 或者删除所有在 mongo:3.2 之前的镜像：`$ docker image rm $(docker image ls -q -f before=mongo:3.2)`
```
# 删除名为 registry-center 的镜像
docker images | grep "registry-center" | awk '{print $1":"$2}' | xargs docker rmi
```

4. 设置镜像标签 `docker tag 860c279d2fec runoob/centos:dev`
 + 为镜像id为860c279d2fec的镜像设置一个新的标签

5. 通过 `docker system df` 命令来便捷的查看镜像、容器、数据卷所占用的空间


> 虚悬镜像: 随着官方镜像维护，发布了新版本后，重新 docker pull mongo:3.2 时，mongo:3.2 这个镜像名被转移到了新下载的镜像身上，而旧的镜像上的这个名称则被取消，从而成为了 <none>。除了 docker pull 可能导致这种情况，docker build 也同样可以导致这种现象。由于新旧镜像同名，旧镜像名称被取消，从而出现仓库名、标签均为 <none> 的镜像。这类无标签镜像也被称为 虚悬镜像(dangling image) , 一般来说，虚悬镜像已经失去了存在的价值，是可以随意删除的。 可以用下面的命令专门显示这类镜像：

```
$ docker image ls -f dangling=true
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              00285df0df87        5 days ago          342 MB

# 删除虚悬镜像 
$ docker image prune
```



## 2.3 创建个人镜像
创建镜像有两种方式
+ 从已经创建的容器中更新镜像，并且提交这个镜像
+ 使用 Dockerfile 指令来创建一个新的镜像

### 2.3.1 通过更新镜像创建个人镜像
1. 更新镜像之前, 需要在指定的镜像的容器中进行相关操作
```
docker exec -it ContainerID xxxCommand
# 在home目录下新增一个文件
touch /home/test.jar 
exit 
```

2. 提交镜像`docker commit -m="msg" -a="author" ContainerID ImageName:Version`
```
docker commit -m="test" -a="hsiong" 253e855b1604 test/ubuntu:v2
```

3. 使用`docker images`查看新建镜像

4. 使用新镜像启动容器
```
docker run -it test/ubuntu:v2 /bin/bash

# 可以看到home目录下有刚才创建的文件
ls /home
```

## 2.3.2 通过 Dockerfile 构建一个全新的镜像, 详见第三章
1. 创建 Dockerfile 文件  
先创建一个 Dockerfile 文件, 来告诉 Docker 如何构建您的镜像

```
touch Dockerfile
# 指定镜像来源
FROM    centos:6.7 
# 维护者信息, MAINTAINER 指令已经被抛弃，建议使用 LABEL 指令。
MAINTAINER      Fisher "fisher@sudops.com" 

# 每条 RUN 指令将在当前镜像的基础上执行指定命令，并提交为新的镜像。当命令较长时可以使用 \ 来换行。
RUN     /bin/echo 'root:123456' |chpasswd 
RUN     useradd runoob
RUN     /bin/echo 'runoob:123456' |chpasswd
RUN     /bin/echo -e "LANG=\"en_US.UTF-8\"" >/etc/default/local
# 告诉 Docker 服务，容器需要暴露的端口号，供互联系统使用。在启动容器时需要通过 -P 参数让 Docker 主机分配一个端口转发到指定的端口。使用 -p 参数则可以具体指定主机上哪个端口映射过来。
EXPOSE  22 
EXPOSE  80
# 指定启动容器时执行的命令，每个 Dockerfile 只能有一条 CMD 命令。如果指定了多条 CMD 命令，只有最后一条会被执行。如果用户在启动容器时指定了要运行的命令，则会覆盖掉 CMD 指定的命令。
CMD     /usr/sbin/sshd -D 
```

2. 使用`docker build`构建镜像   
`docker build -t ImageName:Version DockerfilePath`
```
# 利用当前目录的Dockerfile创建镜像
docker build -t runoob/centos:6.7 .
```
参数详解
+ -t 指定镜像名
+ ImageName:Version 
+ DockerfilePath: 指定Dockerfile目录

# 第三章 Dockerfile详解
在上文您已经使用 Dockerfile 定制了一个镜像, 本章将详述 Dockerfile 的各个指令
## 3.1 新建 Dockerfile
```
# 在一个空目录下，新建一个名为 Dockerfile 文件
cd ~/test/test
vim Dockerfile

# 并在文件内添加以下内容

# 构建好的镜像内会有一个 /usr/share/nginx/html/index.html 文件
FROM nginx
RUN echo '这是一个本地构建的nginx镜像' > /usr/share/nginx/html/index.html
```
指令详解:
+ FROM：定制的镜像都是基于 FROM 的镜像，这里的 nginx 就是定制需要的基础镜像。后续的操作都是基于 nginx。除了选择现有镜像为基础镜像外，Docker 还存在一个特殊的镜像，名为 scratch。这个镜像是虚拟的概念，并不实际存在，它表示一个空白的镜像。如果你以 scratch 为基础镜像的话，意味着你不以任何镜像为基础，接下来所写的指令将作为镜像第一层开始存在。
+ RUN：用于执行后面跟着的命令行命令。有以下俩种格式：  
1. shell格式
```
# <命令行命令> 等同于，在终端操作的 shell 命令。
RUN <命令行命令>
```
2. exec格式
```
# 例如：RUN ["./test.php", "dev", "offline"] 等价于 RUN ./test.php dev offline
RUN ["可执行文件", "参数1", "参数2"]
```

&nbsp;

> 注意: Dockerfile 的 `RUN` 指令每执行一次都会在 docker 上新建一层。所以过多无意义的层，会造成镜像膨胀过大。例如以下命令执行会创建 3 层镜像。
``` 
FROM centos
RUN yum -y install wget
RUN wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz"
RUN tar -xvf redis.tar.gz
```

> 所以请您简化成以下格式。以 `&&` 符号连接命令，这样执行后，只会创建 1 层镜像。   
   + Dockerfile 支持 Shell 类的行尾添加 \ 的命令换行方式，以及行首 # 进行注释的格式。良好的格式，比如换行、缩进、注释等，会让维护、排障更为容易，这是一个比较好的习惯。 
   + 此外，还可以看到这一组命令的最后添加了清理工作的命令，删除了为了编译构建所需要的软件，清理了所有下载、展开的文件，并且还清理了 apt 缓存文件。这是很重要的一步，我们之前说过，镜像是多层存储，每一层的东西并不会在下一层被删除，会一直跟随着镜像。因此镜像构建时，一定要确保每一层只添加真正需要添加的东西，任何无关的东西都应该清理掉。
```
FROM centos
RUN yum -y install wget \
    && wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz" \
    && tar -xvf redis.tar.gz \
    && apt-get purge -y --auto-remove $buildDeps
```

## 3.2 构建对象

```
# 在 Dockerfile 文件的存放目录下，执行构建动作。
cd ~/test/test

# 通过当前目录下的 Dockerfile 构建一个 nginx:v3（镜像名称:镜像标签）
docker build -t nginx:v3 .

# docker build -t ImageName:Version DockerfilePath
```
> 参数详解
> + -t 指定镜像名
> + ImageName:Version 
> + DockerfilePath: 指定Dockerfile目录

## 3.3 复制文件或者目录到容器里指定路径
```
COPY dir1 dir2...  containerDir
COPY ["dir1", "dir2", ...  "containerDir"]
```
> 参数详解: 
> + dir1: 源文件或者源目录，这里可以是通配符表达式，其通配符规则要满足 Go 的 filepath.Match 规则
> + containerDir: 容器内的指定路径，该路径不用事先建好，路径不存在的话，会自动创建
> + `COPY [--chown=<user>:<group>]`: 可选参数，用户改变复制到容器内文件的拥有者和属组。例如: 
> `COPY --chown=user:mygroup files* /mydir/`
> 
> 参考链接: [Docker 合并多条 COPY 命令](https://xdhuxc.github.io/posts/docker/docker-copy-file-or-folder-one-command/)

> 注意: 
> 1. `COPY` 只能复制目录下的内容，不能复制目录，对于目录的复制, 要这样写
> `COPY templates/ /scmp/templates`
> 2. `COPY` 指令支持通配符，如果复制多个文件时，文件名称本身有规律，则可以使用通配符来实现
> ```
> # 复制所有以 "dingtalk" 开头的文件到 /xdhuxc/ 目录下
> COPY dingtalk* /xdhuxc/ 
> ```
> 3. 路径中包含空格时, 必须使用`COPY ["dir1", "dir2", ...  "containerDir"]`的形式, 例如: 
> `COPY ["~/test test/test.md", "/var/test test/test"]`

## 3.4 ADD指令
ADD 指令和 COPY 的格式和性质基本一致。但是在 COPY 基础上增加了一些功能。
1. 自动解压缩
如果 <源路径> 为一个 tar 压缩文件的话，压缩格式为 gzip, bzip2 以及 xz 的情况下，ADD 指令将会自动解压缩这个压缩文件到 <目标路径> 去。
```
# 在某些情况下，这个自动解压缩的功能非常有用，比如官方镜像 ubuntu 中：
FROM scratch
ADD ubuntu-xenial-core-cloudimg-amd64-root.tar.gz /

# 但在某些情况下，如果我们真的是希望复制个压缩文件进去，而不解压缩，
# 这时就不可以使用 ADD 命令了。
```

2. 从URL下载并复制到容器内
<del>比如 <源路径> 可以是一个 URL，这种情况下，Docker 引擎会试图去下载这个链接的文件放到 <目标路径> 去。下载后的文件权限自动设置为 600，如果这并不是想要的权限，那么还需要增加额外的一层 `RUN` 进行权限调整，另外，如果下载的是个压缩包，需要解压缩，也一样还需要额外的一层 `RUN` 指令进行解压缩。所以不如直接使用 `RUN` 指令，然后使用 `wget` 或者 `curl` 工具下载，处理权限、解压缩、然后清理无用文件更合理。</del><b>因此，这个功能其实并不实用，而且不推荐使用。</b>

> 所以, 在 Docker 官方的 [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) 中要求，尽可能的使用 COPY，因为 COPY 的语义很明确，就是复制文件而已，而 ADD 则包含了更复杂的功能，其行为也不一定很清晰。最适合使用 ADD 的场合，就是所提及的需要自动解压缩的场合。
> 
> 另外需要注意的是，ADD 指令会令镜像构建缓存失效，从而可能会令镜像构建变得比较缓慢。



# 第四章 Docker仓库管理
## 4.1 推送镜像至 Docker 仓库或者阿里云仓库
> 因为涉及到安全原因, 这并不是实际仓库部署的方式, 一带而过
https://www.runoob.com/docker/docker-repository.html

## 4.2 搭建本地私有 Docker 仓库
> 在实际的开发和生产过程中, 因为安全原因, 我们常使用本地私有仓库来分发 Docker 镜像。
> docker-registry 是官方提供的工具，可以用于构建私有的镜像仓库。
> 参考链接: https://yeasy.gitbook.io/docker_practice/repository/registry

1. 运行镜像`registry`
```
# 使用官方的 registry 镜像来启动私有仓库。默认情况下，仓库会被创建在容器的 /var/lib/registry 目录下
docker run -d -p 5000:5000 --restart=always --name registry registry
```

您可以通过 -v 参数来将镜像文件存放在本地的指定路径。例如下面的例子将上传的镜像放到本地的 /opt/data/registry 目录。
```
docker run -d \
    -p 5000:5000 \
    -v /opt/data/registry:/var/lib/registry \
    registry
```




# x

## x.1 Docker 部署 redis
docker run -d --name redis -m 200m -p 6379:6379 redis

## x.2 Docker 部署 postgres
docker run -d --name postgres -p 5432:5432 -m 1G -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=123456 kartoza/postgis

## x.x Docker 部署 nginx

> Docker 部署 nginx 需要指定以下内容:
> 1. 指定名字, 方便日后的管理
> 2. 指定端口映射, 本地 -> 远程
> 3. 映射配置文件路径
>   + 此步

```
docker run --name nginx -p 80:80 -v /root/config/docker/default.conf:/etc/nginx/conf.d/default.conf  -d nginx
```

# 配置守护进程
/etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl restart docker

# 修改 docker 存储路径 
https://blog.csdn.net/xhtchina/article/details/119876054


> ca 证书 
https://www.cnblogs.com/-wenli/p/13555833.html

> docker 文件无法映射 
https://codeantenna.com/a/sG54XRlW2Z

> docker code=exited, status=1   
可能是 /etc/docker/daemon.json 配置出错; 检查 daemon.json 且不能为空
https://containerization-automation.readthedocs.io/zh_CN/latest/docker/faq/service%E5%90%AF%E5%8A%A8docker%E5%A4%B1%E6%95%88/

# SpringBoot 使用SSH 通过A服务器跳板机 连接B服务器Mysql(安全策略)
## Reference: 
https://blog.csdn.net/weixin_40461281/article/details/103695882

+ 先设置 ssh 免密登录
+ ssh-keygen -t rsa
+ cat ~/.ssh/id_rsa.pub 
+ vim ~/.ssh/authorized_keys
+ ssh -fN -L5433:localhost:5432 -p22 root@localhost

## 添加和修改 docker 容器端口映射的方法
https://cloud.tencent.com/developer/article/1833131
```
systemctl stop docker 

cd /var/lib/docker/containers/363ff2d*

# 修改 hostconfig.json
"PortBindings":{"443/tcp":[{"HostIp":"","HostPort":"443"}],"80/tcp":[{"HostIp":"","HostPort":"80"}]},

# 修改 config.v2.json
"ExposedPorts":{"443/tcp":{},"80/tcp":{}}

systemctl start docker 
docker start nginx
```

## 不使用sudo运行docker
> https://www.myfreax.com/how-to-install-and-use-docker-on-ubuntu-20-04/


默认情况下，只有root用户，[具有sudo权限的用户](https://www.myfreax.com/how-to-create-a-sudo-user-on-ubuntu/)以及docker组成员可以执行docker命令。

但是docker我们经常使用的命令，没有必须每次运行docker都使用或者切换docker用户。

如果在要以非root用户或者docker用户运行Docker，您需要将您的用户添加到docker组中。

docker组的成员可以运行docker，而不必每次使用sudo命令切换用户运行。你可使用`usermod`[命令](https://www.myfreax.com/usermod-command-in-linux/)将当前用户追加到docker组中。

```shell
sudo usermod -aG docker $USER
newgrp docker
```

`$USER`是保存您的用户名，`newgrp`命令使usermod命令更改在当前终端中生效。

现在您可以在不添加[`sudo`](https://www.myfreax.com/sudo-command-in-linux/)的情况下执行`docker`命令，让我们将[运行](https://www.myfreax.com/docker-run-command/)Docker官方Hello-World测试容器`docker container run hello-world`以是否正确配置。

该命令将下载测试镜像，然后运行它，它将打印Hello from Docker消息。由于没有长时间运行的进程，因此容器在打印完消息后将停止。

## 修复 docker postgres 重启后密码错误
```
systemctl stop docker 

cd /var/lib/docker/containers/363ff2d*

# 修改 config.v2.json, env 修改
"POSTGRES_PASSWORD=xxxx"

systemctl start docker 
docker start postgres
```

## Docker容器互访三种方式
我们都知道docker容器之间是互相隔离的，不能互相访问，但如果有些依赖关系的服务要怎么办呢。下面介绍三种方法解决容器互访问题。

用于处理在 docker-java 中访问 redis/posgres 以及 nginx 做反向代理等出现 localhost 127.0.0.1 不能访问的情况

https://blog.csdn.net/junehappylove/article/details/107387362

## Docker 指定时区
https://cloud.tencent.com/developer/article/1626811

运行时加入参数: -e TZ=Asia/Shanghai

```
docker run --name test -e TZ=Asia/Shanghai --rm -ti debian /bin/bash
/# date
Fri Nov 29 18:46:18 CST 2019
```

## docker 网桥
https://docs.docker.com.zh.xy2401.com/compose/networking/
https://s1973.top/blog/001597819247602cb6a8f5c30624b868447f77b48d63fe5000

如果您对服务进行配置更改并运行docker-compose up进行更新，则会删除旧容器，而新容器将使用其他IP地址但名称相同的网络加入网络。运行中的容器可以查找该名称并连接到新地址，但是旧地址会停止工作。

如果有任何容器打开了到旧容器的连接，则它们将被关闭。检测这种情况，再次查找名称并重新连接是容器的责任。

```
version: "3"
services:

  web:
    build: .
    ports:
      - "8000:8000"
  db:
    image: postgres

networks:
  default:
    # Use a custom driver
    name: custom-driver-1
```


## docker 修改国内源 

```
"https://hub-mirror.c.163.com",
"https://registry.aliyuncs.com",
"https://registry.docker-cn.com",
"https://docker.mirrors.ustc.edu.cn"
```

sudo service docker restart

docker restart nginx, ...


## 












