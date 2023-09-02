package function_programing.other;

import java.util.function.BiFunction;
import java.util.function.Function;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/8/30
 */
public class CurryingTest {

    static String uncurried(String a, String b) {
        return a + b;
    }

    public static void main(String[] args) {

        String s1 = "1 ";
        String s2 = "2";
        System.out.println("uncurried(a, b)");
        System.out.println(uncurried(s1, s2));
        System.out.println();
        
        // 柯里化的函数，它是一个接受多参数的函数
        Function<String, Function<String, String>> sum = fa -> fb -> fa + "fun1 " + fb; // fa为第一个
        BiFunction<String, String, String> sumBi = (fa, fb) -> fa + "fun1 " + fb;
        Function<String,
            Function<String,
                Function<String, String>>> sumMulti = a -> b -> c -> a + b + c;

        // 通过链式调用逐个传递参数
        Function<String, String> hi = sum.apply(s1);
        System.out.println(hi.apply(s2));

        Function<String, String> sumHi = s -> s + " fun2 " + s;
        System.out.println(sumHi.apply(s2));
    }

}
