package function_programing.function_higher;

import java.util.function.Function;

/**
 * 〈实现接收一个函数作为函数的参数〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/30
 */
class One {}
class Two {}
public class FunctionHigherBaseParam {

    static Two consume(Function<One, Two> onetwo) {
        return onetwo.apply(new One());
    }

    public static void main(String[] args) {
        Two two = consume(one -> new Two());
    }

}
