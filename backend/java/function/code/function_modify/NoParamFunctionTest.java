package function.function_modify;

import org.junit.Test;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/30
 */
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
