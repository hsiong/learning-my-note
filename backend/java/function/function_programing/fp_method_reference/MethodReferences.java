package function_programing.fp_method_reference;

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

public class MethodReferences {
    static void hello(String name) { // [3] 也符合 call() 方法实现
        System.out.println("Hello, " + name);
    }
    
    static class Describe {
        void show(String msg) { // [2] 符合 Callable 接口的 call() 方法实现
            System.out.println(msg);
        }
    }

    static class Helper {
        static void assist(String msg) { // [5] 静态类的静态方法，符合 call() 方法
            System.out.println(msg);
        }
    }

    public static void main(String[] args) {
        
        Callable c = MethodReferences::hello; // [6] 通过方法引用创建 Callable 的接口实现
        c.call("call()"); // [7] 通过该实例 call() 方法调用 show() 方法

        c = Helper::assist; // [10] 静态方法的方法引用
        c.call("Help!");

        c = new Describe()::show; // [8] 静态方法的方法引用
        c.call("Bob");
    }

}
