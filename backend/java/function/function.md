# 函数式编程

https://xie.infoq.cn/article/dd1f3d433d84b0ad223e24560



# 用代码来举例


## Lambda 实现

Lambda 表达式是使用**最小可能**语法编写的函数定义：（原则）



1. Lambda 表达式产生函数，而不是类
2. Lambda 语法尽可能少，这正是为了使 Lambda 易于编写和使用



``` java
interface Description {
    String brief();
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

方法引用由类名或者对象名，后面跟着 `::`  然后跟方法名称，先定义一个接口, 符合该接口的实现都可以利用方法引用实现
```java

interface Callable { // [1] 单一方法的接口（重要）
    void call(String s);
}

class Describe {
    void show(String msg) { // [2] 符合 Callable 接口的 call() 方法实现
        System.out.println(msg);
    }
}

public class MethodReferences {
    static void hello(String name) { // [3] 也符合 call() 方法实现
        System.out.println("Hello, " + name);
    }

    static class Description {
        String about;

        Description(String desc) {
            about = desc;
        }

        void help(String msg) { // [4] 静态类的非静态方法
            System.out.println(about + " " + msg);
        }
    }

    static class Helper {
        static void assist(String msg) { // [5] 静态类的静态方法，符合 call() 方法
            System.out.println(msg);
        }
    }

    public static void main(String[] args) {
        Describe d = new Describe();
        Callable c = d::show; // [6] 通过方法引用创建 Callable 的接口实现
        c.call("call()"); // [7] 通过该实例 call() 方法调用 show() 方法

        c = MethodReferences::hello; // [8] 静态方法的方法引用
        c.call("Bob");

        c = new Description("valuable")::help; // [9] 实例化对象的方法引用
        c.call("information");

        c = Helper::assist; // [10] 静态方法的方法引用
        c.call("Help!");
    }
}

```

## Runnable 接口实现

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
                System.out.println("Anonymous");
            }
        }).start();

        new Thread(
                () -> System.out.println("lambda")
        ).start();

        new Thread(Go::go).start();    // 通过 方法引用创建 Runnable 实现的引用
    }
}
```

## 未绑定的方法引用
使用未绑定的引用时，需要先提供对象：

``` java

interface MakeString {
    String make();
}

interface TransformX {
    String transform(X x);
}

class X {
    String f() {
        return "X::f()";
    }
    
    String t() {
        return "X::t()";
    }
}

class SX extends X {
    
}

class S {
    String s() {
        return "s";
    }
}

public class UnboundMethodReference {

    public static void main(String[] args) {
        // MakeString sp = X::f;       // [1] 你不能在没有 X 对象参数的前提下调用 f()，因为它是 X 的方法
        TransformX sp = X::f;       // [2] 你可以首个参数是 X 对象参数的前提下调用 f()，使用未绑定的引用，函数式的方法不再与方法引用的签名完全相同
        X x = new X();
        System.out.println(sp.transform(x));      // [3] 传入 x 对象，调用 x.f() 方法
        System.out.println(x.f());      // 同等效果

        TransformX spx = X::t;
//        TransformX spx = SX::t;  // 报错, 继承不支持
//        TransformX spx = S::s;   // 报错, 其他方法不支持

        SX sx = new SX();
        S s = new S();
        System.out.println(sp.transform(x));      // [3] 传入 x 对象，调用 x.f() 方法
        System.out.println(sp.transform(sx));      // 支持
//        System.out.println(sp.transform(s));      // 报错, 类型错误
        
    }
}
```

我们通过更多示例来证明，通过未绑的方法引用和 interface 之间建立关联：

```java
package function.unbound_method;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/27
 */
// 未绑定的方法与多参数的结合运用


interface TwoArgs {
    void call2(TestClass athis, int i, double d);
}

interface ThreeArgs {
    void call3(TestClass athis, int i, double d, String s);
}

interface FourArgs {
    void call4(TestClass athis, int i, double d, String s, char c);
}
    
class TestClass {
    void two(int i, double d) {
        System.out.println("two");
    }

    void three(int i, double d, String s) {
        System.out.println("three");
    }

    void four(int i, double d, String s, char c) {
        System.out.println("four");
    }
}

public class UnboundMulti {

    public static void main(String[] args) {
        TwoArgs twoargs = TestClass::two;
        ThreeArgs threeargs = TestClass::three;
        FourArgs fourargs = TestClass::four;
        TestClass athis = new TestClass();
        twoargs.call2(athis, 11, 3.14);
        threeargs.call3(athis, 11, 3.14, "Three");
        fourargs.call4(athis, 11, 3.14, "Four", 'Z');
    }
}

```

## 总结

+ 方法引用在很大程度上可以理解为创建一个函数式接口的实例
+ 方法引用实际上是一种简化 Lambda 表达式的语法糖，它提供了一种更简洁的方式来创建一个函数式接口的实现
+ 在代码中使用方法引用时，实际上是在创建一个匿名实现类，引用方法实现并且覆盖了接口的抽象方法
+ 方法引用大多用于创建函数式接口的实现



# 函数式接口

以上是自己创建 函数式接口的示例。在 `java.util.function` 包旨在创建一组完整的预定义接口，使得我们一般情况下不需再定义自己的接口。

在 `java.util.function` 的函数式接口的基本使用基本准测，如下

1. 只处理对象而非基本类型，名称则为 Function，Consumer，Predicate 等，参数通过泛型添加
2. 如果接收的参数是基本类型，则由名称的第一部分表示，如 LongConsumer， DoubleFunction，IntPredicate 等
3. 如果返回值为基本类型，则用 To 表示，如 ToLongFunction  和 IntToLongFunction
4. 如果返回值类型与参数类型一致，则是一个运算符
5. 如果接收两个参数且返回值为布尔值，则是一个谓词（Predicate）
6. 如果接收的两个参数类型不同，则名称中有一个 Bi



### 基本类型



```java
package function.function_base;

import java.util.function.*;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/27
 */
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



### 非基本类型

在使用函数接口时，名称无关紧要——只要参数类型和返回类型相同。Java 会将你的方法映射到接口方法。
