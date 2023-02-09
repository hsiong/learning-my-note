package other;

import com.icbc.api.KeyGen;
import com.icbc.api.crypt.RSA;
import com.icbc.api.internal.util.codec.Base64;
import org.junit.Test;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.security.*;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/1/16
 */
public class AesTest {

    public static void main(String[] args) throws Exception {
        KeyGen.main(args);
    }

    @Test
    public void test() throws Exception {

        KeyPair var4 = RSA.generateKeyPair(2048);

        byte[] privateKey = var4.getPrivate().getEncoded();
        byte[] publicKey = var4.getPublic().getEncoded();
        String pri = new String(Base64.encodeBase64(privateKey));
        String pub = new String(Base64.encodeBase64(publicKey));

        // 检查 公私钥是否匹配
        // 若不匹配, 加解密过程中会报 decryption error
        pri = "priKey";
        pub = "pubKey";
        privateKey = Base64.decodeBase64(pri);
        publicKey = Base64.decodeBase64(pub);

        System.out.println("pri");
        System.out.println(pri);
        System.out.println("pub");
        System.out.println(pub);


        String data = "1234";
        byte[] encryptByPublicKey = encryptByPublicKey(data.getBytes(), publicKey);
        System.out.println("使用公钥加密后的数据：" + new String(Base64.encodeBase64(encryptByPublicKey)));

        byte[] decryptByPrivateKey = decryptByPrivateKey(encryptByPublicKey, privateKey);
        System.out.println("使用私钥解密后的数据：" + new String(decryptByPrivateKey));

    }

    public static String RSA_ALGORITHM = "RSA";

    /**
     * 公钥加密
     *
     * @param data
     * @param key
     * @return
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeySpecException
     * @throws NoSuchPaddingException
     * @throws BadPaddingException
     * @throws IllegalBlockSizeException
     * @throws InvalidKeyException
     */
    private static byte[] encryptByPublicKey(byte[] data,
                                             byte[] key) throws NoSuchAlgorithmException, InvalidKeySpecException, NoSuchPaddingException, BadPaddingException, IllegalBlockSizeException, InvalidKeyException {
        //实例化密钥工厂
        KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
        //初始化公钥,根据给定的编码密钥创建一个新的 X509EncodedKeySpec。
        X509EncodedKeySpec x509EncodedKeySpec = new X509EncodedKeySpec(key);
        PublicKey publicKey = keyFactory.generatePublic(x509EncodedKeySpec);
        //数据加密
        Cipher cipher = Cipher.getInstance(keyFactory.getAlgorithm());
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        return cipher.doFinal(data);
    }

    /**
     * 私钥解密
     *
     * @param data 待解密数据
     * @param key  密钥
     * @return byte[] 解密数据
     */
    public static byte[] decryptByPrivateKey(byte[] data, byte[] key) throws Exception {
        //取得私钥
        PKCS8EncodedKeySpec pkcs8KeySpec = new PKCS8EncodedKeySpec(key);
        KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
        //生成私钥
        PrivateKey privateKey = keyFactory.generatePrivate(pkcs8KeySpec);
        //数据解密
        Cipher cipher = Cipher.getInstance(keyFactory.getAlgorithm());
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        return cipher.doFinal(data);
    }
}
