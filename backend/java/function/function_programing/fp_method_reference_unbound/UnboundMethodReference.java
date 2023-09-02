package function_programing.fp_method_reference_unbound;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/27
 */
interface MakeString {
    String make();
}

interface TransformX {
    String transform(UnboundMethodReference.X x);
}

interface TransformS {
    String transform(UnboundMethodReference.S x);
}

interface TransformSDouble {
    String transform(UnboundMethodReference.X x, String s);
}

interface TransformSTrible {
    String transform(UnboundMethodReference.X x, UnboundMethodReference.S s, String s3);
}

interface TransformInterface {
    String transform(TransformInterfaceX x, TransformInterfaceY s, String s3);
}

interface TransformInterfaceX {
    String transform(TransformInterfaceY s, String s3);
}

interface TransformInterfaceY {
    String transform(String s3);
}


public class UnboundMethodReference {

    public static void main(String[] args) {

        /**
         * 首个参数是 X 对象参数的前提下调用 f()，使用未绑定的引用，函数式的方法不再与方法引用的签名完全相同
         */
        TransformX transformX = X::f;
        transformX = X::f1; // 可以非常灵活的各类实现
        /* TransformX transformX2 = X::staticT; */ // 报错, 不支持静态类
        TransformS transformS = S::s;
        /* TransformX spx = XExtend::f; */  // 报错, 继承不支持
        /* TransformX spx = S::s; */   // 报错, 其他类不支持

        // 单参数调用
        X x = new X();
        System.out.println(transformX.transform(x));      // [3] 传入 x 对象，调用 x.f() 方法
        System.out.println(x.f());      // 同等效果

        /**
         * 多参数
         */
        TransformSDouble transformSDouble = X::fDouble; // 多参数
        transformSDouble.transform(new X(), "");
        /* TransformSDouble transformXS2 = X::f; */// 报错, 多参数剩余入参不足不支持
        TransformSTrible transformSTrible = X::fTrible;
        // 接口-多参数
        TransformInterface transformInterface = TransformInterfaceX::transform;
        TransformInterfaceX transformInterfaceX = TransformInterfaceY::transform;
        TransformInterfaceY transformInterfaceY = i -> i;
        System.err.println(transformInterface.transform(transformInterfaceX, transformInterfaceY, "1234"));
        
        String test = "1234";
        transformInterface.transform(transformInterfaceX, transformInterfaceY, test);
        transformInterfaceX.transform(transformInterfaceY, test);
        transformInterfaceY.transform(test);
        
        XExtend XExtend = new XExtend();
        S s = new S();
        System.out.println(transformX.transform(x));      // [3] 传入 x 对象，调用 x.f() 方法
        System.out.println(transformX.transform(XExtend));      // 支持继承
        /* System.out.println(transformX.transform(s)); */      // 报错, 类型错误

    }

    static class X {
        String f() {
            return "X::f()";
        }

        String f1() {
            return "X::f1()";
        }

        String fDouble(String s) {
            return this + "fDouble";
        }

        String fTrible(S s, String s3) {
            return "ft";
        }

        static String staticT() {
            return "X::t()";
        }
    }

    static class XExtend extends X {

    }

    static class S {
        String s() {
            return "s";
        }
    }
}
