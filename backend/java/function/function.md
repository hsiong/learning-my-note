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

详见 function/BaseFunctionTest



### 非基本类型

在使用函数接口时，名称无关紧要——只要参数类型和返回类型相同。Java 会将你的方法映射到接口方法。

详见 function/ObjectFunctionTest



### 多参数函数式接口

java.util.functional 中的接口是有限的，如果需要无参数或者多个参数函数的接口怎么办？自己创建就可以了

详见 function_modify



### 高阶函数

高阶函数（Higher-order Function）其实很好理解，并且在函数式编程中非常常见，它有以下特点：



1. 接收一个或多个函数作为参数
2. 返回一个函数作为结果
