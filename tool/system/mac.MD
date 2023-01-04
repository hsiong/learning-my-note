
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