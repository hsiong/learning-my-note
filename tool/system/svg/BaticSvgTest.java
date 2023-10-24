package wordTest.image;

import org.apache.batik.transcoder.Transcoder;
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
public class BaticSvgTest {

    public static void main(String[] args) throws Exception {
        String svgFile = "/Users/vjf/Desktop/svg.svg";  // 指定输入的SVG文件路径
        String jpgFile = "/Users/vjf/Desktop/test.jpg"; // 指定输出的JPG文件路径
        File outFile = new File(jpgFile);
        if (!outFile.exists()) {
            outFile.createNewFile();
        }

        // 指定输出图像的宽度和高度（以像素为单位）
//        int width = 114 * 4; // 宽度
//        int height = 25 * 4; // 高度

        try {
            // 创建转码器
            Transcoder transcoder = new JPEGTranscoder();

            // 设置JPEG图像质量（可选）
            transcoder.addTranscodingHint(JPEGTranscoder.KEY_QUALITY, 1f);
            // 设置输出图像的宽度和高度
//            transcoder.addTranscodingHint(JPEGTranscoder.KEY_WIDTH, (float) width);
//            transcoder.addTranscodingHint(JPEGTranscoder.KEY_HEIGHT, (float) height);
            // 设置输入
            InputStream inputStream = new FileInputStream(svgFile);
            TranscoderInput input = new TranscoderInput(inputStream);

            // 设置输出
            OutputStream outputStream = new FileOutputStream(jpgFile);
            TranscoderOutput output = new TranscoderOutput(outputStream);

            // 执行转换
            transcoder.transcode(input, output);

            // 关闭输入和输出流
            inputStream.close();
            outputStream.close();

            System.out.println("SVG转换为JPG成功！");
        } catch (IOException | TranscoderException e) {
            e.printStackTrace();
        }
    }

}
