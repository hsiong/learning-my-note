# design-pattern-java
23 commonly-used design patterns implemented by java  

[参考链接: https://design-patterns.readthedocs.io/zh_CN/latest/read_uml.html](https://design-patterns.readthedocs.io/zh_CN/latest/read_uml.html)

# 第一章 简述
设计模式分为三大类：
+ 创建型模式，共五种：工厂方法模式、抽象工厂模式、单例模式、建造者模式、原型模式
+ 结构型模式，共七种：适配器模式、装饰者模式、代理模式、外观模式、桥接模式、组合模式、享元模式。
+ 行为型模式，共十一种：解释器模式、模板方法模式、策略模式、观察者模式、迭代器模式、职责链模式、命令模式、备忘录模式、状态模式、访问者模式、中介者模式。
+ 其实还有两类：并发型模式和线程池模式。

|范围|类模式|对象模式|
|:-:|:-:|:-:|
|创建型模式|工厂方法|抽象工厂<br>单例<br>建造者<br>原型|
|结构型模式|(类)适配器|(对象）适配器<br>装饰者<br>代理<br>外观<br>桥接<br>组合<br>享元|
|行为型模式|模板方法<br>解释器|策略<br>观察者<br>迭代器<br>职责链<br>命令<br>备忘录<br>状态<br>访问者<br>中介者|


# 第二章 简单工厂模式( Simple Factory Pattern )


# 第x章 实际使用
+ 简单工厂模式  getInstance(xxx)， 获取加密实例
+ 工厂方法模式   消息推送， 根据不同的状态， 调用不同的推送方法
+ 中介者模式   聊天过滤系统
+ 观察者模式   发布订阅
+ 状态模式   oa审批流共享状态
+ 桥接模式   不同安卓平台下载不同文件  

spring: 
+ 适配器模式  jdbc
+ 迭代器模式   
+ 外观模式  引入nacos
+ 单例模式  ioc
+ 代理模式  aop
