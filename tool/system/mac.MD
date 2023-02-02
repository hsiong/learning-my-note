
# 1. Mac OS遇到 Operation not permitted 问题
[https://blog.csdn.net/WangJiankun_ls/article/details/103110241](https://blog.csdn.net/WangJiankun_ls/article/details/103110241)

# 2. Mac新建文件夹报错，mkdir()：Operation not supported
[https://learnku.com/articles/65155](https://learnku.com/articles/65155)

# 3. IDEA PERMISSION DENIED
`sudo chmod -R username:usergroup FilePath`

# homebrew install specific version
https://shockerli.net/post/homebrew-install-formula-specific-version/

# mac compile java opencv
https://juejin.cn/post/7006821354397761543

/opt/homebrew/Cellar/opencv/4.6.0_1/share/java/opencv4

```
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.6.0.zip

cd opencv-4.5.0
mkdir build && cd build

cmake 
-DWITH_OPENJPEG=OFF \
-DWITH_IPP=OFF \
-D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local/opencv \
-D JAVA_INCLUDE_PATH=$JAVA_HOME/include \
-D JAVA_AWT_LIBRARY=$JAVA_HOME/jre/lib/amd64/libawt.so \
-D JAVA_JVM_LIBRARY=$JAVA_HOME/jre/lib/arm/server/libjvm.so \
-D BUILD_opencv_python2=OFF \
-D BUILD_opencv_java=ON \
-D INSTALL_PYTHON_EXAMPLES=OFF \
-D INSTALL_C_EXAMPLES=OFF \
-D OPENCV_ENABLE_NONFREE=OFF \
-D BUILD_EXAMPLES=ON
```

# m1 slim compatity
docker hub 找 支持 linux/arm64 的镜像即可

# m1 chip run windows11 
https://kb.parallels.com/en/122702

# fix “This Application cannot run under a Virtual Machine”
https://securedstatus.com/how-to-fix-this-application-cannot-run-under-a-virtual-machine/

# paralle desktop delete image
https://www.baidu.com/s?ie=utf-8&f=3&rsv_bp=1&rsv_idx=1&tn=baidu&wd=parallels%20desktop%E5%A6%82%E4%BD%95%E5%88%A0%E9%99%A4%E9%95%9C%E5%83%8F&fenlei=256&rsv_pq=0xb460e606000f381e&rsv_t=a28bZab9xE3KKEg04%2FhB2OAn81EaXiyAi1dx3Wb90kLaDNAjqEn%2FAxzS9h8Z&rqlang=en&rsv_enter=1&rsv_dl=is_8&rsv_sug3=2&rsv_sug1=3&rsv_sug7=100&rsv_sug2=0&rsv_btype=i&prefixsug=parallels%2520desktop%2520%25E9%2595%259C%25E5%2583%258F&rsp=8&inputT=5437&rsv_sug4=5436