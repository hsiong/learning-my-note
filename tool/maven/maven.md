# bug

## maven 正常, 但是 dependency 出现红色下划线
 clean 重启 即可正常

# optimize 

1. 修改maven仓库, 从阿里云拉取
2. 修改 maven 参数, 优化 jvm 配置
3. 跳过测试代码  -Dmaven.test.skip=true 
4. 多线程编译 -Dmaven.compile.fork=true
5. 多核编译 -T 1C

```
1.  set MAVEN_OPTS= -Xms800m -Xmx800m -XX:MaxNewSize=512m  -XX:MaxPermSize=512m
  
2. mvn clean package -T 1C -Dmaven.test.skip=true -Dmaven.compile.fork=true
```