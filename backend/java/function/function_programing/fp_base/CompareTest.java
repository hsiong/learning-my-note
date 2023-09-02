package function_programing.fp_base;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/8/29
 */
interface Strategy {
    String approach(String msg);
}

class Soft implements Strategy {
    public String approach(String msg) {
        return msg.toLowerCase() + "?";
    }
}

class Unrelated {
    static String twice(String msg) {
        return msg + " " + msg;
    }
}

public class CompareTest {

    Strategy strategy;
    String msg;
    CompareTest(String msg) {
        strategy = new Soft(); // [1] 构建默认的 Soft
        this.msg = msg;
    }

    void communicate() {
        // strategy.approach(msg) 实际执行了 实例化的子类.approach() 方法
        System.out.println(strategy.approach(msg));
    }

    void changeStrategy(Strategy strategy) {
        this.strategy = strategy;
    }

    public static void main(String[] args) {
        String message = "Hello there";
        Strategy[] strategies = {
            new Strategy() { // [2] Java 8 以前的匿名内部类, 实现 Strategy 接口 & approach 方法
                public String approach(String msg) {
                    return msg.toUpperCase() + "!";
                }
            },
            msg -> msg.substring(0, 5), // [3] 基于 Ldmbda 表达式，实例化 interface, 入参与出参一致
            Unrelated::twice // [4] 基于 方法引用，实例化 interface, 入参与出参一致, 即可实例化
        };
        System.out.println("init");
        for (Strategy strategy : strategies) {
            message = strategy.approach(message);
            System.out.println(message);
        }
        
        CompareTest s = new CompareTest(message); // 实例化 CompareTest 的同时
        s.communicate();
        for(Strategy newStrategy : strategies) {
            s.changeStrategy(newStrategy); // [5] 使用默认的 Soft 策略
            s.communicate(); // [6] 每次调用 communicate() 都会产生不同的行为
        }
    }
}
