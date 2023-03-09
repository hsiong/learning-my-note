

## 获取 userInfo 

1. 根据 wx.login() 获取 jscode & openId

   https://developers.weixin.qq.com/miniprogram/dev/api/open-api/login/wx.login.html

2. 根据 jscode 获取 session-key 获取加密字符串

   https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/user-login/code2Session.html

3. 用户解密方法

   https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/signature.html