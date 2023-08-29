# 函数式编程

https://xie.infoq.cn/article/dd1f3d433d84b0ad223e24560

急需一种 **语法优雅，简洁健壮，高并发，易于测试和调试** 的编程方式，这一切恰恰就是 **函数式编程（FP）** 的意义所在。

> OO（object oriented，面向对象）是抽象数据，FP（functional programming，函数式编程）是抽象行为。

注意: 千万注意: 开始读下面一切之前, 请牢记一句话, 实现的是接口, 调用的是方法

## 一个简单的对比如下

```java
interface Strategy {
    String approach(String msg);
}

class Soft implements Strategy {
    public String approach(String msg) {
        return msg.toLowerCase() + "?";
    }
}

class Unrelated {
    static String twice(String msg) {
        return msg + " " + msg;
    }
}

public class Strategize {

    Strategy strategy;
    String msg;
    Strategize(String msg) {
        strategy = new Soft(); // [1] 构建默认的 Soft
        this.msg = msg;
    }

    void communicate() {
        // strategy.approach(msg) 实际执行了 实例化的子类.approach() 方法
        System.out.println(strategy.approach(msg));
    }

    void changeStrategy(Strategy strategy) {
        this.strategy = strategy;
    }

    public static void main(String[] args) {
        Strategy[] strategies = {
                new Strategy() { // [2] Java 8 以前的匿名内部类, 实现 Strategy 接口 & approach 方法
                    public String approach(String msg) {
                        return msg.toUpperCase() + "!";
                    }
                },
                msg -> msg.substring(0, 5), // [3] 基于 Ldmbda 表达式，实例化 interface, 入参与出参一致
                Unrelated::twice // [4] 基于 方法引用，实例化 interface, 入参与出参一致, 即可实例化
        };
        Strategize s = new Strategize("Hello there");
        s.communicate();
        for(Strategy newStrategy : strategies) {
            s.changeStrategy(newStrategy); // [5] 使用默认的 Soft 策略
            s.communicate(); // [6] 每次调用 communicate() 都会产生不同的行为
        }
    }
}
```

我们在这个demo中演示了以下几种FP的实现方式

+ 基于匿名内部类, 实现 Strategy 接口 & approach 方法
+ 基于 Ldmbda 表达式，实例化 interface, 入参与出参一致
+ 基于 方法引用，实例化 interface, 入参与出参一致, 即可实例化
+ 基于构造函数, 实例化 interface

下面, 我们将详述这些FP的各类实现


## Lambda 实现

Lambda 的使用条件如下: 

+ 入参与出参与接口定义的方法一致
+ 接口仅定义了一个方法

> + 如果接口定义了多个方法, 例如 Description.brief() & Description.brief2(), 再使用lambda来定义函数, 则会报以下异常`Multiple non-overriding abstract methods found in interface function.function.Description`
>
> + Lambda 表达式是使用最小可能语法编写的函数定义（原则）：
>
> + Lambda 表达式产生函数，而不是类
> + Lambda 语法尽可能少，这正是为了使 Lambda 易于编写和使用
> + Lambda 表达式通常比匿名内部类产生更易读的代码，因此我们将尽可能使用它们。

``` java
interface Description {
    String brief();
  //    String brief2();
}

interface Body {
    String detailed(String head);
}

interface Multi {
    String twoArg(String head, Double d);
}

public class LambdaExpressions {

    static Body bod = h -> h + " No Parens!"; // [1] 一个参数时，可以不需要扩展 ()， 但这是一个特例
    static Body bod2 = (h) -> h + " More details"; // [2] 正常情况下的使用方式
    static Description desc = () -> "Short info"; // [3] 没有参数的情况下的使用方式
    static Multi mult = (h, n) -> h + n; // [4] 多参数情况下的使用方式

    static Description moreLines = () -> { 
        // [5] 多行代码情况下使用 `{}` + `return` 关键字
        // （在单行的 Lambda 表达式中 `return` 是非法的）
        System.out.println("moreLines()");
        return "from moreLines()";
    };

    public static void main(String[] args) {
        System.out.println(bod.detailed("Oh!"));
        System.out.println(bod2.detailed("Hi!"));
        System.out.println(desc.brief());
        System.out.println(mult.twoArg("Pi! ", 3.14159));
        System.out.println(moreLines.brief());
    }
}
```



## 方法引用实现

方法引用由类名或者对象名，后面跟着 `::` 然后跟方法名称，使用条件与 lambda 一致:

+ 入参与出参与接口定义的方法一致
+ 接口仅定义了一个方法

