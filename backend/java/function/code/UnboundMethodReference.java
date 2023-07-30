package function;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/27
 */

class X {
    String f() {
        return "X::f()";
    }
    
    String t() {
        return "X::t()";
    }
}

class SX extends X {
    
}

class S {
    String s() {
        return "s";
    }
}


interface MakeString {
    String make();
}

interface TransformX {
    String transform(X x);
}

public class UnboundMethodReference {

    public static void main(String[] args) {
        // MakeString sp = X::f;       // [1] 你不能在没有 X 对象参数的前提下调用 f()，因为它是 X 的方法
        TransformX sp = X::f;       // [2] 你可以首个参数是 X 对象参数的前提下调用 f()，使用未绑定的引用，函数式的方法不再与方法引用的签名完全相同
        X x = new X();
        System.out.println(sp.transform(x));      // [3] 传入 x 对象，调用 x.f() 方法
        System.out.println(x.f());      // 同等效果

        TransformX spx = X::t;
//        TransformX spx = SX::t;  // 报错, 继承不支持
//        TransformX spx = S::s;   // 报错, 其他方法不支持

        SX sx = new SX();
        S s = new S();
        System.out.println(sp.transform(x));      // [3] 传入 x 对象，调用 x.f() 方法
        System.out.println(sp.transform(sx));      // 支持
//        System.out.println(sp.transform(s));      // 报错, 类型错误
        
    }
}
