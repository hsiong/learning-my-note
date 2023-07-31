package function.function;

import java.util.function.BiConsumer;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/27
 */
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
