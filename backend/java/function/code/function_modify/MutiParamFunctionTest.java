package function.function_modify;

import org.junit.Test;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/30
 */
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
