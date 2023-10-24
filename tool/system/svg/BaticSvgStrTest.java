package wordTest.image;

import org.apache.batik.transcoder.TranscoderException;
import org.apache.batik.transcoder.TranscoderInput;
import org.apache.batik.transcoder.TranscoderOutput;
import org.apache.batik.transcoder.image.JPEGTranscoder;

import java.io.*;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/9/26
 */
public class BaticSvgStrTest {

    public static void main(String[] args) {
        String svgXml = "<svg width='100' height='100' xmlns='http://www.w3.org/2000/svg'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='2' fill='red'/></svg>";

        try {
            byte[] jpgData = convertSvgToJpg(svgXml);
            String out = "/Users/vjf/Desktop/test.jpeg";
            OutputStream jpgOutputStream = new FileOutputStream(out);

            // 将JPG数据写入文件或进行其他操作
            jpgOutputStream.write(jpgData);
            jpgOutputStream.close();
        } catch (IOException | TranscoderException e) {
            e.printStackTrace();
        }
    }

    public static byte[] convertSvgToJpg(String svgXml) throws TranscoderException, IOException {
        // 将SVG字符串转换为输入流
        ByteArrayInputStream svgInputStream = new ByteArrayInputStream(svgXml.getBytes());

        // 设置输入和输出
        TranscoderInput input = new TranscoderInput(svgInputStream);
        ByteArrayOutputStream jpgOutputStream = new ByteArrayOutputStream();
        TranscoderOutput output = new TranscoderOutput(jpgOutputStream);

        // 执行转换
        JPEGTranscoder transcoder = new JPEGTranscoder();  // 创建JPEGTranscoder实例
        transcoder.addTranscodingHint(JPEGTranscoder.KEY_QUALITY, 0.8f); // 设置JPEG图像质量（0.0 - 1.0）
        transcoder.transcode(input, output);

        // 获取JPG数据
        byte[] jpgData = jpgOutputStream.toByteArray();

        // 关闭流
        jpgOutputStream.close();
        svgInputStream.close();

        return jpgData;
    }

}
