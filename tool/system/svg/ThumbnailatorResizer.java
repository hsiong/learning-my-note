package wordTest.image;

import net.coobird.thumbnailator.Thumbnails;

import java.io.File;
import java.io.IOException;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/9/26
 */
public class ThumbnailatorResizer {

    public static void main(String[] args) {
        // 输入的 PNG 文件和输出的 PNG 文件路径
        String inputFilePath = "/Users/vjf/Desktop/2048.png";
        String outputFilePath = "/Users/vjf/Desktop/outputt.jpg";
        FileUtil.generateOutFile(outputFilePath);
        try {
            File inputFile = new File(inputFilePath);
            File outputFile = new File(outputFilePath);

            Thumbnails.of(inputFile)
                      .size(114, 20)
                      .outputQuality(1.0) // 1.0 表示最高质量
                      .outputFormat("png")
                      .toFile(outputFile);

            System.out.println("PNG图像已缩放并保存。");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
