import com.alibaba.fastjson.JSON;
import lombok.Data;
import module.old.YzBaseEntity;
import org.junit.Test;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2022/8/25
 */
@Data
public class GenericZTest {


    /**
     * Reference: 
     * https://cloud.tencent.com/developer/article/1497707
     */
    @Test
    public void mapGenericTest() {
        Map<String, Integer> map = new HashMap<String, Integer>();

        Type type = map.getClass().getGenericSuperclass(); // 获取HashMap父类AbstractMap<K,V>  请注意：此处为<K,V>
        ParameterizedType parameterizedType = ParameterizedType.class.cast(type);

        Type[] actualTypeArguments = parameterizedType.getActualTypeArguments(); // 两个类型  一个是K，一个是V
        for (Type typeArgument : actualTypeArguments) {
            System.out.println(typeArgument.getTypeName()); //k,v（泛型消失了）
        }
    }

    @Test
    public void mapGenericTest2() {
        // 此处必须用匿名内部类的方式写，如果使用new HashMapEx<String,Integer> 效果同上
        Map<String, Integer> map = new HashMap<String, Integer>() {};

        Type type = map.getClass().getGenericSuperclass(); // 获取HashMapEx父类HashMap<K,V>
        ParameterizedType parameterizedType = ParameterizedType.class.cast(type);

        Type[] actualTypeArguments = parameterizedType.getActualTypeArguments(); // 两个类型  一个是K，一个是V
        for (Type typeArgument : actualTypeArguments) {
            System.out.println(typeArgument.getTypeName()); //k,v（泛型消失了）
        }
    }

    @Test
    public void listGenericTest() {
        List<YzBaseEntity> dummy = new ArrayList<>(0){};
        Type[] actualTypeArguments = ((ParameterizedType) dummy.getClass().getGenericSuperclass()).getActualTypeArguments();
        Type clazz = actualTypeArguments[0];
        System.out.println();


        YzBaseEntity test = new YzBaseEntity();
        test.setId("1234");
        String sout = JSON.toJSONString(test);
        YzBaseEntity t = JSON.parseObject(sout, clazz);
        System.out.println(t);
    }
}
