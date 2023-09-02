package function_programing.other;

import java.util.function.Function;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/8/29
 */
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