```java

interface Callable { // [1] 单一方法的接口（重要）
    void call(String s);
}

public class MethodReferences {
    static void hello(String name) { // [3] 也符合 call() 方法实现
        System.out.println("Hello, " + name);
    }
  
    static class Helper {
        static void assist(String msg) { // [5] 静态类的静态方法，符合 call() 方法
            System.out.println(msg);
        }
    }
    
    static class Describe {
        void show(String msg) { // [2] 符合 Callable 接口的 call() 方法实现
            System.out.println(msg);
        }
    }

    public static void main(String[] args) {
			  Callable c = MethodReferences::hello; // [6] 通过方法引用创建 Callable 的接口实现
        c.call("call()"); // [7] 通过该实例 call() 方法调用 show() 方法
      
        c = Helper::assist; // [10] 静态方法的方法引用
        c.call("Help!");

        Describe d = new Describe();
        c = d::show; // [8] 非静态方法的方法引用
        c.call("Bob");
      
    }

}


```

我们在这个demo中演示了以下几种通过方法引用实现的FP

+ 类的静态方法	MethodReferences::hello
+ 静态类的静态方法  Helper::assist
+ 静态类的非静态方法  *new* Describe()::show

## Runnable 接口实现

Runnable 接口本身满足我们上述的重要条件

+ 接口仅定义了一个方法

所以, 只要我们定义了入参为空且返回值为 void 的函数, 即可基于 Runnable 接口实现 FP

```java
class Go {
    static void go() {
        System.out.println("Go::go()");
    }
}

public class RunnableMethodReference {

    public static void main(String[] args) {

        new Thread(new Runnable() {
            public void run() { 
                System.out.println("Anonymous"); // 匿名内部类
            }
        }).start();

        new Thread(
                () -> System.out.println("lambda") // lambda 方法
        ).start();

        new Thread(Go::go).start();    // 通过 方法引用创建 Runnable 实现的引用
    }
}
```

这里是三种 Runnable 接口的具体实现

+ 匿名内部类
+ lambda 方法
+ 方法引用

## 未绑定的方法引用

使用未绑定的引用实现接口，函数式的方法不再与方法引用的签名完全相同, 使用未绑定的引用时，有以下几个条件

+ 接口仅定义了一个方法
+ 实现类需要先提供对象
+ 实现类指定的方法为非静态方法
+ 接口方法的返回值, 与实现类指定方法的返回值一致
+ 不支持继承类/其他类
+ 多参数情况下, 实现类的指定方法的入参要与接口类中定义的方法入参排除掉实现类后一致, 详见代码例子中的 `TransformXS transformXS = X::fs; // 多参数`

``` java
interface MakeString {
    String make();
}

interface TransformX {
    String transform(UnboundMethodReference.X x);
}

interface TransformS {
    String transform(UnboundMethodReference.S x);
}

interface TransformSDouble {
    String transform(UnboundMethodReference.X x, String s);
}

interface TransformSTrible {
    String transform(UnboundMethodReference.X x, UnboundMethodReference.S s, String s3);
}

interface TransformInterface {
    String transform(TransformInterfaceX x, TransformInterfaceY s, String s3);
}

interface TransformInterfaceX {
    String transform(TransformInterfaceY s, String s3);
}

interface TransformInterfaceY {
    String transform(String s3);
}


public class UnboundMethodReference {

    public static void main(String[] args) {

        /**
         * 首个参数是 X 对象参数的前提下调用 f()，使用未绑定的引用，函数式的方法不再与方法引用的签名完全相同
         */
        TransformX transformX = X::f;
        transformX = X::f1; // 可以非常灵活的各类实现
        /* TransformX transformX2 = X::staticT; */ // 报错, 不支持静态类
        TransformS transformS = S::s;
        /* TransformX spx = XExtend::f; */  // 报错, 继承不支持
        /* TransformX spx = S::s; */   // 报错, 其他类不支持

        // 单参数调用
        X x = new X();
        System.out.println(transformX.transform(x));      // [3] 传入 x 对象，调用 x.f() 方法
        System.out.println(x.f());      // 同等效果

        /**
         * 多参数
         */
        TransformSDouble transformSDouble = X::fDouble; // 多参数
        transformSDouble.transform(new X(), "");
        /* TransformSDouble transformXS2 = X::f; */// 报错, 多参数剩余入参不足不支持
        TransformSTrible transformSTrible = X::fTrible;
        // 接口-多参数
        TransformInterface transformInterface = TransformInterfaceX::transform;
        TransformInterfaceX transformInterfaceX = TransformInterfaceY::transform;
        TransformInterfaceY transformInterfaceY = i -> i;
        System.err.println(transformInterface.transform(transformInterfaceX, transformInterfaceY, "1234"));
        
        XExtend XExtend = new XExtend();
        S s = new S();
        System.out.println(transformX.transform(x));      // [3] 传入 x 对象，调用 x.f() 方法
        System.out.println(transformX.transform(XExtend));      // 支持继承
        /* System.out.println(transformX.transform(s)); */      // 报错, 类型错误

    }

    static class X {
        String f() {
            return "X::f()";
        }

        String f1() {
            return "X::f1()";
        }

        String fDouble(String s) {
            return this + "fDouble";
        }

        String fTrible(S s, String s3) {
            return "ft";
        }

        static String staticT() {
            return "X::t()";
        }
    }

    static class XExtend extends X {

    }

    static class S {
        String s() {
            return "s";
        }
    }
}
```

