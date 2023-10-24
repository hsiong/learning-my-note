
# 1. Mac OS遇到 Operation not permitted 问题
[https://blog.csdn.net/WangJiankun_ls/article/details/103110241](https://blog.csdn.net/WangJiankun_ls/article/details/103110241)

# 2. Mac新建文件夹报错，mkdir()：Operation not supported
[https://learnku.com/articles/65155](https://learnku.com/articles/65155)

# 3. IDEA PERMISSION DENIED
`sudo chmod -R username:usergroup FilePath`

# mac compile java opencv

## Manual Install Mac

https://zhuanlan.zhihu.com/p/392751819

```shell
mkdir cd ~/Desktop/build & cd ~/Desktop/build

cmake -S ../opencv-4.7.0 \
-D OPENCV_EXTRA_MODULES_PATH=~/Desktop/opencv_contrib-4.7.0/modules \
-D OPENCV_ENABLE_SUPERRES=ON \
-D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_VERBOSE_MAKEFILE=ON \
-D CMAKE_INSTALL_PREFIX=/opt/homebrew/Cellar/opencv \
-D JAVA_INCLUDE_PATH=$JAVA_HOME/include \
-D JAVA_AWT_LIBRARY=$JAVA_HOME/lib/libawt.dylib \
-D JAVA_JVM_LIBRARY=$JAVA_HOME/lib/server/libjvm.dylib \
-D WITH_OPENJPEG=OFF \
-D WITH_IPP=OFF \
-D BUILD_TESTS=OFF \
-D BUILD_PERF_TESTS=OFF \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D INSTALL_C_EXAMPLES=OFF \
-D OPENCV_ENABLE_NONFREE=ON \
-D BUILD_EXAMPLES=OFF \
-D BUILD_opencv_python2=OFF \
-D BUILD_opencv_python3=OFF \
-D BUILD_opencv_java=ON \
-D BUILD_opencv_core=ON \
-D BUILD_opencv_video=ON \
-D BUILD_opencv_imgcodecs=ON \
-D BUILD_opencv_superres=ON \
-D BUILD_opencv_dnn_superres=ON \
-D BUILD_opencv_ml=ON \
-D BUILD_opencv_dnn=ON \
-D BUILD_opencv_tests=OFF \
-D BUILD_opencv_apps=OFF \
-D BUILD_opencv_ts=OFF

make all

sudo make install

```


# linux manual install

> mac: HOMEBREW_NO_AUTO_UPDATE=1 brew edit opencv

```
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.6.0.zip

cd opencv-4.5.0
mkdir build && cd build

cmake -D WITH_OPENJPEG=OFF \
-D WITH_IPP=OFF \
-D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local/opencv \
-D JAVA_INCLUDE_PATH=$JAVA_HOME/include \
-D JAVA_AWT_LIBRARY=$JAVA_HOME/jre/lib/amd64/libawt.so \
-D JAVA_JVM_LIBRARY=$JAVA_HOME/jre/lib/arm/server/libjvm.so \
-D BUILD_opencv_python2=OFF \
-D BUILD_opencv_python3=OFF \
-D BUILD_opencv_java=ON \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D INSTALL_C_EXAMPLES=OFF \
-D OPENCV_ENABLE_NONFREE=OFF \
-D BUILD_EXAMPLES=ON

make all -j$(grep -c ^processor /proc/cpuinfo)

sudo make install -j$(grep -c ^processor /proc/cpuinfo)   
```

## newest-release
https://juejin.cn/post/7006821354397761543

/opt/homebrew/Cellar/opencv/4.6.0_1/share/java/opencv4

## homebrew install specific version
https://shockerli.net/post/homebrew-install-formula-specific-version/

+ brew info opencv
+ brew tap-info homebrew/core  
+ cd /opt/homebrew/Library/Taps/homebrew/homebrew-core
+ git log -p -- Formula/opencv.rb | grep -e ^commit -e 'url "http'
+ git checkout f54d39e63b609a2ae25dd039f9edae6c82120f96 --force
+ HOMEBREW_NO_AUTO_UPDATE=1 
+ brew edit opencv
+ brew install --build-from-source --formula ./Formula/opencv.rb
+ git checkout master

# m1 slim compatity
docker hub 找 支持 linux/arm64 的镜像即可

# m1 chip run windows11 
https://kb.parallels.com/en/122702

# fix “This Application cannot run under a Virtual Machine”
https://securedstatus.com/how-to-fix-this-application-cannot-run-under-a-virtual-machine/

# paralle desktop delete image
https://www.baidu.com/s?ie=utf-8&f=3&rsv_bp=1&rsv_idx=1&tn=baidu&wd=parallels%20desktop%E5%A6%82%E4%BD%95%E5%88%A0%E9%99%A4%E9%95%9C%E5%83%8F&fenlei=256&rsv_pq=0xb460e606000f381e&rsv_t=a28bZab9xE3KKEg04%2FhB2OAn81EaXiyAi1dx3Wb90kLaDNAjqEn%2FAxzS9h8Z&rqlang=en&rsv_enter=1&rsv_dl=is_8&rsv_sug3=2&rsv_sug1=3&rsv_sug7=100&rsv_sug2=0&rsv_btype=i&prefixsug=parallels%2520desktop%2520%25E9%2595%259C%25E5%2583%258F&rsp=8&inputT=5437&rsv_sug4=5436

# macOS 上 ⌘ W（关闭 Window）和 ⌘ Q (关闭应用 )
https://www.zhihu.com/question/21143701

# git idea local change 怎么打开
https://blog.csdn.net/comeilmforever/article/details/107753783

# mac 彻底删除 idea
```
打开终端, 删除以下和 webstorm 以及 Jetbrain 相关的所有文件夹
cd ~/Library/Preferences/
ls 查看该目录下所有App文件夹,找到webstrom的文件夹(我的是WebStrom2018.3)
rm -rf WebStrom2018.3
cd ~/Library/Caches/
ls 查看该目录下所有App文件夹,找到webstrom的文件夹(我的是WebStrom2018.3)
rm -rf WebStrom2018.3
cd ~/Library/Application Support/
ls 查看该目录下所有App文件夹,找到webstrom的文件夹(我的是WebStrom2018.3)
rm -rf WebStrom2018.3
~/Library/Logs/
ls 查看该目录下所有App文件夹,找到webstrom的文件夹(我的是WebStrom2018.3)
rm -rf WebStrom2018.3
```

# mac 修改快捷键 
https://www.zhihu.com/question/381319396

System Preference -> Keyboard Shortcut -> App Shortcut -> 

# can't change default app
Get Info -> open With -> change default app


# Mac app
vss/vsd -> EdrawMax

# Mac系统输入法长按一个按键不能连续输入
```shell
defaults write NSGlobalDomain ApplePressAndHoldEnabled -boolean false
```
https://www.jianshu.com/p/74dda481ed24

# Postman

## postman 导出 curl 命令
https://www.cnblogs.com/hi3254014978/p/15585732.html
直接右侧tab页, 展开 code