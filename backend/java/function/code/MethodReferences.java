/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/25
 */
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
