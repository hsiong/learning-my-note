<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="知识共享许可协议" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />本作品采用<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">知识共享署名-非商业性使用-禁止演绎 4.0 国际许可协议</a>进行许可。

- [面向对象基础](#面向对象基础)
- [第一章 程序设计思想](#第一章-程序设计思想)
  - [1.1 程序设计目标](#11-程序设计目标)
  - [1.2 通用设计原则](#12-通用设计原则)
- [第二章 面向对象的 7 大设计原则](#第二章-面向对象的-7-大设计原则)
  - [开闭原则（Open Closed Principle，OCP）](#开闭原则open-closed-principleocp)
  - [里氏替换原则（Liskov Substitution Principle，LSP）](#里氏替换原则liskov-substitution-principlelsp)
  - [合成复用原则（Composite Reuse Principle，CRP）](#合成复用原则composite-reuse-principlecrp)
  - [依赖倒置原则（Dependence Inversion Principle，DIP）](#依赖倒置原则dependence-inversion-principledip)
  - [单一职责原则（Single Responsibility Principle，SRP）](#单一职责原则single-responsibility-principlesrp)
  - [接口隔离原则（Interface Segregation Principle，ISP）](#接口隔离原则interface-segregation-principleisp)
  - [迪米特法则（Law of Demeter，LoD）](#迪米特法则law-of-demeterlod)

&nbsp;

# 面向对象基础

&nbsp;

# 第一章 程序设计思想

## 1.1 程序设计目标

在代码设计上, 我们的目标是`高内聚、低耦合。多聚合、少继承`

一. `高内聚、低耦合`  
内聚是从功能角度来度量模块内的联系，一个好的内聚模块应当恰好做一件事。它描述的是模块内的功能联系。
耦合是软件结构中各模块之间相互连接的一种度量，耦合强弱取决于模块间接口的复杂程度、进入或访问一个模块的点以及通过接口的数据。
高内聚低耦合，是软件工程中的概念，是判断设计好坏的标准，主要是面向对象的设计，主要是看类的内聚性是否高，耦合度是否低。

 + 概念
   + 内聚：每个模块尽可能独立完成自己的功能，不依赖于模块外部的代码。若一个模块内各元素（语名之间、程序段之间）联系的越紧密，则它的内聚性就越高。
   + 耦合：模块与模块之间接口的复杂程度，模块之间联系越复杂耦合度越高，牵一发而动全身。模块之间联系越紧密，其耦合性就越强，模块的独立性则越差。模块间耦合高低取决于模块间接口的复杂性、调用的方式及传递的信息。在java中, 我们考虑接口/类/模块甚至是服务之间的耦合程度。
   + 目的：使得模块的“可重用性”、“移植性”大大增强; 通常程序结构中各模块的内聚程度越高，模块间的耦合程度就越低
 + 模块粒度
   + 函数
     高内聚：尽可能类的每个成员方法只完成一件事（最大限度的聚合）
     低耦合：减少类内部，一个成员方法调用另一个成员方法
   + 类
     减少类内部，对其他类的调用
   + 功能块
     减少模块之间的交互复杂度（接口数量，参数数据）

> 耦合可以分为以下几种:
>
> 1. 内容耦合：一个模块`直接访问另一模块的内容`，则称这两个模块为内容耦合。
>    若在程序中出现下列情况之一，则说明两个模块之间发生了内容耦合:
>       + 一个模块直接访问另一个模块的内部数据
>       + 一个模块不通过正常入口而直接转入到另一个模块的内部
>       + 两个模块有一部分代码重叠（该部分代码具有一定的独立功能）
>       + 一个模块有多个入口
> 2. 公共耦合：一组模块`都访问同一个公共数据结构`，则称之为公共耦合。
>    公共数据环境可以是全局数据结构、共享的通信区、内存的公共覆盖区等。
>    如果模块只是向公共数据环境输入数据，或是只从公共数据环境取出数据，这属于比较松散的公共耦合。
>    如果模块既向公共数据环境输入数据又从公共数据环境取出数据，这属于较紧密的公共耦合。
>    公共耦合会引起以下问题：
>       + 无法控制各个模块对公共数据的存取，严重影响了软件模块的可靠性和适应性。
>       + 使软件的可维护性变差。若一个模块修改了公共数据，则会影响相关模块。
>       + 降低了软件的可理解性。不容易清楚知道哪些数据被哪些模块所共享，排错困难。
> 3. 外部耦合：一组模块`都访问同一全局简单变量`，而且不通过参数表传递该全局变量的信息，则称之为外部耦合。
> 4. 控制耦合：调用模块和被调用模块之间模块之间传递的信息包括用于`控制模块内部逻辑的信息`。
> 5. 标记耦合：调用模块和被调用模块之间 `传递数据结构` 而不是简单数据，同时也称作特征耦合。表就和表的模块间传递的不是简单变量，而是像高级语言中的数据名、记录名和文件名等数据结果，这些名字即为标记，其实传递的是地址。
> 6. 数据耦合：调用模块和被调用模块之间`只传递简单的数据项参数`。相当于高级语言中的值传递。
> 7. 非直接耦合：`两个模块之间没有直接关系，它们之间的联系完全是通过主模块的控制和调用来实现的`。耦合度最弱，模块独立性最强。(低耦合)
>
> 总结:
> 耦合是影响软件复杂程度和设计质量的一个重要因素，为提高模块的独立性，应建立模块间尽可能松散的系统。
> 在设计上我们应采用以下原则：若模块间必须存在耦合，应尽量使用数据耦合，少用控制耦合，慎用或有控制地使用公共耦合，并限制公共耦合的范围，尽量避免内容耦合。

<br/>
<br/>

> 内聚有如下的种类，它们之间的内聚度<u>由弱到强</u>排列如下：
>
> 1. 偶然内聚：一个`模块内的各处理元素之间没有任何联系`，只是偶然地被凑到一起。这种模块也称为巧合内聚，内聚程度最低。
> 2. 逻辑内聚：这种模块`把几种逻辑相关的功能组合在一起`，每次被调用时，由传送给模块的参数来确定该模块应完成哪一种功能。
> 3. 时间内聚/瞬时内聚：把需要`同时执行`的动作组合在一起形成的模块称为时间内聚模块。
> 4. 过程内聚：如果一个模块内的`处理元素是相关`的，而且必须`以特定次序执行`则称为过程内聚。
> 5. 通信内聚：指模块内所有处理元素都在同一个数据结构上操作或所有处理功能都通过公用数据而发生关联（有时称之为信息内聚）。即指模块内各个组成部分都`使用相同的数据数据或产生相同的数据结构`。
> 6. 顺序内聚：同一个模块中`各个处理元素和同一个功能密切相关，而且这些处理必须顺序执行`。
> 7. 功能内聚：模块内所有元素的各个组成部分全部都`为完成同一个功能而存在`，共同完成一个单一的功能，模块已不可再分。即模块仅包括为完成某个功能所必须的所有成分，这些成分紧密联系、缺一不可。(高内聚)
>    + 功能内聚是最强的内聚，其优点是它的功能明确。判断一个模块是否功能内聚，一般从模块名称就能看出。如果模块名称只有一个动词和一个特定的目标（单数名词），一般来说就是功能内聚，如：“计算水费”、“计算产值”等模块。功能内聚一般出现在软件结构图的较低层次上。
>
> 总结：在模块划分时，要遵循“一个模块，一个功能”的原则，尽可能使模块达到功能内聚。

高内聚，低耦合的系统有什么好处呢？事实上，短期来看，并没有很明显的好处，甚至短期内会影响系统的开发进度，因为高内聚，低耦合的系统对开发设计人员提出了更高的要求。高内聚，低耦合的好处体现在系统持续发展的过程中，高内聚，低耦合的系统具有更好的重用性，维护性，扩展性，可以更高效的完成系统的维护开发，持续的支持业务的发展，而不会成为业务发展的障碍。

模块之间低耦合, 模块之内高内聚。

<br/>

> Java中实现高内聚低耦合的常用方式：
>
> + 少使用类的继承，多用接口隐藏实现的细节。
> + 模块的功能化分尽可能的单一，道理也很简单，功能单一的模块供其它模块调用的机会就少。
> + 遵循一个定义只在一个地方出现。
> + 少使用全局变量。
> + 类属性和方法的声明少用public，多用private关键字，
> + 多用设计模式，比如采用MVC的设计模式就可以降低界面与业务逻辑的耦合度。
> + 尽量不用“硬编码”的方式写程序。
> + 最后当然就是避免直接操作或调用其它模块或类（内容耦合）。

二. `多聚合、少继承`

 + 聚合：事物A由若干个事物B组成。也就是“类B的实例”作为“类A”的成员对象出现。

```
@Autowired
private TestClass tClass;
```

 + 继承：顾名思义，体现在类与类之间的关系就是：“类B”被类A所继承
   当观察类B所具有的行为能力时，“聚合”方式更加清晰。java适配器模式中，优选“对象适配器”，而不是“类适配器”

## 1.2 通用设计原则

1. KISS  
   所谓KISS原则，即：Keep It Simple,Stupid，指设计时要坚持`简约`原则，避免不必要的复杂化，并且易于修改。
2. DRY  
   所谓DRY原则，即：Don't Repeat Yourself，`不重复`。重复代码是软件程序变烂的万恶之首。
3. Maximize Cohesion， Minimize Coupling  
   即：`高内聚低耦合`。这是判断设计好坏的标准，主要是看模块内的内聚性是否高，模块间的耦合度是否低。
4. SOC  
   所谓SOC原则，即：关注点分离（Separation of Concerns）。不同领域的功能，应该由不同的代码和最小重迭的模块组成。
5. YAGNI  
   所谓YAGNI原则，即：You Ain’t Gonna Need It，你不需要它。它是一种极限编程（XP）实践，表示程序员不应为目前还不需要的功能编写代码。
6. Boy-Scout Rule  
   Boy-Scout Rule，译为：童子军规则。童子军规则告诉我们在对现有代码库进行更改时，代码质量往往会降低，从而积累技术债务。所以需要始终保持代码整洁。不管原作者是谁，如果我们努力去改进代码模块，不管是多么小的改进，我们的软件系统就再也不会持续变坏了。
   </br>

具体详见参考链接: [软件程序设计原则](https://blinkfox.github.io/2018/11/24/ruan-jian-she-ji/ruan-jian-cheng-xu-she-ji-yuan-ze/), 大佬文章写得真的很有味道


# 第二章 面向对象的 7 大设计原则

[参考链接](http://c.biancheng.net/view/1322.html): http://c.biancheng.net/view/1322.html

## 开闭原则（Open Closed Principle，OCP）

1. 定义  
   软件实体应当对扩展开放，对修改关闭（Software entities should be open for extension，but closed for modification）。
2. 含义  
   当应用的需求改变时，在不修改软件实体的源代码或者二进制代码的前提下，可以扩展模块的功能，使其满足新的需求。这里的软件实体包括以下几个部分：  
   + 项目中划分出的模块  
   + 类与接口  
   + 方法  

3. 作用  
   使软件实体拥有一定的适应性和灵活性的同时具备稳定性和延续性, 具体表现如下:
+ 软件遵守开闭原则的话，软件测试时只需要对扩展的代码进行测试就可以了，因为原有的测试代码仍然能够正常运行。
+ 可以提高代码的可复用性。粒度越小，被复用的可能性就越大；在面向对象的程序设计中，根据原子和抽象编程可以提高代码的可复用性。
+ 可以提高软件的可维护性。遵守开闭原则的软件，其稳定性高和延续性强，从而易于扩展和维护。

4. 实现方法  
   可以通过“抽象约束、封装变化”来实现开闭原则，即通过接口或者抽象类为软件实体定义一个相对稳定的抽象层，而将相同的可变因素封装在相同的具体实现类中。  
   因为抽象灵活性好，适应性广，只要抽象的合理，可以基本保持软件架构的稳定。而软件中易变的细节可以从抽象派生来的实现类来进行扩展，当软件需要发生变化时，只需要根据需求重新派生一个实现类来扩展就可以了。
5. 总结  
   在不修改软件实体的源代码或者二进制代码的前提下，可以扩展模块的功能，使其满足新的需求。具体通过**里氏替换原则**和**依赖倒置原则**实现。

## 里氏替换原则（Liskov Substitution Principle，LSP）

1. 定义  
   继承必须确保超类所拥有的性质在子类中仍然成立（Inheritance should ensure that any property proved about supertype objects also holds for subtype objects）
2. 含义  
   里氏替换原则主要阐述了有关继承的一些原则，也就是什么时候应该使用继承，什么时候不应该使用继承，以及其中蕴含的原理。  
   里氏替换原是继承复用的基础，它反映了基类与子类之间的关系，是对开闭原则的补充，是对实现抽象化的具体步骤的规范。
3. 作用  
   + 里氏替换原则是实现开闭原则的重要方式之一。
   + 它克服了继承中重写父类造成的可复用性变差的缺点。
   + 它是动作正确性的保证。即类的扩展不会给已有的系统引入新的错误，降低了代码出错的可能性。
   + 加强程序的健壮性，同时变更时可以做到非常好的兼容性，提高程序的维护性、可扩展性，降低需求变更时引入的风险。
4. 实现方法  
   里氏替换原则通俗来讲就是：****子类可以扩展父类的功能，但不能改变父类原有的功能。也就是说：子类继承父类时，除添加新的方法完成新增功能外，尽量不要重写父类的方法。****   
   通过重写父类的方法来完成新的功能写起来虽然简单，但是整个继承体系的可复用性会比较差，特别是运用多态比较频繁时，程序运行出错的概率会非常大。 如果程序违背了里氏替换原则，则继承类的对象在基类出现的地方会出现运行错误。  
   <br/>
   根据上述理解，对里氏替换原则的定义可以总结如下：
   + 子类可以实现父类的抽象方法，但不能覆盖父类的非抽象方法
   + 子类中可以增加自己特有的方法
   + 当子类的方法重载父类的方法时，方法的前置条件（即方法的输入参数）要比父类的方法更宽松
   + 当子类的方法实现父类的方法时（重写/重载或实现抽象方法），方法的后置条件（即方法的的输出/返回值）要比父类的方法更严格或相等

> 关于里氏替换原则的例子，最有名的是“正方形不是长方形”。当然，生活中也有很多类似的例子，例如，企鹅、鸵鸟和几维鸟从生物学的角度来划分，它们属于鸟类；但从类的继承关系来看，由于它们不能继承“鸟”会飞的功能，所以它们不能定义成“鸟”的子类。同样，由于“气球鱼”不会游泳，所以不能定义成“鱼”的子类；“玩具炮”炸不了敌人，所以不能定义成“炮”的子类等。

5. 总结  
   子类继承父类时，除添加新的方法完成新增功能外，尽量不要重写父类的方法。

## 合成复用原则（Composite Reuse Principle，CRP）

1. 定义  
   要求在软件复用时，要尽量先使用组合或者聚合等关联关系来实现，其次才考虑使用继承关系来实现。如果要使用继承关系，则必须严格遵循里氏替换原则。合成复用原则同里氏替换原则相辅相成的，两者都是开闭原则的具体实现规范。

2. 作用  
   通常类的复用分为<u>继承复用和合成复用</u>两种。
   继承复用虽然有简单和易实现的优点，但它也存在以下缺点:

   + 继承复用破坏了类的封装性。因为继承会将父类的实现细节暴露给子类，父类对子类是透明的，所以这种复用又称为“白箱”复用。
   + 子类与父类的耦合度高。父类的实现的任何改变都会导致子类的实现发生变化，这不利于类的扩展与维护。
   + 它限制了复用的灵活性。从父类继承而来的实现是静态的，在编译时已经定义，所以在运行时不可能发生变化。

    采用组合或聚合复用时(即**合成复用原则**)，可以将已有对象纳入新对象中，使之成为新对象的一部分，新对象可以调用已有对象的功能，它有以下优点:

   + 它维持了类的封装性。因为成分对象的内部细节是新对象看不见的，所以这种复用又称为“黑箱”复用。
   + 新旧类之间的耦合度低。这种复用所需的依赖较少，新对象存取成分对象的唯一方法是通过成分对象的接口。
   + 复用的灵活性高。这种复用可以在运行时动态进行，新对象可以动态地引用与成分对象类型相同的对象。

> 聚合(Aggregation): 关联的一种特殊形态, class2 is part of class1, but has different lifetime.  
> 组合(composition): 聚合的一种特殊形态, Objects of Class2 live and die with Class1 & Class2 cannot stand by itself.

3. 实现方法  
   合成复用原则是通过将已有的对象纳入新对象中，作为新对象的成员对象来实现的，新对象可以调用已有对象的功能，从而达到复用。

## 依赖倒置原则（Dependence Inversion Principle，DIP）

1. 定义  
   高层模块不应该依赖低层模块，两者都应该依赖其抽象；抽象不应该依赖细节，细节应该依赖抽象（High level modules shouldnot depend upon low level modules.Both should depend upon abstractions.Abstractions should not depend upon details. Details should depend upon abstractions）。其核心思想是：要****面向接口编程，不要面向实现编程。****
2. 含义  
   由于在软件设计中，细节具有多变性，而抽象层则相对稳定，因此以抽象为基础搭建起来的架构要比以细节为基础搭建起来的架构要稳定得多。这里的抽象指的是接口或者抽象类，而细节是指具体的实现类。
3. 作用  
   + 依赖倒置原则是实现开闭原则的重要途径之一，它降低了客户与实现模块之间的耦合。
   + 依赖倒置原则可以降低类间的耦合性。
   + 依赖倒置原则可以提高系统的稳定性。
   + 依赖倒置原则可以减少并行开发引起的风险。
   + 依赖倒置原则可以提高代码的可读性和可维护性。
4. 实现方法  
   依赖倒置原则的目的是通过要面向接口的编程来降低类间的耦合性，所以我们在实际编程中只要遵循以下4点，就能在项目中满足这个规则。
   + 每个类尽量提供接口或抽象类，或者两者都具备。
   + 变量的声明类型尽量是接口或者是抽象类。
   + 任何类都不应该从具体类派生。
   + 使用继承时尽量遵循里氏替换原则。
5. 总结  
   面向抽象(接口)编程, 而不是面向实现编程。

## 单一职责原则（Single Responsibility Principle，SRP）

1. 定义  
   单一职责原则规定一个类应该有且仅有一个引起它变化的原因，否则类应该被拆分（There should never be more than one reason for a class to change）。  
   这里的职责是指类变化的原因, 简单来说, 就是一个类应该只负责实现一个特定的功能。
2. 含义  
   该原则提出对象不应该承担太多职责，如果一个对象承担了太多的职责，至少存在以下两个缺点：
   + 一个职责的变化可能会削弱或者抑制这个类实现其他职责的能力；
   + 当客户端需要该对象的某一个职责时，不得不将其他不需要的职责全都包含进来，从而造成冗余代码或代码的浪费。
3. 作用  
   ****单一职责原则的核心就是控制类的粒度大小、将对象解耦、提高其内聚性。**** 如果遵循单一职责原则将有以下优点。
   + 降低类的复杂度。一个类只负责一项职责，其逻辑肯定要比负责多项职责简单得多。
   + 提高类的可读性。复杂性降低，自然其可读性会提高。
   + 提高系统的可维护性。可读性提高，那自然更容易维护了。
   + 变更引起的风险降低。变更是必然的，如果单一职责原则遵守得好，当修改一个功能时，可以显著降低对其他功能的影响。
4. 实现方法  
   单一职责原则是最简单但又最难运用的原则，需要设计人员发现类的不同职责并将其分离，再封装到不同的类或模块中。而发现类的多重职责需要设计人员具有较强的分析设计能力和相关重构经验。
5. 总结  
   就是一个类应该只负责实现一个特定的功能。
   

## 接口隔离原则（Interface Segregation Principle，ISP）

1. 定义  
   客户端不应该被迫依赖于它不使用的方法（Clients should not be forced to depend on methods they do not use）。该原则还有另外一个定义：一个类对另一个类的依赖应该建立在最小的接口上（The dependency of one class to another one should depend on the smallest possible interface）。
2. 含义  
   ****要为各个类建立它们需要的专用接口，而不要试图去建立一个很庞大的接口供所有依赖它的类去调用。****  
   接口隔离原则和单一职责都是为了提高类的内聚性、降低它们之间的耦合性，体现了封装的思想，但两者是不同的：
   + 单一职责原则注重的是职责，而接口隔离原则注重的是对接口依赖的隔离。
   + 单一职责原则主要是约束类，它针对的是程序中的实现和细节；接口隔离原则主要约束接口，主要针对抽象和程序整体框架的构建。
3. 作用  
   接口隔离原则是为了约束接口、降低类对接口的依赖性，遵循接口隔离原则有以下优点:
   + 将臃肿庞大的接口分解为多个粒度小的接口，可以预防外来变更的扩散，提高系统的灵活性和可维护性。
   + 接口隔离提高了系统的内聚性，减少了对外交互，降低了系统的耦合性。
   + 如果接口的粒度大小定义合理，能够保证系统的稳定性；但是，如果定义过小，则会造成接口数量过多，使设计复杂化；如果定义太大，灵活性降低，无法提供定制服务，给整体项目带来无法预料的风险。
   + 使用多个专门的接口还能够体现对象的层次，因为可以通过接口的继承，实现对总接口的定义。
   + 能减少项目工程中的代码冗余。过大的大接口里面通常放置许多不用的方法，当实现这个接口的时候，被迫设计冗余的代码。
4. 实现方法  
   在具体应用接口隔离原则时，应该根据以下几个规则来衡量: 
   + 接口尽量小，但是要有限度。一个接口只服务于一个子模块或业务逻辑。
   + 为依赖接口的类定制服务。只提供调用者需要的方法，屏蔽不需要的方法。
   + 了解环境，拒绝盲从。每个项目或产品都有选定的环境因素，环境不同，接口拆分的标准就不同深入了解业务逻辑。
   + 提高内聚，减少对外交互。使接口用最少的方法去完成最多的事情。
5. 总结  
   每个类应该是实现自己的功能接口即可， 而不能将所有的接口放在一起


## 迪米特法则（Law of Demeter，LoD）

1. 定义  
   只与你的直接朋友交谈，不跟“陌生人”说话（Talk only to your immediate friends and not to strangers）。   
   迪米特法则中的“朋友”是指：当前对象本身、当前对象的成员对象、当前对象所创建的对象、当前对象的方法参数等，这些对象同当前对象存在关联、聚合或组合关系，可以直接访问这些对象的方法。  

2. 含义  
   ****如果两个软件实体无须直接通信，那么就不应当发生直接的相互调用，可以通过第三方转发该调用。**** 其目的是降低类之间的耦合度，提高模块的相对独立性。

3. 作用  
   迪米特法则要求限制软件实体之间通信的宽度和深度，正确使用迪米特法则将有以下两个优点。

   + 降低了类之间的耦合度，提高了模块的相对独立性。
   + 由于亲合度降低，从而提高了类的可复用率和系统的扩展性。

    但是，过度使用迪米特法则会使系统产生大量的中介类，从而增加系统的复杂性，使模块之间的通信效率降低。所以，在釆用迪米特法则时需要反复权衡，确保高内聚和低耦合的同时，保证系统的结构清晰。

4. 实现方法  
   从迪米特法则的定义和特点可知，它强调以下两点：

   + 从依赖者的角度来说，只依赖应该依赖的对象。
   + 从被依赖者的角度说，只暴露应该暴露的方法。

    所以，在运用迪米特法则时要注意以下几点: 

   + 在类的划分上，应该创建弱耦合的类。类与类之间的耦合越弱，就越有利于实现可复用的目标。
   + 在类的结构设计上，尽量降低类成员的访问权限。
   + 在类的设计上，优先考虑将一个类设置成不变类。
   + 在对其他类的引用上，将引用其他对象的次数降到最低。
   + 不暴露类的属性成员，而应该提供相应的访问器（set 和 get 方法）。
   + 谨慎使用序列化（Serializable）功能。

5. 总结  
   如果两个软件实体无须直接通信，那么就不应当发生直接的相互调用，可以通过第三方转发该调用。