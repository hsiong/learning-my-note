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
