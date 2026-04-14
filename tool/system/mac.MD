
# 1. Mac OS遇到 Operation not permitted 问题
[https://blog.csdn.net/WangJiankun_ls/article/details/103110241](https://blog.csdn.net/WangJiankun_ls/article/details/103110241)

# 2. Mac新建文件夹报错，mkdir()：Operation not supported
[https://learnku.com/articles/65155](https://learnku.com/articles/65155)

# 3. IDEA PERMISSION DENIED
`sudo chmod -R username:usergroup FilePath`

# mac compile java opencv

## Manual Install on Mac

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
display tester -> https://tool.maxiaobang.com/screentest/

# Mac系统输入法长按一个按键不能连续输入
```shell
defaults write NSGlobalDomain ApplePressAndHoldEnabled -boolean false
```
https://www.jianshu.com/p/74dda481ed24

# Postman

## postman 导出 curl 命令
https://www.cnblogs.com/hi3254014978/p/15585732.html
直接右侧tab页, 展开 code

# touchpad
## gesture
单指轻触   单击
双指轻触   右键
三指轻触    拖动窗口

四指向上刷, 打开多桌面
四指左右刷, 多桌面切换
五指合拢, 打开应用中心

## drag with three finger
-> use trackpad for dragging
-> Dragging style: Three Finger Drag

## Mac 如何显示隐藏文件以及如何隐藏文件？
在 Mac 上有时候我们想查看一些隐藏文件，怎么办呢？只需要输入快捷键

Command + Shift + . 

# 远程访问

## muCommander  sftp
```
sftp://domain/dir
sftp://www.test.com/home/ubuntu/backend/dingding-bot
```




# 美区账号准备

https://zhpengfei.com/how-to-register-a-us-apple-id-with-a-domestic-phone-number-for-free/

## 第一步、美区Apple ID 开始注册前的准备：

### 1.1、准备一个干净的邮箱（没注册过Apple ID）

### 1.2、准备一个干净的国内手机号（没有注册/绑定过Apple ID）

## 第二步、开始 注册美区Apple ID

### 2.1、 在浏览器内打开苹果官网注册网址：

[https://appleid.apple](https://appleid.apple.com/account)[.](https://appleid.apple.com/account)[com/account](https://appleid.apple.com/account)

### 2.2、在打开的**创建您的 Apple ID** 页面，按照页面指示完善个人信息。

![fa49f93eb8d072568224039a50701b96 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2023/08/fa49f93eb8d072568224039a50701b96-827x1024.jpg)美区Apple ID

![d233a335fa46c2de0d18cd7bb0b6a473 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2023/08/d233a335fa46c2de0d18cd7bb0b6a473.png)美区Apple ID

注意：1、**国家或地区**选择美国

### 2.3、验证邮箱

填写完所有的信息点击继续之后，这时会收到一封验证Apple ID的电子邮件，需要把邮箱验证码填写上去输入验证码后，点击**继续**按钮。

![992cb5e4292d086905f508d36f93895a - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2023/08/992cb5e4292d086905f508d36f93895a.png)验证邮箱

完成邮箱验证之后，系统会再发送一条短信给你验证手机号，需要把手机号验证码填写上去

![6c64a21044d86f7a8d2baa68e3bd2acf - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2023/08/6c64a21044d86f7a8d2baa68e3bd2acf.png)验证手机号

> **注意事项：**使用英文名注册；国家和地区选择**美国**；电话号码可以填国内手机号,且必须是没有注册过Apple ID；建议使用 Gmail 邮箱或 Outlook 邮箱注册,且必须是没有注册过Apple ID；验证方式选择**短信**；取消勾选苹果公司的公告和服务订阅及新闻的邮件订阅

验证通过后，页面将自动登录刚刚申请好的 Apple ID，点击左侧边栏**个人信息**，可以看到此 Apple ID 的国家或地区显示为**美国**。

![1b703db5eddbb8631e406c83db4f67bd - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2023/08/1b703db5eddbb8631e406c83db4f67bd-1024x646.jpg)apple id美区

由于我们新注册的 Apple ID 尚未在 iTunes 商店使用过，我们需要在接下来的步骤完善这个 Apple ID 的地址信息。

## 第三步、付款与配送

### 3.1、点击左侧付款与配送设置账单地址

#### 生成美国免税州账单地址信息

需要给这个新注册的 Apple ID 填写一个美国地址信息。

建议生成美国免税州地址，推荐**俄勒冈州（Oregon）、特拉华州（Delaware）** 或**蒙大拿州（Montana）** 等免税州。生成的美国地址复制到配送地址。

我使用的这个https://www.fakepersongenerator.com/Random/generate_address生成

![58443a0c1fc38a66281d0cd5f3e910c1 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2023/08/58443a0c1fc38a66281d0cd5f3e910c1-1024x141.png)生成美国免税州地址

![08a126966d5b0c32640c6cd33489f9f8 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2023/08/08a126966d5b0c32640c6cd33489f9f8-1024x704.jpg)美区免税州地址

在美国，有5个州是免税的，它们分别是：俄勒冈州（Oregon）、特拉华州（Delaware）、蒙大拿州（Montana）、新罕布什尔州（New Hampshire）和阿拉斯加州（Alaska）部分区域，这5个州的州政府不对其任何商品征税

### 3.2、填写付款账单寄送地址

![step3-3 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step3-3-1024x655.png)step3 3

![step3-4 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step3-4-1024x648.png)step3 4

注意：如果你注册时填写的不是免税州地址，也可以更改为免税州地址，支付也能免税

## 第四步、退出App Store账号

#### 4.1、进入App Store，点击右上方的头像，进入到账户页面

![step4-1 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step4-1-471x1024.png)进入App Store点击右上方的头像进入到账户页面

#### 4.2、滑动该页面至底部，点击 **退出登录** 即可退出商店ID，再点击 **完成**

![step4-2 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step4-2-466x1024.png)滑动该页面至底部点击退出登录即可退出商店ID再点击完成

## 第五步、在App Store登录刚注册的 美区 Apple ID

#### 5.1、再次点击右上角的头像，进入账号登录页面

![step5-1 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step5-1-473x1024.png)再次点击右上角的头像进入账号登录页面

#### 5.2、输入账号、密码，点击“登录”，进行登录

![step5-2-1 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step5-2-1-472x1024.png)输入账号密码点击登录进行登录

#### 5.3、输入验证码，成功检验后，即登录成功Apple ID

![step5-3 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step5-3-472x1024.png)输入验证码成功检验后即登录成功Apple ID

#### 5.4、若出现以下提示信息，则按步骤进行检查操作，完成检查

![step5-4 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step5-4.png)若出现以下提示信息则按步骤进行检查操作完成检查

#### 5.5、点击“同意条款与条件”的按钮，再点击”下一页”

![step5-5 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step5-5-471x1024.png)点击同意条款与条件的按钮再点击下一页

6、下图请不要填写任何信息，直接点击”下一页”

![step5-6 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step5-6-473x1024.png)请不要填写任何信息直接点击下一页

7、点击“继续”，即可进行下载

![step5-7 - zhpengfei.com](https://zhpengfei.com/wp-content/uploads/2024/03/step5-7-463x1024.png)点击继续即可进行下载

点击底部的**继续**按钮，就可以开始在美国区的 App Store 下载安装 app 了。

## 一些需要注意的地方

1.设置密码时，密码中不要包含前面填写的名字、生日、邮箱中的任何信息，否则可能会卡在验证码那一步，总之就是密码尽量原创一个。

2.不要在「设置」中登录美区Apple ID，以免造成不必要的麻烦。下载美区 App 只需在 App Store 中登录即可，下载完后再换回国区账号即可，对 iCloud 等不会有任何影响。

3.如果你有在用Apple Music，切换成美区后会导致已下载的歌曲全被清空。

4.建议不要把美区 Apple ID 当成主力账号，需要下美区应用时登录就行了，以免出现啥问题


# find my   提示 airpods  setup incomplete

+ 登录国服账号 无效
+ 重启 无效
+ find my = share my location 无效
+ 关闭热点, 启用流量数据 无效
+ forget device - "not your airpodsxxx" - 必须双击两下 白灯闪烁 - connect with icloud  - 重启 ~ find my - 有无本设备 无效
+ 重新登录账号 - 然后连接 airpods  有概率能成功, 依然没唤醒 uwb 
+ find my - play sound 强制连接  不能唤醒
+ play sound 无反应: 重启 location permission
+ 更换账号后, 是没法 uwb 的

> 直接: 连点三下, 重新恢复出厂, 重新配置, 注意: 国行必须国行账号才有uwb


# upgrade to expected version
https://support.apple.com/en-us/102662

# NSURLErrorServerCertificateUntrusted

If you want to test it anyway, do this:

```
echo | openssl s_client -connect login.dingtalk.com:443 -servername login.dingtalk.com -showcerts
```

Copy the **first** certificate block:

```
-----BEGIN CERTIFICATE-----
...
-----END CERTIFICATE-----
```

Save it as `dingtalk.cer`, then:

- open **Keychain Access**
- select **System**
- **File → Import Items…**
- import `dingtalk.cer`
- double-click the imported `*.dingtalk.com`
- expand **Trust**
- set **When using this certificate** to `Always Trust`
- close the window and enter your admin password

That is the correct Apple workflow for persistent certificate trust settings in Keychain Access. 


# apple pinyin input CAPS 不生效
 Mac 电脑解决方案 (macOS)
Mac OS 10.12 后，短按 Caps Lock 默认为切换中英文，长按才切换大写。若要恢复点按锁定：
打开 系统设置 (System Settings)。
点击左侧边栏的 键盘 (Keyboard)。
点击 输入法 (Input Sources) 的选项 (部分系统版本可能在“键盘”设置的高级选项中)。
找到 “使用大写锁定键切换‘ABC’输入模式”，将其关闭 (取消勾选)。
注：修改后，按下 Caps Lock 即可切换大小写，灯亮即为大写。