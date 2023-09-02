package function_programing.fp_base;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/8/29
 */
interface Description {
    String brief();
//    String brief2();
}

interface Body {
    String detailed(String head);
}

interface Multi {
    String twoArg(String head, Double d);
}

public class LambdaTest {

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