在以上 demo 中, 未绑定的方法引用有以下几种实现方式

+ 首个参数是某对象参数的前提下, 调用实例化对象的非静态方法实例化接口，
+ 多参数接口接口实例化实现
+ 以及在未绑定的方法引用中, 如何通过接口来实例化接口

### 在未绑定的方法引用中, 如何通过接口来实例化接口

由于本段代码较难, 重点讲一下如何实现的, 这里我们将使用等效的效果来进行解析, 这样方便您理解

```java
interface TransformInterface {
    String transform(TransformInterfaceX x, TransformInterfaceY s, String s3);
}

interface TransformInterfaceX {
    String transform(TransformInterfaceY s, String s3);
}

interface TransformInterfaceY {
    String transform(String s3);
}
public class UnboundMethodReference {
    public static void main(String[] args) {
        TransformInterface transformInterface = TransformInterfaceX::transform;
        TransformInterfaceX transformInterfaceX = TransformInterfaceY::transform;
        TransformInterfaceY transformInterfaceY = i -> i;
        System.err.println(transformInterface.transform(transformInterfaceX, transformInterfaceY, "1234"));
    }  
}
```

在未绑定的方法引用这一章中, 您应该已经理解了

```java
    TransformX transformX = X::f;        
    System.out.println(transformX.transform(x));      // [3] 传入 x 对象，调用 x.f() 方法
    System.out.println(x.f());      // 同等效果
```

这两个实现是同等效果, 那么我们就可以把上面的代码做以下等效

```java
    TransformInterface transformInterface = TransformInterfaceX::transform;
    TransformInterfaceX transformInterfaceX = TransformInterfaceY::transform;
    TransformInterfaceY transformInterfaceY = i -> i;
    String test = "1234";
    transformInterface.transform(transformInterfaceX, transformInterfaceY, test); // 1
    transformInterfaceX.transform(transformInterfaceY, test); // 2
    transformInterfaceY.transform(test); // 3
```

1 等效 2 等效 3, 由于我们定义了 TransformInterfaceY transformInterfaceY = i -> i, 所以最后执行的 3 也就实际上执行了实例化方法 i -> i

## 总结

+ 方法引用在很大程度上可以理解为创建一个函数式接口的实例
+ 方法引用实际上是一种简化 Lambda 表达式的语法糖，它提供了一种更简洁的方式来创建一个函数式接口的实现
+ 在代码中使用方法引用时，实际上是在创建一个匿名实现类，引用方法实现并且覆盖了接口的抽象方法
+ 方法引用大多用于创建函数式接口的实现



# 函数式接口

在 `java.util.function` 包旨在创建一组完整的预定义接口，使得我们一般情况下不需再定义自己的接口。

> 命名规则如下
>
> + 只处理对象而非基本类型，名称则为 Function，Consumer，Predicate 等，参数通过泛型添加, 第一个值为入参, 第二个值为出参
>
> + 入参是基本类型, 出参是非基本类型, 名称的第一部分表示入参, 泛型表示出参类型, 如 LongConsumer<IBaz>， DoubleFunction<LBaz>，
> + 入参是基本类型, 出参是基本类型, 名称的第一部分表示入参, ToXXX 表示出参, 如 IntToLongFunction, LongToDoubleFunction
> + 入参是非基本类型, 出参为基本类型，则用泛型表示入参, To 表示出参，如 ToIntFunction<IBaz>, ToLongFunction<LBaz>
> + 如果返回值为布尔值，则是由 Predicate 表示, 如 Predicate<DBaz>
> + 如果接收的参数有两个，则名称中有一个 Bi, 如 BiPredicate<DBaz, DBaz>,  BiFunction<IBaz, DBaz, Long>

