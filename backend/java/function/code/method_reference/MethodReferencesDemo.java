package function.method_reference;

import org.junit.Test;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/27
 */

interface CallableTest { // [1] 单一方法的接口（重要）
    void call();
}

class ReuseTest {
    
    public static void reuse(Integer count, CallableTest callable) {
        for (Integer i = 0; i < count; i++) {
            callable.call();
        }
    }
    
}

class Test1 {

    void test1() {
        System.out.println("test1");
    }
    
}

class Test2 {
    
    static void test2() {
        System.out.println("test2");
    }
    
}

public class MethodReferencesDemo {

    @Test
    public void reuseFunction() {

        Test1 test1 = new Test1();
        CallableTest callable = test1::test1;
        ReuseTest.reuse(2, callable);

        CallableTest callable2 = Test2::test2;
        ReuseTest.reuse(3, callable2);
        
    }

}
