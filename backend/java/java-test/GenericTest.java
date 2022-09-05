import cn.hutool.core.bean.BeanUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import lombok.Data;
import module.old.YzBaseEntity;
import org.junit.Test;

import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2022/8/25
 */
@Data
public class GenericTest {

    @Test
    public void genericTest() {

        Integer integer = 66; // 自动拆箱


        /**
         * Reference: 
         * Java通过反射获取泛型类型信息 
         * https://blog.csdn.net/cnds123321/article/details/119655880
         * 
         * 擦拭法 
         * https://www.liaoxuefeng.com/wiki/1252599548343744/1265104600263968
         * 
         * java泛型--创建类型实例的几种方法 
         * https://blog.csdn.net/Sife_007/article/details/80308517
         * 
         * Type 类型 泛型 反射 Class ParameterizedType [MD] 
         * https://www.cnblogs.com/baiqiantao/p/7460580.html
         * 
         * 打个赌你可能不知道如何获取Java泛型的Class对象 
         * https://cloud.tencent.com/developer/article/1851247
         * 
         */
        YzBaseEntity str = new YzBaseEntity();
        getRet(str);
        System.out.println(str);
    }

    public <T> T getRet(T t) {
        YzBaseEntity test = new YzBaseEntity();
        test.setId("1234");
        String sout = JSON.toJSONString(test, SerializerFeature.WRITE_MAP_NULL_FEATURES);
        System.out.println("sout");
        System.out.println(sout);
        
        T out = JSON.parseObject(sout, (Type) t.getClass());
        BeanUtil.copyProperties(out, t);
        return t;
    }

    /**
     * 通过反射获取泛型类型
     *
     * @param
     * @return
     */
    private <T> T getGenericType() {
        // 获取名为"getList"的方法，在MyClass类中
        Method getListMethod = null;
        try {
            /**
             * 如果为泛型, 获取的是 .class 文件
             * Java的泛型是由编译器在编译时实行的，
             * 编译器内部永远把所有类型T视为Object处理，
             * 但是，在需要转型的时候，编译器会根据T的类型自动为我们实行安全地强制转型。
             */
            getListMethod = this.getClass().getMethod("getRet");
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
        // 获取返回值类型，getGenericReturnType()会返回值带有泛型的返回值类型
        Type genericReturnType = getListMethod.getGenericReturnType();


        // 但我们实际上需要获取返回值类型中的泛型信息，所以要进一步判断，即判断获取的返回值类型是否是参数化类型ParameterizedType
        if (genericReturnType instanceof ParameterizedType) {
            // 如果要使用ParameterizedType中的方法，必须先强制向下转型
            ParameterizedType type = (ParameterizedType) genericReturnType;
            // 获取返回值类型中的泛型类型，因为可能有多个泛型类型，所以返回一个数组
            Type[] actualTypeArguments = type.getActualTypeArguments();
            // 循环数组，遍历每一个泛型类型
            for (Type actualTypeArgument : actualTypeArguments) {
                Class typeArgClass = (Class) actualTypeArgument;
                System.out.println("成员方法返回值的泛型信息：" + typeArgClass);
            }
        }
        return null;
    }


}
