package function.function_modify;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/30
 */
@FunctionalInterface
public interface MultiParamFunction<T, U, V, R> {

     R apply(T t, U u, V v);

    
}
