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
+ spring cache not null -  unless="#result == null"
  Spring Cacheable注解不缓存null值 https://blog.csdn.net/difffate/article/details/64124272
+ @Cacheable 不生效 
  缺少缓存配置： 确保您的 Spring Boot 项目中已经配置了缓存。通常，您需要在配置类上添加 @EnableCaching 注解，以启用缓存功能  

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

25. "Couldn't find PersistentEntity for type class java.lang.Object"
``` java
@Repository
public interface ImageEntityRepository extends CrudRepository<ImageEntity, Long> {


}
```

26. mybatis-plus incepter ignore mapper
```
// 用于在特定情况, mysql的特殊语句
@InterceptorIgnore(tenantLine = "true")
public interface ImageEntityRepository extends CrudRepository<ImageEntity, Long> {


}

```

26. idea: Could not autowire. No beans of 'PlanOperateMapper' type found. 
```
@Repository
public interface ImageEntityRepository extends CrudRepository<ImageEntity, Long> {


}
```

27. jwt - Have you remembered to include the jjwt-impl.jar in your runtime classpath?
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

28.  jwt - The specified key byte array is 40 bits which is not secure enough for any JWT HMAC-SHA algorithm.  The JWT JWA Specification (RFC 7518, Section 3.2)
https://blog.csdn.net/Fine_Cui/article/details/124713766

29.  spring boot 静态文件映射
```java 
WebMvcConfiguration.java

// 访问路径
registry.addResourceHandler("/static/**")
        // 文件路径
        .addResourceLocations("file:" + neoPath + "//");

```

30. springboot接口入参下划线转驼峰以及返回参数驼峰转下划线实现
https://www.cnblogs.com/newAndHui/p/14767675.html
+ 响应结果的时候(驼峰转为下划线)
@JsonNaming(PropertyNamingStrategy.SnakeCaseStrategy.class)

31. java JVM 优化
 -Xms64m -Xmx256m -Xmn64m  -Xss64k 
 + 

+ 传入参数, 不考虑

32.  java list 初始化赋值
```
List<String> stringList = Arrays.asList("a", "b", "c");
```

33.  java listener 中, 不会显示异常, 需要手动捕获异常
34.  ` Fatal error compiling: java.lang.NoSuchFieldError: Class com.sun.tools.javac.tree.JCTree$JCImport does not have member field 'com.sun.tools.javac.tree.JCTree qualid'`
最新的 j22 导致的问题, 降级为 j19
+ 检查 java -version 和 $JAVA_HOME; 
+ 检查 mvn 指令
  ```
  which mvn
  ls -l /opt/homebrew/bin/mvn 
  cd /opt/homebrew/bin
  cd ../Cellar/maven/3.9.8/bin/    
  sublime mvn
  ```
  替换 `JAVA_HOME="${JAVA_HOME:-/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home}" exec "/opt/homebrew/Cellar/maven/3.9.8/libexec/bin/mvn"  "$@" ` 为 ` /opt/homebrew/Cellar/openjdk/19.0.1/libexec/openjdk.jdk/Contents/Home  exec "/opt/homebrew/Cellar/maven/3.9.8/libexec/bin/mvn"  "$@" `

# java reg
> Referenece
+ online test: https://tool.oschina.net/regex/
+ tutorial: http://www.regexlab.com/zh/regref.htm

1. replaceLast
```
                String fileName = file.getName();
                String newFileName = fileName.replaceAll("i$", "");
```

2. [] 匹配一个字符

| 表达式 | 可匹配                                                      |
| ------ | ----------------------------------------------------------- |
| \d     | 任意一个数字，0~9 中的任意一个                              |
| \w     | 任意一个字母或数字或下划线，也就是 A~Z,a~z,0~9,_ 中任意一个 |
| \s     | 包括空格、制表符、换页符等空白字符的其中任意一个            |
| .      | 小数点可以匹配除了换行符（\n）以外的任意一个字符            |

3. () 匹配一段话

> [表达式 "(go\s*)+" 在匹配 "Let's go go go!" 时](http://www.regexlab.com/zh/workshop.htm?pat=(go\s*)%2B&txt=Let's go go go!)，匹配结果是：成功；匹配到内容是："go go go"；匹配到的位置是：开始于6，结束于14。

4. 浅谈Java Matcher对象中find()与matches()的区别。
https://zhuanlan.zhihu.com/p/142846161

find()：是否存在与该模式匹配的下一个子序列。简单来说就是在字符某部分匹配上模式就会返回true，同时匹配位置会记录到当前位置，再次调用时从该处匹配下一个。

matches()：整个字符串是否匹配上模式，匹配上则返回true，否则false。