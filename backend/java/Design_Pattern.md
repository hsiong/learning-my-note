# design-pattern-java
23 commonly-used design patterns implemented by java  

[参考链接: https://design-patterns.readthedocs.io/zh_CN/latest/read_uml.html](https://design-patterns.readthedocs.io/zh_CN/latest/read_uml.html)

# 序 UML介绍
## 1. 示例
![19441645688391_ pic](https://user-images.githubusercontent.com/37357447/155480183-731c4e05-4d03-4445-86e7-fabef16e31cb.jpg)
## 2. 详述
1. 泛化关系(generalization)  
![](https://design-patterns.readthedocs.io/zh_CN/latest/_images/uml_generalize.jpg)
+ 泛化关系用一条带空心箭头的直接表示
+ 继承关系为 is-a的关系；两个对象之间如果可以用 is-a 来表示，就是继承关系：（..是..)  
+ 最终代码中，泛化关系表现为继承非抽象类
+ 类的继承结构表现在UML中为：泛化(generalize)与实现(realize)

2. 实现关系(realize)  
![](https://design-patterns.readthedocs.io/zh_CN/latest/_images/uml_realize.jpg)
+ 实现关系用一条带空心箭头的虚线表示
+ 最终代码中，实现关系表现implement interface, 或继承抽象类

3. 聚合关系(aggregation)  
![image](https://user-images.githubusercontent.com/37357447/155485564-5519b65d-63be-45cd-8b85-a3bcefc4cf74.png)
+ 聚合关系用一条带空心菱形箭头的直线表示
+ 聚合关系用于表示实体对象之间的关系，表示整体由部分构成的语义
+ 与组合关系不同的是，整体和部分不是强依赖的，即使整体不存在了，部分仍然存在

4. 组合关系(composition)  
![image](https://user-images.githubusercontent.com/37357447/155485726-74f8bcf7-845d-4f1d-91e3-c96e262153ba.png)
+ 组合关系用一条带实心菱形箭头直线表示
+ 与聚合关系一样，组合关系同样表示整体由部分构成的语义
+ 组合关系是一种强依赖的特殊聚合关系，如果整体不存在了，则部分也不存在了

5. 关联关系(association)  
![image](https://user-images.githubusercontent.com/37357447/155485823-0cd03979-4fd1-4c70-ac6f-a3a8ce260c06.png)
+ 关联关系是用一条直线表示的; 关联关系默认不强调方向，表示对象间相互知道, 如需表达方向, 使用箭头表示
+ 它描述不同类的对象之间的结构关系, 它是一种静态关系， 通常与运行状态无关，一般由常识等因素决定的
+ 它一般用来定义对象之间静态的、天然的结构, 所以，关联关系是一种“强关联”的关系

6. 依赖关系(dependency)  
![image](https://user-images.githubusercontent.com/37357447/155485916-7390750f-38a9-48ab-8469-8a2b5bd3a207.png)
+ 依赖关系是用一套带箭头的虚线表示的
+ 他描述一个对象在运行期间会用到另一个对象的关系
+ 与关联关系不同的是，它是一种临时性的关系，通常在运行期间产生，并且随着运行时的变化, 依赖关系也可能发生变化
+ 显然，依赖也有方向，双向依赖是一种非常糟糕的结构，我们总是应该保持单向依赖，杜绝双向依赖的产生
+ 在最终代码中，依赖关系体现为类构造方法及类方法的传入参数，箭头的指向为调用关系, 依赖关系除了临时知道对方外，还“使用”对方的方法和属性

## 3. 时序图

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
