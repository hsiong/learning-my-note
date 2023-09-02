
# Java-review
Java-review-for-audition

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="知识共享许可协议" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />本作品采用<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">知识共享署名-非商业性使用-禁止演绎 4.0 国际许可协议</a>进行许可。

- [Java-review](#java-review)
- [第一章 Java](#第一章-java)
  - [Java 基础](#java-基础)
    - [基础类型](#基础类型)
    - [访问控制修饰符](#访问控制修饰符)
    - [静态上下文与非静态内部类](#静态上下文与非静态内部类)
      - [为什么如果您需要在静态上下文中创建非静态内部类的实例，您需要将内部类声明为静态的](#为什么如果您需要在静态上下文中创建非静态内部类的实例您需要将内部类声明为静态的)
      - [静态上下文](#静态上下文)
    - [Java使用this关键字调用本类重载构造器](#java使用this关键字调用本类重载构造器)
    - [抽象类和接口的区别有哪些](#抽象类和接口的区别有哪些)
    - [FastJson](#fastjson)
    - [Java 队列](#java-队列)
    - [swagger](#swagger)
    - [Java使用HMAC-SHA256算法实现接口认证](#java使用hmac-sha256算法实现接口认证)
    - [Java 命名规范](#java-命名规范)
    - [分布式锁 redission](#分布式锁-redission)
    - [Java 实现回调](#java-实现回调)
  - [1.3 Map](#13-map)
    - [1.3.1 Map的实现类](#131-map的实现类)
  - [1.4 Iterator](#14-iterator)
    - [1.4.1 Set](#141-set)
    - [1.4.2 List](#142-list)
      - [1.4.2.1 实现类](#1421-实现类)
      - [list set array 互转](#list-set-array-互转)
        - [List转数组](#list转数组)
        - [数组转List](#数组转list)
        - [Set转数组](#set转数组)
        - [Set转List](#set转list)
        - [List转Set](#list转set)
      - [1.4.2.2 移除元素](#1422-移除元素)
      - [1.4.2.3 去重](#1423-去重)
  - [1.5 线程池](#15-线程池)
    - [原理](#原理)
      - [为什么使用线程池](#为什么使用线程池)
      - [使用线程池的风险](#使用线程池的风险)
      - [线程池组成](#线程池组成)
      - [Java 线程池工作过程](#java-线程池工作过程)
      - [拒绝策略](#拒绝策略)
    - [SpringBoot 实现](#springboot-实现)
      - [线程池构造方法](#线程池构造方法)
      - [异步线程池调用 @Async](#异步线程池调用-async)
      - [线程池业务隔离, 状态监控与状态调优](#线程池业务隔离-状态监控与状态调优)
    - [JDK 实现](#jdk-实现)
        - [调用默认构造器(cache, fixed, single, schedule)](#调用默认构造器cache-fixed-single-schedule)
      - [线程池阻塞队列](#线程池阻塞队列)
  - [1.6 对象, 反射, 泛型](#16-对象-反射-泛型)
  - [1.7 stream 流式操作](#17-stream-流式操作)
    - [flatmap](#flatmap)
  - [1.8 函数式编程](#18-函数式编程)
  - [1.9 Predicate 断言](#19-predicate-断言)
  - [Java 定时器](#java-定时器)
  - [Java Localdate -\> String](#java-localdate---string)
    - [String 类型转localDate](#string-类型转localdate)
    - [date类型转localDate](#date类型转localdate)
  - [Java经验](#java经验)
- [第二章 Mysql](#第二章-mysql)
  - [2.1 基础类型](#21-基础类型)
  - [2.2 约束](#22-约束)
  - [2.3 mysql优化](#23-mysql优化)
  - [2.4 mysql锁](#24-mysql锁)
    - [2.4.1 加锁机制](#241-加锁机制)
    - [2.4.2 mysql锁分类](#242-mysql锁分类)
    - [2.4.3 mysql-Innodb锁介绍](#243-mysql-innodb锁介绍)
    - [2.4.4 mysql-Innodb锁实现](#244-mysql-innodb锁实现)
  - [2.5 事务隔离](#25-事务隔离)
    - [2.5.1 数据库事务特征](#251-数据库事务特征)
    - [2.5.2 MySQL 数据隔离级别](#252-mysql-数据隔离级别)
    - [2.5.3 脏读、幻读、不可重复读的概念](#253-脏读幻读不可重复读的概念)
  - [2.6 范式](#26-范式)
  - [2.7 Mysql经验](#27-mysql经验)
- [第三章 中间件](#第三章-中间件)
  - [3.1 redis](#31-redis)
    - [3.1.1 常用的数据类型](#311-常用的数据类型)
    - [3.1.2 服务雪崩与击穿](#312-服务雪崩与击穿)
    - [3.1.3 哨兵](#313-哨兵)
    - [3.1.4 消息订阅](#314-消息订阅)
  - [3.x 中间件经验](#3x-中间件经验)
- [第四章 Linux](#第四章-linux)
  - [4.x Linux经验](#4x-linux经验)
- [第五章 Spring-Boot](#第五章-spring-boot)
  - [5.1 Spring-Boot经验](#51-spring-boot经验)
  - [5.2 Spring 中的 maven 冲突与管理](#52-spring-中的-maven-冲突与管理)
    - [5.2.1 SpringBoot 中的依赖管理和自动仲裁机制](#521-springboot-中的依赖管理和自动仲裁机制)
  - [Spring yml](#spring-yml)
- [第六章 Spring-cloud-alibaba](#第六章-spring-cloud-alibaba)
- [第七章 数据结构与算法](#第七章-数据结构与算法)
- [第八章 常见的锁及其实现](#第八章-常见的锁及其实现)
- [第九章 程序设计](#第九章-程序设计)
  - [9.1 面向对象设计](#91-面向对象设计)
  - [9.2 设计思想](#92-设计思想)
    - [9.2.1 自顶向下](#921-自顶向下)
    - [9.2.2 敏捷开发](#922-敏捷开发)
    - [9.2.3 领域驱动](#923-领域驱动)
  - [9.3 设计模式](#93-设计模式)
- [第十章 DevOps](#第十章-devops)
  - [10.1 Jenkins](#101-jenkins)
  - [10.2 Docker](#102-docker)
  - [10.3 k8s](#103-k8s)
- [第十一章 Android](#第十一章-android)
- [第十二章 Vue](#第十二章-vue)
  - [12.1 Vue生命周期](#121-vue生命周期)
  - [12.x Vue经验](#12x-vue经验)
- [第十三章 常用工具](#第十三章-常用工具)
- [第十四章 网络开发](#第十四章-网络开发)
  - [14.1 OSI七层模型](#141-osi七层模型)
  - [14.2 网络协议](#142-网络协议)
  - [排序/查找算法](#排序查找算法)
  - [零拷贝/DMA](#零拷贝dma)
- [](#)
  - [保持好的对接习惯](#保持好的对接习惯)
- [高并发](#高并发)
  - [后端性能优化的指标](#后端性能优化的指标)
  - [**后台服务器常用的优化方式**](#后台服务器常用的优化方式)
  - [缓存](#缓存)
      - [**缓存的本质**](#缓存的本质)
        - [**合理的使用缓存**](#合理的使用缓存)
        - [**频繁修改的数据**   ](#频繁修改的数据-)
        - [**没有热点的访问**   ](#没有热点的访问-)
        - [**数据的不一致与脏读**   ](#数据的不一致与脏读-)
      - [缓存的常见问题优化手段](#缓存的常见问题优化手段)
        - [缓存雪崩](#缓存雪崩)
        - [缓存穿透](#缓存穿透)
        - [缓存预热](#缓存预热)
      - [**分布式缓存架构**](#分布式缓存架构)
  - [异步](#异步)
  - [集群](#集群)
  - [代码优化](#代码优化)
  - [存储优化](#存储优化)

+ Object & class
+ Encapsulation
+ Abstraction 
+ Inheritance
+ Polymorphism
+ Generic

# 第一章 Java

## Java 基础

### 基础类型
二进制原理, 计算机中第一位为符号位, 所以取值范围正数最大范围少一位。
|类型|字节数|取值范围|具体取值范围|
|:-:|:-:|:-:|:-:|
|byte|1|±2^7|[-128, 127]|
|short|2|±2^15|[-32768, 32767]|
|int|4|±2^31|[-21亿xxx, 21亿xxx]|
|long|8|±2^63|很大|
|float|4|±2^31|[-21亿xxx, 21亿xxx]|
|double|8|±2^63|很大|
|char|2|±2^15|[-32768, 32767]|
|boolean|4||true/false|

在Java中，boolean被当成int处理，所以4个字节。

### 访问控制修饰符
|修饰符|当前类|同一包内|同一包子孙|不同包子孙|其他包|
|:-:|:-:|:-:|:-:|:-:|:-:|
|default|√|√|√|||
|public|√|√|√|√|√|
|private|√|||||
|protected|√|√|√|√/X||

> protected
> + 子类与基类在同一包中：  
>   被声明为 protected 的变量、方法和构造器能被同一个包中的任何其他类访问；
> + 子类与基类不在同一包中：  
>   那么在子类中，子类实例可以访问其从基类继承而来的 protected 方法，而不能访问基类实例的protected方法。
```java
package p2;
class MyObject2 {
    protected Object clone() throws CloneNotSupportedException{
       return super.clone();
    }
}
 
package p22;
public class Test2 extends MyObject2 {
    public static void main(String args[]) {
       MyObject2 obj = new MyObject2();
       obj.clone(); // Compile Error         ----(1)
 
       Test2 tobj = new Test2();
       tobj.clone(); // Complie OK         ----(2)
    }
}
```
对于(1)而言，clone()方法来自于类MyObject2本身，因此其可见性为包p2及MyObject2的子类，虽然Test2是MyObject2的子类，但在Test2中不能访问基类MyObject2的protected方法clone()，因此编译不通过;对于(2)而言，由于在Test2中访问的是其本身实例的从基类MyObject2继承来的的clone()，因此编译通过。

### 静态上下文与非静态内部类

ChatbotInitParam 实体如下所示, 但是 ChatbotInitParam.ChatbotInitChatbotConfigParam chatbotConfig = new ChatbotInitParam.ChatbotInitChatbotConfigParam(); 报错, 提示ChatbotInitParam' is not an enclosing class  ?

```java
@Data
public class ChatbotInitParam {

    @ApiModelProperty(value = "实例唯⼀id")
    private String instance_id;

    @Data
    public class ChatbotInitChatbotConfigParam {

        @ApiModelProperty(value = "机器⼈名称")
        private String name;

    }

}

```
####  为什么如果您需要在静态上下文中创建非静态内部类的实例，您需要将内部类声明为静态的

在 Java 中，非静态内部类（也称为成员内部类）是与外部类的实例相关联的，因为它们可以访问外部类的实例变量和方法。而在静态方法中，您无法直接访问非静态的实例变量，因为静态方法是与类本身关联，而不是与特定实例关联。

如果要在静态上下文中访问内部类，可以采取以下方法：

+ 将内部类声明为静态：将内部类声明为静态后，它就不再与外部类的实例相关联，可以在静态上下文中创建实例。这是因为静态内部类不依赖于外部类的实例。

+ 使用外部类的实例创建内部类的实例：如果您不希望将内部类声明为静态，而又想在静态方法中创建它的实例，您可以先创建外部类的实例，然后通过该实例来创建内部类的实例。

在您的情况下，如果您希望在静态方法中创建 ChatbotInitChatbotConfigParam 的实例，您可以将内部类声明为静态，或者将其提取为独立的类，或者通过创建外部类的实例来创建内部类的实例。选择哪种方法取决于您的需求和设计。

#### 静态上下文


"静态上下文" 是指在 Java 中与类本身关联的环境，而不是与类的实例相关联的环境。静态上下文中的代码可以访问和操作静态成员（静态字段和静态方法），但不能访问非静态的实例成员。

具体来说，在以下情况下，您处于静态上下文：

+ 在类的静态方法中：静态方法是与类本身相关联的，因此在静态方法中只能访问静态成员，不能访问非静态的实例成员。

+ 在静态初始化块中：静态初始化块是在类加载时执行的，也属于类本身的操作，因此同样只能访问静态成员。

+ 在静态字段的初始化中：静态字段的初始化也在类加载时进行，所以只能访问静态成员。

总之，静态上下文表示您处于与类本身关联的环境，这意味着您无法在其中访问与类的实例相关的成员，除非这些成员被声明为静态。

> 总结: 在本例中 new ChatbotInitParam.ChatbotInitChatbotConfigParam(), 就是调用了 ChatbotInitParam 类下的 ChatbotInitChatbotConfigParam() 静态方法, 而这个类是 class xxx 并不是静态的, 所以导致了一场


### Java使用this关键字调用本类重载构造器
https://www.cnblogs.com/wanghongyun/p/6132083.html
```java
this(name,"男");
```

### 抽象类和接口的区别有哪些

相似点：

+ 不能实例化
+ 包含未实现的方法声明
+ 派生类必须实现未实现的方法，抽象类是抽象方法，接口则是所有成员（不仅是方法包括其他成员）

区别: 

+ 默认的方法实现  
  抽象类可以有默认的方法实现；接口，Java8规定可以为接口提供默认实现的方法并且不用强制实现。
+ 实现  
  如果子类不是抽象类的话，它需要重写抽象类中的抽象方法；接口子类使用关键字implements 来实现接口，它需要重写接口中没有默认。 
+ 构造器
  抽象类可以有构造器，接口不能有构造器。
+ 与正常Java类的区别
  除了不能实例化抽象类之外，和普通Java类没有任何区别；接口是完全不同的类型外。
+ 访问修饰符
  抽象方法可有public.protected和default、abstract修饰符。不能用privatestatic.synchronize、 native 修饰。接口属性默认修饰符是publicstatic final (必须赋初值) ，方法默认修饰符是publicabstract. Java8 开始出现静态方法，多加static关键字。
+ main方法
  抽象类可以运行它；接口没有main方法，因此不能运行它。
+ 多继承
  抽象类可以继承一个类和实现多个接口；接口只可以继承一个或多个接口。

抽象类的运用意义: 

+ 在面向对象方法中，抽象类主要用来进行类型隐藏。构造出一个固定的一组行为的抽象描述，但是这组行为却能够有任意个可能的具体实现方式
+ 这个抽象描述就是抽象类，而这一组任意个可能的具体实现则表现为所有可能的派生类。模块可以操作一个抽象体
+ 由于模块依赖于一个固定的抽象体，因此它可以是不允许修改的；同时，通过从这个抽象体派生，也可扩展此模块的行为功能
+ 为了能够实现面向对象设计的一个最核心的原则OCP(Open-Closed Principle)，抽象类是其中的关键所在

### FastJson

1. 在 fastJson DefaultJSONParser.parse() 中              

```
case LBRACE:
                JSONObject object = new JSONObject(lexer.isEnabled(Feature.OrderedField));
                return parseObject(object, fieldName);
```

将所有{ } 识别成 JSONObject

2. SerializerFeature 与 Feature 什么关系 ? 
   没有关系; 重载方法

### Java 队列

+ [高性能队列——Disruptor](https://tech.meituan.com/2016/11/18/disruptor.html)
+ [java队列与线程池](https://cloud.tencent.com/developer/article/2068908)

### swagger

knife4j v3 add header (4.0.0 bug)

+ 文档管理 -> 全局参数设置 -> 参数名称: AUTH_HEADER

### Java使用HMAC-SHA256算法实现接口认证

https://www.jianshu.com/p/365c2b3811d9

### Java 命名规范

https://www.jhelp.net/p/Dq0h3U69SZfAAGhP

### 分布式锁 redission

https://blog.csdn.net/u014042066/article/details/72830939

### Java 实现回调

## 1.3 Map

### 1.3.1 Map的实现类
|实现类|key value null?|有序?|并发?|
|:-:|:-:|:-:|:-:|
|HashMap|key value可以为null|无序|线程不安全|
|LinkedHashMap|key value可以为null|元素按插入的顺序排列|线程不安全|
|TreeMap|key value都不能为null|按key自然排序|非线程安全|
|ConcurrentHashMap|key value都不能为null|按key自然排序|线程安全|
|Hashtable|key value都不能为null|无序|线程安全|
|Properties|与Hashtable一致|||

看源码的时候, 我们发现, Hashtable的put方法有`synchronized`, 所以是线程安全的  
而ConcurrentHashMap是在put方法的内部, 使用了`synchronized`的方法块, 所以也是线程安全的

Properties是Hashtable的子类，在处理属性文件时特别方便。Properties的key、value都必须是String。
EnumMap是用于存储enum类型的类, 研究意义不大

> 注: 弄清这个非常重要,   
> 虽然目前后端都常用对象传递数据, 但是在某些特殊情况下, 我们需要将对象转化为map做特殊处理,   
> 如果使用了错误的类, 后端会直接报错, 很难定位


> 注: TreeMap 一般情况下是不允许存放重复元素的，在一些情况下是可以存放重复元素的  
> 存放元素时，TreeMap实现外部比较器接口Comparator，并重写其compare方法，当判断元素重复时，强制compare方法返回一个非0的数，就可以将重复元素存入；
> 实现如下: 

```
TreeMap<Integer,String> tree = new TreeMap<Integer,String>(new Comparator<Integer>(){
            @Override
            public int compare(Integer o1, Integer o2) {
                if(o1.equals(o2))
                    return 1;
                else
                return o1-o2;
            }
        });
```

## 1.4 Iterator
`Collection`是`Iterator`的一个实现类,   
`Collection`有两个重要的实现类: `Set`以及`List`   
`Collection`的实现类可以调用`stream流`的方法, 以及`Iterator`的遍历方法
```
        TreeSet<String> set = new TreeSet();
        set.add("1");
        for (String s : set) {
            System.out.println(s);
        }

        Iterator iterator = set.iterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }
```

### 1.4.1 Set
`Set`接口是一种不包括重复元素的Collection, 元素可以为`null`值  
|实现类|有序?|并发?|底层|
|:-:|:-:|:-:|:-:|
|HashSet|无序|线程不安全|HashMap|
|LinkedHashSet|遍历序和插入序一致|线程不安全|LinkHashMap|
|TreeSet|自然排序|非线程安全|TreeMap|

### 1.4.2 List
#### 1.4.2.1 实现类
+ ArrayList，底层采用数组结构的实现的。(内存中连续空间)。jdk1.2只实现了List接口，功能都是List接口中规定的。
    + 优点：遍历访问元素，效率很高
    + 缺点：插入或删除元素，效率相对低。
+ LinkedList，底层采用双向链表结构实现的。(元素在内存中不挨着，元素之间的指向)。jdk1.2实现了List接口的同时，还实现了Deque接口，所以有这两个接口中的功能。
    + 优点：插入或删除元素，效率很高。
    + 缺点：遍历访问元素，效率相对低。
	
+ Vector，是ArrayList的前身。也是数组的结构。古老的类。从jdk1.0的版本就有了。
    + 线程安全，效率低，后来被ArrayList替代了。

> 注意：  
> + 如果一个集合，绝大多数的操作就是遍历查询，建议选择ArrayList。  
> + 如果一个集合，频繁的添加或删除元素，建议选择LinkedList。  
> + 如果要模拟栈，队列等结构，建议选择LinkedList。  
> +	ArrayList和LinkedList都是线程不安全的，效率高。Collections工具类，可以获取线程安全的集合。
> 

#### list set array 互转
https://www.jianshu.com/p/717bc27141c4
##### List转数组

+  toArray

  ```java
      public void test(List<String> list) {
          String[] arrays = list.toArray(new String[0]);
          System.out.println(Arrays.toString(arrays));
      }
  ```

##### 数组转List

+ Arrays.asList()

  ```java
  		public void test(String[] arrays) {
          List<String> stringList = Arrays.asList(array);
          System.out.println(stringList.toString());
      }
  ```

##### Set转数组

+ Stream

  ```java
      private static void arrayToSet2() {
          String[] array = {"value1","value2","value3"};
          Set<String> set = Stream.of(array).collect(Collectors.toSet());
          System.out.println(set);
      }
  ```

##### Set转List

+ new ArrayList<>(set)

  ```java
      //set为null会报错
      private static void setToList(Set<String> set) {
          List<String> list=new ArrayList<>(set);
          System.out.println(list.toString());
      }
  ```
  
##### List转Set

+ new HashSet

  ```java
  	private static void listToSet(List<String> list) {
          Set<String> set=new HashSet<>(list);
          System.out.println(set.toString());
    }
  ```

  

#### 1.4.2.2 移除元素

[list集合移除指定元素](https://blog.csdn.net/shenxiaomo1688/article/details/91973077)

#### 1.4.2.3 去重
1. 循环list中的所有元素然后删除重复
2. 通过HashSet踢除重复元素
3. 新增集合, 不重复添加
4. 用list.contains()
5. 使用`retainAll`获取交集
6. Stream中对List进行去重：list.stream().distinct();

[Java中List集合去除重复数据的六种方法](https://www.cnblogs.com/zhaoyan001/p/11737961.html)

## 1.5 线程池

### 原理

参考资料 
+ [美团技术文档-线程池](https://tech.meituan.com/2020/04/02/java-pooling-pratice-in-meituan.html)
+ [Java常用的几种线程池比较](https://www.cnblogs.com/aaron911/p/6213808.html)
#### 为什么使用线程池
诸如 Web 服务器、数据库服务器、文件服务器或邮件服务器之类的许多服务器应用程序都面向处理来自某些远程来源的大量短小的任务。请求以某种方式到达服务器，这种方式可能是通过网络协议（例如 HTTP、FTP 或 POP）、通过 JMS 队列或者可能通过轮询数据库。不管请求如何到达，服务器应用程序中经常出现的情况是：单个任务处理的时间很短而请求的数目却是巨大的。  
构建服务器应用程序的一个简单模型是：每当一个请求到达就创建一个新线程，然后在新线程中为请求服务。实际上对于原型开发这种方法工作得很好，但如果试图部署以这种方式运行的服务器应用程序，那么这种方法的严重不足就很明显。每个请求对应一个线程（thread-per-request）方法的不足之一是：为每个请求创建一个新线程的开销很大；为每个请求创建新线程的服务器在创建和销毁线程上花费的时间和消耗的系统资源要比花在处理实际的用户请求的时间和资源更多。  
除了创建和销毁线程的开销之外，活动的线程也消耗系统资源。在一个 JVM 里创建太多的线程可能会导致系统由于过度消耗内存而用完内存或“切换过度”。为了防止资源不足，服务器应用程序需要一些办法来限制任何给定时刻处理的请求数目。  
线程池为线程生命周期开销问题和资源不足问题提供了解决方案。通过对多个任务重用线程，线程创建的开销被分摊到了多个任务上。其好处是，因为在请求到达时线程已经存在，所以无意中也消除了线程创建所带来的延迟。这样，就可以立即为请求服务，使应用程序响应更快。而且，通过适当地调整线程池中的线程数目，也就是当请求的数目超过某个阈值时，就强制其它任何新到的请求一直等待，直到获得一个线程来处理为止，从而可以防止资源不足。  
#### 使用线程池的风险
1. 死锁  
任何多线程应用程序都有死锁风险。当一组进程或线程中的每一个都在等待一个只有该组中另一个进程才能引起的事件时，我们就说这组进程或线程死锁。  
死锁的最简单情形是：线程 A 持有对象 X 的独占锁，并且在等待对象 Y 的锁，而线程 B 持有对象 Y 的独占锁，却在等待对象 X 的锁。除非有某种方法来打破对锁的等待（Java 锁定不支持这种方法），否则死锁的线程将永远等下去。  
虽然任何多线程程序中都有死锁的风险，但线程池却引入了另一种死锁可能，在那种情况下，所有池线程都在执行已阻塞的等待队列中另一任务的执行结果的任务，但这一任务却因为没有未被占用的线程而不能运行。当线程池被用来实现涉及许多交互对象的模拟，被模拟的对象可以相互发送查询，这些查询接下来作为排队的任务执行，查询对象又同步等待着响应时，会发生这种情况。  
2. 资源不足   
线程池的一个优点在于：相对于其它替代调度机制而言，它们通常执行得很好。但只有恰当地调整了线程池大小时才是这样的。  
线程消耗包括内存和其它系统资源在内的大量资源。除了 Thread 对象所需的内存之外，每个线程都需要两个可能很大的执行调用堆栈。除此以外，JVM 可能会为每个 Java 线程创建一个本机线程，这些本机线程将消耗额外的系统资源。最后，虽然线程之间切换的调度开销很小，但如果有很多线程，环境切换也可能严重地影响程序的性能。  
如果线程池太大，那么被那些线程消耗的资源可能严重地影响系统性能。在线程之间进行切换将会浪费时间，而且使用超出比您实际需要的线程可能会引起资源匮乏问题，因为池线程正在消耗一些资源，而这些资源可能会被其它任务更有效地利用。除了线程自身所使用的资源以外，服务请求时所做的工作可能需要其它资源，例如 JDBC 连接、套接字或文件。这些也都是有限资源，有太多的并发请求也可能引起失效，例如不能分配 JDBC 连接。
3. 并发错误  
线程池和其它排队机制依靠使用 wait() 和 notify() 方法，这两个方法都难于使用。如果编码不正确，那么可能丢失通知，导致线程保持空闲状态，尽管队列中有工作要处理。使用这些方法时，必须格外小心。而最好使用现有的、已经知道能工作的实现，例如 util.concurrent 包。
4. 线程泄漏  
当从池中除去一个线程以执行一项任务，而在任务完成后该线程却没有返回池时，会发生这种情况。发生线程泄漏的一种情形出现在任务抛出一个 RuntimeException 或一个 Error 时。如果池类没有捕捉到它们，那么线程只会退出而线程池的大小将会永久减少一个。当这种情况发生的次数足够多时，线程池最终就为空，而且系统将停止，因为没有可用的线程来处理任务。  
有些任务可能会永远等待某些资源或来自用户的输入，而这些资源又不能保证变得可用，用户可能也已经离线了，诸如此类的任务会永久停止，而这些停止的任务也会引起和线程泄漏同样的问题。如果某个线程被这样一个任务永久地消耗着，那么它实际上就被从池除去了。对于这样的任务，应该要么只给予它们自己的线程，要么只让它们等待有限的时间。
5. 请求过载   
仅仅是请求就压垮了服务器，这种情况是可能的。在这种情形下，我们可能不想将每个到来的请求都排队到我们的工作队列，因为排在队列中等待执行的任务可能会消耗太多的系统资源并引起资源缺乏。在这种情形下决定如何做取决于您自己；在某些情况下，您可以简单地抛弃请求，依靠更高级别的协议稍后重试请求，您也可以用一个指出服务器暂时很忙的响应来拒绝请求。

#### 线程池组成
一般的线程池主要分为以下 4 个组成部分：
1. 线程池管理器：用于创建并管理线程池
2. 工作线程：线程池中的线程
3. 任务接口：每个任务必须实现的接口，用于工作线程调度其运行
4. 任务队列：用于存放待处理的任务，提供一种缓冲机制  

Java 中的线程池是通过 Executor 框架实现的，该框架中用到了 Executor，Executors，ExecutorService，ThreadPoolExecutor ，Callable 和 Future、FutureTask 这几个类。  
ThreadPoolExecutor 的构造方法如下：

```java
public ThreadPoolExecutor(int corePoolSize,
                          int maximumPoolSize,
                          long keepAliveTime,
                          TimeUnit unit,
                          BlockingQueue<Runnable> workQueue) {
        this(corePoolSize, maximumPoolSize, keepAliveTime, unit, workQueue,
             Executors.defaultThreadFactory(), defaultHandler);
    }
```
1. corePoolSize：指定了线程池中的线程数量。
2. maximumPoolSize：指定了线程池中的最大线程数量。
3. keepAliveTime：当前线程池数量超过 corePoolSize 时，多余的空闲线程的存活时间，即多次时间内会被销毁。
4. unit：keepAliveTime 的单位。
5. workQueue：任务队列，被提交但尚未被执行的任务。
6. threadFactory：线程工厂，用于创建线程，一般用默认的即可。
7. handler：拒绝策略，当任务太多来不及处理，如何拒绝任务。

#### Java 线程池工作过程
1. 线程池刚创建时，里面没有一个线程。任务队列是作为参数传进来的。不过，就算队列里面有任务，线程池也不会马上执行它们。
2. 当调用 execute() 方法添加一个任务时，线程池会做如下判断：  
    a) 如果正在运行的线程数量小于 corePoolSize，那么马上创建线程运行这个任务；  
    b) 如果正在运行的线程数量大于或等于 corePoolSize，那么将这个任务放入队列；  
    c) 如果这时候队列满了，而且正在运行的线程数量小于 maxiumPoolSize，那么还是要创建非核心线程立刻运行这个任务；  
    d) 如果队列满了，而且正在运行的线程数量等于 maxiumPoolSize，那么线程池会抛出异常 RejectExecutionException。  
3. 当一个线程完成任务时，它会从队列中取下一个任务来执行。
4. 当一个线程无事可做，超过一定的时间（keepAliveTime）时，线程池会判断，如果当前运行的线程数大于 corePoolSize，那么这个线程就被停掉。所以线程池的所有任务完成后，它最终会收缩到 corePoolSize 的大小。

#### 拒绝策略  

线程池中的线程已经用完了，无法继续为新任务服务，同时，等待队列也已经排满了，再也塞不下新任务了。这时候我们就需要拒绝策略机制合理的处理这个问题。JDK 内置的拒绝策略如下：

+ AbortPolicy ： 直接抛出异常，阻止系统正常运行。
+ CallerRunsPolicy ： 只要线程池未关闭，该策略直接在调用者线程中，运行当前被丢弃的任务。显然这样做不会真的丢弃任务，但是，任务提交线程的性能极有可能会急剧下降。
+ DiscardOldestPolicy ： 丢弃最老的一个请求，也就是即将被执行的一个任务，并尝试再次提交当前任务。
+ DiscardPolicy ： 该策略默默地丢弃无法处理的任务，不予任何处理。如果允许任务丢失，这是最好的一种方案。

以上内置拒绝策略均实现了 RejectedExecutionHandler 接口，若以上策略仍无法满足实际需要，完全可以自己扩展 RejectedExecutionHandler 接口。

### SpringBoot 实现

#### 线程池构造方法

```java
ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
// 最大同时执行20个, 缓存200个, 多余则阻塞线程
executor.setCorePoolSize(coreSize);
executor.setMaxPoolSize(maxSize);
executor.setQueueCapacity(queueCapacity);
executor.setKeepAliveSeconds(keepAlive);
executor.setThreadNamePrefix(threadNamePrefix);
executor.setRejectedExecutionHandler(rejectedExecutionHandlerC);
executor.setWaitForTasksToCompleteOnShutdown(awaitTermination);
executor.setAwaitTerminationSeconds(awaitTerminationPeriod);
return executor;
```

+ setCorePoolSize：指定了线程池中的线程数量。

+ setMaxPoolSize：指定了线程池中的最大线程数量。注意, core-size 不能大于 max-size, 否则会报空指针异常

+ setQueueCapacity: 用来缓冲执行任务的队列最大数量, 超过执行拒绝策略

+ setKeepAliveSeconds：当前线程池数量超过 corePoolSize 时，多余的空闲线程的存活时间，即多次时间内会被销毁。

+ setThreadNamePrefix: 线程池名的前缀, 设置好了之后可以方便我们定位处理任务所在的线程池

+ setRejectedExecutionHandler: 拒绝策略

+ setWaitForTasksToCompleteOnShutdown: 设置线程池关闭的时候等待所有任务都完成再继续销毁其他的Bean, 避免应用关闭导致线程池中的任务执行失败

+ setAwaitTerminationSeconds: 设置线程池中任务的等待时间，如果超过这个时候还没有销毁就强制销毁，以确保应用最后能够被关闭，而不是阻塞住

  > Set the maximum number of seconds that this executor is supposed to block on shutdown in order to wait for remaining tasks to complete their execution before the rest of the container continues to shut down. This is particularly useful if your remaining tasks are likely to need access to other resources that are also managed by the container.
  > By default, this executor won't wait for the termination of tasks at all. It will either shut down immediately, interrupting ongoing tasks and clearing the remaining task queue - or, if the "waitForTasksToCompleteOnShutdown" flag has been set to true, it will continue to fully execute all ongoing tasks as well as all remaining tasks in the queue, in parallel to the rest of the container shutting down.
  > In either case, if you specify an await-termination period using this property, this executor will wait for the given time (max) for the termination of tasks. As a rule of thumb, specify a significantly higher timeout here if you set "waitForTasksToCompleteOnShutdown" to true at the same time, since all remaining tasks in the queue will still get executed - in contrast to the default shutdown behavior where it's just about waiting for currently executing tasks that aren't reacting to thread interruption.

#### 异步线程池调用 @Async

https://zhuanlan.zhihu.com/p/532827958

https://juejin.cn/post/6976893903223914527

#### 线程池业务隔离, 状态监控与状态调优

https://www.jianshu.com/p/6f6e2bcb8128





### JDK 实现

##### 调用默认构造器(cache, fixed, single, schedule)

https://blog.51cto.com/u_15736848/5540003

1. newCachedThreadPool  

   ![Java使用 Executors 创建四种线程池原理_阻塞队列_03](https://s2.51cto.com/images/blog/202208/03095144_62e9d4b0c753f33120.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

   创建一个可缓存线程池，如果线程池长度超过处理需要，可灵活回收空闲线程，若无可回收，则新建线程。  
   特点：  

     + 工作线程的创建数量几乎没有限制(其实也有限制的,数目为Interger. MAX_VALUE), 这样可灵活的往线程池中添加线程。在使用CachedThreadPool时，一定要注意控制任务的数量，否则，由于大量线程同时运行，很有会造成系统瘫痪。
     + 如果长时间没有往线程池中提交任务，即如果工作线程空闲了指定的时间(默认为1分钟)，则该工作线程将自动终止。终止后，如果你又提交了新的任务，则线程池重新创建一个工作线程。  

2. newFixedThreadPool  

   ![Java使用 Executors 创建四种线程池原理_队列](https://s2.51cto.com/images/blog/202208/03095144_62e9d4b04bbb016743.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

   创建一个指定工作线程数量的线程池。每当提交一个任务就创建一个工作线程，如果工作线程数量达到线程池初始的最大数，则将提交的任务存入到池队列中。FixedThreadPool是一个典型且优秀的线程池，它具有线程池提高程序效率和节省创建线程时所耗的开销的优点。  
   特点: 

    + 工作线程数量指定
    + 但是，在线程池空闲时，即线程池中没有可运行任务时，它不会释放工作线程，还会占用一定的系统资源。

3. newSingleThreadExecutor  

   ![Java使用 Executors 创建四种线程池原理_阻塞队列_02](https://s2.51cto.com/images/blog/202208/03095144_62e9d4b092a9b62048.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

   创建一个单线程化的Executor，即只创建唯一的工作者线程来执行任务，它只会用唯一的工作线程来执行任务，保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行。如果这个线程异常结束，会有另一个取代它，保证顺序执行。单工作线程最大的特点是可保证顺序地执行各个任务，并且在任意给定的时间不会有多个线程是活动的。 
   特点: 

    + 用唯一的工作线程来执行任务, 可保证顺序地执行各个任务
    + 占用小, 但是执行效率低

4. newScheduleThreadPool  

   ![Java使用 Executors 创建四种线程池原理_阻塞队列_03](https://s2.51cto.com/images/blog/202208/03095144_62e9d4b0c753f33120.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

   创建一个定长的线程池，而且支持定时的以及周期性的任务执行，支持定时及周期性任务执行。 
   特点: 

    + 工作线程数量指定
    + 支持定时及周期性任务执行, 应尽量避免使用

   > newScheduleThreadPool详解: http://www.ideabuffer.cn/2017/04/14/%E6%B7%B1%E5%85%A5%E7%90%86%E8%A7%A3Java%E7%BA%BF%E7%A8%8B%E6%B1%A0%EF%BC%9AScheduledThreadPoolExecutor/

#### 线程池阻塞队列

+ ArrayBlockingQueue

  数组结构组成的有界阻塞队列。此队列按照先进先出（FIFO）的原则对元素进行排序，但是默认情况下不保证线程公平的访问队列，即如果队列满了，那么被阻塞在外面的线程对队列访问的顺序是不能保证线程公平（即先阻塞，先插入）的。

+ LinkedBlockingQueue

  一个由链表结构组成的有界阻塞队列。此队列按照先出先进的原则对元素进行排序

+ DelayQueue

  支持延时获取元素的无界阻塞队列，即可以指定多久才能从队列中获取当前元素

+ SynchronousQueue

  不存储元素的阻塞队列，每一个put必须等待一个take操作，否则不能继续添加元素。并且他支持公平访问队列。

+ PriorityBlockingQueue

  支持优先级的无界阻塞队列

+ LinkedTransferQueue

  由链表结构组成的无界阻塞TransferQueue队列。

+ LinkedBlockingDeque

  链表结构的双向阻塞队列，优势在于多线程入队时，减少一半的竞争。

## 1.6 对象, 反射, 泛型

Reference: 
* Java通过反射获取泛型类型信息 
  https://blog.csdn.net/cnds123321/article/details/119655880
* 擦拭法 
  https://www.liaoxuefeng.com/wiki/1252599548343744/1265104600263968
* Java泛型--创建类型实例的几种方法 
  https://blog.csdn.net/Sife_007/article/details/80308517
  
* Type 类型 泛型 反射 Class ParameterizedType [MD] 
  https://www.cnblogs.com/baiqiantao/p/7460580.html
  
* 打个赌你可能不知道如何获取Java泛型的Class对象 
  https://cloud.tencent.com/developer/article/1851247

jad; jclasslib;  type erase 

* Java根据类名反射创建对象 Java通过反射创建对象
https://blog.51cto.com/u_13259/6482348
``` java
      Constructor constructor = i.getClass().getConstructor();
      constructor.setAccessible(true);
      test = (Test) constructor.newInstance();
```


## 1.7 stream 流式操作
### flatmap
+ https://www.geeksforgeeks.org/stream-flatmap-Java-examples/  
+ https://openhome.cc/zh-tw/Java/functional-api/flatmap/  
```
        List<String> violationList = sosInfoDTOS.stream()
                                                .filter(i -> ObjectUtil.isNotEmpty(i.getMsgInfo()))
                                                .flatMap(i -> Arrays.asList(i.getMsgInfo().split(",")).stream())
                                                .distinct()
                                                .collect(Collectors.toList());
```

## 1.8 函数式编程
https://zyb0408.github.io/gitbooks/onJava8/docs/book/13-Functional-Programming.html#Lambda%E8%A1%A8%E8%BE%BE%E5%BC%8F

## 1.9 Predicate 断言
https://www.jianshu.com/p/5988b22f45dd

## Java 定时器

https://www.cnblogs.com/silent-bug/p/13653049.html

## Java Localdate -> String
LocalDate/LocalDateTime与String的互相转换示例(附DateTimeFormatter详解)
https://www.jianshu.com/p/b7e72e585a37
https://www.cnblogs.com/CF1314/p/13884530.html

### String 类型转localDate
LocalDate beginDateTime = LocalDate.parse(beginDate, DateTimeFormatter.ofPattern(“yyyy-MM-dd”));

### date类型转localDate
Date dates = new SimpleDateFormat(“yyyyMM”).parse(cycle);
Instant instant = dates.toInstant();
ZoneId zoneId = ZoneId.systemDefault();
LocalDate localDate = instant.atZone(zoneId).toLocalDate();

## Java经验

1. refDefine-class的问题如果来自于引用, 可能是jar包冲突; 本地的class找不到再确定是不是maven-compile出了问题
2. 

```/**
         * enum类自带一个values()方法, 获取该类中的所有enum
         * 
         * enum变量自带两属性
         * name: 即变量名toString 如RequestMethod.GET.name()即为"name"
         * ordinal: 在enum类中的顺序, 从0开始
         */

  enum 获取索引位置: ConstantEnum.values()[i].ordinal()
```

3. 对象必须做非空判断, 避免NPE
4. list或分页不要使用copyproperties方法, 在一定数量的时候, copyproperties会导致查询很慢; 建议使用mapper查询直接返回vo, 在vo中直接set值
5. Restful本地调用127.0.0.1:xxxx, 但是这种的问题在于, 一个服务依赖于一个服务, 而不是分布式服务集群; (所以引入Feign解耦)
6. 引入代码规范的意义, 实现风险可控
7. 学会做差异化设计, 产品差异化, 服务差异化

```
import static com.xxx.xxxStaticFinal.*;
直接引用所有常量
```

8. 抛出异常必须精准报错, 知道是哪个方法, 哪个字段报错

9. 第三方接口数据必须全部保存, 尤其是涉及到支付

10. // 不可用 clazz.getDeclaredConstructor().newInstance(); 因为这样不会加载 spring - autowired   this.factory = SpringUtils.getBean(clazz);

11. 数据库建议关闭 5432 对外端口, 需要连接时, ssh 连过去    然后再写 postgres sql; 并且使用内网端口, 可以节省外网 io 

12. 测试/生产与本地环境共用 redis, 会导致断点调试异常

13. fileter

14. 除了新增功能, 修改共用数据库之前必须通知 dba, 或者做好备份, 严禁直接修改数据库, 引起生产事故

15. 自定义命令行参数  `--myParam='test'`

16. Response 获取 byte[]

    ```java
    InputStream inputStream = response.body().asInputStream();
    return IOUtils.toByteArray(inputStream);    
    ```

17. @Async 使用 https://blog.csdn.net/YoungLee16/article/details/88398045

    + 在@SpringBootApplication启动类当中添加注解@EnableAsync注解。
    + 异步方法使用注解@[Async](https://so.csdn.net/so/search?q=Async&spm=1001.2101.3001.7020)的返回值只能为void或者Future。
    + 需要走Spring的代理类。因为@Transactional和@Async注解的实现都是基于Spring的AOP，而AOP的实现是基于动态代理模式实现的。那么注解失效的原因就很明显了，有可能因为调用方法的是对象本身而不是代理对象，因为没有经过Spring容器。

18. 命名规范 https://www.jhelp.net/p/Dq0h3U69SZfAAGhP
19. Java使用HMAC-SHA256算法实现接口认证  https://www.jianshu.com/p/365c2b3811d9
20. constant string too long
java string 支持传递长字段, 但是初始化时不支持 10kb 以上字符串, 所以只能通过读取文件或者http方式获取长字段, 比如
```java
    public static String sendLongAudio() {
        // 指定要读取的文件路径
        String filePath = "path";

        String out = "";
        try {
            // 创建文件读取器
            FileReader fileReader = new FileReader(filePath);

            // 创建缓冲字符流
            BufferedReader bufferedReader = new BufferedReader(fileReader);

            // 逐行读取文件内容
            String line = "";
            while ((line = bufferedReader.readLine()) != null) {
                out = line;
            }

            // 关闭文件读取器
            bufferedReader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return out;
    }
```


# 第二章 Mysql

## 2.1 基础类型
[原文链接](https://blog.csdn.net/Alen_xiaoxin/article/details/88418808)：https://blog.csdn.net/Alen_xiaoxin/article/details/88418808
1. 数值类型  

|类型|大小|范围(有符号)|范围(无符号 unsigned)|
|:-:|:-:|:-:|:-:|
|TINYINT|1|(-128, 127)|(0, 255)|
|SMALLINT|2|(-32768, 32767)|(0, 65535)|
|MEDIUMINT|3|±800万|1700万|
|INT|4|±21亿|42亿|
|BIGINT|8|很大||
|FLOAT|4|||
|DOUBLE|8|||
|DECIMAL|对DECIMAL(M,D) ，如果M>D，为M+2否则为D+2|依赖于M和D的值||

+ int(m) 里的 m 是表示 SELECT 查询结果集中的显示宽度，并不影响实际的取值范围，没有影响到显示的宽度。  
+ > MySQL 中使用浮点数和定点数来表示小数。  
  > 浮点类型有两种，分别是单精度浮点数（FLOAT）和双精度浮点数（DOUBLE）；定点类型只有一种，就是 DECIMAL。  
  > 浮点类型和定点类型都可以用(M, D)来表示，其中M称为精度，表示总共的位数；D称为标度，表示小数的位数。  
  > FLOAT 类型的取值范围如下：  
  > 有符号的取值范围：-3.402823466E+38～-1.175494351E-38。  
  > 无符号的取值范围：0 和 -1.175494351E-38～-3.402823466E+38。  
  > DOUBLE 类型的取值范围如下：  
  > 有符号的取值范围：-1.7976931348623157E+308～-2.2250738585072014E-308。  
  > 无符号的取值范围：0 和 -2.2250738585072014E-308～-1.7976931348623157E+308。  
  > 提示：不论是定点还是浮点类型，如果用户指定的精度超出精度范围，则会四舍五入进行处理。  
  > FLOAT 和 DOUBLE 在不指定精度时，默认会按照实际的精度（由计算机硬件和操作系统决定），DECIMAL 如果不指定精度，默认为（10，0）。  
  > float(5,2) 表示：这个浮点数最大长度为5，也就是五位，然后小数部分为2位，至于存储范围，取决于你是否定义了无符号。
  > 无符号的话，最小是0.0 最大能存储到99999.9，如果有符号的话，范围是：-99999.9至99999.9。
  > 默认大小为24位数字，精度大约7位数字（经测试为6位），当设置M大小大于24时，自动转换为DOUBLE类型;同时设置M和D时不进行自动转换。
  > 小数位超过设定值，按四舍五入保存
+ 浮点型在数据库中存放的是近似值，而定点类型在数据库中存放的是精确值。  
+ decimal(m,d) 参数 m ( m < 65 ) 是总个数，参数 d ( d < 30且 d < m) 是小数位。

2. 日期和时间类型
表示时间值的日期和时间类型为DATETIME、DATE、TIMESTAMP、TIME、YEAR。  
每个时间类型有一个有效值范围和一个"零"值，当指定不合法的MySQL不能表示的值时使用"零"值。  
TIMESTAMP类型有专有的自动更新特性。 

3. 字符串类型
字符串类型指CHAR、VARCHAR、BINARY、VARBINARY、BLOB、TEXT、ENUM和SET。
|类型|大小|用途|
|:-:|:-:|:-:|
|CHAR|0-255字节|定长|
|VARCHAR|0-65535字节|变长|
|TINYBLOB|0-255字节|二进制字符串|
|BLOB|0-65536字节|二进制长文本|
|MEDIUMBLOB|0-16 777 215字节|二进制中长文本|
|LONGBLOB|0-4 294 967 295字节|二进制极大文本|
|TINYTEXT|0-255字节|短文本|
|TEXT|0-65536字节|长文本|
|MEDIUMTEXT|0-16 777 215字节|中长文本|
|LONGTEXT|0-4 294 967 295字节|极大文本|

+ > char 和 varchar：  
  > 1. char(n) 若存入字符数小于n，则以空格补于其后，查询之时再将空格去掉。所以 char 类型存储的字符串末尾不能有空格，varchar 不限于此。  
  > 2. char(n) 固定长度，char(4) 不管是存入几个字符，都将占用 4 个字节，varchar 是存入的实际字符数 +1 个字节（n<=255）或 +2个字节(n>255)，
  所以 varchar(4),存入 3 个字符将占用 4 个字节。  
  > 3. char 类型的字符串检索速度要比 varchar 类型的快。  
+ > varchar 和 text：  
  > 1. varchar 可指定 n，text 不能指定，内部存储 varchar 是存入的实际字符数 +1 个字节（n<=255）或 +2 个字节(n>255)，text 是实际字符数 +2 个字节。
  > 2. text 类型不能有默认值。
  > 3. varchar 可直接创建索引，text 创建索引要指定前多少个字符。varchar 查询速度快于 text, 在都创建索引的情况下，text 的索引似乎不起作用。
  > 4. 字段长度低于5000使用varchar(), 大于5000使用text(阿里规约), 且抽离单独做表
+ > blob 和 text:   
  > 1. BLOB和text存储方式不同，TEXT以文本方式存储，英文存储区分大小写，而Blob是以二进制方式存储，不分大小写。  
  > 2. BLOB存储的数据只能整体读出。  
  > 3. TEXT可以指定字符集，BLOB不用指定字符集。  

## 2.2 约束
在 MySQL 中，主要支持以下 6 种约束：
1. 主键约束  
主键约束是使用最频繁的约束。在设计数据表时，一般情况下，都会要求表中设置一个主键。  
主键是表的一个特殊字段，该字段能唯一标识该表中的每条信息。例如，学生信息表中的学号是唯一的。  
2. 外键约束  
   外键约束经常和主键约束一起使用，用来确保数据的一致性。  
   例如，一个水果摊，只有苹果、桃子、李子、西瓜 4 种水果，那么，你来到水果摊要买水果只能选择苹果、桃子、李子和西瓜，不能购买其它的水果。  
    > 注意: 阿里规范规定, 禁止使用外键和级联, 一切外键概念必须在应用层解决  
    > 因为外键影响数据库的插入速度  
    > 而级联更新是强阻塞  
    > 都不适合分布式/高并发的集群

    > 如果某些旧表有外键怎么办?  
    > 解决办法: SET FOREIGN_KEY_CHECKS = 0;
3. 唯一约束  
唯一约束与主键约束有一个相似的地方，就是它们都能够确保列的唯一性。与主键约束不同的是，唯一约束在一个表中可以有多个，并且设置唯一约束的列是允许有空值的，虽然只能有一个空值。  
例如，在用户信息表中，要避免表中的用户名重名，就可以把用户名列设置为唯一约束。
4. 检查约束  
检查约束是用来检查数据表中，字段值是否有效的一个手段。  
例如，学生信息表中的年龄字段是没有负数的，并且数值也是有限制的。如果是大学生，年龄一般应该在 18~30 岁之间。在设置字段的检查约束时要根据实际情况进行设置，这样能够减少无效数据的输入。
5. 非空约束  
非空约束用来约束表中的字段不能为空。例如，在学生信息表中，如果不添加学生姓名，那么这条记录是没有用的。
6. 默认值约束  
默认值约束用来约束当数据表中某个字段不输入值时，自动为其添加一个已经设置好的值。

## 2.3 mysql优化
1. 避免使用出现3个 join 以上的语句
2. 使用子查询优化代码
3. 确保查询条件落在索引上
    > 使用 Explain + SQL语句来确定索引效果,   
    > consts > ref > range > index > all, 而根据阿里规约, 应至少是 range 等级

    > 索引失效的情况 **https://learnku.com/articles/38889**  
    > a. 违反最佳左前缀法则  
    > + 未命中复合索引  1, 2, 3  索引只命中 1, 12, 13, 123  
    > + like 以通配符开头("%abc")  

    > b. 在索引列上做任何操作(计算, 函数等等)  
    > c. 使用了 范围查找(> <) 不等于(<> !=) OR查找 或 NOT IN查找
    > + 解决办法: 使用like in等替换, 或者使用其他数据库   

    > d. 类型异常, 发生类型转换 例如字段类型为字符串, 而查找条件为数字  
    > e. 字段值为 null, 原则上我们应避免任何字段存储 null 值
    > f. 特殊情况, mysql 认为全表更快的时候
    > g. order by / group by 的字段也需要避免上述情况

4.  应尽量避免 in 操作, 若实在需要使用, 控制 in 元素在1000个以内
5.  避免使用 select * / count(*) / sum(*) 等方法
    > 原因: 
    > + count(*) 会统计值为 null 的行, 
    > + sum(*) 会出现 nul 值, 需要考虑 NPE 问题
    > + select * 会出现以下问题: 
    >   + a. 增加查询分析器解析成本
    >   + b. 增减字段容易与 resultMap 配置不一致
    >   + c. 多余字段增加网络开销
6.  参考[2.1 基础类型](#21-基础类型), 应尽量准确选择长度正确的数据类型'
7.  永远小标驱动大表（小的数据集驱动大的数据集）

## 2.4 mysql锁
[参考资料1](https://www.modb.pro/db/41502): https://www.modb.pro/db/41502  
[参考资料2](https://www.cnblogs.com/jojop/p/13982679.html): https://www.cnblogs.com/jojop/p/13982679.html
### 2.4.1 加锁机制
乐观锁与悲观锁是两种并发控制的思想，可用于解决丢失更新问题  

乐观锁会“乐观地”假定大概率不会发生并发更新冲突，访问、处理数据过程中不加锁，只在更新数据时再根据版本号或时间戳判断是否有冲突，有则处理，无则提交事务。用数据版本（Version）记录机制实现，这是乐观锁最常用的一种实现方式  

悲观锁会“悲观地”假定大概率会发生并发更新冲突，访问、处理数据前就加排他锁，在整个数据处理过程中锁定数据，事务提交或回滚后才释放锁。另外与乐观锁相对应的，悲观锁是由数据库自己实现了的，要用的时候，我们直接调用数据库的相关语句就可以了。  

### 2.4.2 mysql锁分类
1. 从对数据操作的类型分类：
+ 读锁（共享锁）：针对同一份数据，多个读操作可以同时进行，不会互相影响
+ 写锁（排他锁）：当前写操作没有完成前，它会阻断其他写锁和读锁

2. 从对数据操作的粒度分类：  
为了尽可能提高数据库的并发度，每次锁定的数据范围越小越好，理论上每次只锁定当前操作的数据的方案会得到最大的并发度，但是管理锁是很耗资源的事情（涉及获取，检查，释放锁等动作），因此数据库系统需要在高并发响应和系统性能两方面进行平衡，这样就产生了“锁粒度（Lock granularity）”的概念。
   + 表级锁：开销小，加锁快；不会出现死锁；锁定粒度大，发生锁冲突的概率最高，并发度最低（MyISAM 和 MEMORY 存储引擎采用的是表级锁）；
   + 行级锁：开销大，加锁慢；会出现死锁；锁定粒度最小，发生锁冲突的概率最低，并发度也最高（InnoDB 存储引擎既支持行级锁也支持表级锁，但默认情况下是采用行级锁）；
   + 页面锁：开销和加锁时间界于表锁和行锁之间；会出现死锁；锁定粒度界于表锁和行锁之间，并发度一般。

1. 从引擎实现分类
所有引擎均支持表锁, 只有InnoDB支持行锁, 而只有BDB支持页锁

### 2.4.3 mysql-Innodb锁介绍
1. InnoDB表锁——意向锁  
由于表锁和行锁虽然锁定范围不同，但是会相互冲突。当你要加表锁时，势必要先遍历该表的所有记录，判断是否有排他锁。这种遍历检查的方式显然是一种低效的方式，MySQL引入了意向锁，来检测表锁和行锁的冲突。  
意向锁也是表级锁，分为读意向锁（IS锁）和写意向锁（IX锁）。当事务要在记录上加上行锁时，要首先在表上加上意向锁。这样判断表中是否有记录正在加锁就很简单了，只要看下表上是否有意向锁就行了，从而就能提高效率。
意向锁之间是不会产生冲突的，它只会阻塞表级读锁或写锁。意向锁不于行级锁发生冲突。

2. InnoDB中的行锁
   + 共享锁（S）：加了锁的记录，所有事务都能去读取但不能修改，同时阻止其他事务获得相同数据集的排他锁；
   + 排他锁（X）：允许已经获得排他锁的事务去更新数据，阻止其他事务取得相同数据集的共享读锁和排他写锁；

### 2.4.4 mysql-Innodb锁实现
+ 意向锁是 InnoDB 自动加的，不需要用户干预；
+ 对于UPDATE、DELETE和INSERT语句，InnoDB会自动给涉及的数据集加上排他锁；
+ 对于普通的SELECT语句，InnoDB不会加任何锁；事务可以通过以下语句显示给记录集添加共享锁或排他锁：
  + 共享锁（S）：select * from table_name where ... lock in share mode。此时其他 session 仍然可以查询记录，并也可以对该记录加 share mode 的共享锁。但是如果当前事务需要对该记录进行更新操作，则很有可能造成死锁。
  + 排他锁（X）：select * from table_name where ... for update。其他session可以查询记录，但是不能对该记录加共享锁或排他锁，只能等待锁释放后在加锁。

> 注意: 
> + 索引失效会导致行锁变表锁
> + for update 仅适用于InnoDB，且必须在事务块(BEGIN/COMMIT)中才能生效。

所以综上, 我们只用关注 mysql InnoDB select 语句的行锁实现。 
而在不同情形下, InnoDB会根据结果不同, 调用不同的行锁算法, 实现不同的锁模式。
+ 记录锁(Record Locks)
  1. 单个行记录上的锁。对索引项加锁，锁定符合条件的行。其他事务不能修改和删除加锁项；
  ```
  # 在 id=1 的记录上加上记录锁，以阻止其他事务插入，更新，删除 id=1 这一行  
  SELECT * FROM table WHERE id = 1 FOR UPDATE;
  ```
  2. 在通过 主键索引 与 唯一索引 对数据行进行 UPDATE 操作时，也会对该行数据加记录锁：
  ```
  -- id 列为主键列或唯一索引列
  UPDATE SET age = 50 WHERE id = 1;
  ```
+ 间隙锁（Gap Locks）  
  + 当我们使用范围条件而不是相等条件检索数据，并请求共享或排他锁时，InnoDB会给符合条件的已有数据记录的索引项加锁。对于键值在条件范围内但并不存在的记录，叫做“间隙”。InnoDB 也会对这个“间隙”加锁，这种锁机制就是所谓的间隙锁。    
  + 对索引项之间的“间隙”加锁，锁定记录的范围（对第一条记录前的间隙或最后一条将记录后的间隙加锁），不包含索引项本身。其他事务不能在锁范围内插入数据，这样就防止了别的事务新增幻影行。  
  + 间隙锁基于非唯一索引，它锁定一段范围内的索引记录。间隙锁基于下面将会提到的Next-Key Locking算法，请务必牢记：使用间隙锁锁住的是一个区间，而不仅仅是这个区间中的每一条数据。
  + 间隙锁的目的，是为了防止同一事务的两次当前读，出现幻读的情况
```
  -- 所有在（1，10）区间内的记录行都会被锁住，所有id 为 2、3、4、5、6、7、8、9 的数据行的插入会被阻塞，但是 1 和 10 两条记录行并不会被锁住。
  SELECT * FROM table WHERE id BETWEN 1 AND 10 FOR UPDATE;
```

+ 临键锁(Next-key Locks)
  + 临键锁，是记录锁与间隙锁的组合，它的封锁范围，既包含索引记录，又包含索引区间。(临键锁的主要目的，也是为了避免幻读(Phantom Read)。如果把事务的隔离级别降级为RC，临键锁则也会失效。)
  + 临键锁可以理解为一种特殊的间隙锁，也可以理解为一种特殊的算法。通过临建锁可以解决幻读的问题。每个数据行上的非唯一索引列上都会存在一把临键锁，当某个事务持有该数据行的临键锁时，会锁住一段左开右闭区间的数据。需要强调的一点是，InnoDB中行级锁是基于索引实现的，临键锁只与非唯一索引列有关，在唯一索引列（包括主键列）上不存在临键锁。
  + 对于行的查询，都是采用该方法，主要目的是解决幻读的问题。

## 2.5 事务隔离
[参考链接](https://juejin.cn/post/6844903665367547918):https://juejin.cn/post/6844903665367547918  
[参考链接](https://cloud.tencent.com/developer/article/1450773):https://cloud.tencent.com/developer/article/1450773
### 2.5.1 数据库事务特征
数据库事务特征，即 ACID :   
+ A Atomicity 原子性  
事务是一个原子性质的操作单元，事务里面的对数据库的操作要么都执行，要么都不执行，
+ C Consistent 一致性  
在事务开始之前和完成之后，数据都必须保持一致状态，必须保证数据库的完整性。也就是说，数据必须符合数据库的规则。
+ I Isolation 隔离性  
数据库允许多个并发事务同事对数据进行操作，隔离性保证各个事务相互独立，事务处理时的中间状态对其它事务是不可见的，以此防止出现数据不一致状态。可通过事务隔离级别设置：包括读未提交（Read uncommitted）、读提交（read committed）、可重复读（repeatable read）和串行化（Serializable）
+ D Durable 持久性  
一个事务处理结束后，其对数据库的修改就是永久性的，即使系统故障也不会丢失。

### 2.5.2 MySQL 数据隔离级别
+ MySQL 里有四个隔离级别：Read uncommttied（可以读取未提交数据）、Read committed（可以读取已提交数据）、Repeatable read（可重复读）、Serializable（可串行化）。使用 select @@tx_isolation; 可以查看 MySQL 默认的事务隔离级别。这四个级别可以逐个解决脏读、不可重复读、幻读这几类问题。
+ 在 InnoDB 中，默认为 Repeatable 级别，InnoDB 中使用一种我们在[2.4.4 mysql-Innodb锁实现](#244-mysql-innodb锁实现)中被称为 next-key locking 的策略来避免幻读（phantom）现象的产生。  
+ 为了解决不可重复读，innodb采用了MVCC（多版本并发控制）来解决这一问题。MVCC是利用在每条数据后面加了隐藏的两列（创建版本号和删除版本号），每个事务在开始的时候都会有一个递增的版本号。注意, 这种方式是自动的。
![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/8/27/1657927364adccc5~tplv-t2oaga2asx-watermark.awebp)

1. Read uncommitted 读未提交

    公司发工资了，领导把5000元打到singo的账号上，但是该事务并未提交，而singo正好去查看账户，发现工资已经到账，是5000元整，非常高 兴。可是不幸的是，领导发现发给singo的工资金额不对，是2000元，于是迅速回滚了事务，修改金额后，将事务提交，最后singo实际的工资只有 2000元，singo空欢喜一场。

    出现上述情况，即我们所说的脏读 ，两个并发的事务，“事务A：领导给singo发工资”、“事务B：singo查询工资账户”，事务B读取了事务A尚未提交的数据。

    当隔离级别设置为Read uncommitted 时，就可能出现脏读，如何避免脏读，请看下一个隔离级别。

2. Read committed 读提交

    singo拿着工资卡去消费，系统读取到卡里确实有2000元，而此时她的老婆也正好在网上转账，把singo工资卡的2000元转到另一账户，并在 singo之前提交了事务，当singo扣款时，系统检查到singo的工资卡已经没有钱，扣款失败，singo十分纳闷，明明卡里有钱，为何......

    出现上述情况，即我们所说的不可重复读 ，两个并发的事务，“事务A：singo消费”、“事务B：singo的老婆网上转账”，事务A事先读取了数据，事务B紧接了更新了数据，并提交了事务，而事务A再次读取该数据时，数据已经发生了改变。

    当隔离级别设置为Read committed 时，避免了脏读，但是可能会造成不可重复读。

    大多数数据库的默认级别就是Read committed，比如Sql Server , Oracle。如何解决不可重复读这一问题，请看下一个隔离级别。

3. Repeatable read 重复读

    在对于数据库中的某个数据，一个事务范围内多次查询却返回了不同的数据值，这是由于在查询间隔，被另一个事务修改并提交了。

    当隔离级别设置为Repeatable read 时，可以避免不可重复读。当singo拿着工资卡去消费时，一旦系统开始读取工资卡信息（即事务开始），singo的老婆就不可能对该记录进行修改，也就是singo的老婆不能在此时转账。

    虽然Repeatable read避免了不可重复读，但还有可能出现幻读 。

    singo的老婆工作在银行部门，她时常通过银行内部系统查看singo的信用卡消费记录。有一天，她正在查询到singo当月信用卡的总消费金额 （select sum(amount) from transaction where month = 本月）为80元，而singo此时正好在外面胡吃海塞后在收银台买单，消费1000元，即新增了一条1000元的消费记录（insert transaction ... ），并提交了事务，随后singo的老婆将singo当月信用卡消费的明细打印到A4纸上，却发现消费总额为1080元，singo的老婆很诧异，以为出 现了幻觉，幻读就这样产生了。

    注：Mysql的默认隔离级别就是Repeatable read。

    不可重复读和脏读的区别是：脏读是某一事务读取了另一个事务未提交的脏数据，而不可重复读则是读取了前一事务提交的数据。

    幻读和不可重复读都是读取了另一条已经提交的事务（这点就脏读不同），所不同的是不可重复读查询的都是同一个数据项，而幻读针对的是一批数据整体（比如数据的个数）。

4. Serializable 序列化（串行化）

    Serializable 是最高的事务隔离级别，同时代价也花费最高，性能很低，一般很少使用，在该级别下，事务顺序执行，不仅可以避免脏读、不可重复读，还避免了幻读。

### 2.5.3 脏读、幻读、不可重复读的概念
1. 脏读（读取未提交数据）  
A事务读取B事务尚未提交的数据，此时如果B事务发生错误并执行回滚操作，那么A事务读取到的数据就是脏数据。就好像原本的数据比较干净、纯粹，此时由于B事务更改了它，这个数据变得不再纯粹。这个时候A事务立即读取了这个脏数据，但事务B良心发现，又用回滚把数据恢复成原来干净、纯粹的样子，而事务A却什么都不知道，最终结果就是事务A读取了此次的脏数据，称为脏读。这种情况常发生于转账与取款操作中。
2. 幻读（前后多次读取，数据总量不一致）  
事务A在执行读取操作，需要两次统计数据的总量，前一次查询数据总量后，此时事务B执行了新增数据的操作并提交后，这个时候事务A读取的数据总量和之前统计的不一样，就像产生了幻觉一样，平白无故的多了几条数据，成为幻读。
3. 不可重复读（前后多次读取，数据内容不一致）  
事务A在执行读取操作，由整个事务A比较大，前后读取同一条数据需要经历很长的时间。而在事务A第一次读取数据，事务B执行更改操作，此时事务A第二次读取, 和之前的数据不一样了，也就是数据不重复了，系统不可以读取到重复的数据，成为不可重复读。

## 2.6 范式
要想设计一个结构合理的关系型数据库，必须满足一定的范式。
目前关系数据库有六种范式：第一范式(1NF)、第二范式(2NF)、第三范式(3NF)、巴斯-科德范式(BCNF)、第四范式(4NF)和第五范式(5NF，又称完美范式)。  
+ 第一范式：每个列都不可以再拆分。要求数据库表的每一列都是不可分割的原子数据项。(确保每列保持原子性)  
+ 第二范式：在第一范式的基础上，非主键列完全依赖于主键，而不能是依赖于主键的一部分。需要确保数据库表中的每一列都和主键相关，而不能只与主键的某一部分相关(主要针对联合主键而言)。  
+ 第三范式：在第二范式的基础上，非主键列只依赖于主键，不依赖于其他非主键。确保数据表中的每一列数据都和主键直接相关，而不能间接相关。  

## 2.7 Mysql经验
1. resultMap可以让下划线命名的mysql转义到下划线命名的JavaBean
2. ObjectUtil.isNotEmpty可以用Iterable判断集合
3. var(String... args) 不定长参数集，或者叫变长参数 
4.  left join 在 on 后加条件 和where 后加条件的影响
on 后面 直接加条件的话，不会对左边的表产生影响，on条件是在左关联时候的条件，不管如何都会返回左边表中的记录;
where 加条件 才会对左边的表 生效。where条件是关联查询之后的条件
on 条件是在生成临时表时使用的条件，它不管 on 中的条件是否为真，都会返回左边表中的记录。where 条件是在临时表生成好后，再对临时表进行过滤的条件。这时已经没有 left join 的含义（必须返回左边表的记录）了，条件不为真的就全部过滤掉。
5. 做冗余的只有两种, 1是不会变的字段  2是需要记录当时状态的字段
6. 如需考虑数百万级的大数据月统计的需求, 
   + 方案1: 
        + 使用自增id, 先查开始日期的id, 再查结束日期的id, 最后根据id范围再来查数据, 缩小表的扫描范围
        + 并利用redis自增序列等技术控制分布式的自增长
   + 方案2: 在老表里, 新增一个字段, 使用时间戳查找
   + 方案3: 使用r-tree二维查询 https://ruby-china.org/topics/34571
   这三个方案都是基于sql线性查找较多维查找更快
   + 方案4: likeRight 月份
7. mybatis list返回null元素, 是因为mysql查出了null值
8. update和delete语句都不能加表别名, 即不能使用c.xxx的形式
9. mysql date格式化
```
日期->字符串: DATE_FORMAT(start_time,'%Y-%m-%d %h:%i:%s')
任意日期格式字符串->date: date(start_time_str)
日期格式字符串按格式->dateTime: str_to_date(start_time_str, '%Y-%m-%d')
```
10. <where></where> 标签会自动拼接合适的and条件
11. delFlag 阿里规范
```
`del_flag` tinyint unsigned DEFAULT 0 COMMENT '删除标识 0/未删除，1/已删除',
```
12. mysql and与on区别
```
# and写在ON后面 左连接, 不存在则返回null
SELECT
    yc.id,
    yc.id2,
    DATE_ADD(
            IFNULL(t2.end_time, now()), INTERVAL t2.add_day DAY
        ) AS `time`
FROM table1 yc
         LEFT JOIN table2 t2
        ON t2.hid = yc.id AND t2.t2_type = '0'
WHERE yc.id IN ('key1', 'key2', 'key3')
ORDER BY yc.id2 DESC;

# and写在where中, 不存在则整条记录不返回
SELECT
    yc.id,
    yc.id2,
    DATE_ADD(
            IFNULL(t2.end_time, now()), INTERVAL t2.add_day DAY
        ) AS `time`
FROM table1 yc
         LEFT JOIN table2 t2
        ON t2.hid = yc.id
WHERE yc.id IN ('key1', 'key2', 'key3')
    AND t2.t2_type = '0'
ORDER BY yc.id2 DESC;
```
13. 排序+去重
```
#并不会排序, 因为取的是t表的字段
SELECT DISTINCT t.*
FROM (SELECT s.msg
      FROM table1 s
      WHERE s.id1 = #{userId}
      ORDER BY s.time DESC) t
LIMIT 0,10

# 这样结果才会排序
SELECT DISTINCT *
FROM (SELECT s.msg
      FROM table1 s
      WHERE s.id1 = #{userId}
      ORDER BY s.time DESC) t
LIMIT 0,10
```
14. 开启mysql日志吗, 记得事后关闭
```
SHOW VARIABLES LIKE 'general%'; set GLOBAL general_log='ON';
```
15. 在使用mysql的8.0.x以上的jar的时候，需要在代码url的链接里面指定serverTimezone; 而idea-maven mysql-connector在依赖时会自动依赖最新版的mysql-connector, 故, http://www.yayihouse.com/yayishuwu/chapter/1604; 
处理方法: 使用<optional>true</optional>隔离maven  
a. 并且druid 使用 1.1.21以上   否则druid会报序列化异常  
b. Java.time.LocalDateTime cannot be cast to Java.util.Date  -> mysql-connector-Java 8.0.22 
16. mysql 解锁
```
# 锁表, 拼接解锁语句
SELECT concat('KILL ',id,';')
FROM information_schema.processlist p
         INNER JOIN  information_schema.INNODB_TRX x
                     ON p.id=x.trx_mysql_thread_id;
```
17. mysql-plus apply 会自动加and条件
18. 一对多查询, 使用json_array(group_concat(json_object('course_name',course_name))), 而不要用使用for-i-sql查询, 因为频繁的jdbc连接与断开十分消耗性能
19. mysql改变时区, 需要重启Java应用和mysql, 否则内置函数now()不生效
20. 不要使用count(*), 他会统计null的列
21. sum()需要注意 NPE 的问题

# 第三章 中间件
## 3.1 redis
### 3.1.1 常用的数据类型
String
Hash
List
Set
Sorted Set

### 3.1.2 服务雪崩与击穿

### 3.1.3 哨兵

### 3.1.4 消息订阅

## 3.x 中间件经验
1. 工作流节点中的表单key,被用来当作角色Code进行使用
2. 本地连生产websocket出现问题后, 会导致各应用卡死, 需要重启线上应用; 所以切记不可让本地直接连接生产的各中间件
3. redis如果用hset做token, hset的过期时间是对顶层key设置的, 也就是说, 只要最后一个hash没有失效, 则全部不会失效; 目前其实在一定程度上类似设置了token永久生效; 对时间敏感的token不可使用hset
4. 缓存, 小数据可以用cacheable标签, 大数据上万条的请直接使用redis

# 第四章 Linux

## 4.x Linux经验
1. test=$(expr "$filename" : "$libsReg")的返回值是false; 如需使用该
2. expr match "$file" "rfty"; expr: syntax error
原因: macos不支持expr match语法, 请使用 expr "$file" : "rfty"代替
3. linux通过端口查看进程：netstat -nap | grep 端口号  或lsof:if 端口号
4. 快捷路径/usr/local/bin/redis-server; /usr/local/Cellar/dex2jar/2.0

# 第五章 Spring-Boot
## 5.1 Spring-Boot经验
1. 如果Application类包所在的位置也很关键，SpringBoot项目的Bean装配默认规则是根据Application类所在的包位置从上往下扫描！Application类是指SpringBoot项目入口类。也就是我的Service层所在的包必须在com.example.mydemo或其子包下，否则Service层中的Bean不会被扫描到
2. web-shiro原理是通过将userName封在jwt-token中, 然后在shiro-realm的doGetAuthenticationInfo()方法鉴权, 最后通过new SimpleAuthenticationInfo(loginUser, token, getName())将loginUser封在shiro-principal中
3. @NotNull(message = "封面不能为空") 标签只能判断null值, 不能判断size为0的list
4. post接口 @RequestBody才能接json; ios端用post接中文
5. 多表高级查询, 使用FieldsUtil.getFieldsWithAlias(stuDTO, "stu"); 该方法不会拼接delFlag; 同时列表页的简单查询, 请使用单表查询
6. 使用高级查询, 要么remove排序字段, 然后自己手动写排序, 要么就用他的排序
7. DynamicDataSourceContextHolder.push("master"); 不支持在事务下切换数据源
8. idea的项目, 记得从项目里删掉jrebel.xml, 他会导致一堆问题
9. 和第三方对接的准则, 一定要把第三方系统的信息保存完整
10. SOA架构, 在shell脚本中, 一定要先监控server2是否运行, 然后server2运行再部署server1, 部署后监控server1部署成功, 再部署server2; 保证至少一台服务器在运行中;
11. 127.0.0.1 某些端口可能没有打开, 所以无法直接访问
12. 打包时忽略某些模块的办法
```
    <modules>
<!--      <module>module1</module>
      <module>module2</module>-->
      <module>module3</module>
    </modules>
```
13. @CacheEvict(value = {BCardConstant.SYS_CONFIG_PARK_LIST} 只会删除该key, 而不会删除子key; 所以如需删除子key, 需要使用redis模糊删除
14. 
![image](https://user-images.githubusercontent.com/37357447/150462539-dd732910-266a-4f9c-bb06-71924f43108d.png)
15. shiro 如果想用全局异常捕获处理shiro异常, 在JwtFilter-executeLogin方法中使用try-catch-throw即可; 否则会自动抛出AuthenticationException异常, 而交给spring-filter容器处理
16. 在代码中 获取项目名
``` java
    @Autowired
    ServletContext servletContext;

    @RequestMapping("/project-name")
    public void getProjectName(HttpServletResponse response) throws IOException {
        String projectName = servletContext.getContextPath();
        response.getWriter().write("Project Name: " + projectName);
    }
  
```
17.  spring validation
```
https://blog.csdn.net/kylin_tam/article/details/116276610
@Min => num

@Max => num

@Size(min=, max=) => list

@Length(min=, max=) => String
```
18. Java 实现断点传输: https://blog.csdn.net/u011250186/article/details/128322350


## 5.2 Spring 中的 maven 冲突与管理
### 5.2.1 SpringBoot 中的依赖管理和自动仲裁机制

```
<!-- example -->
        <dependency>
            <groupId>com.squareup.okhttp3</groupId>
            <artifactId>okhttp</artifactId>
            <version>${okhttp3.version}</version>
            <scope>compile</scope>
            <optional>true</optional>
        </dependency>
```

参考资料:
1. https://www.cxyzjd.com/article/MrYushiwen/111866287
2. https://cloud.tencent.com/developer/article/1676041

也许您认为这个问题无关紧要, 但是在实际开发中, 各个插件的版本并不能由您所决定, maven 版本冲突导致各种神奇问题, 会让您的开发思路走向崩溃

> 这是一个实际的场景: 
> 1. 例如在您的项目中引入华为Obs  `esdk-obs-Java` 的相关依赖, 他使用的`okhttp`依赖为`4.xx`, 
但是在`Spring 2.3.x`的默认依赖管理中, `okhttp`的默认依赖为`3.xx`, 
这样导致的问题就是, 代码编写时没有问题, 但是在代码运行后, 就会出现 `class not found` 或 `method not found` 之类的异常
> 2. 在复杂项目中, 您往往会使用多模块进行开发, 所以即使您使用了华为官方推荐的 `esdk-obs-Java-bundle`, 依然会存在上述问题
> 3. 而在另一种情形中, 即使您使用了微服务架构进行部署, 但是在某些时候, 您仍然不可避免的会遇到 maven 依赖冲突的问题
> 所以, 以下是我的总结: 

spring maven管理主要是两个标签 `scope` 与 `optional` 
1. scope: compile, provide, runtime, test...
  + compile: 默认值, 子项目继承父项目依赖
  + provide: 子项目不继承父项目依赖, 各自配置 maven 版本
  + runtime: 子项目不继承父项目依赖且仅在 runtime 期间启用
  + test: 仅 test dir 可使用

2. optional: true, false
  + false: 默认值, 子项目继承父项目依赖, 版本默认使用 spring boot 的自动版本仲裁机制, 或者手动指定版本
  + true: 子项目不继承父项目依赖且版本与当前项目保持一致

3. 注意, 单体应用启动后, 同名依赖只会加载一个版本
maven处理重复依赖不同版本的方式如链接所示, https://blog.csdn.net/lishe9452/article/details/119146586

在实际使用中, 我推荐您使用以下三个组合
```
<!--
子项目继承父项目依赖, 
子项目依赖版本与当前项目保持一致
仅在  <dependencies> 中生效, 使用本组合, 子项目无需再引入, 用于全局依赖
-->
            <scope>compile</scope>
            <optional>true</optional>
```

```
<!--
在子项目指定版本

当前不继承父项目依赖, 
仅在当前项目中使用该依赖
-->
            <scope>provide</scope>
```
```
方案三:
放在顶层项目的
    <dependencyManagement>
        <dependencies>
中, 直接替换 spring 依赖
```

> 请您千万不要图省事, 使用 spring 的默认配置, 那样的直接后果就是
> search `google.com` -> 3:00 am



## Spring yml

已知 spring boot yml 配置如下
```yaml
thread-pool:
    # 最大线程数
    max-size: 20
    # 核心线程数
    core-size: 10
    # 存活时间
    keep-alive: 60
    # 队列大小
    queue-capacity: 200
    # 是否允许核心线程超时
    allow-core-thread-timeout: true
    # 线程名称前缀
    thread-name-prefix: taskExecutor-
    # 关闭进程前执行完线程
    await-termination: true
    # 等待时间
    await-termination-period: 60
    # 拒绝政策
    rejected-execution-handle: 'Java.util.concurrent.ThreadPoolExecutor$CallerRunsPolicy'
```

帮我生成 Configuration, 并使用 @Configuration 和 @Data 以及 @Value @ConfigurationProperties(prefix = "thread-pool.thread-oss") 注解, 各变量使用包装类型, 生成结果如下

```java
@Configuration
@ConfigurationProperties(prefix = "thread-pool.thread-oss") //前缀
@Data
public class ThreadPoolOssConfig {

    private Integer maxSize;

    private Integer coreSize;

    private Integer keepAlive;

    private Integer queueCapacity;

    private Boolean allowCoreThreadTimeout;

    private String threadNamePrefix;

    private Boolean awaitTermination;

    private Integer awaitTerminationPeriod;

    private String rejectedExecutionHandler;
}
```



# 第六章 Spring-cloud-alibaba

[相关链接](https://github.com/hsiong/spring-cloud-alibaba-base): https://github.com/hsiong/spring-cloud-alibaba-base

# 第七章 数据结构与算法

# 第八章 常见的锁及其实现

# 第九章 程序设计

## 9.1 面向对象设计
[参考链接](https://github.com/hsiong/my-note/tree/main/oop): https://github.com/hsiong/my-note/tree/main/oop

## 9.2 设计思想
### 9.2.1 自顶向下
### 9.2.2 敏捷开发
### 9.2.3 领域驱动

## 9.3 设计模式
[相关链接](https://github.com/hsiong/design-pattern-Java): https://github.com/hsiong/design-pattern-Java

# 第十章 DevOps
## 10.1 Jenkins
## 10.2 Docker
## 10.3 k8s


# 第十一章 Android

# 第十二章 Vue
## 12.1 Vue生命周期
1. beforeCreate（创建前）  
   在实例初始化之后，数据观测(data observer) 和 event/watcher 事件配置之前被调用。
2. created（创建后）  
   实例已经创建完成之后被调用。在这一步，实例已完成以下的配置：数据观测(data observer)，属性和方法的运算， watch/event 事件回调。然而，挂载阶段还没开始，$el 属性目前不可见。
3. beforeMount（挂载前）  
   在挂载开始之前被调用：相关的 render 函数首次被调用。
4. mounted（挂载后）  
   el 被新创建的 vm.$el 替换，并挂载到实例上去之后调用该钩子。
5. beforeUpdate（更新前）  
   数据更新时调用，发生在虚拟 DOM 重新渲染和打补丁之前。 你可以在这个钩子中进一步地更改状态，这不会触发附加的重渲染过程。
6. updated（更新后）  
   由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。当这个钩子被调用时，组件 DOM 已经更新，所以你现在可以执行依赖于 DOM 的操作。然而在大多数情况下，你应该避免在此期间更改状态，因为这可能会导致更新无限循环。该钩子在服务器端渲染期间不被调用。
7. beforeDestory（销毁前）  
   实例销毁之前调用。在这一步，实例仍然完全可用。
8. destoryed（销毁后）  
   Vue 实例销毁后调用。调用后，Vue 实例指示的所有东西都会解绑定，所有的事件监听器会被移除，所有的子实例也会被销毁。 该钩子在服务器端渲染期间不被调用。

## 12.x Vue经验
1. vue项目 npm出不来, 看看vue插件是不是没启用
2. if判断的and 要小写;queryDateDTO.submitTime_begin != null and queryDateDTO.submitTime_begin != '' 
3. 前端405, post或get请求方式不对

# 第十三章 常用工具
|工具|功能|
|:-:|:-:|
|visual VM|定位堆栈/OOM|
|jmap|定位OOM|
|jmeter|接口测试, 并发测试|
|postman|接口测试|
|XMind|思维导图|
|drawIo|工作流图|
|finalShell|远程链接|
|||
|||

# 第十四章 网络开发
## 14.1 OSI七层模型
参考资料: [OSI七层模型](https://wenku.baidu.com/view/f8a3e498824d2b160b4e767f5acfa1c7ab008202.html)

|协议|介绍|特点|物理设备|协议|
|:-:|:-:|:-:|:-:|:-:|
|物理层|物理层的任务就是为它的上一层提供一个物理连接，以及它们的机械、电气、功能和规程特性|在这一层，数据还没有被组织，仅作为原始的位流或电气电压处理，单位是bit比特|物理连网媒介|电气电压 单位bit|
|数据链路层|在物理层提供比特流服务的基础上，建立相邻结点之间的数据链路，通过差错控制提供数据帧(Frame)在信道上无差错的传输，并进行各电路上的动作系列。它的主要功能是如何在不可靠的物理线路上进行数据的可靠传递|为了保证传输，从网络层接收到的数据被分割成特定的可被物理层传输的帧。帧是用来移动数据的结构包，它不仅包括原始数据，还包括发送方和接收方的物理地址以及检错和控制信息。其中的地址确定了帧将发送到何处，而纠错和控制信息则确保帧无差错到达。如果在传送数据时，接收点检测到所传数据中有差错，就要通知发送方重发这一帧。|交换机|SDLC、HDLC、PPP、STP、帧中继等|
|网络层|其主要功能是将网络地址翻译成对应的物理地址，并决定如何将数据从发送方路由到接收方|网络层通过综合考虑发送优先权、网络拥塞程度、服务质量以及可选路由的花费来决定从一个网络中节点A%2B到另一个网络中节点B%2B的最佳路径。由于网络层处理，并智能指导数据传送，路由器连接网络各段，所以路由器属于网络层。在网络中，“路由”是基于编址方案、使用模式以及可达性来指引数据的发送|路由器|IP、Novell公司的IPX以及AppleTalk协议|
|传输层|传输协议同时进行流量控制或是基于接收方可接收数据的快慢程度规定适当的发送速率。除此之外，传输层按照网络能处理的最大尺寸将较长的数据包进行强制分割。|||TCP/IP协议套中的TCP(传输控制协议)，另一项传输层服务是IPX%2FSPX协议集的SPX(序列包交换)|
|会话层|OSI参考模型的第五层。负责在网络中的两节点之间建立、维持和终止通信。|会话层的功能包括：建立通信链接，保持会话过程通信链接的畅通，同步两个节点之间的对话，决定通信是否被中断以及通信中断时决定从何处重新发送|||
|表示层|在表示层，数据将按照网络能理解的方案进行格式化|表示层管理数据的解密与加密, 表示层协议还对图片和文件格式信息进行解码和编码|||
|应用层|主要负责对软件提供接口以使程序能使用网络服务。某个特别应用程序，应用层提供的服务包括文件传输、文件管理以及电子邮件的信息处理|应用层也称为应用实体(AE)，它由若干个特定应用服务元素(SASE）和一个或多个公共应用服务元素(CASE)组成。每个SASE提供特定的应用服务，例如文件运输访问和管理(FTAM)、电子文电处理(MHS)、虚拟终端协议(VAP)等。CASE提供一组公共的应用服务，例如联系控制服务元素(ACSE)、可靠运输服务元素(RTSE)和远程操作服务元素(ROSE)等|||

## 14.2 网络协议
|协议|特点|区别|
|:-:|:-:|:-:|
|HTTP|||
|HTTPS|||
|MQTT|||
|TCPIP|||
|UDP|||
|蓝牙BLE4.0|||
||||

## 排序/查找算法

锁
查找
排序
KMP
数据结构
nop rl dl slam

## 零拷贝/DMA
https://juejin.cn/post/7016498891365302302

+ 

# 
1. 作为架构师  要有统一版本管理 <= Github: dependBot
  + [spring 2.4 config change](https://spring.io/blog/2020/08/14/config-file-processing-in-spring-boot-2-4)
2. 学会 github ci/cd 
3. 学会 github pr/cr
4. 领域驱动设计
5. microservices
6. devops
7. cloud native
8. 熟练使用英文获取资料
9.  学会用英文查找
10. 制定代码规范和接口规范
    + 分页接口必须返回以下字段: 分页结果, 当前页, 总结果数, 总页数
    + 彻底废弃代码必须删除, 或者注释后并标记 @Deprecated
    + 前端项目名 frontend 结尾, 后端 backend 结尾
    + 数据库严禁使用 enum, 因为 enum 默认存入数据库的值为该 enum 在枚举类中的排序; 实在需要使用时, 需要使用 @Enumerated(EnumType.STRING) 之类的注解, 指定存储为 string
    + 后端必须在接口文档中明确返回类以及返回值的描述
    + 禁止用 map, 而是用对象来接收类
    + 方法必须写注释, 数据库字段必须写注释, 
    + 代码必须避免冗余/重复/恶心的代码, 必须简洁, 禁止一处功能多处定义
    + 必须使用 lombok 来减少耦合
    + 代码规范包括: 命名规范, 注释规范, 
    + 耦合包括: 逻辑耦合, 代码耦合, 设计耦合, 表结构耦合
    + 必须逻辑删除, 严禁物理删除
    + 接口必须 public 声明
11. ci 出错考虑代码异常导致的回退
12. [一篇带你了解OLTP vs. OLAP](https://www.51cto.com/article/701725.html)
13. [Properties和Yml有什么区别](https://wangxiao.xisaiwang.com/ucenter2/zhibo/list.html)

 ##  保持好的对接习惯
+ 保持代码规范
+ 时刻思考软件工程

+ 做好单元测试
+ 接口以 swagger 地址的形式给到前端, 具备完整的测试用例和接口文档说明; 如使用到网关, 另给出网关调用形式

项目设计 -> UI设计 -> 定义接口 -> 开发 -> 交付接口文档 -> 测试 -> 交付; 

+ 多对多: 中间表; 一对多, key-value
+ 利用 jekins 打包的好处, 利用服务器性能, 而不是受本机性能损耗



# 高并发

https://cloud.tencent.com/developer/article/2131980

## 后端性能优化的指标

响应时间 并发数目 吞吐量。

常用的吞吐量指标：   ①TPS(每秒事务数)、

②HPS(每秒Http请求数)、

③QPS(每秒查询数，)

常用的性能计数器有：System Load、对象和线程数、CPU使用、内存使用、磁盘和网络IO等指标。 

性能测试的几个参考点： 性能测试 

负载测试：系统的某项或者多想性能指标达到安全临界值时的并发数 

压力测试 

稳定性测试。稳定性测试主要是长时间给系统一定的压力，看系统是否正常运行。 网站的性能优化三维度

## **后台服务器常用的优化方式**

缓存 集群 异步 代码优化 存储优化 缓存相关知识

## 缓存

**后台性能优化的第一定律：优先考虑使用缓存优化性能。**

#### **缓存的本质**

缓存的本质就是一个内存Hash表，数据以一对KeyValue键值对存储在内存Hash表中。主要用户存放读写比很高、很少变化的数据，网站数据通常遵循“二八定律”，即80%的访问落在20%的数据上，因此，将这20%的数据缓存起来，可以很好的改善系统性能。

##### **合理的使用缓存**

合理的使用缓存对提高系统性能有很多好处，但是不合理的使用缓存反而会成为系统的累赘甚至风险。滥用缓存的三种情况如下：

##### **频繁修改的数据**   

数据的读写比至少应该是2:1以上，即写入一次缓存，在数据更新前至少读写两次，缓存才有意义。真正实践中这个比例可能会更高。

##### **没有热点的访问**   

如果应用系统访问数据没有热点，不遵循二八定律，即大部分数据访问并没有集中在小部分数据中，那么缓存也没有意义，因为大部分数据还没有被再次访问就已经被挤出缓存了。

##### **数据的不一致与脏读**   

写入缓存的数据最好能容忍一定时间的数据不一致，一般情况下最好对缓存的数据设置失效时间(固定值+一定范围的随机值)。如果不能容忍数据的不一致，必须在数据更新时，删除对应的缓存(思考：为什么不是更新缓存)[可以参考这个文档](https://cloud.tencent.com/developer/tools/blog-entry?target=https://www.cnblogs.com/llzhang123/p/9037346.html)，但是这种情况只针对读写比非常高的情况。

#### 缓存的常见问题优化手段

##### 缓存雪崩

   缓存雪崩我们可以简单的理解为：由于原有缓存失效，新缓存未到期间(例如：我们设置缓存时采用了相同的过期时间，在同一时刻出现大面积的缓存过期)，所有原本应该访问缓存的请求都去查询数据库了，而对数据库CPU和内存造成巨大压力，严重的会造成数据库宕机。从而形成一系列连锁反应，造成整个系统崩溃。

该类问题的解决方式主要有三种：

①加锁排队。大概原理是在去数据库取数据的时候加锁排队，该方法仅仅适用于并发量不高的情况。

②在原有失效时间基础上加一个合理的随机值(0-5分钟)。分布式场景下最常见的方式(单机也可以)。

③给缓存加标记，在缓存失效之后更新缓存数据。

##### 缓存穿透

   缓存穿透是指用户查询数据，在数据库没有，自然在缓存中也不会有。这样就导致用户查询的时候，在缓存中找不到，每次都要去数据库再查询一遍，然后返回空（相当于进行了两次无用的查询）。

该类问题的主要解决方式。

①使用布隆过滤器做过滤。该方法仅仅用于查询一个不可能存在的数据。

②把不存在的数据也缓存起来。最佳实践：单独设置比较短的过期时间，比如说五分钟。

##### 缓存预热

   缓存中存放的是热点数据，热点数据又是缓存系统利用某种算法对不断访问的数据筛选淘汰出来的，在重建缓存数据的过程中，系统的性能和数据库负载都不太好，那么多好的方式就是在缓存系统启动的时候就把热点数据加载好，这个缓存预加载的手段叫做缓存预热。对于一些元数据如省市区列表，类目信息，就可以在启动的加载数据库中的全部数据。

#### **分布式缓存架构**

分布式缓存是指缓存部署在多个服务器组成的集群中，以集群方式提供缓存服务，其架构方式有两种：

①以JBosss Cache为代表的需要更新同步的分布式缓存(在所有服务器中保存相同的缓存数据)。

②以Memcache为代表的互不通信的分布式缓存(应用程序通过一致性Hash等路由算法选择缓存服务器远程访问远程数据，可以会容易的扩容，具有良好的可伸缩性)。

## 异步

使用异步操作，可以大幅度改善网站的性能，使用异步的两种场景，高并发、微服务；

①高并发，在不使用消息队列的情况下，用户的请求数据直接写入数据库，在高并发的情况下会对数据库造成一定的压力，同时也使得响应延迟加剧。使用消息队列具有很好的削峰作用，在电子商务网站促销活动中，使用消息队列是常见的技术手段。

②微服务之间调用，在微服务流行的当下，有时候我们调用其他系统的微服务接口，只是为了通知其他系统，我们不关心结果，这个时候我们可以使用单独的线程池异步调用其他系统的微服务，这样可以减少程序的响应时间。

任何可以晚点的事情都应该晚点再做。

## 集群

在网站高并发访问的场景洗下，使用负载均衡技术为一个应用构建一个由多台服务器组成的服务器集群，可以避免单一服务器因负载压力过大而响应缓慢。常用的负载均衡技术有以下几种：

①HTTP重定向负载均衡，不利于SEO，不推荐。

②DNS域名解析负载均衡，许多DNS服务器还支持基于地理位置的域名解析，会将域名解析成距离用户地理最近的一个服务器地址，这样可以加快访问速度。大公司常用的手段。

③反向代理负载均衡(应用层负载均衡)，常见产品：Nginx,反向代理服务器的性能可能会成为瓶颈。

④IP负载均衡，在内核进程完成数据分发，叫反向代理负载均衡有更好的处理性能，网卡和带宽会成为主要的瓶颈。

⑤数据链路层负载均衡(三角传输模式)，又名DR(直接路由模式)，也是大型网站昌运宫的负载均衡手段，在Linux平台上最好的链路层负载均衡产品是LVS。

## 代码优化

网站的业务逻辑实现代码主要部署在应用服务器上，合理的优化代码也可以很好的改善网站性能。几种常用的几种代码优化方式：

①合理使用多线程，服务器的启动的线程数参考值：[任务执行时间/(任务执行时间-IO等待时间)]CPU内核数。

②资源复用，要尽量减少那些开销很大的系统资源的创建和销毁，比如数据库连接，网络通信连接、线程、复杂对象，从编程角度，资源复用主要有两种方式，单例、对象池。

③数据结构，前面缓存部分就已经提到了Hash表的基本原理，Hash表的读写性能在很大程度上依赖于HashCode的随机性，即HashCode越散列，Hash表的冲突就越少，目前比较好的Hash散列算法是Time33算法，算法原型为：hash(i) = hash(i-1)33+str[i]。

④垃圾回收，比如说在JVM里，合理设置Young Generation和Old Generation的大小，尽量减少Full GC，如果设置合理的话，可以在整个运行期间做到从不进行Full GC。

## 存储优化

在网站应用中，海量是的数据读写对磁盘访问会造成一定的压力，虽然可以通过Cache解决一部分数据读压力，但是很多时候，磁仍然是系统最严重的瓶颈。

机械硬盘VS固态硬盘
   这两个的区别我相信大家都知道了吧，机械硬盘是通过马达驱动磁头臂带动磁头到指定的磁盘位置访问数据，这个效率我就不用多说了吧，相反，固态硬盘的数据是存储在可以持久记忆的硅晶体上，因此可以像内存一样随机访问，而且功耗更小。

B+树VS. LSM树
   B+树是一种专门针对磁盘存储而优化的N叉排序树，以树节点为单位存储在磁盘中，从根开始查找所需的节点编号和磁盘位置，将其加载到内存中，然后继续查找，知道找到所需数据，目前大部分关系型数据库多采用两级索引的B+树，树的层次最多为3层。

目前很多NoSQL产品采用LSM树作为主要的数据结构，LSM树可以看做是一个N阶合并树，数据的写操作都在内存中完成，并且都会创建一个新记录，这些数据在内存中仍然还是一颗排序树。在需要读的时候，总是从内存中的排序树开始搜索，如果没有找到，就从磁盘的排序树中查找。

在LSM树上进行一次数据更新不需要磁盘访问，在内存中即可完成，速度远快于B+树，当数据访问以写操作为主，而读操作则集中在最近写入的数据上时，使用LSM树可以极大程度的减少磁盘的访问次数，加快访问速度。