## 基本类型

```java
class Foo {
}

class Bar {
    Foo f;

    Bar(Foo f) {
        this.f = f;
    }
}

class IBaz {
    int i;

    IBaz(int i) {
        this.i = i;
    }
}

class LBaz {
    long l;

    LBaz(long l) {
        this.l = l;
    }
}

class DBaz {
    double d;

    DBaz(double d) {
        this.d = d;
    }
}

public class BaseFunctionTest {
    // 根据不同参数获得对象的函数表达式
    static Function<Foo, Bar> f1 = f -> new Bar(f);
    static IntFunction<IBaz> f2 = i -> new IBaz(i);
    static LongFunction<LBaz> f3 = l -> new LBaz(l);
    static DoubleFunction<DBaz> f4 = d -> new DBaz(d);
    // 根据对象类型参数，获得基本数据类型返回值的函数表达式
    static ToIntFunction<IBaz> f5 = ib -> ib.i;
    static ToLongFunction<LBaz> f6 = lb -> lb.l;
    static ToDoubleFunction<DBaz> f7 = db -> db.d;
    static IntToLongFunction f8 = i -> {
        i++;
        return i + 1;
    };
    static IntToDoubleFunction f9 = i -> i;
    static LongToIntFunction f10 = l -> (int) l;
    static LongToDoubleFunction f11 = l -> l;
    static DoubleToIntFunction f12 = d -> (int) d;
    static DoubleToLongFunction f13 = d -> (long) d;

    public static void main(String[] args) {
        // apply usage examples
        Bar b = f1.apply(new Foo());
        IBaz ib = f2.apply(11);
        LBaz lb = f3.apply(11);
        DBaz db = f4.apply(11);

        // applyAs* usage examples
        int i = f5.applyAsInt(ib);
        long l = f6.applyAsLong(lb);
        double d = f7.applyAsDouble(db);

        // 基本类型的相互转换
        long applyAsLong = f8.applyAsLong(12);
        double applyAsDouble = f9.applyAsDouble(12);
        int applyAsInt = f10.applyAsInt(12);
        double applyAsDouble1 = f11.applyAsDouble(12);
        int applyAsInt1 = f12.applyAsInt(13.0);
        long applyAsLong1 = f13.applyAsLong(13.0);
    }
}
```

## 非基本类型

在使用函数接口时，名称无关紧要——只要参数类型和返回类型相同。Java 会将你的方法映射到接口方法。实际应用时, 与方法引用类似

+ 入参与出参与接口定义的方法一致
+ 接口仅定义了一个方法

```java
public class ObjectFunctionTest {

    static void accept(Integer in1, Boolean in2) {
        System.out.println("accept()");
    }

    static void someOtherName(Integer in1, Boolean in2) {
        System.out.println("someOtherName()");
    }

    public static void main(String[] args) {
        BiConsumer<Integer, Boolean> bic;

        // 类似方法引用
        bic = ObjectFunctionTest::accept;
        bic.accept(1, true);

        // 在使用函数接口时，名称无关紧要——只要参数类型和返回类型相同。Java 会将你的方法映射到接口方法。
        bic = ObjectFunctionTest::someOtherName;
        bic.accept(1, true);
    }

}
```

## 多参数函数式接口

java.util.functional 中的接口是有限的，如果需要无参数或者多个参数函数的接口怎么办？自己创建就可以了; 实际应用时, 与方法引用一致, 所以自己定义一个接口也是可以的

多参 demo: 

```java
@FunctionalInterface
interface MultiParamFunction<T, U, V, R> {

    R apply(T t, U u, V v);
    
}

public class MutiParamFunctionTest {

    static String f(int i, long l, double d) {
        return "ss";
    }

    static void s(int i, long l, double d) {
        System.out.println(d);
    }

    @Test
    public void test() {
        // 方法引用
        MultiParamFunction<Integer, Long, Double, String> tf1 = MutiParamFunctionTest::f;
        System.out.println(tf1.apply(1, 2L, 3d));
        // Lamdba 表达式
        MultiParamFunction<Integer, Long, Double, Integer> tf2 = (i, l, d) -> 12;
        System.out.println(tf2.apply(1, 2L, 3d));
        // 报错
       // MultiParamFunction<Integer, Long, Double, void> tf1 = MutiParamFunctionTest::f;

    }

}
```

无参 demo:

