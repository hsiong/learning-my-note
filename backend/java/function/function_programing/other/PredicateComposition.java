package function_programing.other;

import java.util.function.Predicate;
import java.util.stream.Stream;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/8/30
 */
public class PredicateComposition {

    static Predicate<String>
        p1 = s -> s.contains("bar"),
        p2 = s -> s.length() < 5,
        p3 = s -> s.contains("foo"),
        p4 = p1.negate().and(p2).or(p3);    // 使用谓词组合将多个谓词组合在一起，negate 是取反，and 是与，or 是或

    public static void main(String[] args) {
        Stream.of("bar", "foobar", "foobaz", "fongopuckey")
              .filter(p4)
              .forEach(System.out::println);
    }

}
