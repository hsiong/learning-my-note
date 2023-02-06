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

## note

1. maven 打包不带版本号
https://blog.csdn.net/fly910905/article/details/80276153
```

<build>
  <!-- 产生的构件的文件名，默认值是${artifactId}-${version}。 -->  
        <finalName>projectname</finalName>
</build>

```

2. Maven项目依赖外部jar进行打包的两种方式
https://blog.csdn.net/abcwanglinyong/article/details/90448497
```
<plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
            <configuration>
                <includeSystemScope>true</includeSystemScope>
            </configuration>
        </plugin>
```







