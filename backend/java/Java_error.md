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
