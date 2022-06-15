# docker-practice
This is a proj from Docker base learning to Docker practice.

- [docker-practice](#docker-practice)
- [序言](#序言)
  - [安装 Docker](#安装-docker)
    - [mac OS 安装 Docker](#mac-os-安装-docker)
    - [arch 安装 Docker](#arch-安装-docker)
  - [设置 Docker镜像](#设置-docker镜像)
- [第一章 Docker容器操作](#第一章-docker容器操作)
  - [1.1 Docker Hello World](#11-docker-hello-world)
  - [1.2 使用Docker](#12-使用docker)
  - [1.3 导入导出删除 Docker 容器](#13-导入导出删除-docker-容器)
  - [1.4 运行一个 Docker 应用](#14-运行一个-docker-应用)
  - [1.5 容器链接](#15-容器链接)
    - [1.5.1 容器网络端口映射](#151-容器网络端口映射)
    - [1.5.2 容器互联](#152-容器互联)
- [第二章 Docker镜像操作](#第二章-docker镜像操作)
  - [2.1 管理和使用本地镜像](#21-管理和使用本地镜像)
  - [2.2 创建个人镜像](#22-创建个人镜像)
    - [2.2.1 更新镜像](#221-更新镜像)
    - [2.2.2 构建一个全新的镜像](#222-构建一个全新的镜像)
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

# 序言
本项目基于 mac OS 系统, 在开始本项目之前, 假设您已经做好了一切基于 mac OS homebrew/git 等相关的准备工作. 

本课程前半部分基于菜鸟教程编写, 因为菜鸟有一些结构混乱/表述不清甚至是错误的地方, 在菜鸟基础上重新优化, 便于使用和总结. 

后半部分主要参考资料: 
1. [Docker — 从入门到实践](https://yeasy.gitbook.io/docker_practice/)
2. [Postgres with Docker and Docker compose a step-by-step guide for beginners](https://geshan.com.np/blog/2021/12/docker-postgres/)
3. [Dockerfile 指令详解](http://www.ityouknow.com/docker/2018/03/15/docker-dockerfile-command-introduction.html)

## 安装 Docker
### mac OS 安装 Docker
```
brew install --cask --appdir=/Applications docker
```
在载入 Docker app 后，点击 Next，可能会询问你的 macOS 登陆密码，你输入即可。之后会弹出一个 Docker 运行的提示窗口，状态栏上也有有个小鲸鱼的图标（）。

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

## 设置 Docker镜像
1. 获取阿里云镜像地址: [https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors](https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors)

2. mac设置: 
任务栏点击 Docker for mac 应用图标-> Perferences -> Docker Engine
在配置json中新增 "registry-mirrors":["镜像地址"],

3. 验证
输入```docker info```, 观察 **Registry Mirrors** 一栏, 出现**您输入的镜像地址**即可

4. 参数调整
因为本项目是学习目的, 故此无需占用太多资源.  
任务栏点击 Docker for mac 应用图标-> Perferences -> Resource -> ADVANCED.  
将各资源占用调到最低, 保存并重启即可

> 其他平台参考: [https://www.runoob.com/docker/docker-mirror-acceleration.html](https://www.runoob.com/docker/docker-mirror-acceleration.html)


# 第一章 Docker容器操作
## 1.1 Docker Hello World
1. Docker 允许您在容器内运行应用程序, 使用 docker run 命令来在容器内运行一个应用程序。
```
docker run ubuntu:15.10 /bin/echo "Hello world"
```
> 命令解析
> + docker: Docker 的执行文件。
> + docker run: 运行一个容器。
> + ubuntu:15.10 指定要运行的镜像，Docker 首先从本地主机上查找镜像是否存在，如果不存在，Docker 就会从镜像仓库 Docker Hub 下载公共镜像。如果你不指定一个镜像的版本标签，例如你只使用 ubuntu，docker 将默认使用 ubuntu:latest 镜像。
> + /bin/echo "Hello world": 在启动的容器里执行的命令

2. 运行交互式的容器
您通过 docker 的两个参数 -i -t，让 docker 运行的容器实现"对话"的能力：
```
docker run -i -t ubuntu:15.10 /bin/bash
```
> 命令解析
> + -t: 在新容器内指定一个伪终端或终端。
> + -i: 允许你对容器内的标准输入 (STDIN) 进行交互。

注意 **root@8829940xxxxxxxxx:/#**, 说明此时您已进入一个 ubuntu15.10 系统的容器, 您可以键入一些常用命令, 例如```ls``` ```pwd```等进行测试, 使用```exit```退出容器

3. 启动容器(后台模式)
```
docker run -d ubuntu:15.10 /bin/sh -c "while true; do echo hello world; sleep 1; done"
```
> 命令解析  
> + ```/bin/sh -c  while true; do echo hello world; sleep 1; done``` 在容器中运行一个循环命令  
> + -d 后台运行

## 1.2 使用Docker 
1. 拉取远程镜像```docker pull xxxContainer```
2. 启动容器```docker -it xxxContainer xxxCommand```
3. 启动已停止运行的容器
   + 前面您已经使用过```docker ps```这个命令, 该命令会展示所有存活的容器; 现在请您使用```docker ps -a```, 将展示所有的容器, 包括已停止的
   + 启动已停止的容器```docker start ContainerID```
4. 重启容器`docker restart ContainerId`
5. 进入容器`docker attach ContainerId`或`docker exec ContainerId`指令, 推荐使用后者, 因为`exec`退出终端也不会导致容器停止. 在生产环境, 容器停止容易导致事故. 
> 注意: 在实际使用中, 我们常使用 `run -d` 来运行容器(运行虚拟化系统, 例如ubuntu, 依然需要使用`run -itd`), `exec -it` 来执行具体的命令
```
docker exec -it 243c32535da7 /bin/bash
```

## 1.3 导入导出删除 Docker 容器
1. 导出容器`docker export ContainerID > ExportPath/filename.tar`
2. 导入容器`docker import Url/ImportPathFileName newContainerName:newVersion`
3. 删除容器`docker rm -f ContainerID`
> 注意: 在终端删除容器, 容器需要是停止状态, 在 Dashborad 则无此限制

## 1.4 运行一个 Docker 应用
前面您运行的容器并没有一些什么特别的用处。接下来请您尝试使用 docker 构建一个 web 应用程序。
1. 在docker容器中运行一个 Python Flask 应用来运行一个web应用。
```
# 载入镜像
docker pull training/webapp  
docker run -d -P training/webapp python app.py
```
>参数说明:
> + -d:让容器在后台运行。加了 -d 参数默认不会进入容器，想要进入容器需要使用指令`docker exec`
> + -P:将容器内部使用的网络端口随机映射到您使用的主机上。

终端输入`docker ps`, 您可以找到映射的端口信息, 可以发现 docker 将本机的51000端口映射到了5000
```
PORTS
0.0.0.0:51000->5000/tcp
```

这时, 终端输入`curl 127.0.0.1:51000`, 输出 **Hello World**, 这时, 您成功启动了您的第一个 Docker 应用

2. 您也可以使用 run -p 来指定映射的端口, 注意 -P 大写是随机, -p 小写是指定端口
```
docker run -d -p 5000:5000 training/webapp python app.py
```

3. 快捷查看某个容器的端口映射`docker port containerID/containName`

4. 查看容器内部的进程`docker top containerID`

5. 重启容器`docker restart containerID`


6. 输入```docker ps```来查看容器运行状态
```
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS     NAMES
1f752b10ae30   ubuntu:15.10   "/bin/sh -c 'while t…"   13 seconds ago   Up 13 seconds             epic_wilson
```
> 运行状态介绍
> + CONTAINER ID: 容器 ID。
> + IMAGE: 使用的镜像。
> + COMMAND: 启动容器时运行的命令。
> + CREATED: 容器的创建时间。
> + STATUS: 容器状态。状态有7种：
>   + created（已创建）
>   + restarting（重启中）
>   + running 或 Up（运行中）
>   + removing（迁移中）
>   + paused（暂停）
>   + exited（停止）
>   + dead（死亡）
> + PORTS: 容器的端口信息和使用的连接类型（tcp\udp）。
> + NAMES: 自动分配的容器名称。

7. 输入```docker logs 容器ID或容器名```查看容器内标准输出
```
docker logs 1f752b10ae30
docker logs epic_wilson
```

8. 停止容器```docker stop 容器ID或容器名```

9. 可以使用```docker```命令来查看帮助, 或```docker xxxCommand --help```来查看某条命令的帮助

10. 容器命名
当您创建一个容器的时候，docker 会自动对它进行命名。另外，您也可以使用 `--name `标识来命名容器



## 1.5 容器链接
### 1.5.1 容器网络端口映射
1. 基础操作
之前您已经介绍过了`docker run -P`和`docker run -p`以及`docker port`指令, 想必您已经熟悉了这三个指令的基本用法
```
# -P :是容器内部端口随机映射到主机的端口。
docker run -d -P training/webapp python app.py 

# -p : 将指定的主机端口绑定到容器内部端口。
# 注意: 这里菜鸟表述的有问题
docker run -d -p ActualPort:ContainerPort training/webapp python app.py

# 可以指定容器绑定的网络地址，比如绑定 127.0.0.1。
docker run -d -p 127.0.0.1:5001:5000 training/webapp python app.py

# 查看容器所有端口的实际映射情况
docker port adoring_stonebraker

# 查看容器某个端口的实际映射情况
docker port adoring_stonebraker 5000

```

2. 修改运行中容器的端口映射
+ 老版mac: https://www.xihrni.com/post/macos-yi-yun-xing-de-docker-rong-qi-tian-jia-xiu-gai-duan-kou-ying-she/
+ 新版mac(Big Sur 11.3 版本): 直接参考上文的 <b>如果出现没有 tty 文件无法登陆到容器</b>

> 注意: 修改运行中容器的端口代价非常高, 强烈建议您在镜像运行时即使用 `-p macPort:containerPort` 来指定端口

### 1.5.2 容器互联
端口映射并不是唯一把 docker 连接到另一个容器的方法。  
docker 有一个连接系统允许将多个容器连接在一起，共享连接信息。  
docker 连接会创建一个父子关系，其中父容器可以看到子容器的信息。

1. 新建网络
`$ docker network create -d bridge test-net`
> 参数说明：
> + -d：参数指定 Docker 网络类型，有 bridge、overlay。其中 overlay 网络类型用于 Swarm mode，在本小节中你可以忽略它。

2. 连接容器
```
# 运行一个容器并连接到新建的 test-net 网络:
$ docker run -itd --name test1 --network test-net ubuntu

# 再运行一个容器并加入到 test-net 网络:
$ docker run -itd --name test2 --network test-net ubuntu
```

3. 测试链接
```
# 通过 ping 来证明 test1 容器和 test2 容器建立了互联关系。
docker exec -it test1 ping test2  
docker exec -it test2 ping test1  
```
> 如果 test1、test2 容器内中无 ping 命令，则在容器内执行以下命令安装 ping。  
> (请参考 [2.2 创建个人镜像](#22-创建个人镜像) 尝试在一个容器里安装好，提交容器到镜像，在以新的镜像重新运行以上俩个容器)
> 如果有多个容器之间需要互相连接，推荐使用 Docker Compose
```
apt-get update
apt install iputils-ping
```

4. 其他指令
+ 设定容器的主机名, 写到容器内的 /etc/hostname 和 /etc/hosts `-h HOSTNAME 或者 --hostname=HOSTNAME`
+ 指定某容器的DNS `--dns=ip`
> 如果在容器启动时没有指定 --dns 和 --dns-search，Docker 会默认用宿主主机上的 /etc/resolv.conf 来配置容器的 DNS


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
2. 查找镜像
+ 使用网址搜索 [https://hub.docker.com/search?type=image](https://hub.docker.com/search?type=image)
+ 使用命令`docker search ImageName`
  + > 参数说明
  + > + NAME: 镜像仓库源的名称
  + > + DESCRIPTION: 镜像的描述
  + > + OFFICIAL: 是否 docker 官方发布
  + > + stars: 类似 Github 的 star
  + > + AUTOMATED: 自动构建。

3. 拉取镜像`docker pull ImageName:Version`
4. 删除镜像`docker rmi ImageName`
> 注意: 删除容器是`docker rm ContainerName`

5. 设置镜像标签 `docker tag 860c279d2fec runoob/centos:dev`
> 为镜像id为860c279d2fec的镜像设置一个新的标签

## 2.2 创建个人镜像
创建镜像有两种方式
+ 从已经创建的容器中更新镜像，并且提交这个镜像
+ 使用 Dockerfile 指令来创建一个新的镜像

### 2.2.1 更新镜像
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

### 2.2.2 构建一个全新的镜像
1. 创建 Dockerfile 文件
使用`docker build`构建, 为此, 需要创建一个 Dockerfile 文件, 来告诉 Docker 如何构建您的镜像

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

2. 构建镜像
```
# 利用当前目录的Dockerfile创建镜像
docker build -t runoob/centos:6.7 .

# docker build -t ImageName:Version DockerfilePath
```
> 参数详解
> + -t 指定镜像名
> + ImageName:Version 
> + DockerfilePath: 指定Dockerfile目录

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
> 指令详解:
> + FROM：定制的镜像都是基于 FROM 的镜像，这里的 nginx 就是定制需要的基础镜像。后续的操作都是基于 nginx。  
> + RUN：用于执行后面跟着的命令行命令。有以下俩种格式：  
```
1. shell格式
# <命令行命令> 等同于，在终端操作的 shell 命令。
RUN <命令行命令>

2. exec格式
# 例如：RUN ["./test.php", "dev", "offline"] 等价于 RUN ./test.php dev offline
RUN ["可执行文件", "参数1", "参数2"]
```

&nbsp;

> 注意: Dockerfile 的 `RUN` 指令每执行一次都会在 docker 上新建一层。所以过多无意义的层，会造成镜像膨胀过大。例如以下命令执行会创建 3 层镜像。
> ``` 
> FROM centos
> RUN yum -y install wget
> RUN wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz"
> RUN tar -xvf redis.tar.gz
> ```
> 所以请您简化成以下格式。以 `&&` 符号连接命令，这样执行后，只会创建 1 层镜像。
> ```
> FROM centos
> RUN yum -y install wget \
>     && wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz" \
>     && tar -xvf redis.tar.gz
> ```

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


ca 证书 
https://www.cnblogs.com/-wenli/p/13555833.html