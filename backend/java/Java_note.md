1. syntax error,expect start with { or [,but actually start with error
-> get 请求

2. inaccessibleobjectexception java 17
-> Can't access protected final class

3. vscode can't commit
-> stage -> stash -> push

4. how to make generics class implements a interface ?   
`<? extends xxxClass>` generics class don't distinguish interface or   

5.  module java.base does not "opens java.lang" to unnamed module
--add-opens java.base/java.lang=ALL-UNNAMED

6. No provider available from registry localhost:9090
相应的服务没有启动

7. Could not write JSON Infinite recursion
无限递归

8. Property 'spring.profiles.include' imported from location 'class path resource [config/application-test.yml]' is invalid in a profile specific resource
https://blog.csdn.net/key_xyes/article/details/111935074

9. get frontend null -> emptyString
https://blog.csdn.net/fzy629442466/article/details/113625509

10. get JAVA VM Home
`/usr/libexec/java_home -V`

11. Already config converter Long to String in Spring Boot Configure, but not working
https://www.yisu.com/zixun/609055.html
```java
    @Override
    public void extendMessageConverters(List<HttpMessageConverter<?>> converters) {
        // 会导致其他全局 json 不生效
//        converters.clear();
        converters.add(stringConverter());
        converters.add(fastConverter());
    }
```

12. class.getClassLoader().getResource("") couldn't get resource Dir Path
```
~/.m2/repository/org/junit/platform/junit-platform-commons/1.9.1/junit-platform-commons-1.9.1.jar!/META-INF/versions/9/
```
may caused by `JUnit 5`, try to replace it with `JUnit 4`

13. install jdk in Mac OS homebrew  
As the terminal shows: 
```
For the system Java wrappers to find this JDK, symlink it with
  sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

openjdk is keg-only, which means it was not symlinked into /opt/homebrew,
because macOS provides similar software and installing this software in
parallel can cause all kinds of trouble.

If you need to have openjdk first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.zshrc

For compilers to find openjdk you may need to set:
  export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
```

14. "at org.yaml.snakeyaml.reader.StreamReader.peek(StreamReader.java:136)"
https://blog.csdn.net/Michelle_Zhong/article/details/122702144


15. no fontmanager in system library path: /opt/homebrew/Cellar/openjdk/19.0.1/libexec/openjdk.jdk/Contents/Home/lib
```
# 重装 jdk  
brew reinstall openjdk@19
```

16. Springboot 访问项目怎么不用加项目名?
```
    #应用的访问路径 不配置, 直接访问
    context-path: /
```

17. spring 允许值 正则
https://blog.csdn.net/inthat/article/details/108843826
https://www.cnblogs.com/404code/p/10569158.html
@Pattern

18. swagger/knife4j 成功, 但是没有展示任何 api
https://zhuanlan.zhihu.com/p/447338078
+ 需要解决 springboot2.6 和 springfox 不兼容问题  
+ Spring Boot 2.6+ 后映射匹配的默认策略已从 AntPathMatcher 更改为 PathPatternParser,需要手动指定为 ant-path-matcher

19. spring cache
https://www.cnblogs.com/coding-one/p/12401630.html
+ @Cacheable 提供两个参数来指定缓存名：value、cacheNames，二者选其一即可。

20. obj -> jsonObj
```
JSONObject json = (JSONObject) JSON.toJSON(o);
```

21. 数据脱敏
DesensitizedUtil 5.6.2  
https://apidoc.gitee.com/dromara/hutool/cn/hutool/core/util/DesensitizedUtil.html

22. bigdecimal 保留两位小数
payUserAmountDecimal.setScale(2, RoundingMode.HALF_UP)

23. spring 不出日志, 
请考虑 老编译器 未在新代码上运行

24. java stream 排序
https://blog.csdn.net/qq_38974638/article/details/113795827
```
list = list.stream().sorted(Comparator.comparing(Student::getAge).reversed()).collect(Collectors.toList());
```


## jwt 
1. Have you remembered to include the jjwt-impl.jar in your runtime classpath?
```
        <!-- https://mvnrepository.com/artifact/io.jsonwebtoken/jjwt-api -->
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-api</artifactId>
            <version>${jwt.version}</version>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-impl</artifactId>
            <version>${jwt.version}</version>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt-jackson</artifactId>
            <version>${jwt.version}</version>
            <scope>runtime</scope>
        </dependency>
```

2. The specified key byte array is 40 bits which is not secure enough for any JWT HMAC-SHA algorithm.  The JWT JWA Specification (RFC 7518, Section 3.2)
https://blog.csdn.net/Fine_Cui/article/details/124713766

## swagger
1. knife4j v3 add header (4.0.0 bug)
+ 文档管理 -> 全局参数设置 -> 参数名称: AUTH_HEADER


## mybatis
1. Invalid bound statement (not found)   ||   Property 'mapperLocations' was not specified.
https://www.jianshu.com/p/6dc534bcc512

2. mybatis-plus tableField
https://baomidou.com/pages/6b03c5/
https://www.tabnine.com/code/java/classes/com.baomidou.mybatisplus.annotation.TableLogic
```
	@TableLogic(value = "null", delval = "now()")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(timezone = "GMT+8",pattern = "yyyy-MM-dd HH:mm:ss")
	@Schema(description = "删除标志")
	private LocalDateTime deleteAt;
```

## 微信相关
1. 删除测试号绑定
https://developers.weixin.qq.com/community/develop/doc/000ee46d24ca4892bedd0464251400