```java
@FunctionalInterface
interface NoParamFunction<T> {

    T apply();


}


public class NoParamFunctionTest {

    static String f() {
        return "f";
    }

    static int s() {
        return 1;
    }

    @Test
    public void test() {
        NoParamFunction<String> tf1 = NoParamFunctionTest::f;
        System.out.println(tf1.apply());

        NoParamFunction<Integer> tf2 = NoParamFunctionTest::s;
        System.out.println(tf2.apply());
    }

}
```



## 高阶函数

高阶函数（Higher-order Function）其实很好理解，并且在函数式编程中非常常见，它有以下特点：

1. 接收一个或多个函数作为参数
2. 返回一个函数作为结果

返回一个函数作为结果在实践中很少使用, 一笔带过; 重点介绍接收一个或多个函数作为参数, 这个思想在 stream 流式操作中大量应用

```java
class One {}
class Two {}

public class ConsumeFunction {
    static Two consume(Function<One, Two> onetwo) {
        return onetwo.apply(new One());
    }

    public static void main(String[] args) {
        Two two = consume(one -> new Two());
    }
}
```

+ stream 流式操作

```java
    @Test
    public void groupByList2() {
        List<MultipleLineBO> stringList = Lists.newArrayList();
        stringList.add(new MultipleLineBO("name1", "2021", "20"));
        stringList.add(new MultipleLineBO("name1", "2022", "20"));
        stringList.add(new MultipleLineBO("name2", "2021", "23"));
        stringList.add(new MultipleLineBO("name2", "2021", "20"));
        // list 流操作只能前向路, 而不能随机
        Map<String, List<MultipleLineBO>> postsPerTypeAndAuthor = stringList.stream()
                                                                            .peek(i -> i.setSort((int) (1000 * (Math.random()))))
                                                                            .sorted(Comparator.comparing(MultipleLineBO::getSort)
                                                                                              .reversed())
                                                                            .collect(Collectors.groupingBy(MultipleLineBO::getName, Collectors.toList()));
        System.out.println(postsPerTypeAndAuthor);
    }

```

+ LambadaWrapper 实现复杂查询

# 其他

## 闭包

在 Java 中，闭包通常与 lambda 表达式和匿名内部类相关。简单来说，闭包允许在一个函数内部访问和操作其外部作用域中的变量。在 Java 中的闭包实际上是一个特殊的对象，它封装了一个函数及其相关的环境。这意味着闭包不仅仅是一个函数，它还携带了一个执行上下文，其中包括外部作用域中的变量。这使得闭包在访问这些变量时可以在不同的执行上下文中保持它们的值。

让我们通过一个例子来理解 Java 中的闭包：

```java
public class ClosureExample {
    public static void main(String[] args) {
        int a = 10;
        int b = 20;

        // 这是一个闭包，因为它捕获了外部作用域中的变量 a 和 b
        IntBinaryOperator closure = (x, y) -> x * a + y * b;

        int result = closure.applyAsInt(3, 4);
        System.out.println("Result: " + result); // 输出 "Result: 110"
    }
}
```

需要注意的是，在 Java 中，闭包捕获的外部变量必须是 `final` 或者是有效的 `final`（即在实际使用过程中保持不变）。这是为了防止在多线程环境中引起不可预测的行为和数据不一致。

## 函数组合

函数组合（Function Composition）意为 “多个函数组合成新函数”。它通常是函数式编程的基本组成部分。

先看 Function 函数组合示例代码：

```java
public class FunctionComposition {

    static Function<String, String> f1 = s -> {
        s = s.replace('A', '_');
        System.out.println("f1 result" + s);
        return s;
    }, f2 = s -> {
        s = s.substring(3);
        System.out.println("f2 result" + s);
        return s;
    }, f3 = s -> s.toLowerCase(),

    // 重点：使用函数组合将多个函数组合在一起
    f4 = f1.compose(f2).andThen(f3);  // compose 是先执行参数中的函数，再执行调用者, andThen 是先执行调用者，再执行参数中的函数

    public static void main(String[] args) {
        
        String test = "AFTER AFTER 111";
        f4 = f1.compose(f2);
        String s = f4.apply(test);
        System.out.println("f4 " + s);

        System.out.println("\n\n");
        
        f4 = f1.andThen(f2);
        s = f4.apply(test);
        System.out.println("f4 " + s);
    }

}
```

Function 自带的函数有三个

+ compose(Function<? *super* V, ? *extends* T> before)

  先执行入参，再执行调用者

+ andThen(Function<? *super* R, ? *extends* V> after)

  先执行调用者，再执行入参

+ apply(T t)

  执行调用者
