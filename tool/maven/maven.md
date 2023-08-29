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

3. jeecg maven 多环境 笔记
+ 设置 多环境
```xml

	<profiles>
		<profile>
			<!-- 开发环境 -->
			<id>dev</id>
			<properties>
				<profiles.active>dev</profiles.active>
				<maven.test.skip>true</maven.test.skip>
			</properties>
			<activation>
				<activeByDefault>true</activeByDefault>
			</activation>
		</profile>
		<profile>
			<!-- 测试环境 -->
			<id>test</id>
			<properties>
				<profiles.active>test</profiles.active>
				<maven.test.skip>true</maven.test.skip>
			</properties>
		</profile>
		<profile>
			<!-- 生产环境 -->
			<id>prod</id>
			<properties>
				<profiles.active>prod</profiles.active>
				<maven.test.skip>true</maven.test.skip>
			</properties>
		</profile>
	</profiles>

```

+ 扫描指定的配置文件
```xml
<resource>
    <directory>src/main/resources</directory>
    <includes>
        <include>**/application.yml</include>
        <include>**/application-common.yml</include>
        <include>**/application-${profiles.active}.yml</include>
        <include>**/*.xml</include>
        <!-- 扫描 jeecg 的静态文件 -->
        <include>jeecg/**/*</include>
<!--					<include>static/**/*</include>-->
        <include>templates/**/*</include>
    </includes>
    <!-- 这里要设置为true 否则不会扫描yml文件 -->
    <filtering>true</filtering>
</resource>
```

+ 配置 mybatis-mapper 扫描
``` xml

<resource>
    <directory>src/main/java</directory>
    <filtering>true</filtering>
    <includes>
        <include>**/xml/*.xml</include>
<!--					<include>**/json/*.json</include>-->
    </includes>
</resource>

```

+ 如有其他模块使用 mybatis mapper, 则相应配置扫描
```xml

    <build>
        <resources>
            <resource>
                <directory>src/main/java</directory>
                <filtering>true</filtering>
                <includes>
                    <include>**/xml/*.xml</include>
                    <!--					<include>**/json/*.json</include>-->
                </includes>
            </resource>
        </resources>
    </build>

```

+ dockerFile 中, 不再指定默认启动方式, 由 maven -p 来决定
``` xml

"--spring.profiles.active=dev"

```

## 4. Cannot connect to the Maven process. Try again later. If the problem persists, check the Maven
https://blog.csdn.net/a1782519342/article/details/124740171

这个问题出现于项目指定的sdk与maven sdk 不一致

Build，Execution，Deployment --> Build Tools --> Maven --> Importing --> JDK for import 

```xml
<configuration>
    <source>1.8</source> <!-- 设置 Java 源代码的版本 -->
    <target>1.8</target> <!-- 设置编译生成的字节码版本 -->
</configuration>
```

+ setting --> Build Tools --> Maven --> Importing --> JDK for import 在此设置对应的 JDK版本即可，我的是jdk1.8。  
+ Maven --> Runner -> JRE, 指定对应版本
+ Project Structure -> Project -> 对应的 JDK  

## 5. maven 找不到某个包
检查 pom.xml <repositories></repositories> 标签, 如使用 aliyun, 则在 https://maven.aliyun.com/ 检查对应仓库是否引入; 

## 6. pom.xml distributionManagement 和 repositories 区别
distributionManagement 用于部署依赖, repositories 用于指定下载依赖

## maven setting.xml 不生效
检查 mirrors -> mirror -> mirrorOf 标签